Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29AC5715F2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 11:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbiGLJmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 05:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbiGLJmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 05:42:01 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BE5A2EE4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 02:41:58 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id y11so6464580lfs.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 02:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=GtNcbY+thFGWFHGivawuvM8/TzJCNdYcEcpdyt/HTv8=;
        b=hoRNHMu8pbtSEJjWc0m3nLg/0i3njcuDyG9QY2f1J/vveCAjVVnfz55Bg91uTGhnKe
         XYBssxeZgADKTrcOiJh0Rij6uJPRQUEBP/ngjz3n/5rotwAGg8U+spSNBrQnx+CpZGcF
         vpyaNQFMmEkrr3yZ5A1MC4hliwn51WAPyVsieQGp3uvlr2CCkPBBj4nUqmxi8Ej9bLJo
         LQ0P8Am3KthThasD4RgN/H2R2CsKsCOdwSSuubdgmhla/oVJnS/PxvEQIkkEwf879Ulq
         fF+oEt9tatuSegeLS7W4HeG9yYPdktL8opTtf8PiubBdhPuYxQMBmKQRMieTZrFHTvTY
         PtjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GtNcbY+thFGWFHGivawuvM8/TzJCNdYcEcpdyt/HTv8=;
        b=SQBoqxFJ+wWDaGBYHNh+a7FqiGFMAQq/BsBxBd9goKs7FKM9wJpD/cY2r/Wb/7uEqC
         TGRcOi19JlsntdshIfB/kVLiQ9jsflyg+Ae8MuYz+tUv/saMzyw06enDwd7PYlj3YDZ2
         rljP3l8TJZhZxRJFSGS9LWg9T2TvTr8J1HzBeU4AOR/0uW5r742qoJ8amXh7IR7giWZM
         YWkREluPblH6yQ2pC/BRNch9aouY8i1qsLUsSwS+mSjsEQJzaH7bO9tx5j7JxslpHGI4
         lYI7eIT4oVEFukcP2xT+lHs9oUnDSDbN1kLwpvl9n02PBFM0JfZ9LfZmor3ElMJw7vg1
         TeEw==
X-Gm-Message-State: AJIora9xy138WsgrPV/b0yzFcsLOLBr7Uy1ay7ryWLWKZbHx8sDk6L22
        YYDJWr5F8NGqYPzMdYt0l8ICvQ==
X-Google-Smtp-Source: AGRyM1tk3WkRoJLINYQJslACTfyPMhidqRMvgky2hVLupgjFPZNabqHdygz2W63mTSnI8afdU1JbhQ==
X-Received: by 2002:a05:6512:a89:b0:481:1327:6ff6 with SMTP id m9-20020a0565120a8900b0048113276ff6mr15376395lfu.471.1657618917082;
        Tue, 12 Jul 2022 02:41:57 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id o15-20020a05651205cf00b00488d0e38283sm2068224lfo.153.2022.07.12.02.41.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 02:41:56 -0700 (PDT)
Message-ID: <f5b3e2de-ec60-88ee-4066-6b3860b6c89a@linaro.org>
Date:   Tue, 12 Jul 2022 11:41:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/3] arm64: dts: meson: add S4 Soc clock controller in DT
Content-Language: en-US
To:     Yu Tu <yu.tu@amlogic.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220708062757.3662-1-yu.tu@amlogic.com>
 <20220708062757.3662-3-yu.tu@amlogic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220708062757.3662-3-yu.tu@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/2022 08:27, Yu Tu wrote:
> Added information about the S4 SOC Clock controller in DT.
> 
> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-s4.dtsi | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
> index ff213618a598..ad2ec26a1f4a 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
> @@ -86,7 +86,7 @@ gic: interrupt-controller@fff01000 {
>  		};
>  
>  		apb4: apb4@fe000000 {
> -			compatible = "simple-bus";
> +			compatible = "simple-bus", "syscon";

This is not allowed.
1. syscon needs also dedicated compatible
2. simple-bus with syscon means it is not a simple bus anymore, so nope.

>  			reg = <0x0 0xfe000000 0x0 0x480000>;
>  			#address-cells = <2>;
>  			#size-cells = <2>;
> @@ -118,6 +118,13 @@ gpio_intc: interrupt-controller@4080 {
>  					<10 11 12 13 14 15 16 17 18 19 20 21>;
>  			};
>  
> +			clkc: clock-controller {
> +				compatible = "amlogic,s4-clkc";
> +				#clock-cells = <1>;
> +				clocks = <&xtal>;
> +				clock-names = "xtal";
> +			};
> +
>  			uart_B: serial@7a000 {
>  				compatible = "amlogic,meson-s4-uart",
>  					     "amlogic,meson-ao-uart";


Best regards,
Krzysztof
