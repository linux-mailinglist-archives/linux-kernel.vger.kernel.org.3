Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8BB4E1BA9
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 13:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245084AbiCTMdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 08:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238798AbiCTMdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 08:33:21 -0400
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69C0129261;
        Sun, 20 Mar 2022 05:31:58 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id qa43so24969627ejc.12;
        Sun, 20 Mar 2022 05:31:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BFYdZiXw/eFAD7943y4ojts/SbsmJ5s3mAERW9ZqUmQ=;
        b=QZLd442qQphlgnccaXawAAEP1mfGMogBwq+y+ZcMlJPeRDOCwgSNOT24oCgyX2OYOg
         tVXplIIzz0ZuYOuF7k1lUwHmCdKtRi5Ya3l+iH+V8CPTjaSUT7rEgD0bEVIMTUnxZVWv
         u2ZGoDFMDVSiCNTCW99tPW+VUzAy/VMNtH6KhMrKshF5AV1KHqebKn7pDA00hXOV+NMX
         47E1m0eSrwsIv5kcmFbAdbey5UZ/DMOKqdAtG0vgVHb8CnocFbLQrJSxLFz1ytqF/pRb
         8q6ing/uD+DrqqzLutKvxwvvOddIbII3UVQE791KFW/qr0kvR8TVuo/ZmN78hN4PEnbz
         +LFg==
X-Gm-Message-State: AOAM530oj91FnmLm4SsmRMK5b2UujLJUmA5KjqVEdHQrd9ylLCtWQaMQ
        7oboyjNr/Iz0LrlwOOA68/Y=
X-Google-Smtp-Source: ABdhPJzMwY0jdWTIGYQCaWFHvskjGM1PR9I4ncwINQ3+Tzx86M77tiIlPiHBh5BsD8pwZD30GVmQ6A==
X-Received: by 2002:a17:907:86a3:b0:6da:870c:af44 with SMTP id qa35-20020a17090786a300b006da870caf44mr16234430ejc.445.1647779517155;
        Sun, 20 Mar 2022 05:31:57 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id f6-20020a0564021e8600b00412ae7fda95sm6781002edf.44.2022.03.20.05.31.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Mar 2022 05:31:56 -0700 (PDT)
Message-ID: <81aa7be7-0bfa-05e6-624a-393e6810dc61@kernel.org>
Date:   Sun, 20 Mar 2022 13:31:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Patch v5 1/4] memory: tegra: Add memory controller channels
 support
Content-Language: en-US
To:     Ashish Mhetre <amhetre@nvidia.com>, robh+dt@kernel.org,
        thierry.reding@gmail.com, digetx@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220316092525.4554-1-amhetre@nvidia.com>
 <20220316092525.4554-2-amhetre@nvidia.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220316092525.4554-2-amhetre@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/2022 10:25, Ashish Mhetre wrote:
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

How did you address our previous comments about ABI break? I really do
not see it.

Best regards,
Krzysztof
