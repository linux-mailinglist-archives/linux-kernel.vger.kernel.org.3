Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88DEB46E1C2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 06:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhLIFNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 00:13:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbhLIFNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 00:13:49 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353B2C061746;
        Wed,  8 Dec 2021 21:10:16 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 2918641EA2;
        Thu,  9 Dec 2021 05:10:11 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Sven Peter <sven@svenpeter.dev>, Rob Herring <robh+dt@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <kettenis@openbsd.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: arm: apple: Add t6000/t6001 MacBook Pro 14/16" compatibles
Date:   Thu,  9 Dec 2021 14:09:58 +0900
Message-Id: <20211209051001.70235-2-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211209051001.70235-1-marcan@marcan.st>
References: <20211209051001.70235-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the initial apple,t6000 platforms:

- apple,j314s - MacBook Pro (14-inch, M1 Pro, 2021)
- apple,j316s - MacBook Pro (16-inch, M1 Pro, 2021)

And the initial apple,t6001 platforms:

- apple,j314c - MacBook Pro (14-inch, M1 Max, 2021)
- apple,j316c - MacBook Pro (16-inch, M1 Max, 2021)

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 .../devicetree/bindings/arm/apple.yaml        | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documentation/devicetree/bindings/arm/apple.yaml
index b23c8dc5a27d..8d93e8a6cc18 100644
--- a/Documentation/devicetree/bindings/arm/apple.yaml
+++ b/Documentation/devicetree/bindings/arm/apple.yaml
@@ -19,6 +19,13 @@ description: |
   - MacBook Air (M1, 2020)
   - iMac (24-inch, M1, 2021)
 
+  And devices based on the "M1 Pro" and "M1 Max" SoCs:
+
+  - MacBook Pro (14-inch, M1 Pro, 2021)
+  - MacBook Pro (14-inch, M1 Max, 2021)
+  - MacBook Pro (16-inch, M1 Pro, 2021)
+  - MacBook Pro (16-inch, M1 Max, 2021)
+
   The compatible property should follow this format:
 
   compatible = "apple,<targettype>", "apple,<socid>", "apple,arm-platform";
@@ -60,6 +67,20 @@ properties:
               - apple,j457 # iMac (24-inch, 2x USB-C, M1, 2021)
           - const: apple,t8103
           - const: apple,arm-platform
+      - description: Apple M1 Pro SoC based platforms
+        items:
+          - enum:
+              - apple,j314s # MacBook Pro (14-inch, M1 Pro, 2021)
+              - apple,j316s # MacBook Pro (16-inch, M1 Pro, 2021)
+          - const: apple,t6000
+          - const: apple,arm-platform
+      - description: Apple M1 Max SoC based platforms
+        items:
+          - enum:
+              - apple,j314c # MacBook Pro (14-inch, M1 Max, 2021)
+              - apple,j316c # MacBook Pro (16-inch, M1 Max, 2021)
+          - const: apple,t6001
+          - const: apple,arm-platform
 
 additionalProperties: true
 
-- 
2.33.0

