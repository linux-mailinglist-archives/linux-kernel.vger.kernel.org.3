Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D895A7890
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbiHaIIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbiHaIIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:08:35 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E756ABD767
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 01:08:33 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id q7so18826979lfu.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 01:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=vmWS3ICQ2RM5oR5SXL4HEHG2SH0Ha+DMmwYwfuW5t3k=;
        b=jihFvEFcSQl4e3CLivEhr7BRyksHlyC6vR0KffyQxa+P0SntzX9NmwAPFwpSw9lxM5
         HxQQexiDOk+4XPag3Xk0iofS8BbQkVRPwu4MMw5cjLZp8/h7M5vgFJuTsZzIW58lI+vV
         Cofa3JLWroLOtNooPif02GTFCYmGpoxYm5JWy6afkNCdhZwdsAnMZou3cPTmffOyBi1P
         1SPWq68jMDgN4/muAEfyhT4TBmnwk3q4uYiF5WNCURgQyKY6mcryRAzabmTXQtc5pOS2
         Pyf35CEvDE+zZs6hXweTY9RmBAqiHNyMyCth29UdT2WkVG+glAYJUfi2aWHiog1aySTZ
         ySug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=vmWS3ICQ2RM5oR5SXL4HEHG2SH0Ha+DMmwYwfuW5t3k=;
        b=6uTxG3tnhXA8aCRCd/5ZmLR+NOnxyeuj+EUHHVZ5JAQaZrRtx4gNSHk3kMCqRW/1/j
         UKidByi1HASXo2/ClK66fZu8Rsi3uIrRHaUm7jAhEW82IBmFz/J8HaTbNpVEy4AHlB4h
         xDxQvhaNNA1usFtHHdTkCrI7SuD5U6dxJhV5jPz5nGfko4HSGtwUeSjGsRTVEpIn2bpy
         KD+A8TWWiez+Lnu8qVvy6Fm+Uycqb0JEYCxDSJBHt8DdXF5g05UlyLuHZIMbnwnM1tsU
         cSwgvREpMBt1F4jwvptE3RsAMKCcGOHxZXRyvPNPHEWe5nrZcWVDuOE4nAb9GHrabMt4
         ri2g==
X-Gm-Message-State: ACgBeo3rJXxmJQBx1+DSbQsbP4ZHfOTDwLg8yLWf+uih5hJvn3Uvl/3q
        CmmzoV6zcBI7oD4FyF2ulKU3ECUMnhEba49M
X-Google-Smtp-Source: AA6agR6SuW5AwvCUsL5LauHW6Qc4LSk7bz0Kewp8m40rSFZ3lJRLnlje4nUT0nK5k6a0NRHWwRuPKw==
X-Received: by 2002:a05:6512:10c8:b0:492:41f9:2adc with SMTP id k8-20020a05651210c800b0049241f92adcmr8383042lfg.388.1661933312287;
        Wed, 31 Aug 2022 01:08:32 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id s16-20020a056512315000b0047fa941067fsm1914757lfi.29.2022.08.31.01.08.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 01:08:31 -0700 (PDT)
Message-ID: <6936b536-4b32-3f98-7393-2934eb80d952@linaro.org>
Date:   Wed, 31 Aug 2022 11:08:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v1 2/5] arm64: dts: imx8mq-librem5: add RGB pwmleds
Content-Language: en-US
To:     Martin Kepplinger <martin.kepplinger@puri.sm>, festevam@gmail.com,
        shawnguo@kernel.org
Cc:     devicetree@vger.kernel.org, kernel@pengutronix.de, kernel@puri.sm,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        robh@kernel.org, =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>
References: <20220831080301.1092737-1-martin.kepplinger@puri.sm>
 <20220831080301.1092737-3-martin.kepplinger@puri.sm>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220831080301.1092737-3-martin.kepplinger@puri.sm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/08/2022 11:02, Martin Kepplinger wrote:
> From: Guido Günther <agx@sigxcpu.org>
> 
> Describe the RGB notification leds on the Librem 5 phone.
> Use the common defines so we're sure to adhere to the common patterns,
> use predefined led colors and functions so we're being warned in case
> of deprecations.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>  .../boot/dts/freescale/imx8mq-librem5.dtsi    | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
> index 0626e4194d958..bbf49e419b498 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
> @@ -7,6 +7,7 @@
>  
>  #include "dt-bindings/input/input.h"
>  #include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/leds/common.h>
>  #include "dt-bindings/pwm/pwm.h"
>  #include "dt-bindings/usb/pd.h"
>  #include "imx8mq.dtsi"
> @@ -54,6 +55,31 @@ key-vol-up {
>  		};
>  	};
>  
> +	pwmleds {
> +		compatible = "pwm-leds";
> +
> +		blue {

Test your DTS (`make dtbs_check`).

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation



Best regards,
Krzysztof
