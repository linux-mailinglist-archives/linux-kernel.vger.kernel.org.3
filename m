Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B59844755BE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 11:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241472AbhLOKEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 05:04:13 -0500
Received: from lucky1.263xmail.com ([211.157.147.132]:39212 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241455AbhLOKEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 05:04:06 -0500
Received: from localhost (unknown [192.168.167.223])
        by lucky1.263xmail.com (Postfix) with ESMTP id 68FB6FDF52;
        Wed, 15 Dec 2021 17:57:11 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P18835T140477477144320S1639562220094025_;
        Wed, 15 Dec 2021 17:57:10 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: yifeng.zhao@rock-chips.com
X-SENDER: zyf@rock-chips.com
X-LOGIN-NAME: yifeng.zhao@rock-chips.com
X-FST-TO: heiko@sntech.de
X-RCPT-COUNT: 15
X-LOCAL-RCPT-COUNT: 3
X-MUTI-DOMAIN-COUNT: 0
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-UNIQUE-TAG: <07b2fe5f574baf029ca10c2c0ed9de19>
X-System-Flag: 0
From:   Yifeng Zhao <yifeng.zhao@rock-chips.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, jbx6244@gmail.com, devicetree@vger.kernel.org,
        vkoul@kernel.org, michael.riesch@wolfvision.net,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, kishon@ti.com,
        p.zabel@pengutronix.de, cl@rock-chips.com,
        kever.yang@rock-chips.com, Yifeng Zhao <yifeng.zhao@rock-chips.com>
Subject: [PATCH v5 1/4] dt-bindings: mfd: syscon: add naneng combo phy register compatible
Date:   Wed, 15 Dec 2021 17:56:54 +0800
Message-Id: <20211215095657.13183-2-yifeng.zhao@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211215095657.13183-1-yifeng.zhao@rock-chips.com>
References: <20211215095657.13183-1-yifeng.zhao@rock-chips.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Jonker <jbx6244@gmail.com>

Add naneng combo phy register compatible.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index fdd96e378df0..e9bb96ab9446 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -52,6 +52,8 @@ properties:
               - rockchip,rk3288-qos
               - rockchip,rk3368-qos
               - rockchip,rk3399-qos
+              - rockchip,rk3568-pipe-grf
+              - rockchip,rk3568-pipe-phy-grf
               - rockchip,rk3568-qos
               - samsung,exynos3-sysreg
               - samsung,exynos4-sysreg
-- 
2.17.1



