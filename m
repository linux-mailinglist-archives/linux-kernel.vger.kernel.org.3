Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90599587739
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 08:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235447AbiHBGo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 02:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233221AbiHBGox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 02:44:53 -0400
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3129439BAC;
        Mon,  1 Aug 2022 23:44:52 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 96941BFABF;
        Tue,  2 Aug 2022 08:44:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1659422689; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding; bh=pJXkxfTuy2Kfs/9METJXWpjXexPS9YQvPhg+a91+jm8=;
        b=HwXTSahXlNtyhKr+seQrRKkgVhcOWwQ4GnhyogdmqzM7T5DwaRnAwaNBbAE/QV9kPFAnN8
        xYF9REZ32ZwwS1ehuybrcG8mp7xX5Km/g0aK9Xv24iwzE7aqQ6ClARTc6+lV+D12p1KI70
        q5Pb2vyxAnIn3qz1+sQ49QZX34kxhwC5p4Ab3LRgAl8CyBoU+Mk3uMSS6wt67kxsWB6TZu
        6Pib62noZgiXt7z8D3d9SlsooF5HX4dGHA7PVXceZ74CN/GLjeIPPI45AmQcLjGuXhbGOe
        4xD4VOSIBs28TEof42+q9j6ed/JwoV3VAhJThBzpxEhvVUOLQvvsHWsKm4KjUA==
From:   Frieder Schrempf <frieder@fris.de>
To:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Gong <yibin.gong@nxp.com>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Per-Daniel Olsson <perdo@axis.com>,
        Rickard x Andersson <rickaran@axis.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH] dt-bindings: regulator: pca9450: Remove restrictions for regulator-name
Date:   Tue,  2 Aug 2022 08:43:34 +0200
Message-Id: <20220802064335.8481-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The device bindings shouldn't put any constraints on the regulator-name
property specified in the generic bindings. This allows using arbitrary
and descriptive names for the regulators.

Suggested-by: Mark Brown <broonie@kernel.org>
Fixes: 7ae9e3a6bf3f ("dt-bindings: regulator: add pca9450 regulator yaml")
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 .../bindings/regulator/nxp,pca9450-regulator.yaml     | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
index b539781e39aa..835b53302db8 100644
--- a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
@@ -47,12 +47,6 @@ properties:
         description:
           Properties for single LDO regulator.
 
-        properties:
-          regulator-name:
-            pattern: "^LDO[1-5]$"
-            description:
-              should be "LDO1", ..., "LDO5"
-
         unevaluatedProperties: false
 
       "^BUCK[1-6]$":
@@ -62,11 +56,6 @@ properties:
           Properties for single BUCK regulator.
 
         properties:
-          regulator-name:
-            pattern: "^BUCK[1-6]$"
-            description:
-              should be "BUCK1", ..., "BUCK6"
-
           nxp,dvs-run-voltage:
             $ref: "/schemas/types.yaml#/definitions/uint32"
             minimum: 600000
-- 
2.37.1
