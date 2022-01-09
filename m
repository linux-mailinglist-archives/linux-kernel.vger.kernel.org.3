Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0E5488BEF
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 20:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236589AbiAITHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 14:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbiAITHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 14:07:47 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E135BC06173F;
        Sun,  9 Jan 2022 11:07:46 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id u23so146569qku.5;
        Sun, 09 Jan 2022 11:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LIuUJEhpYyiWk5SC4KmPzkhX52Ed+ueySMLZ3ZhnSEk=;
        b=TtMMW6PSKK4lVCx9+fMTxUzSLfQtUAm/w1mkSQDtnL5cWcht9+mxwbS4mTnNTizPpv
         FXIIxyXErbEf9uPZVS7CjHE0JhHZrWf0XjRWuvPOhx5prJDLMbasZ4gvRu7qJ27DlbSP
         6GxKPHp7nCNaIR9S9e5kTcFEsp5EcX/jopf51NbotX5kOXt8EZXNYnLTULgFseLO5V/a
         i2YA4FEiKn6hSrM9+QwQ/X3JE/kewcmYtfFeJn+P4JXLe6YEoLG0pzfLjA1k32dv4umj
         lEKrgLZz04j0MBEJdGnmC3xz22oAvw4j8aDNkd3zQ8h83uKgV/7moULU09RisQlz3DmM
         Nibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LIuUJEhpYyiWk5SC4KmPzkhX52Ed+ueySMLZ3ZhnSEk=;
        b=ye4GdtCxHDuPfcJaAZZvXCC7WuUSoXhHO+90fZpy+6qZcqpsK3zTUE1ewQibXwBDAd
         vfBloE9iJ0J+W92aaSMByvSzEUmf/F/D2f260I4h5+4GoDoMVNkqSKel0vDQsqX4dUcj
         m7o/KiCgpV+gFXLXE+QU10heuQDQ8YzeFqqlKQR9VoeCpX3F/TVx2PXqXhgweg6Efe6l
         MrnpoLk/o6YBUtNkvQ28BDRCZBtiEWOoNr7lL//Aqb1o8yz9vuVC1CKYoF/w1cAjZkGf
         oBgafuxt7zRMJBsDbVVl5/6/0XdaMxP37s1ouRiEi0exiCI9eZx7bFfLeTSLWIJont0Y
         LLAA==
X-Gm-Message-State: AOAM530QBDj02Tve2uZ4vxd0tYm2agDyS/KuxSvXINVSOezZDfagR2QI
        QZdM/D1St5+c+MOpLe0pp/0=
X-Google-Smtp-Source: ABdhPJz8ma6DoK2QLPKid3Ugn7xuBVtSTf8DbubDXxK/pwWaX/AMeOn71DOoBCeEq/YsBqZlTl8Byg==
X-Received: by 2002:a05:620a:1452:: with SMTP id i18mr12576732qkl.557.1641755265978;
        Sun, 09 Jan 2022 11:07:45 -0800 (PST)
Received: from [10.4.10.38] (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id h18sm280121qkn.62.2022.01.09.11.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jan 2022 11:07:45 -0800 (PST)
Message-ID: <89046151-e44e-6828-ad76-8574fba4fca8@gmail.com>
Date:   Sun, 9 Jan 2022 14:07:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v7 5/7] clk: imx: Add initial support for i.MXRT1050 clock
 driver
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, linux-imx@nxp.com
Cc:     mturquette@baylibre.com, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        ulf.hansson@linaro.org, aisheng.dong@nxp.com, stefan@agner.ch,
        linus.walleij@linaro.org, gregkh@linuxfoundation.org,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        linux@armlinux.org.uk, abel.vesa@nxp.com, adrian.hunter@intel.com,
        jirislaby@kernel.org, giulio.benetti@benettiengineering.com,
        nobuhiro1.iwamatsu@toshiba.co.jp, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org
References: <20220103233948.198119-1-Mr.Bossman075@gmail.com>
 <20220103233948.198119-6-Mr.Bossman075@gmail.com>
 <20220105235157.8ED80C36AEB@smtp.kernel.org>
From:   Jesse Taube <mr.bossman075@gmail.com>
In-Reply-To: <20220105235157.8ED80C36AEB@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> +static const char * const pll_ref_sels[] = {"osc", "dummy", };
>> +static const char * const per_sels[] = {"ipg_pdof", "osc", };
>> +static const char * const pll1_bypass_sels[] = {"pll1_arm", "pll1_arm_ref_sel", };
>> +static const char * const pll2_bypass_sels[] = {"pll2_sys", "pll2_sys_ref_sel", };
>> +static const char * const pll3_bypass_sels[] = {"pll3_usb_otg", "pll3_usb_otg_ref_sel", };
>> +static const char * const pll5_bypass_sels[] = {"pll5_video", "pll5_video_ref_sel", };
>> +static const char *const pre_periph_sels[] = {
>> +       "pll2_sys", "pll2_pfd2_396m", "pll2_pfd0_352m", "arm_podf", };
>> +static const char *const periph_sels[] = { "pre_periph_sel", "todo", };
>> +static const char *const usdhc_sels[] = { "pll2_pfd2_396m", "pll2_pfd0_352m", };
>> +static const char *const lpuart_sels[] = { "pll3_80m", "osc", };
>> +static const char *const lcdif_sels[] = {
>> +       "pll2_sys", "pll3_pfd3_454_74m", "pll5_video", "pll2_pfd0_352m",
>> +       "pll2_pfd1_594m", "pll3_pfd1_664_62m", };
>> +static const char *const semc_alt_sels[] = { "pll2_pfd2_396m", "pll3_pfd1_664_62m", };
>> +static const char *const semc_sels[] = { "periph_sel", "semc_alt_sel", };
> 
> Any chance this can use clk_parent_data instead of string names for
> parents?
> 
>> +
>> +static struct clk_hw **hws;
>> +static struct clk_hw_onecell_data *clk_hw_data;
>> +
>> +static void __init imxrt_clocks_common_init(void __iomem *base)
> 
> Drop __init and preferably inline this to the callsite.
> 
>> +{
>> +       /* Anatop clocks */
>> +       hws[IMXRT1050_CLK_DUMMY] = imx_clk_hw_fixed("dummy", 0UL);
>> +
>> +       hws[IMXRT1050_CLK_PLL1_REF_SEL] = imx_clk_hw_mux("pll1_arm_ref_sel",
>> +               base + 0x0, 14, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
>> +       hws[IMXRT1050_CLK_PLL2_REF_SEL] = imx_clk_hw_mux("pll2_sys_ref_sel",
>> +               base + 0x30, 14, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
>> +       hws[IMXRT1050_CLK_PLL3_REF_SEL] = imx_clk_hw_mux("pll3_usb_otg_ref_sel",
>> +               base + 0x10, 14, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
>> +       hws[IMXRT1050_CLK_PLL5_REF_SEL] = imx_clk_hw_mux("pll5_video_ref_sel",
>> +               base + 0xa0, 14, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
>> +
>> +       hws[IMXRT1050_CLK_PLL1_ARM] = imx_clk_hw_pllv3(IMX_PLLV3_SYS, "pll1_arm",
>> +               "pll1_arm_ref_sel", base + 0x0, 0x7f);
>> +       hws[IMXRT1050_CLK_PLL2_SYS] = imx_clk_hw_pllv3(IMX_PLLV3_GENERIC, "pll2_sys",
>> +               "pll2_sys_ref_sel", base + 0x30, 0x1);
>> +       hws[IMXRT1050_CLK_PLL3_USB_OTG] = imx_clk_hw_pllv3(IMX_PLLV3_USB, "pll3_usb_otg",
>> +               "pll3_usb_otg_ref_sel", base + 0x10, 0x1);
>> +       hws[IMXRT1050_CLK_PLL5_VIDEO] = imx_clk_hw_pllv3(IMX_PLLV3_AV, "pll5_video",
>> +               "pll5_video_ref_sel", base + 0xa0, 0x7f);
>> +
>> +       /* PLL bypass out */
>> +       hws[IMXRT1050_CLK_PLL1_BYPASS] = imx_clk_hw_mux_flags("pll1_bypass", base + 0x0, 16, 1,
>> +               pll1_bypass_sels, ARRAY_SIZE(pll1_bypass_sels), CLK_SET_RATE_PARENT);
>> +       hws[IMXRT1050_CLK_PLL2_BYPASS] = imx_clk_hw_mux_flags("pll2_bypass", base + 0x30, 16, 1,
>> +               pll2_bypass_sels, ARRAY_SIZE(pll2_bypass_sels), CLK_SET_RATE_PARENT);
>> +       hws[IMXRT1050_CLK_PLL3_BYPASS] = imx_clk_hw_mux_flags("pll3_bypass", base + 0x10, 16, 1,
>> +               pll3_bypass_sels, ARRAY_SIZE(pll3_bypass_sels), CLK_SET_RATE_PARENT);
>> +       hws[IMXRT1050_CLK_PLL5_BYPASS] = imx_clk_hw_mux_flags("pll5_bypass", base + 0xa0, 16, 1,
>> +               pll5_bypass_sels, ARRAY_SIZE(pll5_bypass_sels), CLK_SET_RATE_PARENT);
>> +
>> +       hws[IMXRT1050_CLK_VIDEO_POST_DIV_SEL] = imx_clk_hw_divider("video_post_div_sel",
>> +               "pll5_video", base + 0xa0, 19, 2);
>> +       hws[IMXRT1050_CLK_VIDEO_DIV] = imx_clk_hw_divider("video_div",
>> +               "video_post_div_sel", base + 0x170, 30, 2);
>> +
>> +       hws[IMXRT1050_CLK_PLL3_80M] = imx_clk_hw_fixed_factor("pll3_80m",  "pll3_usb_otg", 1, 6);
>> +
>> +       hws[IMXRT1050_CLK_PLL2_PFD0_352M] = imx_clk_hw_pfd("pll2_pfd0_352m", "pll2_sys", base + 0x100, 0);
>> +       hws[IMXRT1050_CLK_PLL2_PFD1_594M] = imx_clk_hw_pfd("pll2_pfd1_594m", "pll2_sys", base + 0x100, 1);
>> +       hws[IMXRT1050_CLK_PLL2_PFD2_396M] = imx_clk_hw_pfd("pll2_pfd2_396m", "pll2_sys", base + 0x100, 2);
>> +       hws[IMXRT1050_CLK_PLL3_PFD1_664_62M] = imx_clk_hw_pfd("pll3_pfd1_664_62m", "pll3_usb_otg", base + 0xf0, 1);
>> +       hws[IMXRT1050_CLK_PLL3_PFD3_454_74M] = imx_clk_hw_pfd("pll3_pfd3_454_74m", "pll3_usb_otg", base + 0xf0, 3);
>> +}
>> +
>> +static int imxrt1050_clocks_probe(struct platform_device *pdev)
>> +{
>> +       void __iomem *ccm_base;
>> +       void __iomem *pll_base;
>> +       struct device *dev = &pdev->dev;
>> +       struct device_node *np = dev->of_node;
>> +       struct device_node *anp;
>> +       int ret;
>> +
>> +       clk_hw_data = kzalloc(struct_size(clk_hw_data, hws,
>> +                                         IMXRT1050_CLK_END), GFP_KERNEL);
>> +       if (WARN_ON(!clk_hw_data))
>> +               return -ENOMEM;
>> +
>> +       clk_hw_data->num = IMXRT1050_CLK_END;
>> +       hws = clk_hw_data->hws;
>> +
>> +       hws[IMXRT1050_CLK_OSC] = __clk_get_hw(of_clk_get_by_name(np, "osc"));
> 
> Use clk_parent_data instead and reference the binding name with .fw_name

Hi Stephen, sorry to bother you again.
I'm wondering if adding `clk_parent_data` is necessary as it seems like 
it wold be a big change and the other IMX boards haven't implemented 
this yet would it be okay if I don't do this, or if it is necessary 
could you link to a patch set to change it.

