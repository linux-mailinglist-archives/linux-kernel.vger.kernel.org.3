Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E3A55CFF0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbiF0HCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 03:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiF0HCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 03:02:19 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65F55F7B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 00:02:18 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id o16so11610701wra.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 00:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=LTRupNP8zGDlH2rCD8HF8CfVKNgPhKFXXtp+I+X0sqE=;
        b=GunVaYPe0aHenehxsNEW691AFHt8ol+2ZpaACxMNN7V/O6NbASYFjjgf2oPP1TIHkT
         zyrsf3rtFQO2r+a+ln7hc4FcdVUpTR84UaVo4n84rhHkT59PVUA8mM1UUshZ7eYJ04OA
         DukqEEt/gYJIfQHoIwaxqwldk1RFEeobJAevTacX6yLfW33fJ+6IFJJl0sEic4JQBKjh
         ahBgNZJB/q/PxcTxtb76QiavIknRfBGRXk9PAdrdNG8t0ykmmi4akYmp5j8PDwbgT1Tn
         nrpCZjC9wllarxIx9fwFzJrHEeIsxdxz8FV9TtQy39PDPHdsfFEZk6bM2CLXwdlW8kBG
         JzjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=LTRupNP8zGDlH2rCD8HF8CfVKNgPhKFXXtp+I+X0sqE=;
        b=nrtluZ6OhIgaKbMk2kWdfUMn97vva0J/uuG4LBu1Jg4/wU/bs6l/dYoqYiSC8cdeuh
         C1jnUyD0PvTbatMftigJPV0fJlslp+viDrop4n/Dxohxxk+YNlyjXOiLyd6P5M4h3Cna
         ij24Lo3oA8GsrLrZK4HjNtUXbJMZr8LhXaQkVCfCtSE/S+ODWZVnM7kgEprCHwcgb0vY
         kJ3XTyV8p2AoHniyBgLmKPifwLxj9wtQfK6UAACvZDXy9isxlNb7ybVxAimUe1Xhq9IO
         QsUb6IeahryC+zcpts9NrT0AzHlzRC/9sVSLBLla+9GA9Kt2uGTISrWTpgLsTkDPwobO
         T6uQ==
X-Gm-Message-State: AJIora84HEfumOkEoXLNBU/Okzws4mR5RcgbYLcq1oegR4hEVW3xJErq
        6z8uDKWVeuGUvSgzN5X78kDp4Q==
X-Google-Smtp-Source: AGRyM1t7nroGAbqdhY6T5XxWBzJWB/PdIsEagImnNYDHnCS7rC/REHafmtvVrPe/H7ZA+YSTp30Fiw==
X-Received: by 2002:a05:6000:1f08:b0:21b:ae8f:4f0a with SMTP id bv8-20020a0560001f0800b0021bae8f4f0amr11200060wrb.456.1656313337255;
        Mon, 27 Jun 2022 00:02:17 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:6f56:f3c6:ba4f:bf5c? ([2001:861:44c0:66c0:6f56:f3c6:ba4f:bf5c])
        by smtp.gmail.com with ESMTPSA id y10-20020a1c4b0a000000b0039c587342d8sm16489337wma.3.2022.06.27.00.02.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 00:02:16 -0700 (PDT)
Message-ID: <ee17ba1e-19ef-f72d-ce81-077fa5c30bd7@baylibre.com>
Date:   Mon, 27 Jun 2022 09:02:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v8 5/5] mtd: rawnand: meson: not support legacy clock
Content-Language: en-US
To:     Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org
Cc:     kernel test robot <lkp@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        XianWei Zhao <xianwei.zhao@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        BiChao Zheng <bichao.zheng@amlogic.com>,
        YongHui Yu <yonghui.yu@amlogic.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220627031703.33243-1-liang.yang@amlogic.com>
 <20220627031703.33243-6-liang.yang@amlogic.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220627031703.33243-6-liang.yang@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/06/2022 05:17, Liang Yang wrote:
> meson NFC driver use common clock interfaces. so the test robot report
> some errors once using the legacy clock with HAVE_LEGACY_CLK on.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Liang Yang <liang.yang@amlogic.com>
> ---
>   drivers/mtd/nand/raw/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> index 67b7cb67c030..c309cfeb74cd 100644
> --- a/drivers/mtd/nand/raw/Kconfig
> +++ b/drivers/mtd/nand/raw/Kconfig
> @@ -395,7 +395,7 @@ config MTD_NAND_STM32_FMC2
>   
>   config MTD_NAND_MESON
>   	tristate "Support for NAND controller on Amlogic's Meson SoCs"
> -	depends on ARCH_MESON || COMPILE_TEST
> +	depends on COMMON_CLK && (ARCH_MESON || COMPILE_TEST)
>   	select MFD_SYSCON
>   	help
>   	  Enables support for NAND controller on Amlogic's Meson SoCs.

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
