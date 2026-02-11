import { useState } from "react";
import { useI18n } from "../i18n";
import type { SkillTreeNode } from "../types";

interface Props {
  nodes: SkillTreeNode[];
  wrongGuesses: string[];  // skill_ids of wrong guesses (turn red)
  onNodeClick: (skill_id: string) => void;
  disabled: boolean;
  correctSlug?: string | null;  // Show green when completed
}

const BRANCH_COLORS = {
  conditioning: "#2afe7f",
  mobility: "#fdd333",
  survival: "#f4101b",
} as const;

export default function SkillTree({ nodes, wrongGuesses, onNodeClick, disabled, correctSlug }: Props) {
  const [hoveredNode, setHoveredNode] = useState<string | null>(null);
  const { lang } = useI18n();

  // Group nodes by branch
  const conditioningNodes = nodes.filter(n => n.category === "conditioning");
  const mobilityNodes = nodes.filter(n => n.category === "mobility");
  const survivalNodes = nodes.filter(n => n.category === "survival");

  const getNodeOpacity = (node: SkillTreeNode) => {
    if (node.skill_id === correctSlug) return 1.0;
    if (wrongGuesses.includes(node.skill_id)) return 0.6;
    return 0.8;
  };

  const getNodeName = (node: SkillTreeNode) => {
    return lang === "ru" ? node.name_ru : node.name_en;
  };

  const renderBranch = (branchNodes: SkillTreeNode[]) => {
    return (
      <>
        {/* Connection lines for this branch */}
        {branchNodes.map(node =>
          node.prerequisites.map(prereqId => {
            const prereq = nodes.find(n => n.skill_id === prereqId);
            if (!prereq) return null;
            return (
              <line
                key={`${node.skill_id}-${prereqId}`}
                x1={prereq.position_x}
                y1={prereq.position_y}
                x2={node.position_x}
                y2={node.position_y}
                className="skill-tree-connection"
              />
            );
          })
        )}

        {/* Nodes for this branch */}
        {branchNodes.map(node => {
          const radius = node.is_major ? 3.5 : 2.8;
          const iconSize = radius * 1.3;
          const isWrong = wrongGuesses.includes(node.skill_id);
          const borderColor = node.skill_id === correctSlug
            ? "#00ff00"
            : isWrong
              ? "#9ca3af"
              : BRANCH_COLORS[node.category];

          return (
            <g key={node.skill_id}>
              <circle
                cx={node.position_x}
                cy={node.position_y}
                r={radius}
                fill="#2a2a2a"
                opacity={getNodeOpacity(node)}
                stroke={borderColor}
                strokeWidth={hoveredNode === node.skill_id ? 0.5 : 0.3}
                strokeDasharray={isWrong ? "1 1.5" : undefined}
                className={`skill-tree-node${isWrong ? " skill-tree-node--wrong" : ""}`}
                style={{ cursor: disabled ? "default" : "pointer" }}
                onClick={() => !disabled && onNodeClick(node.skill_id)}
                onMouseEnter={() => setHoveredNode(node.skill_id)}
                onMouseLeave={() => setHoveredNode(null)}
              />
              {/* Skill icon inside the node */}
              <image
                href={`/static/skills/icons/${node.icon}`}
                x={node.position_x - iconSize / 2}
                y={node.position_y - iconSize / 2}
                width={iconSize}
                height={iconSize}
                opacity={getNodeOpacity(node)}
                className="skill-tree-icon"
                style={{ pointerEvents: "none" }}
              />
              {node.skill_id === correctSlug && (
                <circle
                  cx={node.position_x}
                  cy={node.position_y}
                  r={node.is_major ? 4.2 : 3.5}
                  fill="none"
                  stroke="#00ff00"
                  strokeWidth={0.3}
                  opacity={0.5}
                  className="skill-tree-node--correct-glow"
                />
              )}
            </g>
          );
        })}
      </>
    );
  };

  return (
    <div className="skill-tree-container">
      <svg
        viewBox="-40 -50 180 155"
        className="skill-tree-svg"
        preserveAspectRatio="xMidYMax meet"
      >
        <g transform="translate(0, 15)">
        {/* Conditioning branch - left column (scale around root y=75 so branches grow from bottom) */}
        <g transform="translate(25, 75) scale(2.0) translate(-25, -75) translate(-20, 0)">
          {renderBranch(conditioningNodes)}
        </g>

        {/* Mobility branch - center column */}
        <g transform="translate(50, 75) scale(2.0) translate(-50, -75)">
          {renderBranch(mobilityNodes)}
        </g>

        {/* Survival branch - right column */}
        <g transform="translate(75, 75) scale(2.0) translate(-75, -75) translate(20, 0)">
          {renderBranch(survivalNodes)}
        </g>

        {/* Tooltips layer - render on top of all nodes */}
        {hoveredNode && nodes.find(n => n.skill_id === hoveredNode) && (() => {
          const node = nodes.find(n => n.skill_id === hoveredNode)!;
          const nodeName = getNodeName(node);
          const tooltipWidth = Math.max(30, nodeName.length * 1.3 + 6);
          const halfWidth = tooltipWidth / 2;
          const translateX = node.category === 'conditioning' ? 25 : node.category === 'survival' ? 75 : 50;
          const extraTranslateX = node.category === 'conditioning' ? -20 : node.category === 'survival' ? 20 : 0;
          return (
            <g transform={`translate(${translateX}, 75) scale(2.0) translate(-${translateX}, -75) translate(${extraTranslateX}, 0)`}>
              <rect
                x={node.position_x - halfWidth}
                y={node.position_y - 8}
                width={tooltipWidth}
                height="4"
                rx="1.5"
                className="skill-tree-tooltip-bg"
              />
              <text
                x={node.position_x}
                y={node.position_y - 5}
                textAnchor="middle"
                fill="#fff"
                fontSize="2.5"
                className="skill-tree-tooltip"
                pointerEvents="none"
              >
                {getNodeName(node)}
              </text>
            </g>
          );
        })()}
        </g>
      </svg>
    </div>
  );
}
