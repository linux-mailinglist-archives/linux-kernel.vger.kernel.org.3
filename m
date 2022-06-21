Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0157A552BDF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 09:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346739AbiFUHZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 03:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346703AbiFUHZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:25:31 -0400
X-Greylist: delayed 399 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Jun 2022 00:25:29 PDT
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A9022B05;
        Tue, 21 Jun 2022 00:25:29 -0700 (PDT)
Received: from coburn.home.jannau.net (p579ad988.dip0.t-ipconnect.de [87.154.217.136])
        by soltyk.jannau.net (Postfix) with ESMTPSA id 463C626ED16;
        Tue, 21 Jun 2022 09:18:49 +0200 (CEST)
From:   Janne Grunau <j@jannau.net>
To:     iommu@lists.linux-foundation.org
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        asahi@lists.linux.dev, Sven Peter <sven@svenpeter.dev>,
        Rob Herring <robh@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Hector Martin <marcan@marcan.st>,
        Joerg Roedel <joro@8bytes.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] dt-bindings: iommu: dart: add t6000 compatible
Date:   Tue, 21 Jun 2022 09:18:44 +0200
Message-Id: <20220621071848.14834-2-j@jannau.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220621071848.14834-1-j@jannau.net>
References: <20220621071848.14834-1-j@jannau.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Peter <sven@svenpeter.dev>

The M1 Max/Pro SoCs come with a new DART variant that is incompatible with
the previous one. Add a new compatible for those.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
Acked-by: Rob Herring <robh@kernel.org>

Signed-off-by: Janne Grunau <j@jannau.net>
---

(no changes since v2)

Changes in v2:
- added Rob's Acked-by:

 Documentation/devicetree/bindings/iommu/apple,dart.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/apple,dart.yaml b/Documentation/devicetree/bindings/iommu/apple,dart.yaml
index 82ad669feef7..06af2bacbe97 100644
--- a/Documentation/devicetree/bindings/iommu/apple,dart.yaml
+++ b/Documentation/devicetree/bindings/iommu/apple,dart.yaml
@@ -22,7 +22,9 @@ description: |+
 
 properties:
   compatible:
-    const: apple,t8103-dart
+    enum:
+      - apple,t8103-dart
+      - apple,t6000-dart
 
   reg:
     maxItems: 1
-- 
2.35.1

