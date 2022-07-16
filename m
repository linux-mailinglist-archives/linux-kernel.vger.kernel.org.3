Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A11A576F88
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 16:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbiGPOyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 10:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiGPOyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 10:54:47 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CFE1A819
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 07:54:46 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id l9-20020a056830268900b006054381dd35so5620246otu.4
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 07:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ekPldm2A1SVt6kxU75sPPup61vgqjjJ2DCb2TpRe0gk=;
        b=JxEpfrwSqIHzHrXzQybnp31riyX3iEKfds8el+eDvc50Y1ubQe5s99VwZHKfkLpxF4
         cLs6sCd3TU41ZSbDShuqCsEyIJYi6YVjESGIM5Ofz82vcfijHM8VT7mNxro5FNEQ6kIH
         jXzRcAjo7+ZjxU0yHFPJBp8H0TRiUj9NMkcNkO+ViAj6z+A4PSf+TdW1upV+CcOTTPJu
         dm4Tcgp8ez816zkS7wzt8YdTe2/2W7Eaos5uo3FUYTFSzsoa27KEIL2yQxow8Pf32+eO
         rOorFTHeEDDys7GOPDgKe+WTh8VbBpuGsHadOe/2qY/7b+6Ls58Q5eIH0SjBYJK+a3pD
         Oi9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ekPldm2A1SVt6kxU75sPPup61vgqjjJ2DCb2TpRe0gk=;
        b=hTI8I1mLanVPZg1uEtAbtuPQtLgKbinAYO9OwpDBPznsH3J6htRe/8yVkqpd2iUg/C
         8hFd58gWfX0BMS9bdroGFGz59Y7w9UcKtWoGm29I4P+uozVp+PaghEQl5cibdUES+TVJ
         S598sh77rkcG0AuhBiKuFAllOP+S3o7VWcnT+N4K9L/HtzdylIeDfWmBut0WlRhW3ONF
         cgYDDjT/qtQtrE5LVLfuBz9XYYJaWWVQKxeuXzzDtATYAvX/qi1pFoj+aMdduflkLgXD
         xPuY+jhkCvDIWNbEERL7V7mOpLkRh9PiGozD2bqRtzjXam2hgTkGxnGjwcjJeHazlK10
         5Y3A==
X-Gm-Message-State: AJIora8IBoV1GCmEJelWhEzPVOPvpfapYOPfx2LPp5Uj1bXLMkrvrmfT
        K9vu/B0LS8T/1U2BN16wj7DwCA==
X-Google-Smtp-Source: AGRyM1sEFBcpxDdFdR1gAwvBYtPyOEd03azO1l5+Cj57kze/T0j64sULneyVIZwM4Xof3Vnn1TjOTQ==
X-Received: by 2002:a05:6830:2465:b0:61c:8d2e:215 with SMTP id x37-20020a056830246500b0061c8d2e0215mr1957724otr.116.1657983285360;
        Sat, 16 Jul 2022 07:54:45 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id t4-20020a4a96c4000000b004356bc04240sm3044445ooi.5.2022.07.16.07.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 07:54:44 -0700 (PDT)
Date:   Sat, 16 Jul 2022 09:54:43 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Brian Masney <bmasney@redhat.com>
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        ahalaney@redhat.com, echanude@redhat.com
Subject: Re: [PATCH] clk: qcom: sc8280xp: add parent to gcc_ufs_phy_axi_clk
 for sa8540p
Message-ID: <YtLRM7vQhimGFimN@builder.lan>
References: <20220623142837.3140680-1-bmasney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623142837.3140680-1-bmasney@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 23 Jun 09:28 CDT 2022, Brian Masney wrote:

> The sa8540p automotive board has the same SOC as the sc8280xp. In order
> to get the first UFS controller working on the sa8540p,
> GCC_UFS_REF_CLKREF_CLK needs to be setup as a parent to
> GCC_UFS_PHY_AXI_CLK.
> 
> This clock name came from the DTS for the downstream MSM 5.4 kernel
> sources for the sa8540p. It also references GCC_UFS_CARD_CLKREF_CLK,
> however that wasn't needed to get the first UFS controller working.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---
> I originally added this under GCC_UFS_PHY_PHY_AUX_CLK since that's
> what's in the downstream DTS. I was getting errors about
> GCC_UFS_PHY_AXI_CLK being stuck at off so I moved it there.
> 
> Also I don't have access to any documentation for this board so I'm
> hoping that someone with docs access can verify that this is the
> appropriate place to put this.
> 
>  drivers/clk/qcom/gcc-sc8280xp.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gcc-sc8280xp.c b/drivers/clk/qcom/gcc-sc8280xp.c
> index 4b894442fdf5..4639b50da418 100644
> --- a/drivers/clk/qcom/gcc-sc8280xp.c
> +++ b/drivers/clk/qcom/gcc-sc8280xp.c
> @@ -5685,6 +5685,19 @@ static struct clk_branch gcc_ufs_phy_ahb_clk = {
>  	},
>  };
>  
> +static struct clk_branch gcc_ufs_ref_clkref_clk = {
> +	.halt_reg = 0x8c058,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x8c058,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "gcc_ufs_ref_clkref_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
>  static struct clk_branch gcc_ufs_phy_axi_clk = {
>  	.halt_reg = 0x77010,
>  	.halt_check = BRANCH_HALT_VOTED,
> @@ -5696,6 +5709,7 @@ static struct clk_branch gcc_ufs_phy_axi_clk = {
>  		.hw.init = &(const struct clk_init_data) {
>  			.name = "gcc_ufs_phy_axi_clk",
>  			.parent_hws = (const struct clk_hw*[]){
> +				&gcc_ufs_ref_clkref_clk.clkr.hw,

gcc_ufs_ref_clkref_clk isn't the parent of gcc_ufs_phy_axi_clk.

But I presume that if this works, then you're just enabling the ufs
clkref clock, indirectly. Seems reasonable that you should be specifying
gcc_ufs_ref_clkref_clk as "ref_clk" instead.

Could you please give that a go?

Regards,
Bjorn

>  				&gcc_ufs_phy_axi_clk_src.clkr.hw,
>  			},
>  			.num_parents = 1,
> @@ -5899,19 +5913,6 @@ static struct clk_branch gcc_ufs_phy_unipro_core_hw_ctl_clk = {
>  	},
>  };
>  
> -static struct clk_branch gcc_ufs_ref_clkref_clk = {
> -	.halt_reg = 0x8c058,
> -	.halt_check = BRANCH_HALT,
> -	.clkr = {
> -		.enable_reg = 0x8c058,
> -		.enable_mask = BIT(0),
> -		.hw.init = &(const struct clk_init_data) {
> -			.name = "gcc_ufs_ref_clkref_clk",
> -			.ops = &clk_branch2_ops,
> -		},
> -	},
> -};
> -
>  static struct clk_branch gcc_usb2_hs0_clkref_clk = {
>  	.halt_reg = 0x8c044,
>  	.halt_check = BRANCH_HALT,
> -- 
> 2.36.1
> 
