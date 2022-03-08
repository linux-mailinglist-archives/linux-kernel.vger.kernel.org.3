Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D1C4D22C3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 21:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350039AbiCHUjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 15:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbiCHUjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 15:39:43 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C1F2DAB1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 12:38:46 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id u10so28766495wra.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 12:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :content-language:content-transfer-encoding;
        bh=ULyo0kffQb8MFlOOF7we34fXDDyUwEdwPtkrXvglEPs=;
        b=eVFzVvTrL6W+SQZX1e1QLD2UAbPznTtq3x/k8p4uYIFwsrcooTGex654M3pRzMSHB9
         woARj27QMpi9ObzxyrHiZWhsb6Ialzj9mY0EXjotw9Ds62HT3dsNjnLtQZLdBJ0nJZI3
         kKbZ5UMWAnodj6Tb7r2E9H2yd1wizdlZe2KKjjCy1pTxClYPmNIvXMpj1u3BsZ/HyyLb
         0fSUVS6naUcKr6mn0E3786U1o7uTOFdon+7OpJsz8w8rZ+yvUfY1y3ljsnuNVhIaUfA6
         o7E76RfCqosi4pVkXcD9Zy38zz6eclQKHImv5Llzghlqf4gOEFKkCDZMEHofZPJWRqvE
         vLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=ULyo0kffQb8MFlOOF7we34fXDDyUwEdwPtkrXvglEPs=;
        b=w+0uMtL4sF2jbX+hCUEXmf5pd0XRc2p/RVvUZvCCN+bIwDh0YRczKNg4sHqJzdSkJN
         fQMaH+JbSCjS8ErcqXJDZ2R+VLXlTKaYG7nzpGPJ3a45KSs2DvOZPdujq9TpmvZE9iVh
         qtAu6ocZi1NOU8c5H1VBjwxjC2JtxvrL9mwyf2bR9aDLYu3YW3LpkvxcuFRMOwivbQcX
         lY6TBsqyucuW+kHX+w8g90uqogXjFOxmR3i3r2Wgh11Ywdmyau598cSD4DRhgg4q1u7i
         0xcdFhGjp/EXKbm9BHrwwDSRbUBsRjZS+ZHjPMFdmmQrcdrzuiluy9W0vMoXM+UwENdd
         BeNQ==
X-Gm-Message-State: AOAM532ay4sNq+o9rGV+yWjD6cXYhVY0ZvOKMhU5m4BvOAXXNStsKi8z
        nE1PLiEihzxZ9XKkmaUhnZWlOA==
X-Google-Smtp-Source: ABdhPJz/4VwZm9hYOJnZ+9iSbbHBKgqCe4+QA359N6ErmQ38hqJVpdPryYw75h/4Hd42BERG9d5pOw==
X-Received: by 2002:a5d:458b:0:b0:1f1:f876:48e2 with SMTP id p11-20020a5d458b000000b001f1f87648e2mr8985866wrq.76.1646771924639;
        Tue, 08 Mar 2022 12:38:44 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:1ffc:39b4:7538:de29? ([2a01:e34:ed2f:f020:1ffc:39b4:7538:de29])
        by smtp.googlemail.com with ESMTPSA id u14-20020adfed4e000000b001e3323611e5sm14122165wro.26.2022.03.08.12.38.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 12:38:43 -0800 (PST)
Message-ID: <98efd34d-db75-f3ce-8c47-a2d7fe4b96f6@linaro.org>
Date:   Tue, 8 Mar 2022 21:38:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] thermal changes for v5.18-rc1
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
Content-Language: en-US
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

The following changes since commit 5838a14832d447990827d85e90afe17e6fb9c175:

   thermal: core: Fix TZ_GET_TRIP NULL pointer dereference (2022-03-01 
16:11:38 +0100)

are available in the Git repository at:

   https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git 
tags/thermal-v5.18-rc1

for you to fetch changes up to a7da8a0955cbe81433afecad229d2a2ba60c3f0a:

   MAINTAINERS: thermal: samsung: update Krzysztof Kozlowski's email 
(2022-03-08 21:26:09 +0100)

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
