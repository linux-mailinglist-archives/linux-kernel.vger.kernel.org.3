Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8645152E89F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 11:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347676AbiETJTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 05:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344688AbiETJTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 05:19:17 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1CE8DDC0;
        Fri, 20 May 2022 02:19:16 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id gh17so1436265ejc.6;
        Fri, 20 May 2022 02:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:message-id:in-reply-to:references
         :mime-version;
        bh=VcTPVaqvCoNVkgpyNm16dnWDGZyl5qL7WxaDnKuP598=;
        b=QgSDOiwBJT42qz52RUfx+h8cf/UitIJqtSoyX9Yu2FMeGlS0WRwYR4ZXdQc/pjjSJn
         c7Rd8VXTTo2vSXpQqyMesenS5rB/lmJwAO6jP+Knx8p2DS2goYNODLBijrAIRpNEva+o
         LWquEXbcrRP4tiy1EzuQxSJqtNVZwEWBOs1Qu6CiRyTQppODkc2jTLQlFza4srgQes2+
         n+6l0oOmwW3Zgpk5dERg4MAmlb9M5cUXY7PX/kDO1axss+oPDsOXhmGB2pOKUjdgrdc4
         HEpa37dQp2+3kPtMJV9ojcycikDd50ks3zDV7Y+2iFPSqU+hWATNKiNZqTvMquCZ0CTe
         I9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :references:mime-version;
        bh=VcTPVaqvCoNVkgpyNm16dnWDGZyl5qL7WxaDnKuP598=;
        b=JFVPQMXqMZaY85jFPx+uyS2mfkKOUklgJkPO3RBPGENpovzNa8DRi/Bna7oD2BhJwN
         zfeUul58E1wPyM6ns5WVUydosAqD+sRawWJDwDhIYQZBVwpL3+zZSZlCxdh9v5oe2mDR
         wxUKB2CUNg0QGU+hv52salFsVOvbCEqEH2bi/nBfA1wGpcuFGAAMj5Ci3GrCHcoUBtz1
         lrDxIIyC5IIVzUO/v//o50qJtEPtOAXvOKq/sAThDLHnmXk53ymSknzJfes+i84MsI72
         M/LjkelAh6g9z61/WXdmz160fhvkHiD0AfnZoBmCdmPQSjhx9TxpQzDElfZThUBwqZ2I
         WWUw==
X-Gm-Message-State: AOAM531ZGDZfSbURN5tuFQBvexHpWBJVqQbdKheUt6tHuDZq7IZ7Zs6E
        8muPAilSgVy+SOnMUAffnuDxCpPekfZ31V1Y
X-Google-Smtp-Source: ABdhPJzAUO9xeQzHtZ5a0Bbqyka1OnEaUWkU5eUvOy0bNzKwPcZqDJG4M05mzo97Bx7Dhn70lKrZSg==
X-Received: by 2002:a17:907:7e92:b0:6f4:c553:c734 with SMTP id qb18-20020a1709077e9200b006f4c553c734mr7920226ejc.286.1653038354816;
        Fri, 20 May 2022 02:19:14 -0700 (PDT)
Received: from [192.168.151.247] ([138.199.7.159])
        by smtp.gmail.com with ESMTPSA id g16-20020a056402321000b0042ae33e055bsm4130930eda.2.2022.05.20.02.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 02:19:14 -0700 (PDT)
Date:   Fri, 20 May 2022 13:18:59 +0400
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
Subject: Re: [PATCH v2 4/4] clk: mediatek: Add drivers for MediaTek MT6735
 main clock drivers
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     angelogioacchino.delregno@collabora.com, bgolaszewski@baylibre.com,
        chun-jie.chen@mediatek.com, devicetree@vger.kernel.org,
        ikjn@chromium.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, mturquette@baylibre.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org, sam.shih@mediatek.com,
        sboyd@kernel.org, tinghan.shen@mediatek.com, weiyi.lu@mediatek.com,
        wenst@chromium.org, y.oudjana@protonmail.com,
        ~postmarketos/upstreaming@lists.sr.ht
Message-Id: <NJC6CR.M4CF312LSXXV1@gmail.com>
In-Reply-To: <20220520083514.27891-1-miles.chen@mediatek.com>
References: <20220519142211.458336-5-y.oudjana@protonmail.com>
        <20220520083514.27891-1-miles.chen@mediatek.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, May 20 2022 at 16:35:14 +0800, Miles Chen 
<miles.chen@mediatek.com> wrote:
> hi Yassine,
> 
>>  Add drivers for MT6735 apmixedsys, topckgen, infracfg and pericfg
>>  clock and reset controllers. These provide the base clocks on the
>>  platform, and should be enough to bring up all essential blocks
>>  including PWRAP, MSDC and peripherals (UART, I2C, SPI).
>> 
>>  Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
>>  ---
>>  Dependencies:
>>  - clk: mediatek: Move to struct clk_hw provider APIs (series)
>>    
>> https://patchwork.kernel.org/project/linux-mediatek/cover/20220510104804.544597-1-wenst@chromium.org/
>>  - Cleanup MediaTek clk reset drivers and support MT8192/MT8195 
>> (series)
>>    
>> https://patchwork.kernel.org/project/linux-mediatek/cover/20220503093856.22250-1-rex-bc.chen@mediatek.com/
>>  - Export required symbols to compile clk drivers as module (single 
>> patch)
>>    
>> https://patchwork.kernel.org/project/linux-mediatek/patch/20220518111652.223727-7-angelogioacchino.delregno@collabora.com/
>>  - clk: mediatek: Improvements to simple probe/remove and reset 
>> controller unregistration
>>    
>> https://patchwork.kernel.org/project/linux-clk/cover/20220519134728.456643-1-y.oudjana@protonmail.com/
>> 
>>   MAINTAINERS                                  |    4 +
>>   drivers/clk/mediatek/Kconfig                 |    9 +
>>   drivers/clk/mediatek/Makefile                |    1 +
>>   drivers/clk/mediatek/clk-mt6735-apmixedsys.c |  235 ++++
> 
> ...snip...
> 
>>  +#define APLL2_CON0		0x284
>>  +#define APLL2_CON1		0x288
>>  +#define APLL2_CON2		0x28c
>>  +#define APLL2_PWR_CON0		0x294
>>  +
>>  +#define CON0_RST_BAR		BIT(24)
>>  +
>>  +static const struct mtk_pll_data apmixedsys_plls[] = {
>>  +	{
>>  +		.id = ARMPLL,
>>  +		.name = "armpll",
>>  +		.parent_name = "clk26m",
>>  +
>>  +		.reg = ARMPLL_CON0,
>>  +		.pwr_reg = ARMPLL_PWR_CON0,
>>  +		.en_mask = 0x00000001,
>>  +
>>  +		.pd_reg = ARMPLL_CON1,
>>  +		.pd_shift = 24,
>>  +
>>  +		.pcw_reg = ARMPLL_CON1,
>>  +		.pcw_chg_reg = ARMPLL_CON1,
>>  +		.pcwbits = 21,
>>  +
>>  +		.flags = PLL_AO
> 
> Thanks for submitting this patch.
> 
> I compare this with drivers/clk/mediatek/clk-mt7986-apmixed.c,
> and other clk files are using macros to make the mtk_pll_data array
> more readable.

I'd actually argue that macros make it less readable. While reading
other drivers I had a lot of trouble figuring out which argument
is which field of the struct, and had to constantly go back to the
macro definitions and count arguments to find it. Having it this
way, each value is labeled clearly with the field it's in. I think
the tradeoff between line count and readability here is worth it.

> 
> Would you mind following the same style for all c files, please?
> 
> e.g.,
> 	static const struct mtk_pll_data plls[] = {
> 		PLL(CLK_APMIXED_ARMPLL, "armpll", 0x0200, 0x020C, 0x00000001, 0, 32,
> 				0x0200, 4, 0, 0x0204, 0),
> 		PLL(CLK_APMIXED_NET2PLL, "net2pll", 0x0210, 0x021C, 0x00000001, 0, 
> 32,
> 				0x0210, 4, 0, 0x0214, 0),
> 		...
> 	};
> 
>>  +	},
>>  +	{
>>  +		.id = MAINPLL,
>>  +		.name = "mainpll",
>>  +		.parent_name = "clk26m",
>>  +
>>  +		.reg = MAINPLL_CON0,
>>  +		.pwr_reg = MAINPLL_PWR_CON0,
>>  +		.en_mask = 0xf0000101,
>>  +
>>  +		.pd_reg = MAINPLL_CON1,
>>  +		.pd_shift = 24,
>>  +
>>  +		.pcw_reg = MAINPLL_CON1,
>>  +		.pcw_chg_reg = MAINPLL_CON1,
>>  +		.pcwbits = 21,
>>  +
>>  +		.flags = HAVE_RST_BAR,
>>  +		.rst_bar_mask = CON0_RST_BAR
>>  +	},
>>  +	{
>>  +		.id = UNIVPLL,
>>  +		.name = "univpll",
>>  +		.parent_name = "clk26m",
>>  +
>>  +		.reg = UNIVPLL_CON0,
>>  +		.pwr_reg = UNIVPLL_PWR_CON0,
>>  +		.en_mask = 0xfc000001,
>>  +
>>  +		.pd_reg = UNIVPLL_CON1,
>>  +		.pd_shift = 24,
>>  +
>>  +		.pcw_reg = UNIVPLL_CON1,
>>  +		.pcw_chg_reg = UNIVPLL_CON1,
>>  +		.pcwbits = 21,
>>  +
>>  +		.flags = HAVE_RST_BAR,
>>  +		.rst_bar_mask = CON0_RST_BAR
>>  +	},
>>  +	{
>>  +		.id = MMPLL,
>>  +		.name = "mmpll",
>>  +		.parent_name = "clk26m",
>>  +
>>  +		.reg = MMPLL_CON0,
>>  +		.pwr_reg = MMPLL_PWR_CON0,
>>  +		.en_mask = 0x00000001,
>>  +
>>  +		.pd_reg = MMPLL_CON1,
>>  +		.pd_shift = 24,
>>  +
>>  +		.pcw_reg = MMPLL_CON1,
>>  +		.pcw_chg_reg = MMPLL_CON1,
>>  +		.pcwbits = 21
>>  +	},
>>  +	{
>>  +		.id = MSDCPLL,
>>  +		.name = "msdcpll",
>>  +		.parent_name = "clk26m",
>>  +
>>  +		.reg = MSDCPLL_CON0,
>>  +		.pwr_reg = MSDCPLL_PWR_CON0,
>>  +		.en_mask = 0x00000001,
>>  +
>>  +		.pd_reg = MSDCPLL_CON1,
>>  +		.pd_shift = 24,
>>  +
>>  +		.pcw_reg = MSDCPLL_CON1,
>>  +		.pcw_chg_reg = MSDCPLL_CON1,
>>  +		.pcwbits = 21,
>>  +	},
>>  +	{
>>  +		.id = VENCPLL,
>>  +		.name = "vencpll",
>>  +		.parent_name = "clk26m",
>>  +
>>  +		.reg = VENCPLL_CON0,
>>  +		.pwr_reg = VENCPLL_PWR_CON0,
>>  +		.en_mask = 0x00000001,
>>  +
>>  +		.pd_reg = VENCPLL_CON1,
>>  +		.pd_shift = 24,
>>  +
>>  +		.pcw_reg = VENCPLL_CON1,
>>  +		.pcw_chg_reg = VENCPLL_CON1,
>>  +		.pcwbits = 21,
>>  +
>>  +		.flags = HAVE_RST_BAR,
>>  +		.rst_bar_mask = CON0_RST_BAR
>>  +	},
>>  +	{
>>  +		.id = TVDPLL,
>>  +		.name = "tvdpll",
>>  +		.parent_name = "clk26m",
>>  +
>>  +		.reg = TVDPLL_CON0,
>>  +		.pwr_reg = TVDPLL_PWR_CON0,
>>  +		.en_mask = 0x00000001,
>>  +
>>  +		.pd_reg = TVDPLL_CON1,
>>  +		.pd_shift = 24,
>>  +
>>  +		.pcw_reg = TVDPLL_CON1,
>>  +		.pcw_chg_reg = TVDPLL_CON1,
>>  +		.pcwbits = 21
>>  +	},
>>  +	{
>>  +		.id = APLL1,
>>  +		.name = "apll1",
>>  +		.parent_name = "clk26m",
>>  +
>>  +		.reg = APLL1_CON0,
>>  +		.pwr_reg = APLL1_PWR_CON0,
>>  +module_platform_driver(clk_mt6735_apmixedsys);
>>  +
>>  +MODULE_AUTHOR("Yassine Oudjana <y.oudjana@protonmail.com>");
>>  +MODULE_DESCRIPTION("Mediatek MT6735 apmixedsys clock driver");
> 
> Would you mind changing all Mediatek to MediaTek?
> i.e.,
> 
> s/Mediatek/MediaTek/
> 

Sure. Will fix it.

> 
> thanks,
> Miles
>  +MODULE_LICENSE("GPL");
> 

Thanks,
Yassine



