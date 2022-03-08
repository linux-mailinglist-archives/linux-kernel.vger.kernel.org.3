Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C37D4D1FCC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 19:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349420AbiCHSMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 13:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233562AbiCHSM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 13:12:27 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE06D5674D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 10:11:30 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id h15so5506134wrc.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 10:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=KVZsESrH/S2yqvHapMzlA8otCo1/mrHmDA1KH6uRnrE=;
        b=BDSWz1XmnfrqMytFyuZ5KZDpXlq6bKLyqu+aIGaEBiduS7SinmHZ++8EtRN89mPL16
         ixWKpyl8tqDgb9ZErJ4OHbp8mZazpu32wZOviOLs/glW5b2XD3G8Tc1Pn+ClO+A03L5H
         6W49z3puEksUaxSFHXjw8RWoK3zcKSEJJvjZlgPaDamTeWVJL1fuc49zHr9OZGJgNo1V
         r/38WnVkXYFGGqssrqeWekyHxqpDwmz627xtPgAf8JNjqBQDioDVuTSxtFmRy4kIXLQq
         JxCTrPVSL2LJgPQuRKzPH/oi0ahPoCkGA8a2nx7NMY1glAr3ilYt17PyfLup3+LDVljT
         ALOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=KVZsESrH/S2yqvHapMzlA8otCo1/mrHmDA1KH6uRnrE=;
        b=p1CTNSQ2LlwmUR38YfLCgXBdHbi4GPawTI6QIJbJ1Qx+3I/VEzWVR43fxc40qbTGR+
         6Ee9MMbBMkcWagwBMycAYxyj101J9soLpkyDpppux7yTGdiMz4HrrTwr5Ui7XXUrDY/H
         Wf6zJnCq6TgQV3kaYgOKnme9gMnHsLCjvE8Dnfa5sPua2Ttvb8n1PXKZ8SyaIEcfiQfE
         s4tMywhRwlV5iWvkCBAtmSbsGNiH2nHfcGpUotgE0YavEeLX2dWAOktTAnKbqfFjIxOT
         ho4aJKWTOqkJX+eE1B2fF+OOanFFPTmykLbydpSEzfLKRqpFsOzFTTogq7Ucr2TJmw2O
         /oyw==
X-Gm-Message-State: AOAM531+r7qfWn7pfI0ffumOatMiGyLzLwS9lNfHFjswAOVnYh/xRaHF
        P5phtqQN9Bvh7fbHbZyZgLWoFQ==
X-Google-Smtp-Source: ABdhPJx02A5gaS+KyDYI6FaotYzkPpy5gsW7qKTlF2yxoZCkXrM5VurUnUMx4axG0TGcpYOIOnE3BA==
X-Received: by 2002:a5d:6205:0:b0:1e4:b3fd:9ba8 with SMTP id y5-20020a5d6205000000b001e4b3fd9ba8mr12579926wru.426.1646763089124;
        Tue, 08 Mar 2022 10:11:29 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:1ffc:39b4:7538:de29? ([2a01:e34:ed2f:f020:1ffc:39b4:7538:de29])
        by smtp.googlemail.com with ESMTPSA id l7-20020adfe9c7000000b001f06f8ec92dsm11960759wrn.30.2022.03.08.10.11.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 10:11:28 -0800 (PST)
Message-ID: <77450e71-9228-dace-56b0-c2516220f572@linaro.org>
Date:   Tue, 8 Mar 2022 19:11:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Romain Naour <romain.naour@smile.fr>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        YueHaibing <yuehaibing@huawei.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] thermal changes for v5.18-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
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


Hi Rafael,

please consider pulling,


The following changes since commit 8a43cf06864363f43917b046ab689fab61fd44f2:

   Merge branch 'thermal-hfi' into linux-next (2022-03-08 15:49:29 +0100)

are available in the Git repository at:

   https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git 
tags/thermal-v5.18-rc1

for you to fetch changes up to c0013ecc2f1da00ac1683259aa02a8f696fecd6f:

   MAINTAINERS: thermal: samsung: update Krzysztof Kozlowski's email 
(2022-03-08 15:57:04 +0100)


Thanks
   -- Daniel

----------------------------------------------------------------
- Convert the DT bindings to yaml format for the Exynos platform
   and fix the MAINTAINERS file regarding this driver (Krzysztof
   Kozlowski)

- Register the thermal zones as HWmon sensors for the QCom's
   Tsens driver (Dmitry Baryshkov)

- Add the sm8150 platform support to LMh (Thara Gopinath)

- Add the msm8953 compatible documentation in the bindings (Luca
   Weiss)

- Register the thermal zones as HWmon sensors for the TI thermal
   platforms (Romain Naour)

- Check the command result from the IPC command to the
   BPMP in the Tegra driver (Mikko Perttunen)

- Silent the error for normal configuration where the interrupt
   is optionnal on the Broadcom thermal driver (Florian Fainelli)

- Remove a remaining dead code from the TI thermal driver (Yue
   Haibing)

- Update the email in MAINTAINERS file for the Exynos thermal
   driver (Krzysztof Kozlowski)

----------------------------------------------------------------
Dmitry Baryshkov (1):
       thermal/drivers/tsens: register thermal zones as hwmon sensors

Florian Fainelli (1):
       thermal/drivers/brcmstb_thermal: Interrupt is optional

Krzysztof Kozlowski (3):
       dt-bindings: thermal: samsung: Convert to dtschema
       MAINTAINERS: thermal: samsung: Drop obsolete properties
       MAINTAINERS: thermal: samsung: update Krzysztof Kozlowski's email

Luca Weiss (1):
       dt-bindings: thermal: tsens: Add msm8953 compatible

Mikko Perttunen (1):
       thermal: tegra-bpmp: Handle errors in BPMP response

Romain Naour (1):
       drivers/thermal/ti-soc-thermal: Add hwmon support

Thara Gopinath (2):
       thermal/drivers/qcom/lmh: Add support for sm8150
       dt-bindings: thermal: Add sm8150 compatible string for LMh

YueHaibing (1):
       thermal/drivers/ti-soc-thermal: Remove unused function 
ti_thermal_get_temp()

  .../devicetree/bindings/thermal/exynos-thermal.txt | 106 ------------
  .../devicetree/bindings/thermal/qcom-lmh.yaml      |   1 +
  .../devicetree/bindings/thermal/qcom-tsens.yaml    |   1 +
  .../bindings/thermal/samsung,exynos-thermal.yaml   | 184 
+++++++++++++++++++++
  MAINTAINERS                                        |   7 +-
  drivers/thermal/broadcom/brcmstb_thermal.c         |   2 +-
  drivers/thermal/qcom/lmh.c                         |  62 ++++---
  drivers/thermal/qcom/tsens.c                       |   5 +
  drivers/thermal/tegra/tegra-bpmp-thermal.c         |  13 +-
  drivers/thermal/ti-soc-thermal/ti-thermal-common.c |  12 +-
  10 files changed, 247 insertions(+), 146 deletions(-)
  delete mode 100644 
Documentation/devicetree/bindings/thermal/exynos-thermal.txt
  create mode 100644 
Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
