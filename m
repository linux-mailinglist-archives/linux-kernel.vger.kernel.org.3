Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4204DE704
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 09:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242494AbiCSI0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 04:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbiCSIZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 04:25:58 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B5427CE26;
        Sat, 19 Mar 2022 01:24:36 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id s25so13941406lji.5;
        Sat, 19 Mar 2022 01:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/ZpwHLQU+wmeCbu/+G/e1bt058wLloUaoM6rRJWzX2w=;
        b=DJNAfZI9glvof+R+9AsDOymBUSQGXACtnv7dvlJQQEgvbUSWDUOgX5XISdPn+rIR58
         OiT8eG4zSIxaHrZi+XcXJKUFQakRoCNNVtsUFMIIyN1D51u/cneuivhimssLvvLDS+BX
         Kl4Ok1kPRWmAfIledIpwp/6rhssj1Nd/+TRYm7ZqQYj20dAsIQ/xjL5QTThus236/Q3W
         pPXOtpkPay8UpZmcvERp9POaAD7x4ib+wxEhnzwJb1xlMTSd6gYwWNrM6xm0fDUmGzfd
         YiKvurcwKGK5ypt22E1W5MlFk1M3VOh8CCQlKa8QNb3a1/gI0GPTRDbR5Alskwet5Ubk
         6A5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/ZpwHLQU+wmeCbu/+G/e1bt058wLloUaoM6rRJWzX2w=;
        b=8KzvjUa1CCZ5qNJxt8KyuBpbBQ94X7T4PMEYawaK4aGM80k25mWu4zMqm0R7oflOe+
         PCl/XfNXULw5v92zNWPui+idCTT59VFPgfm1d0Rag7gYZT5kWoEO6BIfxSFwJPKyRmD2
         dRzdKshmgLpeOyhL6x7UXDyoX4lCZkhVadi7RvW5XjMHyP5xcRNy5mh71v/8DwJsajLm
         7UCrhscfojUtCoIzKHv6Gb0tEr+V7zsBL+rBqdgpUbseTOPuR8Pd6caaoKnKv6PMMC6o
         gc8N6oSpMT5+eRuLl1MaH37l5jtE209UtymSHWpOUnVT0swG+EyJkkawQzy/ILRQSesA
         6lKA==
X-Gm-Message-State: AOAM530YdtDzkxIy3KSlc0+pkQn4GmP5t3mXCBDJUI/o3LqHFw2X/vr0
        9MmXdc6HwjxGE0YcrmsZUZbJQmXb4N8=
X-Google-Smtp-Source: ABdhPJyZ2UsDbC5F5eTFm1ubxR/1o29YAZM4C0C4KHStzRN8blY/0Q/TrWEVjWw+WlnXPv8mueqrbw==
X-Received: by 2002:a05:651c:17a3:b0:245:f39e:f2d2 with SMTP id bn35-20020a05651c17a300b00245f39ef2d2mr8861978ljb.490.1647678274018;
        Sat, 19 Mar 2022 01:24:34 -0700 (PDT)
Received: from [192.168.1.103] ([178.176.72.203])
        by smtp.gmail.com with ESMTPSA id bi2-20020a0565120e8200b004484aaaf818sm1232576lfb.13.2022.03.19.01.24.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Mar 2022 01:24:33 -0700 (PDT)
Subject: Re: [PATCH v2 7/8] ARM: dts: lan9662-pcb8291: fix pinctrl node name
To:     Michael Walle <michael@walle.cc>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Paul Burton <paulburton@kernel.org>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Antoine Tenart <atenart@kernel.org>,
        Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        UNGLinuxDriver@microchip.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org
References: <20220318202547.1650687-1-michael@walle.cc>
 <20220318202547.1650687-8-michael@walle.cc>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <cf2a6d1a-bf98-e382-2623-e44e5979ca29@gmail.com>
Date:   Sat, 19 Mar 2022 11:24:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220318202547.1650687-8-michael@walle.cc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 3/18/22 11:25 PM, Michael Walle wrote:

> The pinctrl device tree binding will be converted to YAML format. All
> the pin nodes should end with "-pins". Fix them.

   It does end with "pins" already, right?

> Fixes: 290deaa10c50 ("ARM: dts: add DT for lan966 SoC and 2-port board pcb8291")
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  arch/arm/boot/dts/lan966x-pcb8291.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/lan966x-pcb8291.dts b/arch/arm/boot/dts/lan966x-pcb8291.dts
> index 3281af90ac6d..3c7e3a7d6f14 100644
> --- a/arch/arm/boot/dts/lan966x-pcb8291.dts
> +++ b/arch/arm/boot/dts/lan966x-pcb8291.dts
> @@ -35,7 +35,7 @@ fc3_b_pins: fcb3-spi-pins {
>  		function = "fc3_b";
>  	};
>  
> -	can0_b_pins:  can0_b_pins {
> +	can0_b_pins:  can0-b-pins {

   Mhm, I can't even see what is changed here... :-/

[...]

MBR, Sergey
