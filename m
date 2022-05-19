Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFBEB52D313
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 14:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238204AbiESMx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 08:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237082AbiESMx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 08:53:56 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3421A8890
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 05:53:51 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id p189so2828176wmp.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 05:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=3vKLZw93fLqaNJvuqrU4MRj95+wXm+ZL+fwMgVAojQ8=;
        b=NVMm9/50pqifLaqQmrjCTEtPJaQIetsY/VnOfwHSVjZzU/j96S7dsAwCbn2GKDjl5V
         d7B44Y9MTESm0DKb/y0XhC40lCrdh4kAqdSVO5Hn+YkLI6AVs9orMoLq88yIjMlGRrk2
         yEMV5qNrsFDVDtfmzDSah/b56PIzEB1hNiwNqGJcOoQLiKq09NiUndR98lZU0t067+fc
         9Sv1gs2Ju4BuJfViejhynjJ3c72sghv3z7TKe+Rko9jpvXECRsbG90lis0my0mhOo9ZU
         sSj9Yhgta9YtMpOg1ou1N+MuypOi+gGsFMb1JHUsziZ2QSkcJ2iLAymCyg3vp4vHwYtF
         DkTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=3vKLZw93fLqaNJvuqrU4MRj95+wXm+ZL+fwMgVAojQ8=;
        b=FJi+ie+aXu1muU12Uyy8qNBh4Q4SFEiQsEvJEaMqHoQm+93hpdvYfJkS+dB2tgeeAI
         IjuwdaV6TPQjfO7MalLltUj4omCXLgXMUWBQOGqHmPCUcPiqJ7SVRGnpggzOg6axLADD
         8BPK1B5OuiWD6ln7U1y4Kk3+C1fbipRIuXapF1XhaxPJTD6g/tBlcG8j8T/z0l31UrfU
         v2ErYV4m42vROipJD1anT5FyWeGLOCJ+6z++UhBm0xOqZ7XNVP1Kj8wspsqapMCEvWmh
         0yPuQL3eB6O11URAcxwOHlIL/H+z5zvAQpcthY/yBV/A6GqX6Sy4zlu/CflTNYKOSItx
         DOYQ==
X-Gm-Message-State: AOAM531U+7LfjDBhUs0UP7B6funTy3Z8wpqYxlj2eA0tlOGfRtjRmQnF
        fDNeGdiMp2bzYSp+s5rvUnQUrQ==
X-Google-Smtp-Source: ABdhPJz8XZVfba4AE76YqGrFXk8m6HsbOQWl/1CfM3mfwYT2xq/NTs/Gif65KtcizVkMV7GFZSSFzA==
X-Received: by 2002:a05:600c:35ce:b0:394:8621:a1e7 with SMTP id r14-20020a05600c35ce00b003948621a1e7mr3660994wmq.127.1652964829973;
        Thu, 19 May 2022 05:53:49 -0700 (PDT)
Received: from ?IPV6:2a01:e34:ed2f:f020:c540:b1c4:228b:d53? ([2a01:e34:ed2f:f020:c540:b1c4:228b:d53])
        by smtp.googlemail.com with ESMTPSA id r18-20020a05600c159200b003949dbc3790sm3924527wmf.18.2022.05.19.05.53.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 05:53:49 -0700 (PDT)
Message-ID: <6535f2dd-aa2e-21b4-8ac4-7762521f16fc@linaro.org>
Date:   Thu, 19 May 2022 14:53:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM mailing list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Keerthy <j-keerthy@ti.com>, Miaoqian Lin <linmq006@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        zhengyongjun3@huawei.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Massimiliano Minella <massimiliano.minella@gmail.com>,
        Jishnu Prakash <jprakash@qti.qualcomm.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] thermal for v5.19-rc1
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

please consider pulling:

The following changes since commit 7b145802ba545ecf9446ce6d67d6011b73dac0e0:

   thermal: int340x: Mode setting with new OS handshake (2022-05-11 
20:08:15 +0200)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git 
tags/thermal-v5.19-rc1

for you to fetch changes up to ffcb2fc86eb7ebc9f5524525fb57e1cccfbd1fc0:

   thermal: k3_j72xx_bandgap: Add the bandgap driver support (2022-05-19 
12:11:53 +0200)

----------------------------------------------------------------
- Add the new k3 j72xx bangdap driver and the corresponding bindings 
(Keerthy)

- Fix the missing of_node_put() in the SC iMX driver at probe timer 
(Miaoqian Lin)

- Fix memory leak in __thermal_cooling_device_register() when 
device_register()
   fails by calling thermal_cooling_device_destroy_sysfs() (Yang Yingliang)

- Add sc8180x and sc8280xp compatible string in the DT bindings and lMH 
support
   for QCom tsens driver (Bjorn Andersson)

- Fix OTP Calibration Register values conforming to the documentation on 
RZ/G2L
   and bindings documentation for RZ/G2UL (Biju Das)

- Fix type in kerneldoc description for __thermal_bind_params (Corentin 
Labbe)

- Remove unneeded semi colon in libthermal and tools thermal as reported by
   cocci (Jiapeng Chong)

- Fix potential NULL dereference in sr_thermal_probe() on Broadcom platform
   (Zheng Yongjun)

- Add thermal library and thermal tools to encapsulate the netlink into 
event
   based callbacks (Daniel Lezcano)

- Add change mode ops for the thermal-of sensor (Manaf Meethalavalappu
   Pallikunhi)

- Fix non negative value support by preventing the value to be clamp to zero
   (Stefan Wahren)

- Add compatible string and DT bindings for MSM8960 tsens driver (Dmitry
   Baryshkov)

- Add hwmon support for K3 driver (Massimiliano Minella)

- Refactor and add multiple generations support for QCom ADC driver (Jishnu
   Prakash)

- Use platform_get_irq_optional() to get the interrupt on RCar driver and
   document Document RZ/V2L bindings (Lad Prabhakar)

----------------------------------------------------------------
Biju Das (2):
       dt-bindings: thermal: rzg2l-thermal: Document RZ/G2UL bindings
       thermal/drivers/rz2gl: Fix OTP Calibration Register values

Bjorn Andersson (3):
       thermal/drivers/qcom/lmh: Add sc8180x compatible
       dt-bindings: thermal: lmh: Add Qualcomm sc8180x compatible
       dt-bindings: thermal: tsens: Add sc8280xp compatible

Corentin Labbe (1):
       thermal: thermal_of: fix typo on __thermal_bind_params

Daniel Lezcano (4):
       tools/lib/thermal: Add a thermal library
       tools/thermal: Add util library
       tools/thermal: Add a temperature capture tool
       tools/thermal: Add thermal daemon skeleton

Dmitry Baryshkov (2):
       dt-bindings: thermal: qcom-tsens.yaml: add msm8960 compat string
       thermal/drivers/tsens: Add compat string for the qcom,msm8960

Jiapeng Chong (2):
       tools/lib/thermal: remove unneeded semicolon
       tools/thermal: remove unneeded semicolon

Jishnu Prakash (4):
       dt-bindings: thermal: qcom: add PMIC5 Gen2 ADC_TM bindings
       iio: adc: qcom-vadc-common: add reverse scaling for PMIC5 Gen2 ADC_TM
       thermal/drivers/qcom: Add support for multiple generations of devices
       thermal/drivers/qcom: Add support for PMIC5 Gen2 ADCTM

Keerthy (2):
       dt-bindings: thermal: k3-j72xx: Add VTM bindings documentation
       thermal: k3_j72xx_bandgap: Add the bandgap driver support

Lad Prabhakar (2):
       dt-bindings: thermal: rzg2l-thermal: Document RZ/V2L bindings
       thermal/drivers/rcar_thermal: Use platform_get_irq_optional() to 
get the interrupt

Manaf Meethalavalappu Pallikunhi (1):
       thermal/drivers/thermal_of: Add change_mode ops support for 
thermal_of sensor

Massimiliano Minella (1):
       thermal/drivers/k3: Add hwmon support

Miaoqian Lin (1):
       thermal/drivers/imx_sc_thermal: Fix refcount leak in 
imx_sc_thermal_probe

Stefan Wahren (1):
       thermal/drivers/bcm2711: Don't clamp temperature at zero

Yang Yingliang (1):
       thermal/core: Fix memory leak in __thermal_cooling_device_register()

Zheng Yongjun (1):
       thermal/drivers/broadcom: Fix potential NULL dereference in 
sr_thermal_probe

  .../devicetree/bindings/thermal/qcom-lmh.yaml      |   1 +
  .../bindings/thermal/qcom-spmi-adc-tm5.yaml        | 110 +++-
  .../devicetree/bindings/thermal/qcom-tsens.yaml    |   5 +-
  .../devicetree/bindings/thermal/rzg2l-thermal.yaml |   2 +
  .../bindings/thermal/ti,j72xx-thermal.yaml         |  63 +++
  MAINTAINERS                                        |   1 +
  drivers/iio/adc/qcom-vadc-common.c                 |  11 +
  drivers/thermal/Makefile                           |   2 +-
  drivers/thermal/broadcom/bcm2711_thermal.c         |   5 +-
  drivers/thermal/broadcom/sr-thermal.c              |   3 +
  drivers/thermal/imx_sc_thermal.c                   |   6 +-
  drivers/thermal/k3_bandgap.c                       |   5 +
  drivers/thermal/k3_j72xx_bandgap.c                 | 566 
++++++++++++++++++++
  drivers/thermal/qcom/lmh.c                         |   1 +
  drivers/thermal/qcom/qcom-spmi-adc-tm5.c           | 486 +++++++++++++++--
  drivers/thermal/qcom/tsens.c                       |   3 +
  drivers/thermal/rcar_thermal.c                     |  17 +-
  drivers/thermal/rzg2l_thermal.c                    |  10 +-
  drivers/thermal/thermal_core.c                     |   1 +
  drivers/thermal/thermal_of.c                       |  14 +-
  include/linux/iio/adc/qcom-vadc-common.h           |   2 +
  include/linux/thermal.h                            |   3 +
  tools/Makefile                                     |  36 +-
  tools/lib/thermal/.gitignore                       |   2 +
  tools/lib/thermal/Build                            |   5 +
  tools/lib/thermal/Makefile                         | 165 ++++++
  tools/lib/thermal/commands.c                       | 349 +++++++++++++
  tools/lib/thermal/events.c                         | 164 ++++++
  tools/lib/thermal/include/thermal.h                | 142 +++++
  tools/lib/thermal/libthermal.map                   |  25 +
  tools/lib/thermal/libthermal.pc.template           |  12 +
  tools/lib/thermal/sampling.c                       |  75 +++
  tools/lib/thermal/thermal.c                        | 135 +++++
  tools/lib/thermal/thermal_nl.c                     | 215 ++++++++
  tools/lib/thermal/thermal_nl.h                     |  46 ++
  tools/thermal/lib/Build                            |   3 +
  tools/thermal/lib/Makefile                         | 158 ++++++
  tools/thermal/lib/libthermal_tools.pc.template     |  12 +
  tools/thermal/lib/log.c                            |  77 +++
  tools/thermal/lib/log.h                            |  31 ++
  tools/thermal/lib/mainloop.c                       | 120 +++++
  tools/thermal/lib/mainloop.h                       |  15 +
  tools/thermal/lib/thermal-tools.h                  |  10 +
  tools/thermal/lib/uptimeofday.c                    |  40 ++
  tools/thermal/lib/uptimeofday.h                    |  12 +
  tools/thermal/thermal-engine/Build                 |   1 +
  tools/thermal/thermal-engine/Makefile              |  28 +
  tools/thermal/thermal-engine/thermal-engine.c      | 341 ++++++++++++
  tools/thermal/thermometer/Build                    |   1 +
  tools/thermal/thermometer/Makefile                 |  26 +
  tools/thermal/thermometer/thermometer.8            |  92 ++++
  tools/thermal/thermometer/thermometer.c            | 572 
+++++++++++++++++++++
  tools/thermal/thermometer/thermometer.conf         |   5 +
  53 files changed, 4173 insertions(+), 59 deletions(-)
  create mode 100644 
Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
  create mode 100644 drivers/thermal/k3_j72xx_bandgap.c
  create mode 100644 tools/lib/thermal/.gitignore
  create mode 100644 tools/lib/thermal/Build
  create mode 100644 tools/lib/thermal/Makefile
  create mode 100644 tools/lib/thermal/commands.c
  create mode 100644 tools/lib/thermal/events.c
  create mode 100644 tools/lib/thermal/include/thermal.h
  create mode 100644 tools/lib/thermal/libthermal.map
  create mode 100644 tools/lib/thermal/libthermal.pc.template
  create mode 100644 tools/lib/thermal/sampling.c
  create mode 100644 tools/lib/thermal/thermal.c
  create mode 100644 tools/lib/thermal/thermal_nl.c
  create mode 100644 tools/lib/thermal/thermal_nl.h
  create mode 100644 tools/thermal/lib/Build
  create mode 100644 tools/thermal/lib/Makefile
  create mode 100644 tools/thermal/lib/libthermal_tools.pc.template
  create mode 100644 tools/thermal/lib/log.c
  create mode 100644 tools/thermal/lib/log.h
  create mode 100644 tools/thermal/lib/mainloop.c
  create mode 100644 tools/thermal/lib/mainloop.h
  create mode 100644 tools/thermal/lib/thermal-tools.h
  create mode 100644 tools/thermal/lib/uptimeofday.c
  create mode 100644 tools/thermal/lib/uptimeofday.h
  create mode 100644 tools/thermal/thermal-engine/Build
  create mode 100644 tools/thermal/thermal-engine/Makefile
  create mode 100644 tools/thermal/thermal-engine/thermal-engine.c
  create mode 100644 tools/thermal/thermometer/Build
  create mode 100644 tools/thermal/thermometer/Makefile
  create mode 100644 tools/thermal/thermometer/thermometer.8
  create mode 100644 tools/thermal/thermometer/thermometer.c
  create mode 100644 tools/thermal/thermometer/thermometer.conf

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
