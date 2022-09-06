Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0885AF07C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbiIFQeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 12:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238928AbiIFQdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:33:38 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6276564EC
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 09:09:09 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id bx38so12791460ljb.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 09:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=AGK+sz0TUJzswJkzOmTR5fSgFOVg40XnbGraCYktuRI=;
        b=YV6RiYWlaxRg3F2sQWOI/4595QNSgL803EFFmBrTXsH5iWmLZfk7YWLJHq3XVIIwJa
         hxl+VwKFMhTxFnrkxuDCyXuQ+K3BUNio/2Uz1Cj3Z8Ld/zDpqzViGK2Wb+In2+3Zst4W
         4Ukw1xIobhTtwDJDAX+BUL0xXyDEvBXrRBVFZifXsRsocs23Zx7ot3n9v2shnG21ouqj
         dD8Q2r5Iy3PjggOI9A0Eqa8SNvGEBhHiQdcDKInbQd/s0SGiooQTwrIaxYPyghQjR9OU
         Ji42uU6jDDUFFg3P46B0nJ/eowqzyVn3qD/2MnubUhjEiYzcaPKBAKGJR+QLsjKgsm75
         bxoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=AGK+sz0TUJzswJkzOmTR5fSgFOVg40XnbGraCYktuRI=;
        b=yHqu2u9Zw38ON1l3jtlourcSoqdo2v2nOkzHu/qq13Kly8ncJmqKDzJ29Zb7Qk0Sw8
         qkn7h4VtIhvpAQQjoZJhzOqXddw+mDBtrV6+KB53ASFBei2T7TXOX/XZEcovVa8eSOmk
         vzWYG41INJef966JcD6eot5aQdqPhSZ0lM+OzeMP1g6KQrzswlinAjk50zr5LuG/Y4OY
         OE74DJA0r4QaZlRsUc0ot4WhrsM7ux9OBdfcyyXQCnTOm84muoBl9fyig4wEBsMAhU0A
         uD65oU6ga1Nk/JW+eFM0ySEtMDByqstnpJ53BhhjEbSQbXm5SS3g65dIXzg0aQJomwpi
         NIeA==
X-Gm-Message-State: ACgBeo1FYnrkXol6XtaX+v1/yIjEVBji/96MWfH9YlNQQX6GjgbF9QJ6
        7tTH609OsorncWYKrNvuAUMydw==
X-Google-Smtp-Source: AA6agR5Kirr92vR6Rq3sIqfLkPRppOYzJYHA1JIEFOhXtrzV+nker1w3wl7GyeY06o7nqTZrRlU6Vg==
X-Received: by 2002:a2e:92d5:0:b0:26a:8d21:1e37 with SMTP id k21-20020a2e92d5000000b0026a8d211e37mr1983172ljh.449.1662480547690;
        Tue, 06 Sep 2022 09:09:07 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g1-20020a056512118100b00492e570e036sm1819953lfr.54.2022.09.06.09.09.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 09:09:07 -0700 (PDT)
Message-ID: <78a86b33-689a-cc03-b2eb-2fb9d7b6169b@linaro.org>
Date:   Tue, 6 Sep 2022 18:09:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] arm64: dts: rockchip: Add regulator suffix to BPI-R2-Pro
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-rockchip@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220906155503.10971-1-linux@fw-web.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220906155503.10971-1-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2022 17:55, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add -regulator suffix to regulator names on Banana Pi R2 Pro board as
> discussed on Mailinglist
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> https://patchwork.kernel.org/project/linux-rockchip/patch/20220825193836.54262-6-linux@fw-web.de/
> ---
>  arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts b/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
> index 7a8d55a898f5..432469697544 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
> @@ -46,7 +46,7 @@ green_led: led-1 {
>  		};
>  	};
>  
> -	dc_12v: dc-12v {
> +	dc_12v: dc-12v-regulator {
>  		compatible = "regulator-fixed";
>  		regulator-name = "dc_12v";
>  		regulator-always-on;
> @@ -66,7 +66,7 @@ hdmi_con_in: endpoint {
>  		};
>  	};
>  
> -	vcc3v3_sys: vcc3v3-sys {
> +	vcc3v3_sys: vcc3v3-sys-regulator {
>  		compatible = "regulator-fixed";
>  		regulator-name = "vcc3v3_sys";
>  		regulator-always-on;
> @@ -76,7 +76,7 @@ vcc3v3_sys: vcc3v3-sys {
>  		vin-supply = <&dc_12v>;
>  	};
>  
> -	vcc5v0_sys: vcc5v0-sys {
> +	vcc5v0_sys: vcc5v0-sys-regulator {
>  		compatible = "regulator-fixed";
>  		regulator-name = "vcc5v0_sys";
>  		regulator-always-on;
> @@ -146,7 +146,7 @@ vcc3v3_ngff: vcc3v3-ngff-regulator {
>  		vin-supply = <&vcc3v3_pi6c_05>;
>  	};
>  
> -	vcc5v0_usb: vcc5v0_usb {
> +	vcc5v0_usb: vcc5v0_usb-regulator {

While at it drop underscore in node name (hyphen is ok).

Best regards,
Krzysztof
