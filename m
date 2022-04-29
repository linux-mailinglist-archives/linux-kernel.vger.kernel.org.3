Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D68E5155AE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380815AbiD2UeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380771AbiD2UeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:34:16 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6480A5A15E;
        Fri, 29 Apr 2022 13:30:57 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 8504F1F469DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651264256;
        bh=TGXOnKC566KySlgE7TthYsPemPWKYachLNySsPYvAsg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JGBsEe1eRAd8NEWxwWO63Bgl5dZPFLGJlFdaRgKMETqsbNVgwXwcRfRlEFgcJJCyS
         ooSnwfpyncNz0b9V2AU76cO2jhtczgyap0FFpH/nIMS1NmP6xcx16YzEak2F/OUwYQ
         PgUgwY8wePE7RHEdwIuyqlLyM1e640JeXNvHWhG+dTcBPE/ZMTrDJEsCCKdjxLrg+C
         Si1Z4cK7N0emfsOSCGIMsZ9jcHJTj+FNk400VBay/6N+CnuPZ8D12I7/6w1S5HinvZ
         on70teL+QK4YgcrORHVrjzo4PXuPOjhTwo+xhyHngAwqz/7xq/xP/T33A/GHQbXv96
         IE6c3nISQweTA==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ASoC: dt-bindings: rt5682: Add #sound-dai-cells
Date:   Fri, 29 Apr 2022 16:30:39 -0400
Message-Id: <20220429203039.2207848-4-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220429203039.2207848-1-nfraprado@collabora.com>
References: <20220429203039.2207848-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rt5682 codec can be pointed to through a sound-dai property to be
used as part of a machine sound driver. dtc expects #sound-dai-cells to
be defined in the codec's node in those cases, so add it in the
dt-binding and set it to 0.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

 Documentation/devicetree/bindings/sound/rt5682.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rt5682.txt b/Documentation/devicetree/bindings/sound/rt5682.txt
index cd8c53d8497e..c5f2b8febcee 100644
--- a/Documentation/devicetree/bindings/sound/rt5682.txt
+++ b/Documentation/devicetree/bindings/sound/rt5682.txt
@@ -46,6 +46,8 @@ Optional properties:
 
 - realtek,dmic-clk-driving-high : Set the high driving of the DMIC clock out.
 
+- #sound-dai-cells: Should be set to '<0>'.
+
 Pins on the device (for linking into audio routes) for RT5682:
 
   * DMIC L1
-- 
2.36.0

