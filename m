Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89007482449
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 14:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbhLaN6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 08:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbhLaN6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 08:58:17 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C938DC06173E
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 05:58:16 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id h7so15835928lfu.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 05:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ADzJWr+CbGVX014WZDS2L6snWL7iPLu3/ZLqlh/Pj3s=;
        b=wI4yxCNQ8DbOEzf9a0EEKR+uVoNpqKvP2j3TfccxorArKXFLWGvXnmq/u3210XY7Bt
         6SY+obn+o24I8ByNoCgePQrC00WOPliPKsVcJbKrys/NONrQfwABt+PYc9qNSjhQDXh4
         nbip7b2zI1sg+e+4l9mNsHd2MOPZ8otBtAOAjqk8WfUql3FekXWomakhZ6RuuQvT2anB
         x2gqumAvx4XayRNJBogn2ZkuHZpWolkn4EsDqtF3YlDHx2oBwLx1Fyj4cCuiQPK8xz0o
         JZ4jhvwMP3FphymMKH6+FGcxVJ/zTIuNIXzTwmo2Sw7vgjcnNViKYKGEPpKmvv3w/HNW
         9CLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ADzJWr+CbGVX014WZDS2L6snWL7iPLu3/ZLqlh/Pj3s=;
        b=l0ee2r41avwyQQR5TKEch47NadD2C1pbzw3q7pMN/aFzutkHMUOrq0TUp3N03xKlQz
         Bm9C9kTcW0EPxwGHTrC8I3fBrtqsAPgtybbSkjFfnMdZb4bSdZT4Jr5uapIjBJy9I2jf
         hvV/Mtj8tHh3Kuns6rP83PnBNWFtx6K10CMIBbKlaH4Ekem2Q9UzpiniByvibuTna9sE
         Zmf3qgqxLPZgb9/wBfuuCOr90GLU7GMiHvxWXRL5qpuYkTVQevFDv7tLLE09Yz6LI8yx
         5PtZZEBzhdcLB/6JH2POxzgi6tZJ+G1KWGmNizrjdDpehavpWbh3kHGiIF/cs//9XN1X
         qKHw==
X-Gm-Message-State: AOAM532d16UP3PV08TV0DMfcJaac3xKopjYYDr9iteY6tJpuCyRnBTaD
        Xs/FpWWWpEf/o3GnYGmWMK2SuHB/K6n7yE9sIcpSMQ==
X-Google-Smtp-Source: ABdhPJzaghSLSAc0pNPQzuES57Tnf+aNwFRoLwgYkTTcyuTMuv5rOoeqy7bTcVpKTyo/oJWiGUWJw4io8u+6ND1nCZk=
X-Received: by 2002:a05:6512:4015:: with SMTP id br21mr32693525lfb.233.1640959094947;
 Fri, 31 Dec 2021 05:58:14 -0800 (PST)
MIME-Version: 1.0
References: <20211218130014.4037640-1-daniel.lezcano@linaro.org> <20211218130014.4037640-6-daniel.lezcano@linaro.org>
In-Reply-To: <20211218130014.4037640-6-daniel.lezcano@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 31 Dec 2021 14:57:38 +0100
Message-ID: <CAPDyKFqWUJTKte3dM=7xG6EtKR8i9neCCNYFs7Jf1J34TezUEQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] rockchip/soc/drivers: Add DTPM description for rk3399
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     rjw@rjwysocki.net, lukasz.luba@arm.com, heiko@sntech.de,
        arnd@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel, Rob,

On Sat, 18 Dec 2021 at 14:00, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> The DTPM framework does support now the hierarchy description.
>
> The platform specific code can call the hierarchy creation function
> with an array of struct dtpm_node pointing to their parent.
>
> This patch provides a description of the big and Little CPUs and the
> GPU and tie them together under a virtual package name. Only rk3399 is
> described now.
>
> The description could be extended in the future with the memory
> controller with devfreq if it has the energy information.
>
> The hierarchy uses the GPU devfreq with the panfrost driver, and this
> one could be loaded as a module. If the hierarchy is created before
> the panfrost driver is loaded, it will fail. For this reason the
> Kconfig option depends on the panfrost Kconfig's option. If this one
> is compiled as a module, automatically the dtpm hierarchy code will be
> a module also. Module loading ordering will fix this chicken-egg
> problem.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/soc/rockchip/Kconfig  |  8 +++++
>  drivers/soc/rockchip/Makefile |  1 +
>  drivers/soc/rockchip/dtpm.c   | 56 +++++++++++++++++++++++++++++++++++
>  3 files changed, 65 insertions(+)
>  create mode 100644 drivers/soc/rockchip/dtpm.c
>
> diff --git a/drivers/soc/rockchip/Kconfig b/drivers/soc/rockchip/Kconfig
> index 25eb2c1e31bb..a88fe6d3064a 100644
> --- a/drivers/soc/rockchip/Kconfig
> +++ b/drivers/soc/rockchip/Kconfig
> @@ -34,4 +34,12 @@ config ROCKCHIP_PM_DOMAINS
>
>            If unsure, say N.
>
> +config ROCKCHIP_DTPM
> +       tristate "Rockchip DTPM hierarchy"
> +       depends on DTPM && DRM_PANFROST
> +       help
> +        Describe the hierarchy for the Dynamic Thermal Power
> +        Management tree on this platform. That will create all the
> +        power capping capable devices.
> +
>  endif
> diff --git a/drivers/soc/rockchip/Makefile b/drivers/soc/rockchip/Makefile
> index 875032f7344e..05f31a4e743c 100644
> --- a/drivers/soc/rockchip/Makefile
> +++ b/drivers/soc/rockchip/Makefile
> @@ -5,3 +5,4 @@
>  obj-$(CONFIG_ROCKCHIP_GRF) += grf.o
>  obj-$(CONFIG_ROCKCHIP_IODOMAIN) += io-domain.o
>  obj-$(CONFIG_ROCKCHIP_PM_DOMAINS) += pm_domains.o
> +obj-$(CONFIG_ROCKCHIP_DTPM) += dtpm.o
> diff --git a/drivers/soc/rockchip/dtpm.c b/drivers/soc/rockchip/dtpm.c
> new file mode 100644
> index 000000000000..77edc565c110
> --- /dev/null
> +++ b/drivers/soc/rockchip/dtpm.c
> @@ -0,0 +1,56 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2021 Linaro Limited
> + *
> + * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
> + *
> + * DTPM hierarchy description
> + */
> +#include <linux/dtpm.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +
> +static struct dtpm_node __initdata rk3399_hierarchy[] = {
> +       [0]{ .name = "rk3399" },
> +       [1]{ .name = "package",
> +            .parent = &rk3399_hierarchy[0] },
> +       [2]{ .name = "/cpus/cpu@0",
> +            .type = DTPM_NODE_DT,
> +            .parent = &rk3399_hierarchy[1] },
> +       [3]{ .name = "/cpus/cpu@1",
> +            .type = DTPM_NODE_DT,
> +            .parent = &rk3399_hierarchy[1] },
> +       [4]{ .name = "/cpus/cpu@2",
> +            .type = DTPM_NODE_DT,
> +            .parent = &rk3399_hierarchy[1] },
> +       [5]{ .name = "/cpus/cpu@3",
> +            .type = DTPM_NODE_DT,
> +            .parent = &rk3399_hierarchy[1] },
> +       [6]{ .name = "/cpus/cpu@100",
> +            .type = DTPM_NODE_DT,
> +            .parent = &rk3399_hierarchy[1] },
> +       [7]{ .name = "/cpus/cpu@101",
> +            .type = DTPM_NODE_DT,
> +            .parent = &rk3399_hierarchy[1] },
> +       [8]{ .name = "rockchip,rk3399-mali",
> +            .type = DTPM_NODE_DT,
> +            .parent = &rk3399_hierarchy[1] },
> +       [9]{ },
> +};

I will not object to this, as in the end this seems like what we need
to do, unless we can describe things through generic DT bindings for
DTPM. Right?

Although, if the above is correct, I need to stress that I am kind of
worried that this doesn't really scale. We would need to copy lots of
information from the DTS files into platform specific c-files, to be
able to describe the DTPM hierarchy.

> +
> +static struct of_device_id __initdata rockchip_dtpm_match_table[] = {
> +        { .compatible = "rockchip,rk3399", .data = rk3399_hierarchy },
> +        {},
> +};
> +
> +static int __init rockchip_dtpm_init(void)
> +{
> +       return dtpm_create_hierarchy(rockchip_dtpm_match_table);
> +}
> +late_initcall(rockchip_dtpm_init);
> +
> +MODULE_DESCRIPTION("Rockchip DTPM driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:dtpm");
> +MODULE_AUTHOR("Daniel Lezcano <daniel.lezcano@kernel.org");
> --
> 2.25.1
>

Kind regards
Uffe
