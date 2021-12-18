Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C22F1479C64
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 20:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbhLRTsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 14:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbhLRTsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 14:48:01 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDB5C06173F
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 11:48:00 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id x43-20020a056830246b00b00570d09d34ebso7316890otr.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 11:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xZbl8kry1oh8fgr14gyBKadSkFkgf66pQ/lNWJRGpuk=;
        b=isRS9OfoaM3RItUzEdCQE3X34KmLU5ljCl16w3NIyiU/3WJt5wuxVZei89oJeDuJYh
         vOu8SG0HUynOXu8Nzc1wlCDtJlsa0tJnx65Xi7jdDtlgmPiOA/wQubBoNz0nd4FMNVgs
         wmVOaReFvpemU3B9J3Yt+f+knLdwHUfHuMRCokcwVm59VxjJykW03cFfB2xsp6sz13wC
         L6iOZX4bBTonpZiFiPKc71TZw0anucFmmI9oZOCmTN2B5jlbKCDNgWLOCEFw8+sdexVB
         2uivFlf3yOtlXBvvx0HgsHG4GpSm7B7m2yjfd806zHrsMfiHYavX1p5COA0w4sf5OaiO
         +Z+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xZbl8kry1oh8fgr14gyBKadSkFkgf66pQ/lNWJRGpuk=;
        b=QywSiSOy/3nLeowqIXQ/DmqCmpU8/NORaqflXRJ0/0Lg+sIUQo9t0ukR5n0oNvv7+P
         WiGGhYDgYghgcECss/mR4xJjxjDvh7PbYdvZmMxVvM5DhRh9Hi+8tjfVUs5oXgluWqXF
         R2VqdZB4qBYEQrLa9s2dLGAE4g34GYVL8KUZx1ECPgZ6lxl3xR3/7p/yOGYagu6ABZAO
         woy/2+Hvl2EFkhPbWYD9GdirN0ZZn7qH2UpXXpznlbjIcHb/Ta5Sp7QhAARwnDpkDDIt
         Xoy4UP/Un9oNEPkwo7rbvi/rE8JVvMNGOSQ6CXTiQdYC9SQg9zUcnZiQIMejFamR3CvI
         nsAw==
X-Gm-Message-State: AOAM530OVgN0dMfjmKjDKEIBcjgmgEgY6H1lqw3R4vCtC1g24OVuARFi
        rN3UJ5LfnG/00fow6+RQAbaipg==
X-Google-Smtp-Source: ABdhPJyottwvIBEpp4PIbHlt1JVvxo+WxfHaqMBh5Vo3p1am0yoxA1mDQMqnmk5UTbnVoRTK0+iSpw==
X-Received: by 2002:a05:6830:4090:: with SMTP id x16mr6590388ott.281.1639856880137;
        Sat, 18 Dec 2021 11:48:00 -0800 (PST)
Received: from [192.168.11.48] (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id j5sm2290053oou.23.2021.12.18.11.47.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Dec 2021 11:47:59 -0800 (PST)
Message-ID: <aae49bcb-078f-f414-aede-0906c44c030b@kali.org>
Date:   Sat, 18 Dec 2021 13:47:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v5 6/6] qcom/soc/drivers: Add DTPM description for sdm845
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rjw@rjwysocki.net
Cc:     lukasz.luba@arm.com, robh@kernel.org, heiko@sntech.de,
        arnd@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, ulf.hansson@linaro.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>
References: <20211218130014.4037640-1-daniel.lezcano@linaro.org>
 <20211218130014.4037640-7-daniel.lezcano@linaro.org>
From:   Steev Klimaszewski <steev@kali.org>
In-Reply-To: <20211218130014.4037640-7-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 12/18/21 7:00 AM, Daniel Lezcano wrote:
> The DTPM framework does support now the hierarchy description.
>
> The platform specific code can call the hierarchy creation function
> with an array of struct dtpm_node pointing to their parents.
>
> This patch provides a description of the big and Little CPUs and the
> GPU and tie them together under a virtual package name. Only sdm845 is
> described.
>
> The description could be extended in the future with the memory
> controller with devfreq if it has the energy information.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   drivers/soc/qcom/Kconfig  |  9 ++++++
>   drivers/soc/qcom/Makefile |  1 +
>   drivers/soc/qcom/dtpm.c   | 65 +++++++++++++++++++++++++++++++++++++++
>   3 files changed, 75 insertions(+)
>   create mode 100644 drivers/soc/qcom/dtpm.c
>
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index e718b8735444..f21c1df2f2f9 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -228,4 +228,13 @@ config QCOM_APR
>   	  application processor and QDSP6. APR is
>   	  used by audio driver to configure QDSP6
>   	  ASM, ADM and AFE modules.
> +
> +config QCOM_DTPM
> +	tristate "Qualcomm DTPM hierarchy"

Testing this on a Lenovo Yoga C630 here and...


Should this be tristate?  Is it actually possible to unload the module 
once it's loaded?

Here I have DTPM=y, DTPM_CPU=y, DTPM_DEVFREQ=y, QCOM_DTPM=m

But if I attempt to modprobe -r dtpm,

modprobe: ERROR: ../libkmod/libkmod-module.c:799 
kmod_module_remove_module() could not remove 'dtpm': Device or resource busy



> +	depends on DTPM
> +	help
> +	 Describe the hierarchy for the Dynamic Thermal Power
> +	 Management tree on this platform. That will create all the
> +	 power capping capable devices.
> +
>   endmenu
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index 70d5de69fd7b..cf38496c3f61 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -28,3 +28,4 @@ obj-$(CONFIG_QCOM_LLCC) += llcc-qcom.o
>   obj-$(CONFIG_QCOM_RPMHPD) += rpmhpd.o
>   obj-$(CONFIG_QCOM_RPMPD) += rpmpd.o
>   obj-$(CONFIG_QCOM_KRYO_L2_ACCESSORS) +=	kryo-l2-accessors.o
> +obj-$(CONFIG_QCOM_DTPM) += dtpm.o
> diff --git a/drivers/soc/qcom/dtpm.c b/drivers/soc/qcom/dtpm.c
> new file mode 100644
> index 000000000000..c15283f59494
> --- /dev/null
> +++ b/drivers/soc/qcom/dtpm.c
> @@ -0,0 +1,65 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2021 Linaro Limited
> + *
> + * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
> + *
> + * DTPM hierarchy description
> + */
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/dtpm.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +
> +static struct dtpm_node __initdata sdm845_hierarchy[] = {
> +	[0]{ .name = "sdm845" },
> +	[1]{ .name = "package",
> +	     .parent = &sdm845_hierarchy[0] },
> +	[2]{ .name = "/cpus/cpu@0",
> +	     .type = DTPM_NODE_DT,
> +	     .parent = &sdm845_hierarchy[1] },
> +	[3]{ .name = "/cpus/cpu@100",
> +	     .type = DTPM_NODE_DT,
> +	     .parent = &sdm845_hierarchy[1] },
> +	[4]{ .name = "/cpus/cpu@200",
> +	     .type = DTPM_NODE_DT,
> +	     .parent = &sdm845_hierarchy[1] },
> +	[5]{ .name = "/cpus/cpu@300",
> +	     .type = DTPM_NODE_DT,
> +	     .parent = &sdm845_hierarchy[1] },
> +	[6]{ .name = "/cpus/cpu@400",
> +	     .type = DTPM_NODE_DT,
> +	     .parent = &sdm845_hierarchy[1] },
> +	[7]{ .name = "/cpus/cpu@500",
> +	     .type = DTPM_NODE_DT,
> +	     .parent = &sdm845_hierarchy[1] },
> +	[8]{ .name = "/cpus/cpu@600",
> +	     .type = DTPM_NODE_DT,
> +	     .parent = &sdm845_hierarchy[1] },
> +	[9]{ .name = "/cpus/cpu@700",
> +	     .type = DTPM_NODE_DT,
> +	     .parent = &sdm845_hierarchy[1] },
> +	[10]{ .name = "/soc@0/gpu@5000000",
> +	     .type = DTPM_NODE_DT,
> +	     .parent = &sdm845_hierarchy[1] },
> +	[11]{ },
> +};
> +
> +static struct of_device_id __initdata sdm845_dtpm_match_table[] = {
> +        { .compatible = "qcom,sdm845", .data = sdm845_hierarchy },
> +        {},
> +};
> +
> +static int __init sdm845_dtpm_init(void)
> +{
> +	return dtpm_create_hierarchy(sdm845_dtpm_match_table);
> +}
> +late_initcall(sdm845_dtpm_init);
> +
> +MODULE_DESCRIPTION("Qualcomm DTPM driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:dtpm");
> +MODULE_AUTHOR("Daniel Lezcano <daniel.lezcano@kernel.org");
> +

It does seem to work aside from not being able to modprobe -r the 
module. Although I do see

[   35.849622] dtpm: Registered dtpm node 'sdm845' / 0-0 uW,
[   35.849652] dtpm: Registered dtpm node 'package' / 0-0 uW,
[   35.849676] dtpm: Registered dtpm node 'cpu0-cpufreq' / 40000-436000 uW,
[   35.849702] dtpm: Registered dtpm node 'cpu4-cpufreq' / 
520000-5828000 uW,
[   35.849734] dtpm_devfreq: No energy model available for '5000000.gpu'
[   35.849738] dtpm: Failed to setup '/soc@0/gpu@5000000': -22

If the devfreq issue with the gpu isn't expected, are we missing 
something for the c630?

-- Steev

