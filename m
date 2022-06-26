Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B291455AE68
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 05:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbiFZDMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 23:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbiFZDMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 23:12:36 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCD7140B1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 20:12:34 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id h65so8579312oia.11
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 20:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=32NeeEG1BGWkZDNDo1wGPxqL/eiCKyADH8DuEofAJ48=;
        b=el1eYg+9jlr5npNRJ+slAEYxfrng1zBT2LOCEMsgCl7rhfj5nkEA88ujGmaMrygJr+
         SZ83sIrcvZykz/8q77toUvtbsrLnrSMWYEThoVO+yhjWVbBOiTJXP4E5mpO+6WC//Ydo
         oKVt+ENcol4bjUOXpE2TR1b3DQY7K0T2lWSCDvJKpYxVDneA+gJNBSJ37l9tacCziR5Y
         2o5pjgk5+R4LvkSxGMsCvNg79LGPIZQx/Mru0hjMW5SI5IX4VbzQj1I5Ed0ziUFsBYar
         xDerwl520DkPtO6YCYzJhFH6QRH6vSVe3TK1RputKYoPyqfwtlVOPynPApyCilNqTIoQ
         rPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=32NeeEG1BGWkZDNDo1wGPxqL/eiCKyADH8DuEofAJ48=;
        b=fMLTbpqSPiXCZ/Gcjylod7ZG8uXuulVpRhMa9Z/QbnAmDsLje8OA7uJIFco04lyNbc
         wDOizo4PrCXAAnDR6qegTaikV2C2cJpoNwv9r+m7PHC7/Df/+CBJA4BeSLa7d+LK5/UX
         2UKVfve0Qc84zkRqSln77X6gzp+1Ejf35Z/W/1v7r1hw7HUM6Ge6wxR/Mu+P/9USRPla
         SmP9QE0RY9axRSrn1qthqfRJXiaAipiJIxkN5opDb1gyNWR+j5dWK/ObVKi6TZqEFFit
         jpTbBtK+nhE294Cay/BGuBTpFsOr4206+KFL7YrRA3P+hG0VlV4Dr9KIw8EhC6mj03uE
         gbeQ==
X-Gm-Message-State: AJIora+gQLPZ1HBk4MpUdHHPUelZIxqXqvFXT5sOvlvZMUAiq2c86kgW
        zoMfusXI8h1yjFvh71fezrnLeA==
X-Google-Smtp-Source: AGRyM1v1NlWHMpLy3dB9qVX/c3QOLyAQx3KT52Egd2gfyzu/7+akJnSxt6ECTmvHeSyUoI+0aLUtvA==
X-Received: by 2002:a05:6808:1514:b0:335:511b:a7b0 with SMTP id u20-20020a056808151400b00335511ba7b0mr3831640oiw.288.1656213153970;
        Sat, 25 Jun 2022 20:12:33 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id e7-20020a4aaac7000000b0041b49c19a00sm3936303oon.18.2022.06.25.20.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 20:12:33 -0700 (PDT)
Date:   Sat, 25 Jun 2022 22:12:31 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: timer should use only 32-bit size
Message-ID: <YrfOn6T+cUn5mEe3@builder.lan>
References: <20220515221758.88723-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220515221758.88723-1-david@ixit.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 15 May 17:17 CDT 2022, David Heidelberg wrote:

> There's no reason the timer needs > 32-bits of size.
> Since we using 32-bit size, we need to define ranges properly.
> 
> Fixes warnings as:
> ```
> arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dt.yaml: timer@17c90000: #size-cells:0:0: 1 was expected
>         From schema: Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
> ```
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> 
> ---
> Replaces "dt-bindings: timer: add #size-cells 2 for ARM"

I'm not able to find this patch, but I'm guessing that you tried to make
it possible to allow #size-cells to be 2 in the binding?

> v2: fix accidental change of value 0x0 to 0
> 
>  arch/arm64/boot/dts/qcom/ipq6018.dtsi | 20 ++++++++++----------
>  arch/arm64/boot/dts/qcom/sc7180.dtsi  | 20 ++++++++++----------
>  arch/arm64/boot/dts/qcom/sc7280.dtsi  | 20 ++++++++++----------
>  arch/arm64/boot/dts/qcom/sdm845.dtsi  | 20 ++++++++++----------
>  arch/arm64/boot/dts/qcom/sm6350.dtsi  | 20 ++++++++++----------
>  arch/arm64/boot/dts/qcom/sm8150.dtsi  | 20 ++++++++++----------
>  arch/arm64/boot/dts/qcom/sm8250.dtsi  | 20 ++++++++++----------
>  arch/arm64/boot/dts/qcom/sm8350.dtsi  | 20 ++++++++++----------
>  arch/arm64/boot/dts/qcom/sm8450.dtsi  | 20 ++++++++++----------
>  9 files changed, 90 insertions(+), 90 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> index c89499e366d3..8638231dbd2f 100644
> --- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> @@ -526,8 +526,8 @@ timer {
>  
>  		timer@b120000 {
>  			#address-cells = <2>;
> -			#size-cells = <2>;
> -			ranges;
> +			#size-cells = <1>;

While perfectly valid, I don't like the asymmetry of #address-cells = 2
and #size-cells = 1.

If the binding maintainers don't approve of allowing #size-cells = 2,
can you please make #address-cells = 1 as well?

Regards,
Bjorn

> +			ranges = <0 0 0 0 0x10000000>;
>  			compatible = "arm,armv7-timer-mem";
>  			reg = <0x0 0x0b120000 0x0 0x1000>;
>  
> @@ -535,49 +535,49 @@ frame@b120000 {
>  				frame-number = <0>;
>  				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
>  					     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0x0 0x0b121000 0x0 0x1000>,
> -				      <0x0 0x0b122000 0x0 0x1000>;
> +				reg = <0x0 0x0b121000 0x1000>,
> +				      <0x0 0x0b122000 0x1000>;
>  			};
>  
>  			frame@b123000 {
>  				frame-number = <1>;
>  				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0x0 0xb123000 0x0 0x1000>;
> +				reg = <0x0 0x0b123000 0x1000>;
>  				status = "disabled";
>  			};
>  
>  			frame@b124000 {
>  				frame-number = <2>;
>  				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0x0 0x0b124000 0x0 0x1000>;
> +				reg = <0x0 0x0b124000 0x1000>;
>  				status = "disabled";
>  			};
>  
>  			frame@b125000 {
>  				frame-number = <3>;
>  				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0x0 0x0b125000 0x0 0x1000>;
> +				reg = <0x0 0x0b125000 0x1000>;
>  				status = "disabled";
>  			};
>  
>  			frame@b126000 {
>  				frame-number = <4>;
>  				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0x0 0x0b126000 0x0 0x1000>;
> +				reg = <0x0 0x0b126000 0x1000>;
>  				status = "disabled";
>  			};
>  
>  			frame@b127000 {
>  				frame-number = <5>;
>  				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0x0 0x0b127000 0x0 0x1000>;
> +				reg = <0x0 0x0b127000 0x1000>;
>  				status = "disabled";
>  			};
>  
>  			frame@b128000 {
>  				frame-number = <6>;
>  				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0x0 0x0b128000 0x0 0x1000>;
> +				reg = <0x0 0x0b128000 0x1000>;
>  				status = "disabled";
>  			};
>  		};
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index 5dcaac23a138..4b7be66e04df 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -3385,8 +3385,8 @@ watchdog@17c10000 {
>  
>  		timer@17c20000{
>  			#address-cells = <2>;
> -			#size-cells = <2>;
> -			ranges;
> +			#size-cells = <1>;
> +			ranges = <0 0 0 0 0x20000000>;
>  			compatible = "arm,armv7-timer-mem";
>  			reg = <0 0x17c20000 0 0x1000>;
>  
> @@ -3394,49 +3394,49 @@ frame@17c21000 {
>  				frame-number = <0>;
>  				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
>  					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0 0x17c21000 0 0x1000>,
> -				      <0 0x17c22000 0 0x1000>;
> +				reg = <0 0x17c21000 0x1000>,
> +				      <0 0x17c22000 0x1000>;
>  			};
>  
>  			frame@17c23000 {
>  				frame-number = <1>;
>  				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0 0x17c23000 0 0x1000>;
> +				reg = <0 0x17c23000 0x1000>;
>  				status = "disabled";
>  			};
>  
>  			frame@17c25000 {
>  				frame-number = <2>;
>  				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0 0x17c25000 0 0x1000>;
> +				reg = <0 0x17c25000 0x1000>;
>  				status = "disabled";
>  			};
>  
>  			frame@17c27000 {
>  				frame-number = <3>;
>  				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0 0x17c27000 0 0x1000>;
> +				reg = <0 0x17c27000 0x1000>;
>  				status = "disabled";
>  			};
>  
>  			frame@17c29000 {
>  				frame-number = <4>;
>  				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0 0x17c29000 0 0x1000>;
> +				reg = <0 0x17c29000 0x1000>;
>  				status = "disabled";
>  			};
>  
>  			frame@17c2b000 {
>  				frame-number = <5>;
>  				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0 0x17c2b000 0 0x1000>;
> +				reg = <0 0x17c2b000 0x1000>;
>  				status = "disabled";
>  			};
>  
>  			frame@17c2d000 {
>  				frame-number = <6>;
>  				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0 0x17c2d000 0 0x1000>;
> +				reg = <0 0x17c2d000 0x1000>;
>  				status = "disabled";
>  			};
>  		};
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index e66fc67de206..1b81cd1e84e9 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -4772,8 +4772,8 @@ watchdog@17c10000 {
>  
>  		timer@17c20000 {
>  			#address-cells = <2>;
> -			#size-cells = <2>;
> -			ranges;
> +			#size-cells = <1>;
> +			ranges = <0 0 0 0 0x20000000>;
>  			compatible = "arm,armv7-timer-mem";
>  			reg = <0 0x17c20000 0 0x1000>;
>  
> @@ -4781,49 +4781,49 @@ frame@17c21000 {
>  				frame-number = <0>;
>  				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
>  					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0 0x17c21000 0 0x1000>,
> -				      <0 0x17c22000 0 0x1000>;
> +				reg = <0 0x17c21000 0x1000>,
> +				      <0 0x17c22000 0x1000>;
>  			};
>  
>  			frame@17c23000 {
>  				frame-number = <1>;
>  				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0 0x17c23000 0 0x1000>;
> +				reg = <0 0x17c23000 0x1000>;
>  				status = "disabled";
>  			};
>  
>  			frame@17c25000 {
>  				frame-number = <2>;
>  				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0 0x17c25000 0 0x1000>;
> +				reg = <0 0x17c25000 0x1000>;
>  				status = "disabled";
>  			};
>  
>  			frame@17c27000 {
>  				frame-number = <3>;
>  				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0 0x17c27000 0 0x1000>;
> +				reg = <0 0x17c27000 0x1000>;
>  				status = "disabled";
>  			};
>  
>  			frame@17c29000 {
>  				frame-number = <4>;
>  				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0 0x17c29000 0 0x1000>;
> +				reg = <0 0x17c29000 0x1000>;
>  				status = "disabled";
>  			};
>  
>  			frame@17c2b000 {
>  				frame-number = <5>;
>  				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0 0x17c2b000 0 0x1000>;
> +				reg = <0 0x17c2b000 0x1000>;
>  				status = "disabled";
>  			};
>  
>  			frame@17c2d000 {
>  				frame-number = <6>;
>  				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0 0x17c2d000 0 0x1000>;
> +				reg = <0 0x17c2d000 0x1000>;
>  				status = "disabled";
>  			};
>  		};
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 0692ae0e60a4..9a1705bfa425 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -4949,8 +4949,8 @@ slimbam: dma-controller@17184000 {
>  
>  		timer@17c90000 {
>  			#address-cells = <2>;
> -			#size-cells = <2>;
> -			ranges;
> +			#size-cells = <1>;
> +			ranges = <0 0 0 0 0x20000000>;
>  			compatible = "arm,armv7-timer-mem";
>  			reg = <0 0x17c90000 0 0x1000>;
>  
> @@ -4958,49 +4958,49 @@ frame@17ca0000 {
>  				frame-number = <0>;
>  				interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
>  					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0 0x17ca0000 0 0x1000>,
> -				      <0 0x17cb0000 0 0x1000>;
> +				reg = <0 0x17ca0000 0x1000>,
> +				      <0 0x17cb0000 0x1000>;
>  			};
>  
>  			frame@17cc0000 {
>  				frame-number = <1>;
>  				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0 0x17cc0000 0 0x1000>;
> +				reg = <0 0x17cc0000 0x1000>;
>  				status = "disabled";
>  			};
>  
>  			frame@17cd0000 {
>  				frame-number = <2>;
>  				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0 0x17cd0000 0 0x1000>;
> +				reg = <0 0x17cd0000 0x1000>;
>  				status = "disabled";
>  			};
>  
>  			frame@17ce0000 {
>  				frame-number = <3>;
>  				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0 0x17ce0000 0 0x1000>;
> +				reg = <0 0x17ce0000 0x1000>;
>  				status = "disabled";
>  			};
>  
>  			frame@17cf0000 {
>  				frame-number = <4>;
>  				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0 0x17cf0000 0 0x1000>;
> +				reg = <0 0x17cf0000 0x1000>;
>  				status = "disabled";
>  			};
>  
>  			frame@17d00000 {
>  				frame-number = <5>;
>  				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0 0x17d00000 0 0x1000>;
> +				reg = <0 0x17d00000 0x1000>;
>  				status = "disabled";
>  			};
>  
>  			frame@17d10000 {
>  				frame-number = <6>;
>  				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0 0x17d10000 0 0x1000>;
> +				reg = <0 0x17d10000 0x1000>;
>  				status = "disabled";
>  			};
>  		};
> diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
> index d4f8f33f3f0c..fc473cb8c93b 100644
> --- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
> @@ -1305,56 +1305,56 @@ timer@17c20000 {
>  			reg = <0x0 0x17c20000 0x0 0x1000>;
>  			clock-frequency = <19200000>;
>  			#address-cells = <2>;
> -			#size-cells = <2>;
> -			ranges;
> +			#size-cells = <1>;
> +			ranges = <0 0 0 0 0x20000000>;
>  
>  			frame@17c21000 {
>  				frame-number = <0>;
>  				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
>  					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0x0 0x17c21000 0x0 0x1000>,
> -				      <0x0 0x17c22000 0x0 0x1000>;
> +				reg = <0x0 0x17c21000 0x1000>,
> +				      <0x0 0x17c22000 0x1000>;
>  			};
>  
>  			frame@17c23000 {
>  				frame-number = <1>;
>  				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0x0 0x17c23000 0x0 0x1000>;
> +				reg = <0x0 0x17c23000 0x1000>;
>  				status = "disabled";
>  			};
>  
>  			frame@17c25000 {
>  				frame-number = <2>;
>  				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0x0 0x17c25000 0x0 0x1000>;
> +				reg = <0x0 0x17c25000 0x1000>;
>  				status = "disabled";
>  			};
>  
>  			frame@17c27000 {
>  				frame-number = <3>;
>  				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0x0 0x17c27000 0x0 0x1000>;
> +				reg = <0x0 0x17c27000 0x1000>;
>  				status = "disabled";
>  			};
>  
>  			frame@17c29000 {
>  				frame-number = <4>;
>  				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0x0 0x17c29000 0x0 0x1000>;
> +				reg = <0x0 0x17c29000 0x1000>;
>  				status = "disabled";
>  			};
>  
>  			frame@17c2b000 {
>  				frame-number = <5>;
>  				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0x0 0x17c2b000 0x0 0x1000>;
> +				reg = <0x0 0x17c2b000 0x1000>;
>  				status = "disabled";
>  			};
>  
>  			frame@17c2d000 {
>  				frame-number = <6>;
>  				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0x0 0x17c2d000 0x0 0x1000>;
> +				reg = <0x0 0x17c2d000 0x1000>;
>  				status = "disabled";
>  			};
>  		};
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> index 8ea44c4b56b4..066cc00191b2 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -3945,8 +3945,8 @@ watchdog@17c10000 {
>  
>  		timer@17c20000 {
>  			#address-cells = <2>;
> -			#size-cells = <2>;
> -			ranges;
> +			#size-cells = <1>;
> +			ranges = <0 0 0 0 0x20000000>;
>  			compatible = "arm,armv7-timer-mem";
>  			reg = <0x0 0x17c20000 0x0 0x1000>;
>  			clock-frequency = <19200000>;
> @@ -3955,49 +3955,49 @@ frame@17c21000{
>  				frame-number = <0>;
>  				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
>  					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0x0 0x17c21000 0x0 0x1000>,
> -				      <0x0 0x17c22000 0x0 0x1000>;
> +				reg = <0x0 0x17c21000 0x1000>,
> +				      <0x0 0x17c22000 0x1000>;
>  			};
>  
>  			frame@17c23000 {
>  				frame-number = <1>;
>  				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0x0 0x17c23000 0x0 0x1000>;
> +				reg = <0x0 0x17c23000 0x1000>;
>  				status = "disabled";
>  			};
>  
>  			frame@17c25000 {
>  				frame-number = <2>;
>  				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0x0 0x17c25000 0x0 0x1000>;
> +				reg = <0x0 0x17c25000 0x1000>;
>  				status = "disabled";
>  			};
>  
>  			frame@17c27000 {
>  				frame-number = <3>;
>  				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0x0 0x17c26000 0x0 0x1000>;
> +				reg = <0x0 0x17c26000 0x1000>;
>  				status = "disabled";
>  			};
>  
>  			frame@17c29000 {
>  				frame-number = <4>;
>  				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0x0 0x17c29000 0x0 0x1000>;
> +				reg = <0x0 0x17c29000 0x1000>;
>  				status = "disabled";
>  			};
>  
>  			frame@17c2b000 {
>  				frame-number = <5>;
>  				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0x0 0x17c2b000 0x0 0x1000>;
> +				reg = <0x0 0x17c2b000 0x1000>;
>  				status = "disabled";
>  			};
>  
>  			frame@17c2d000 {
>  				frame-number = <6>;
>  				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0x0 0x17c2d000 0x0 0x1000>;
> +				reg = <0x0 0x17c2d000 0x1000>;
>  				status = "disabled";
>  			};
>  		};
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index cf0c97bd5ad3..ae7d0573e1dc 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -4868,8 +4868,8 @@ watchdog@17c10000 {
>  
>  		timer@17c20000 {
>  			#address-cells = <2>;
> -			#size-cells = <2>;
> -			ranges;
> +			#size-cells = <1>;
> +			ranges = <0 0 0 0 0x20000000>;
>  			compatible = "arm,armv7-timer-mem";
>  			reg = <0x0 0x17c20000 0x0 0x1000>;
>  			clock-frequency = <19200000>;
> @@ -4878,49 +4878,49 @@ frame@17c21000 {
>  				frame-number = <0>;
>  				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
>  					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0x0 0x17c21000 0x0 0x1000>,
> -				      <0x0 0x17c22000 0x0 0x1000>;
> +				reg = <0x0 0x17c21000 0x1000>,
> +				      <0x0 0x17c22000 0x1000>;
>  			};
>  
>  			frame@17c23000 {
>  				frame-number = <1>;
>  				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0x0 0x17c23000 0x0 0x1000>;
> +				reg = <0x0 0x17c23000 0x1000>;
>  				status = "disabled";
>  			};
>  
>  			frame@17c25000 {
>  				frame-number = <2>;
>  				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0x0 0x17c25000 0x0 0x1000>;
> +				reg = <0x0 0x17c25000 0x1000>;
>  				status = "disabled";
>  			};
>  
>  			frame@17c27000 {
>  				frame-number = <3>;
>  				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0x0 0x17c27000 0x0 0x1000>;
> +				reg = <0x0 0x17c27000 0x1000>;
>  				status = "disabled";
>  			};
>  
>  			frame@17c29000 {
>  				frame-number = <4>;
>  				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0x0 0x17c29000 0x0 0x1000>;
> +				reg = <0x0 0x17c29000 0x1000>;
>  				status = "disabled";
>  			};
>  
>  			frame@17c2b000 {
>  				frame-number = <5>;
>  				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0x0 0x17c2b000 0x0 0x1000>;
> +				reg = <0x0 0x17c2b000 0x1000>;
>  				status = "disabled";
>  			};
>  
>  			frame@17c2d000 {
>  				frame-number = <6>;
>  				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0x0 0x17c2d000 0x0 0x1000>;
> +				reg = <0x0 0x17c2d000 0x1000>;
>  				status = "disabled";
>  			};
>  		};
> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> index 743cba9b683c..58e6bb4a1899 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> @@ -1934,8 +1934,8 @@ intc: interrupt-controller@17a00000 {
>  		timer@17c20000 {
>  			compatible = "arm,armv7-timer-mem";
>  			#address-cells = <2>;
> -			#size-cells = <2>;
> -			ranges;
> +			#size-cells = <1>;
> +			ranges = <0 0 0 0 0x20000000>;
>  			reg = <0x0 0x17c20000 0x0 0x1000>;
>  			clock-frequency = <19200000>;
>  
> @@ -1943,49 +1943,49 @@ frame@17c21000 {
>  				frame-number = <0>;
>  				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
>  					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0x0 0x17c21000 0x0 0x1000>,
> -				      <0x0 0x17c22000 0x0 0x1000>;
> +				reg = <0x0 0x17c21000 0x1000>,
> +				      <0x0 0x17c22000 0x1000>;
>  			};
>  
>  			frame@17c23000 {
>  				frame-number = <1>;
>  				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0x0 0x17c23000 0x0 0x1000>;
> +				reg = <0x0 0x17c23000 0x1000>;
>  				status = "disabled";
>  			};
>  
>  			frame@17c25000 {
>  				frame-number = <2>;
>  				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0x0 0x17c25000 0x0 0x1000>;
> +				reg = <0x0 0x17c25000 0x1000>;
>  				status = "disabled";
>  			};
>  
>  			frame@17c27000 {
>  				frame-number = <3>;
>  				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0x0 0x17c27000 0x0 0x1000>;
> +				reg = <0x0 0x17c27000 0x1000>;
>  				status = "disabled";
>  			};
>  
>  			frame@17c29000 {
>  				frame-number = <4>;
>  				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0x0 0x17c29000 0x0 0x1000>;
> +				reg = <0x0 0x17c29000 0x1000>;
>  				status = "disabled";
>  			};
>  
>  			frame@17c2b000 {
>  				frame-number = <5>;
>  				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0x0 0x17c2b000 0x0 0x1000>;
> +				reg = <0x0 0x17c2b000 0x1000>;
>  				status = "disabled";
>  			};
>  
>  			frame@17c2d000 {
>  				frame-number = <6>;
>  				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0x0 0x17c2d000 0x0 0x1000>;
> +				reg = <0x0 0x17c2d000 0x1000>;
>  				status = "disabled";
>  			};
>  		};
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 7d08fad76371..64ceff515337 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -2858,8 +2858,8 @@ intc: interrupt-controller@17100000 {
>  		timer@17420000 {
>  			compatible = "arm,armv7-timer-mem";
>  			#address-cells = <2>;
> -			#size-cells = <2>;
> -			ranges;
> +			#size-cells = <1>;
> +			ranges = <0 0 0 0 0x20000000>;
>  			reg = <0x0 0x17420000 0x0 0x1000>;
>  			clock-frequency = <19200000>;
>  
> @@ -2867,49 +2867,49 @@ frame@17421000 {
>  				frame-number = <0>;
>  				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
>  					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0x0 0x17421000 0x0 0x1000>,
> -				      <0x0 0x17422000 0x0 0x1000>;
> +				reg = <0x0 0x17421000 0x1000>,
> +				      <0x0 0x17422000 0x1000>;
>  			};
>  
>  			frame@17423000 {
>  				frame-number = <1>;
>  				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0x0 0x17423000 0x0 0x1000>;
> +				reg = <0x0 0x17423000 0x1000>;
>  				status = "disabled";
>  			};
>  
>  			frame@17425000 {
>  				frame-number = <2>;
>  				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0x0 0x17425000 0x0 0x1000>;
> +				reg = <0x0 0x17425000 0x1000>;
>  				status = "disabled";
>  			};
>  
>  			frame@17427000 {
>  				frame-number = <3>;
>  				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0x0 0x17427000 0x0 0x1000>;
> +				reg = <0x0 0x17427000 0x1000>;
>  				status = "disabled";
>  			};
>  
>  			frame@17429000 {
>  				frame-number = <4>;
>  				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0x0 0x17429000 0x0 0x1000>;
> +				reg = <0x0 0x17429000 0x1000>;
>  				status = "disabled";
>  			};
>  
>  			frame@1742b000 {
>  				frame-number = <5>;
>  				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0x0 0x1742b000 0x0 0x1000>;
> +				reg = <0x0 0x1742b000 0x1000>;
>  				status = "disabled";
>  			};
>  
>  			frame@1742d000 {
>  				frame-number = <6>;
>  				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> -				reg = <0x0 0x1742d000 0x0 0x1000>;
> +				reg = <0x0 0x1742d000 0x1000>;
>  				status = "disabled";
>  			};
>  		};
> -- 
> 2.35.1
> 
