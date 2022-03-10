Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF774D4126
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 07:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239810AbiCJGdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 01:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239783AbiCJGdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 01:33:22 -0500
Received: from mx1.cqplus1.com (unknown [113.204.237.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8099412E744
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 22:32:13 -0800 (PST)
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 172.28.114.216
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(26038:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Thu, 10 Mar 2022 14:28:59 +0800 (CST)
From:   Qin Jian <qinjian@cqplus1.com>
To:     robh+dt@kernel.org
Cc:     krzk@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        tglx@linutronix.de, maz@kernel.org, p.zabel@pengutronix.de,
        linux@armlinux.org.uk, broonie@kernel.org, arnd@arndb.de,
        stefan.wahren@i2se.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Qin Jian <qinjian@cqplus1.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v10 01/10] dt-bindings: vendor-prefixes: Add Sunplus
Date:   Thu, 10 Mar 2022 14:28:40 +0800
Message-Id: <2e74a1339a5ea54d92fdc4d1998a2b169e23b82b.1646892810.git.qinjian@cqplus1.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1646892810.git.qinjian@cqplus1.com>
References: <cover.1646892810.git.qinjian@cqplus1.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for Sunplus Technology Co., Ltd. (http://www.sunplus.com)

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Qin Jian <qinjian@cqplus1.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index a867f7102..50d4ee5ac 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1131,6 +1131,8 @@ patternProperties:
     description: Summit microelectronics
   "^sunchip,.*":
     description: Shenzhen Sunchip Technology Co., Ltd
+  "^sunplus,.*":
+    description: Sunplus Technology Co., Ltd.
   "^SUNW,.*":
     description: Sun Microsystems, Inc
   "^supermicro,.*":
-- 
2.33.1

