Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7584E4893D7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241207AbiAJImx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:42:53 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:43861 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241140AbiAJIkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:40:45 -0500
Received: by mail-ed1-f42.google.com with SMTP id m4so8985300edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 00:40:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vgc1sntnNb4mCabkYlzozIs2CeX6MltaJuv4XQe/6c8=;
        b=IoSjvgKgcXXPuXAJAIODbc3M1SIh5/OGC50dGODKlQY8cyvHP3tF1u+YINiREtdpcU
         656w40AJ7niOYorS1voh9ON5kT0AezGFbcC5T1TM4NqsT6Tm9BPb5Sd62F8G4II167LT
         oIMxKt9G+eibx5fAeV8Qaosq9VHpZ8T/WIYtcl/jBEnajj8tUoeodeRimIAg0feW6d2b
         a/P4jb8hiEyjytjsfXmUfXa033QXqwNv2tsigPFM3jK9vgqjLiGerKZ+6sCtv4c3e6rx
         PXmcUqkoQZvvx8eq5cl4j/+s1c6FcU/YbUt1u60fyaCr3w5zfTx6apz30ZzGtsKSsEGS
         4cEw==
X-Gm-Message-State: AOAM532Yv+prILXtTVXwNMY8c25Uy46KRgoUGmENjYdIuny0VrPcX+J6
        gvGICQtWBCmnR27ClowNieY=
X-Google-Smtp-Source: ABdhPJy7+JuNGqqHzOTnwLs+ft6s5gFl1kN+u4dD713Lpw0NQ0VGDP0dJTDIqa6J3g1mvHg7kbsnhQ==
X-Received: by 2002:a17:907:724e:: with SMTP id ds14mr60447346ejc.464.1641804044447;
        Mon, 10 Jan 2022 00:40:44 -0800 (PST)
Received: from [192.168.1.126] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.googlemail.com with ESMTPSA id 10sm2179821ejy.174.2022.01.10.00.40.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 00:40:43 -0800 (PST)
Message-ID: <c3962f91-7183-dd12-f645-629acd0cf076@kernel.org>
Date:   Mon, 10 Jan 2022 09:40:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v1 06/14] arm64: defconfig: build r8169 as a module
Content-Language: en-US
To:     Marcel Ziswiler <marcel@ziswiler.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>,
        Olof Johansson <olof@lixom.net>,
        Shawn Guo <shawnguo@kernel.org>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20220107180314.1816515-1-marcel@ziswiler.com>
 <20220107180314.1816515-7-marcel@ziswiler.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220107180314.1816515-7-marcel@ziswiler.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/2022 19:03, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Build Realtek Gigabit Ethernet driver as a module.

Why?

We see what the patch does easily, so no really need of explaining it.
What is needed here is to explain why do you do it? What board needs it?

> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> ---
> 
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index a18785a827dc..86d39d8456c1 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -338,6 +338,7 @@ CONFIG_MLX5_CORE=m
>  CONFIG_MLX5_CORE_EN=y
>  CONFIG_QCOM_EMAC=m
>  CONFIG_RMNET=m
> +CONFIG_R8169=m
>  CONFIG_SH_ETH=y
>  CONFIG_RAVB=y
>  CONFIG_SMC91X=y
> 


Best regards,
Krzysztof
