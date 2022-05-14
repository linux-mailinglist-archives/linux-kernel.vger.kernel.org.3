Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FBF527050
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 11:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbiENJgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 05:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbiENJf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 05:35:56 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA72E90;
        Sat, 14 May 2022 02:35:55 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id u23so18238652lfc.1;
        Sat, 14 May 2022 02:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9bON5I8dBLTli09gYDVRZAOvbSHuOcYBnAT6sWpt8v0=;
        b=KEkFaNttl7V7FEihDHHSSuU636QWKiLfXshYdyn8lq3aLqum/xm8JVHSrRKzlldw+R
         o1rc5KRqfjJmzpQ2qBSVLqiSS+GqOPBRZbkSQxgxj05gQ9IarKQ9Mxq2ZYXs1+ZWrTcw
         dpTqeVpKBTEoaV8pGCb4wcDUpMSmZ6lZW99/KANy++8jxAIOZYLhw0it/iS0HyhIpQ++
         my6QM9lPKl4QjQHj3/w3Kz00KfMnrqFwSd41CqYQR0K5ZUYijiX5hZ4gPjJ7zWu+O1we
         kxm+cqzQjSAyoqZo43ZzSRa3hQfHN4m1EAsGD7rKtYx3saxCQLXsKlSDnF/MjHuvSEl5
         u16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9bON5I8dBLTli09gYDVRZAOvbSHuOcYBnAT6sWpt8v0=;
        b=vUSuOUv60FTX3fPNao1p7oqL1DkBRKbcgfm6yiV6+IAH4jEcBTp2JNoulMZjJO64db
         BqC2AsBXsXMQNasDHXRcus9CgOFkOYdcYQB1DP89+3afZyg4Jr789rXDd9JccalJJz+Z
         1WNlE0UvbHjOdjuHHFRYxBty9Va4cZXcoU8BrhySHPhBd8ozWJDTrezTfI28mgnfCSUS
         bSf74qWVGWP9KJaPZbZ19MWQSdaPDOgx1fST29FFcSEq5O0HnqGyAC4CsxREZAa4NxPt
         eV889Ma7JnLaapQWtszF94zj3vSkJ3W8/Rb8Gc4MvEHNwpUUzSYIpCixO2LNjLzSy9kH
         +VXA==
X-Gm-Message-State: AOAM533UfHL9cM+P3oWmcxmUzl9c3JqJzaCRaPyviUFsGhXZtnM/u1DJ
        4GTIYEM7EfflVfxxhir1f5znSLfIvbvzpw==
X-Google-Smtp-Source: ABdhPJzu4j4jzb+I5ffVkHkC1IPaeSod8S923nLoNM+nFx0WOGl7Zp1ZdW9e7Xi3pO/Vc2LsRQ9uNg==
X-Received: by 2002:ac2:48a4:0:b0:471:fc7f:b54d with SMTP id u4-20020ac248a4000000b00471fc7fb54dmr6376200lfg.538.1652520953758;
        Sat, 14 May 2022 02:35:53 -0700 (PDT)
Received: from [192.168.1.103] ([31.173.80.11])
        by smtp.gmail.com with ESMTPSA id d7-20020a05651221c700b0047255d210f0sm660466lft.31.2022.05.14.02.35.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 May 2022 02:35:52 -0700 (PDT)
Subject: Re: [PATCH 3/3] ARM: dts: lan966x: Add UDPHS support
To:     Herve Codina <herve.codina@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20220513105850.310375-1-herve.codina@bootlin.com>
 <20220513105850.310375-4-herve.codina@bootlin.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <4436479e-c0ef-4962-7ad3-2b8b80e1643a@gmail.com>
Date:   Sat, 14 May 2022 12:35:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220513105850.310375-4-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 5/13/22 1:58 PM, Herve Codina wrote:

> Add UDPHS (the USB High Speed Device Port controller) support.
> The UDPHS IP present in the lan966x SOC is the same as the one
> present in the SAMA5D3 SOC
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  arch/arm/boot/dts/lan966x.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/lan966x.dtsi b/arch/arm/boot/dts/lan966x.dtsi
> index 7d2869648050..4c09f3166d27 100644
> --- a/arch/arm/boot/dts/lan966x.dtsi
> +++ b/arch/arm/boot/dts/lan966x.dtsi
> @@ -211,6 +211,17 @@ can0: can@e081c000 {
>  			status = "disabled";
>  		};
>  
> +		udc: udphs@e0808000 {

   Shouldn't it be:

		udphs: udc@e0808000 {

(as the node names should be generic)?

[...]

MBR, Sergey
