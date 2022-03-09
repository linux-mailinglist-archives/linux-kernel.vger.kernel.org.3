Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D1C4D2F50
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 13:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbiCIMqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 07:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbiCIMqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 07:46:01 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D4017129D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 04:45:03 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id i8so2829598wrr.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 04:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vgKY2Q6+QhjEsaicdqEnaC8ePiL0nSdZLDa1oY8ac70=;
        b=vVSZXrOPJfdfQlk3yTj0sWxYXjSZJJJkmhzOxE8T2zdhsyWzXcJymep2acmJW5EkAj
         tDRgXyY/uR+mP9F92Mto8Ua/ILvYDmGp64/LXYomkY+MK1rCMnk8u12j2VVPJahNUhS6
         +CsX2K1acavUCwQt7YsxEB0kw5Dd+RkwxFtZ0Fl15TTmgrVdO0kIXf8UNPjbmEHb54Wy
         rBdBlhr4PTMAYyRcjAH3JGSph2JPa0K8mfiYKGg49yc8LQoUMJJWCgYNgOTtO58extn8
         mchCuXE3HVN6NGKZVKmMxBCKSy+gODUHJwECYAwDSrwtUey2k5ZfdtG1VP2B15qGSVeJ
         Qfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vgKY2Q6+QhjEsaicdqEnaC8ePiL0nSdZLDa1oY8ac70=;
        b=v4awtDWSB3YFOUlRggVXNxX1b5h1KCsjRyTpUt4bA6KUATJAjznbhOuwoY5iFKk2MM
         srihr56DSuZze5apLofWOsf162AFeGalfsWQaKeRdbVpG7PCNVi6S06oDhmKHKLQEVSU
         2WZqCgtkvZgXeenrkYYy84Emx537oxlEEG6SpGierWiNm8Vchqo3vFjSxqIy8GdrHQi9
         ZT0G3R8Dlxh7a5qlj/b2NV7s0nHuznJZYInTCweyaMS6b9h/j2wqqTTbncEeP/SbDLEa
         BI9SBoYYD2hRdvHMab4TZvCJVdb5YmfuZUkiGvPFhTWjnLf+6r9gnsCO73uOIB33O4wa
         zvgQ==
X-Gm-Message-State: AOAM531adaEtLMd4eeMrx7w77mpX0Bsu4nkHhMoGxl29ZQJ+kIJl3Rfi
        ScP2FSWM3aF98UtTlJbw59SFTQ==
X-Google-Smtp-Source: ABdhPJwj7n2SG+ZJ5L+LFVYmeqokwoThVczi/zeuMIVWGe6Ti9GLdtc8xDYQ1inhbtePKDrv/qyzog==
X-Received: by 2002:a5d:6344:0:b0:1f0:21ee:9705 with SMTP id b4-20020a5d6344000000b001f021ee9705mr15663343wrw.93.1646829901625;
        Wed, 09 Mar 2022 04:45:01 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id bg20-20020a05600c3c9400b0037fa5c422c8sm5414414wmb.48.2022.03.09.04.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 04:45:01 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] ASoC: qcom: fix Kconfig for SC7280
Date:   Wed,  9 Mar 2022 12:44:53 +0000
Message-Id: <20220309124453.25841-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

select would force the symbol to value without checking the dependencies.
In this case selecting TX and RX MACROs directly without checking its
dependency on COMMON_CLK would break builds on platform which do no
set COMMON_CLK.
ex:
WARNING: unmet direct dependencies detected for SND_SOC_LPASS_RX_MACRO
  Depends on [n]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && COMMON_CLK [=n]
  Selected by [m]:
  - SND_SOC_SC7280 [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] &&
	 SND_SOC_QCOM [=m] && I2C [=y] && SOUNDWIRE [=m]

move select to imply which should enforce symbol to be set to 'n' if any
dependencies are not resolved.

Fixes: 57350bd41c3a ("ASoC: qcom: SC7280: Add machine driver")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index ae99833b3fdb..593fd85e03ad 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -194,8 +194,8 @@ config SND_SOC_SC7280
 	select SND_SOC_LPASS_SC7280
 	select SND_SOC_MAX98357A
 	select SND_SOC_WCD938X
-	select SND_SOC_LPASS_RX_MACRO
-	select SND_SOC_LPASS_TX_MACRO
+	imply SND_SOC_LPASS_RX_MACRO
+	imply SND_SOC_LPASS_TX_MACRO
 	help
 	  Add support for audio on Qualcomm Technologies Inc.
 	  SC7280 SoC-based systems.
-- 
2.21.0

