Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A44514335
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 09:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355100AbiD2HZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 03:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238464AbiD2HZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 03:25:47 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EAEBF53F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 00:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1651216950;
  x=1682752950;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BDFaFgbVHHjpgsWI9EIGW4e5nqVRQr43ShctVkUJkmo=;
  b=ap4ndWtZD6sdVabptXAjY7ZJmPn0ElxjbtZ8flyJrSaJPAb0UsgMGESz
   UymfdJQQIle+6wkoS9cPlo123YwAcObmKmyQrJMitgwTLeWHaJdUnM+tY
   NFrLWSV1SsRiJvMsGwGXPltoM71ExKVxPJm9759awYAp0MkFI4BZu0xcK
   wfFbiu5ROYQE/kdGCrC8gEITgEsKLheONYJguagk3mIaxcTdi+iqdo2cr
   OF3TXwzG90KEG+mXqLGX2k75JfxuXJ9ByTD+n05qulTEu7XprY47xbUST
   pfxbLnClrd5jGJYutnYUnBm7MQMTWm2M6OqkKFo5BLqoVX/6weSLz5g73
   g==;
From:   Rickard Andersson <rickaran@axis.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <rickaran@axis.com>, <rickard314.andersson@gmail.com>,
        <perdo@axis.com>
Subject: [PATCH v2 1/5] dt-bindings: regulator: Add property for I2C level shifter
Date:   Fri, 29 Apr 2022 09:22:07 +0200
Message-ID: <20220429072211.24957-1-rickaran@axis.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail03w.axis.com
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
Signed-off-by: Rickard x Andersson <rickaran@axis.com>
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

