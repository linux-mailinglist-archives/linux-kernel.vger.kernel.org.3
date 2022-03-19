Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CFA4DE915
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 16:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243517AbiCSPny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 11:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243503AbiCSPnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 11:43:53 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3248D393C2;
        Sat, 19 Mar 2022 08:42:32 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id p15so7680346lfk.8;
        Sat, 19 Mar 2022 08:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6ZeJmCk5mE5R2RccHBVmn2Ty11i285jE8gWuCxpKHAM=;
        b=etnZaXT+cCQoaCs9sRpvFsEQsnbmphOmzCc0EYa/hQkW13cIbLsWLaVQ57hym7EiyD
         9JfiyvKzrypHw7e9vTIhinDAIQ4u4GGZatRHqCRWWFUAeftkvXDgWT5d36ThYKzacbZo
         lnyn4lBODMn7drMi/lCHvy8oEMMNYpNvsGeiPKpleGOF3zSi0W90qjW4+KrDl+uw3Yt+
         na/w/sLZXUzMB6i+EupVNmNLk5MKL7H8LvBD9VfxjjV4MKRnC1zpZab0gSWGhDRWMn9u
         7/wy0FWwhVtCZDzh5BcCnDnc7B+27a6038INslx/k9BW0vk+ai5HNCvAvA2upouhX2OQ
         6U9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6ZeJmCk5mE5R2RccHBVmn2Ty11i285jE8gWuCxpKHAM=;
        b=Fmp9O4QdkC5s+TXjVAcDc1PjOoyyKSGoyxYxVXrKpSN0Ql2tgtYFkWTdebFil/2YjL
         FTa3u9hvIOuVt1hPeVpN0b1s/oWxnDNdkM4f+d0609AOBjBfxoFGKbozmMnOTKYLeVtS
         s9lWa64sTLKFFwFQW/TO2/utLgriU16oZluxcq0CHDEATycx2vu/KIlMD3hByg8On+hg
         1QYhXE1OuPv8NuaPHROzvC/D2xDwzVDYqKvIjSY+dbG7fFEoPu6dsb4pfaWlFzqFpsgD
         xwmWj8+clJB9sdnZ9wT6kHGsaL5QYNBkBZcNfgWBD6ok7Wjtl4H+IOYA5pRb530xGFyS
         1kPg==
X-Gm-Message-State: AOAM530rRY/CMqMeS6dXzrOwr/y/+/+ylPSUe/MUd5M+kKvNG0oXKqKB
        AT+gyObwhaQXKxQN1Q7++Js=
X-Google-Smtp-Source: ABdhPJztR0oMkcNXDn7kJhzWOx2ynSO0TwuQ+yCpxHJ0VRIBa9+CowgcpLYhfc2vkAnsXyKfYK/mJg==
X-Received: by 2002:ac2:4825:0:b0:443:b112:e513 with SMTP id 5-20020ac24825000000b00443b112e513mr8936592lft.114.1647704550369;
        Sat, 19 Mar 2022 08:42:30 -0700 (PDT)
Received: from [192.168.2.145] (109-252-136-171.dynamic.spd-mgts.ru. [109.252.136.171])
        by smtp.googlemail.com with ESMTPSA id b11-20020ac2410b000000b004457116a575sm1325583lfi.273.2022.03.19.08.42.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Mar 2022 08:42:29 -0700 (PDT)
Message-ID: <83bc4c12-13e3-d239-3845-a3541b1fbb2a@gmail.com>
Date:   Sat, 19 Mar 2022 18:42:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Patch v5 1/4] memory: tegra: Add memory controller channels
 support
Content-Language: en-US
To:     Ashish Mhetre <amhetre@nvidia.com>,
        krzysztof.kozlowski@canonical.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220316092525.4554-1-amhetre@nvidia.com>
 <20220316092525.4554-2-amhetre@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220316092525.4554-2-amhetre@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16.03.2022 12:25, Ashish Mhetre пишет:
> From tegra186 onwards, memory controller support multiple channels.
> Add support for mapping address spaces of these channels.
> Make sure that number of channels are as expected on each SOC.
> During error interrupts from memory controller, appropriate registers
> from these channels need to be accessed for logging error info.
> 
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
>  drivers/memory/tegra/mc.c       |  6 ++++
>  drivers/memory/tegra/tegra186.c | 52 +++++++++++++++++++++++++++++++++
>  drivers/memory/tegra/tegra194.c |  1 +
>  drivers/memory/tegra/tegra234.c |  1 +
>  include/soc/tegra/mc.h          |  7 +++++
>  5 files changed, 67 insertions(+)
> 
> diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
> index bf3abb6d8354..3cda1d9ad32a 100644
> --- a/drivers/memory/tegra/mc.c
> +++ b/drivers/memory/tegra/mc.c
> @@ -749,6 +749,12 @@ static int tegra_mc_probe(struct platform_device *pdev)
>  	if (IS_ERR(mc->regs))
>  		return PTR_ERR(mc->regs);
>  
> +	if (mc->soc->ops && mc->soc->ops->map_regs) {
> +		err = mc->soc->ops->map_regs(mc, pdev);
> +		if (err < 0)
> +			return err;
> +	}
> +
>  	mc->debugfs.root = debugfs_create_dir("mc", NULL);
>  
>  	if (mc->soc->ops && mc->soc->ops->probe) {
> diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
> index 3d153881abc1..a8a45e6ff1f1 100644
> --- a/drivers/memory/tegra/tegra186.c
> +++ b/drivers/memory/tegra/tegra186.c
> @@ -139,11 +139,62 @@ static int tegra186_mc_probe_device(struct tegra_mc *mc, struct device *dev)
>  	return 0;
>  }
>  
> +static int tegra186_mc_map_regs(struct tegra_mc *mc,
> +				struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.parent->of_node;
> +	int num_dt_channels, reg_cells = 0;
> +	struct resource *res;
> +	int i, ret;
> +	u32 val;
> +
> +	ret = of_property_read_u32(np, "#address-cells", &val);
> +	if (ret) {
> +		dev_err(&pdev->dev, "missing #address-cells property\n");
> +		return ret;
> +	}
> +
> +	reg_cells = val;
> +
> +	ret = of_property_read_u32(np, "#size-cells", &val);
> +	if (ret) {
> +		dev_err(&pdev->dev, "missing #size-cells property\n");
> +		return ret;
> +	}
> +
> +	reg_cells += val;
> +
> +	num_dt_channels = of_property_count_elems_of_size(pdev->dev.of_node, "reg",
> +							  reg_cells * sizeof(u32));
> +	/*
> +	 * On tegra186 onwards, memory controller support multiple channels.
> +	 * Apart from regular memory controller channels, there is one broadcast
> +	 * channel and one for stream-id registers.
> +	 */
> +	if (num_dt_channels < mc->soc->num_channels + 2) {
> +		dev_warn(&pdev->dev, "MC channels are missing, please update\n");

Update what?

> +		return 0;
> +	}
> +
> +	mc->mcb_regs = devm_platform_get_and_ioremap_resource(pdev, 1, &res);

Can't we name each reg bank individually in the DT and then use
devm_platform_ioremap_resource_byname()?

...
> @@ -212,6 +217,8 @@ struct tegra_mc {
>  	struct tegra_smmu *smmu;
>  	struct gart_device *gart;
>  	void __iomem *regs;
> +	void __iomem *mcb_regs;
> +	void __iomem *mc_regs[MC_MAX_CHANNELS];

s/mc_regs/ch_regs/ ?
