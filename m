Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA1D5A1CF1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 01:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243020AbiHYXG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 19:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiHYXG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 19:06:57 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7974A10E
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 16:06:54 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id e19so27743pju.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 16:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc;
        bh=ASZScAFd3xb4cxD9Q6pxtvg/PLB75WgObzDXhoHRnHI=;
        b=MBi4DceFS6uNfPfQDQuupqVrJDGVvnFAF0d4SJ3Jyiaq1+Coztny5KKsMuKgfbRhIA
         ySY/9HH/hBiEXlpXZHsY417asgqSycnkxF124alsUfxHPOKkZLUyWit3zU6SjcVWhVK+
         MTvCrnHUgNJW4ZKQZo9JbKSL797sXZEK+IWd72Iyx+r81F7yhTW3ohoIm7Yhm5CPukao
         qPZC7J/I1mcMwmHso3jsLJbDOBNB4TDUq36V+Gp8Yg1AoXTGSNabWzdMABBAjBKG1d3M
         CPlS8vbn0xZ+FArVglRe+TPAYivNt6oJE36EDPU+ciXG6OK8SKJ2gNL5a8reOuclj3ii
         65Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=ASZScAFd3xb4cxD9Q6pxtvg/PLB75WgObzDXhoHRnHI=;
        b=S2EHqPqxWIP6M0dtJHApi7N7dsJJRU06LjUrLMpoAutd/tcq05+V5FhyvITxcyQZ8L
         9KHvxFREfpYW2S6u6v2ATFaCqDucLQRdq9Lm/4abuZcpRrd6lh1M8CdF1TDfvq5MqNyD
         l8YqF7DgFpMZL/uCwP2iBX+uRqBjPyUTs+4gEsCNUqBhOkXkwZ/pDGi5DEQA77D2ijg2
         ubO0o+1khGsGaKZQUPolx3jv4gy7GmhBRIa/X3rpI8W7YdIDXHT2Esg2f/hEJXuwP7rA
         I2hCM9bQcQtnndYo9nAAIUpVvzh/qzGwlmgVyyOdtJwQ39th25VUXgSSGPIpBxwpMVOb
         /gMQ==
X-Gm-Message-State: ACgBeo2cEsrBSwWxh63bvA0ktlXO9JStOp0d92BeJBfDsigoxfHlOzJ+
        JNLRVC0t54fwFc2u9lWs5aX6NdDnWt0=
X-Google-Smtp-Source: AA6agR6fsrtfyVgnfxR8WD3JDLKLSe75uRq7/VgAnlTUlzYPtUAFZE1Lt10i99EB7JmrUoyD8SWOdA==
X-Received: by 2002:a17:903:2585:b0:172:9ac6:30f3 with SMTP id jb5-20020a170903258500b001729ac630f3mr1182621plb.0.1661468813706;
        Thu, 25 Aug 2022 16:06:53 -0700 (PDT)
Received: from thinbox (23-122-134-180.lightspeed.sntcca.sbcglobal.net. [23.122.134.180])
        by smtp.gmail.com with ESMTPSA id ds21-20020a17090b08d500b001fbc4b7eafesm247248pjb.49.2022.08.25.16.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 16:06:53 -0700 (PDT)
Date:   Thu, 25 Aug 2022 16:06:51 -0700
From:   Maurycy Z <10maurycy10@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        aroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH] ASoC: Fix misspelling of 'system' as 'ststem'.
Message-ID: <YwgAi68IzghNf0Dl@thinbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Maurycy Zalewski <10maurycy10@gmail.com>
---
 sound/pci/ice1712/ice1712.c | 2 +-
 sound/pci/ice1712/ice1724.c | 2 +-
 sound/soc/fsl/Kconfig       | 2 +-
 sound/soc/generic/Kconfig   | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/pci/ice1712/ice1712.c b/sound/pci/ice1712/ice1712.c
index a5241a287..ff6ce91bf 100644
--- a/sound/pci/ice1712/ice1712.c
+++ b/sound/pci/ice1712/ice1712.c
@@ -2247,7 +2247,7 @@ static int snd_ice1712_read_eeprom(struct snd_ice1712 *ice,
 				(snd_ice1712_read_i2c(ice, dev, 0x03) << 24);
 		if (ice->eeprom.subvendor == 0 ||
 		    ice->eeprom.subvendor == (unsigned int)-1) {
-			/* invalid subvendor from EEPROM, try the PCI subststem ID instead */
+			/* invalid subvendor from EEPROM, try the PCI subsystem ID instead */
 			u16 vendor, device;
 			pci_read_config_word(ice->pci, PCI_SUBSYSTEM_VENDOR_ID, &vendor);
 			pci_read_config_word(ice->pci, PCI_SUBSYSTEM_ID, &device);
diff --git a/sound/pci/ice1712/ice1724.c b/sound/pci/ice1712/ice1724.c
index 6fab2ad85..9e81e6335 100644
--- a/sound/pci/ice1712/ice1724.c
+++ b/sound/pci/ice1712/ice1724.c
@@ -2266,7 +2266,7 @@ static int snd_vt1724_read_eeprom(struct snd_ice1712 *ice,
 		if (ice->eeprom.subvendor == 0 ||
 		    ice->eeprom.subvendor == (unsigned int)-1) {
 			/* invalid subvendor from EEPROM, try the PCI
-			 * subststem ID instead
+			 * subsystem ID instead
 			 */
 			u16 vendor, device;
 			pci_read_config_word(ice->pci, PCI_SUBSYSTEM_VENDOR_ID,
diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 614eceda6..c7fe12fbd 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -366,7 +366,7 @@ config SND_SOC_IMX_CARD
 	help
 	  This option enables audio sound card support for i.MX boards
 	  with OF-graph DT bindings.
-	  It also support DPCM of single CPU multi Codec ststem.
+	  It also support DPCM of single CPU multi Codec system.
 
 endif # SND_IMX_SOC
 
diff --git a/sound/soc/generic/Kconfig b/sound/soc/generic/Kconfig
index b6df4e26b..955ac8d3f 100644
--- a/sound/soc/generic/Kconfig
+++ b/sound/soc/generic/Kconfig
@@ -7,7 +7,7 @@ config SND_SIMPLE_CARD
 	select SND_SIMPLE_CARD_UTILS
 	help
 	  This option enables generic simple sound card support
-	  It also support DPCM of multi CPU single Codec ststem.
+	  It also support DPCM of multi CPU single Codec system.
 
 config SND_AUDIO_GRAPH_CARD
 	tristate "ASoC Audio Graph sound card support"
@@ -16,7 +16,7 @@ config SND_AUDIO_GRAPH_CARD
 	help
 	  This option enables generic simple sound card support
 	  with OF-graph DT bindings.
-	  It also support DPCM of multi CPU single Codec ststem.
+	  It also support DPCM of multi CPU single Codec system.
 
 config SND_AUDIO_GRAPH_CARD2
 	tristate "ASoC Audio Graph sound card2 support"
-- 
2.37.2

