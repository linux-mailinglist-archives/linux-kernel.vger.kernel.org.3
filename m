Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF274D30F6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 15:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbiCIOZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 09:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiCIOZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 09:25:01 -0500
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE54109A43;
        Wed,  9 Mar 2022 06:24:02 -0800 (PST)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-2dc585dbb02so24119337b3.13;
        Wed, 09 Mar 2022 06:24:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bzLDZxZ/qA7oBqdjR4gt04U5cjegEAChsNJQDgPnbeI=;
        b=xXGzU1bUNHKVGy5jTqQijYPV69tSG/GW9zvvFve7Pc05fc2nFTZXxLSwmmsIv8EC1u
         tMAC2I5SWL6mgst98wyLq8+DG4NT6x80Qa1KilgrTMBwK1SUyi8vmJTqzwC6/Mqpi94+
         YuhvOBjcgMIvDPO6kqSLV1AhwR1ey7XrRbBB1VR0/u4+xC97WQdEVXk+Fs4cGJHy6oL1
         lP8aPvyiEgXybLsmWehFJRnr35J5dvj9cFb6OK1BM/bxEizClhm5pE0dZI+4iQyXM0k1
         sOFT4UW/veWE+jIUBowtfFK5mneWTBcdgg8DuCY6cnb1MzbX4wBpwGWtiCpJsi382NEe
         3NLw==
X-Gm-Message-State: AOAM532B1U2U4rLclGl1b9dFwMBnafYYIYQNNqKY5YwaKb2CqjQxfPim
        dfD2/Hzp6RCLm3tlAY806cLf3tnFBrQLd5Z2lS5YNxL5
X-Google-Smtp-Source: ABdhPJzEo+x6H9cz5qQaPRDtTVk3UUOLYrOyAYAxUmRMwIQ8U7naTGpvVnWiOgM1zRuJ5jIR0dB4WHszf70PofcdmQE=
X-Received: by 2002:a81:1b97:0:b0:2db:640f:49d8 with SMTP id
 b145-20020a811b97000000b002db640f49d8mr16236809ywb.326.1646835841414; Wed, 09
 Mar 2022 06:24:01 -0800 (PST)
MIME-Version: 1.0
References: <98efd34d-db75-f3ce-8c47-a2d7fe4b96f6@linaro.org>
In-Reply-To: <98efd34d-db75-f3ce-8c47-a2d7fe4b96f6@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Mar 2022 15:23:50 +0100
Message-ID: <CAJZ5v0g3A_czchg7pp8yNppkHB2z9Dpova5DyMN1K1X5JL1Wkg@mail.gmail.com>
Subject: Re: [GIT PULL] thermal changes for v5.18-rc1
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Romain Naour <romain.naour@smile.fr>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        YueHaibing <yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 8, 2022 at 9:38 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
> please consider pulling,
>
> The following changes since commit 5838a14832d447990827d85e90afe17e6fb9c175:
>
>    thermal: core: Fix TZ_GET_TRIP NULL pointer dereference (2022-03-01
> 16:11:38 +0100)
>
> are available in the Git repository at:
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
> tags/thermal-v5.18-rc1
>
> for you to fetch changes up to a7da8a0955cbe81433afecad229d2a2ba60c3f0a:
>
>    MAINTAINERS: thermal: samsung: update Krzysztof Kozlowski's email
> (2022-03-08 21:26:09 +0100)
>
> Thanks
>    -- Daniel
>
> ----------------------------------------------------------------
> - Convert the DT bindings to yaml format for the Exynos platform
>    and fix the MAINTAINERS file regarding this driver (Krzysztof
>    Kozlowski)
>
> - Register the thermal zones as HWmon sensors for the QCom's
>    Tsens driver (Dmitry Baryshkov)
>
> - Add the sm8150 platform support to LMh (Thara Gopinath)
>
> - Add the msm8953 compatible documentation in the bindings (Luca
>    Weiss)
>
> - Register the thermal zones as HWmon sensors for the TI thermal
>    platforms (Romain Naour)
>
> - Check the command result from the IPC command to the
>    BPMP in the Tegra driver (Mikko Perttunen)
>
> - Silent the error for normal configuration where the interrupt
>    is optionnal on the Broadcom thermal driver (Florian Fainelli)
>
> - Remove a remaining dead code from the TI thermal driver (Yue
>    Haibing)
>
> - Update the email in MAINTAINERS file for the Exynos thermal
>    driver (Krzysztof Kozlowski)
>
> ----------------------------------------------------------------
> Dmitry Baryshkov (1):
>        thermal/drivers/tsens: register thermal zones as hwmon sensors
>
> Florian Fainelli (1):
>        thermal/drivers/brcmstb_thermal: Interrupt is optional
>
> Krzysztof Kozlowski (3):
>        dt-bindings: thermal: samsung: Convert to dtschema
>        MAINTAINERS: thermal: samsung: Drop obsolete properties
>        MAINTAINERS: thermal: samsung: update Krzysztof Kozlowski's email
>
> Luca Weiss (1):
>        dt-bindings: thermal: tsens: Add msm8953 compatible
>
> Mikko Perttunen (1):
>        thermal: tegra-bpmp: Handle errors in BPMP response
>
> Romain Naour (1):
>        drivers/thermal/ti-soc-thermal: Add hwmon support
>
> Thara Gopinath (2):
>        thermal/drivers/qcom/lmh: Add support for sm8150
>        dt-bindings: thermal: Add sm8150 compatible string for LMh
>
> YueHaibing (1):
>        thermal/drivers/ti-soc-thermal: Remove unused function
> ti_thermal_get_temp()
>
>   .../devicetree/bindings/thermal/exynos-thermal.txt | 106 ------------
>   .../devicetree/bindings/thermal/qcom-lmh.yaml      |   1 +
>   .../devicetree/bindings/thermal/qcom-tsens.yaml    |   1 +
>   .../bindings/thermal/samsung,exynos-thermal.yaml   | 184
> +++++++++++++++++++++
>   MAINTAINERS                                        |   7 +-
>   drivers/thermal/broadcom/brcmstb_thermal.c         |   2 +-
>   drivers/thermal/qcom/lmh.c                         |  62 ++++---
>   drivers/thermal/qcom/tsens.c                       |   5 +
>   drivers/thermal/tegra/tegra-bpmp-thermal.c         |  13 +-
>   drivers/thermal/ti-soc-thermal/ti-thermal-common.c |  12 +-
>   10 files changed, 247 insertions(+), 146 deletions(-)
>   delete mode 100644
> Documentation/devicetree/bindings/thermal/exynos-thermal.txt
>   create mode 100644
> Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml

Now pulled and pushed out, thanks!
