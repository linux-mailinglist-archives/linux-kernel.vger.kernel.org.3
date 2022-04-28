Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38B251361E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 16:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbiD1OFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 10:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbiD1OFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 10:05:22 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4BDAC05A
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 07:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1651154528;
  x=1682690528;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lGgZXFMd6pZotXpgfw7Ugd7k1+69hoVPS1Y6luf5PiE=;
  b=AyYJ2HMnlNUntB3CCwL5BkBzN41pLO9S0Ez2UdL0KpzuUmfXL79RVJwD
   S/0znJAgC3NmMsL+iYf/BouPRCrEukIOtQVvhoy063GU/7aFnuRu2jD5J
   zir2tCpZwdIxqpUDXMutakj0zP+BTfjbVpNiVWBZwN+XAwdBuAcAc6Zbf
   tS9WB8nMFMk5b7ylr1DoTFzOvbHwW7XMj3djqpLkd3PfuUSAE5rmzJHzd
   P/1z3Z7Oe8hQ+cl009Fx66C5Z6UNNNXEEuA+u7BQj72pceHMuzZ3OV2cA
   F8ZoEn8bsu7qtHaMLfMnZpKFoWHfcQ1zKusxlAEMoJ9u/AsqpFpnRqO7P
   w==;
From:   Rickard Andersson <rickaran@axis.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, <yibin.gong@nxp.com>
CC:     <rickaran@axis.com>, <rickard314.andersson@gmail.com>,
        <perdo@axis.com>
Subject: [PATCH 1/5] dt-bindings: regulator: Add property for I2C level shifter
Date:   Thu, 28 Apr 2022 16:01:35 +0200
Message-ID: <20220428140139.7349-1-rickaran@axis.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail06w.axis.com (10.20.40.12) To se-mail03w.axis.com
 (10.20.40.9)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Per-Daniel Olsson <perdo@axis.com>

By setting nxp,i2c-lt-enable the I2C level translator is
enabled.

Signed-off-by: Per-Daniel Olsson <perdo@axis.com>
---
 .../devicetree/bindings/regulator/nxp,pca9450-regulator.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
index f70f2e758a00..e723f8cf6d74 100644
--- a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
@@ -92,6 +92,11 @@ properties:
       LDO5CTRL_L or LDO5CTRL_H register. Use this if the SD_VSEL signal is
       connected to a host GPIO.
 
+  nxp,i2c-lt-enable:
+    type: boolean
+    description:
+      Indicates that the I2C Level Translator is used.
+
 required:
   - compatible
   - reg
-- 
2.20.1

