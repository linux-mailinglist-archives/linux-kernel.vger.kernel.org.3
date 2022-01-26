Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54CB249C662
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 10:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239215AbiAZJgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 04:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbiAZJgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 04:36:36 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6825C061744
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 01:36:35 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id f17so24634520wrx.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 01:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+cJdKrQBbtFl4PCCfmc5IKpii91wqwE6nOEX76XsXzw=;
        b=WjMWLcyAVG4mrCnc/LPX+4zMi8zuj0DdLNl4JrzuDlW8nhtdWBhh0GJ2AR0bNzN8kh
         RoxsssydBHZ6Sd+ZtivTdDLCja6oNInbRN1rl8RJ6xGzXstIJ16KeGA4FAgpPFwkr3ug
         KG+hV4EgLaHzQ1iFjJG8r8nMGotczpafR+CXM0XUvxfatZOX8hG31r0ajYqgSfuk/iq1
         OuA1nMiERRu6aiO7fZzZfe8XL5HjDJ5xKLbYMU5ZoDo1xaKhizVkjfhWUvlbhtaSji9W
         NOvrUoLL1CcgdVWuLHCNmYlukhaXeQUGjEDTUcx1n/RK3UuAKO0LdWrmRPuWOraSsmAQ
         3Cjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+cJdKrQBbtFl4PCCfmc5IKpii91wqwE6nOEX76XsXzw=;
        b=n7414hX50cTckXbvl1G5Hblby0onLPZ7hpwCD7ZlbfinsHndaxyoC4e/MM8gLCdAUo
         ajzgxGrkqi2TKconfsQF7EsFcXzy+yGgm8vpRaztAj53iWIppkeGILBp7Yu6FSPD5Zbn
         kUVkWHXERkW8fuJ1DBm0dAcCyYNkseJ2vi/Elqgb9w+0So+PefcaM/ukwD1AXDRaUAzs
         0lVrh2VKoA0PobGODHjlpRGDSiHhlICmStCzgfMrYNIxj5KJPS1GXpscI199ngiFpi+C
         JdrhcL8R/Z6hg8fkrn51t7ki9tlMejnzQbqXsJRpin9OjO/nF29bTOy97NzwNNx3yI7I
         BUZQ==
X-Gm-Message-State: AOAM532xbHD4dpmEDTA/67UU5d5WD4OveEhb5JfwVlOH1gUzwwSzJ8e4
        +txjKuIEq5LrdnF7wiQK25n+9A==
X-Google-Smtp-Source: ABdhPJwZ7RIf1Mv26UmtNuw4VQZ0frbLNOe8nDz8itMxjbg0gojSWqRwnq7wNETXijrc/qdguRGr1Q==
X-Received: by 2002:adf:fe51:: with SMTP id m17mr21015037wrs.441.1643189794278;
        Wed, 26 Jan 2022 01:36:34 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:f589:cf7d:b2ee:bb5e? ([2a01:e34:ed2f:f020:f589:cf7d:b2ee:bb5e])
        by smtp.googlemail.com with ESMTPSA id h4sm22800855wre.0.2022.01.26.01.36.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 01:36:33 -0800 (PST)
Subject: Re: [PATCH v7 5/5] rockchip/soc/drivers: Add DTPM description for
 rk3399
To:     heiko@sntech.de
Cc:     robh@kernel.org, lukasz.luba@arm.com, arnd@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>, rjw@rjwysocki.net
References: <20220125171809.1273269-1-daniel.lezcano@linaro.org>
 <20220125171809.1273269-6-daniel.lezcano@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <f91ac11e-82bf-2803-bb22-1a4500f07468@linaro.org>
Date:   Wed, 26 Jan 2022 10:36:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220125171809.1273269-6-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Heiko,

do you have comments on this patch?


On 25/01/2022 18:18, Daniel Lezcano wrote:
> The DTPM framework does support now the hierarchy description.
> 
> The platform specific code can call the hierarchy creation function
> with an array of struct dtpm_node pointing to their parent.
> 
> This patch provides a description of the big / Little CPUs and the
> GPU and tie them together under a virtual 'package' name. Only rk3399 is
> described now.
> 
> The description could be extended in the future with the memory
> controller with devfreq.
> 
> The description is always a module and it describes the soft
> dependencies. The userspace has to load the softdeps module in the
> right order.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/soc/rockchip/Kconfig  |  8 +++++
>  drivers/soc/rockchip/Makefile |  1 +
>  drivers/soc/rockchip/dtpm.c   | 59 +++++++++++++++++++++++++++++++++++
>  3 files changed, 68 insertions(+)
>  create mode 100644 drivers/soc/rockchip/dtpm.c
> 
> diff --git a/drivers/soc/rockchip/Kconfig b/drivers/soc/rockchip/Kconfig
> index 25eb2c1e31bb..6dc017f02431 100644
> --- a/drivers/soc/rockchip/Kconfig
> +++ b/drivers/soc/rockchip/Kconfig
> @@ -34,4 +34,12 @@ config ROCKCHIP_PM_DOMAINS
>  
>            If unsure, say N.
>  
> +config ROCKCHIP_DTPM
> +	tristate "Rockchip DTPM hierarchy"
> +	depends on DTPM && DRM_PANFROST && m
> +	help
> +	 Describe the hierarchy for the Dynamic Thermal Power
> +	 Management tree on this platform. That will create all the
> +	 power capping capable devices.
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
> index 000000000000..0b73a9cba954
> --- /dev/null
> +++ b/drivers/soc/rockchip/dtpm.c
> @@ -0,0 +1,59 @@
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
> +	[0]{ .name = "rk3399",
> +	     .type = DTPM_NODE_VIRTUAL },
> +	[1]{ .name = "package",
> +	     .type = DTPM_NODE_VIRTUAL,
> +	     .parent = &rk3399_hierarchy[0] },
> +	[2]{ .name = "/cpus/cpu@0",
> +	     .type = DTPM_NODE_DT,
> +	     .parent = &rk3399_hierarchy[1] },
> +	[3]{ .name = "/cpus/cpu@1",
> +	     .type = DTPM_NODE_DT,
> +	     .parent = &rk3399_hierarchy[1] },
> +	[4]{ .name = "/cpus/cpu@2",
> +	     .type = DTPM_NODE_DT,
> +	     .parent = &rk3399_hierarchy[1] },
> +	[5]{ .name = "/cpus/cpu@3",
> +	     .type = DTPM_NODE_DT,
> +	     .parent = &rk3399_hierarchy[1] },
> +	[6]{ .name = "/cpus/cpu@100",
> +	     .type = DTPM_NODE_DT,
> +	     .parent = &rk3399_hierarchy[1] },
> +	[7]{ .name = "/cpus/cpu@101",
> +	     .type = DTPM_NODE_DT,
> +	     .parent = &rk3399_hierarchy[1] },
> +	[8]{ .name = "/gpu@ff9a0000",
> +	     .type = DTPM_NODE_DT,
> +	     .parent = &rk3399_hierarchy[1] },
> +	[9]{ },
> +};
> +
> +static struct of_device_id __initdata rockchip_dtpm_match_table[] = {
> +        { .compatible = "rockchip,rk3399", .data = rk3399_hierarchy },
> +        {},
> +};
> +
> +static int __init rockchip_dtpm_init(void)
> +{
> +	return dtpm_create_hierarchy(rockchip_dtpm_match_table);
> +}
> +module_init(rockchip_dtpm_init);
> +
> +MODULE_SOFTDEP("pre: panfrost cpufreq-dt");
> +MODULE_DESCRIPTION("Rockchip DTPM driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:dtpm");
> +MODULE_AUTHOR("Daniel Lezcano <daniel.lezcano@kernel.org");
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
