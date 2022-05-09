Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37745204DD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 20:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240375AbiEITAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 15:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240374AbiEITA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 15:00:26 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9054B15FCB;
        Mon,  9 May 2022 11:56:31 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id B58901F44049
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652122590;
        bh=ZLYs6CI7s8Jj8EeHsrXSw3oRF8/mCUSKeayVDMKYyPg=;
        h=From:To:Cc:Subject:Date:From;
        b=HJiXLwHH5YEw2s3HHpeH4aPABH0EI2Upl5k26VzT/j4d5Pyx5F75JtEBDK4qU/Wwi
         UuMqI0weAy9luNMb7N1ZL3BxlwAYAJ7xwABSgHk/GIJ9aChTjiZqZP3z/+YJQYCW2K
         +vsBYYr1BxTJ8qu2KhjAOfsOHl3OUck2aUdZsLa8wDs2CFTfolSH6SctvjcXGnQNF3
         q3thmdZaq9qwWlbqPoH/yyHmJo+PwRfEzUpVpajC8CPKP4EjAkabUMIrX3K4V4yGym
         Dk2Guf3NbgXDSmrbsd79FcJLM3rU7hMUZNxVPRRGmfgCpvQZFuapCqYoFeeaAlWNRZ
         Hia2Y5fzdMpSQ==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shane Chien <shane.chien@mediatek.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] Revert "ASoC: dt-bindings: mediatek: mt8192: Add i2s-share properties"
Date:   Mon,  9 May 2022 14:56:25 -0400
Message-Id: <20220509185625.580811-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit e056cf4341ae3f856f1e38da02b27cb04de4c69b. The commit
was merged while the property name and definition were still being
discussed. Revert the commit for now and a follow up commit will re-add
the property after it is further discussed and reviewed.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

 Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml b/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
index 5b03c8dbf318..7a25bc9b8060 100644
--- a/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
+++ b/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
@@ -54,11 +54,6 @@ properties:
       - const: aud_infra_clk
       - const: aud_infra_26m_clk
 
-patternProperties:
-  "^i2s[0-35-9]-share$":
-    description: Name of the I2S bus that is shared with this bus
-    pattern: "^I2S[0-35-9]$"
-
 required:
   - compatible
   - interrupts
-- 
2.36.0

