Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FAE5625BA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 23:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237502AbiF3V4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 17:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237369AbiF3V4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 17:56:47 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39CF57207
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 14:56:45 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id y10-20020a9d634a000000b006167f7ce0c5so474571otk.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 14:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8CS533fsVHbJlembFtrJaJOunJ/hjtVlmQosQykPOVU=;
        b=S/NpE6Kmx1CbuLYF7W63lIhTpwApNv2nYfn5k5hCaG3+u2eXBUGmP4fIq1dUGisMTw
         Z6TQkg5prg5MB0VGbx9nu39MvWpSFbdJ1IrFg5Q2urI0X65FMnfcAfjTMGnjMurkDFXL
         mdRJfacHhU6owX7jQL2PfmlJ+MMb0y/YegKjxg+VP8ppTBvgEUKR4LSdhAEgHeByL+dO
         /OFZCk5YDGbsigwdkuje2nI7PEPlHeX/BsG5isNHPTyxPT4GeRfjOypgmegh4jSEstao
         5cDNQrLoivLUoQgFZ1Wr3/wwZpEzvT59MTfLSNRjIsQkZiK+5KhOAZEM6E5JhwQMyvHZ
         gENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8CS533fsVHbJlembFtrJaJOunJ/hjtVlmQosQykPOVU=;
        b=RvGu+Lkmnmsk4BnSP7aUN5ftChJVUzJyWank4JAeRQXoeKsuMtNZfynQlO53DL/QsT
         SoZX1Bjhv/ut3wUw1DC9YBBW4lSkDK0nZY+N7A7d3mEtSr0i6Y1bmKx1pJaYzJVN/mte
         G5BYkxy6iDPS/FA30tbZXx3O7w/rE0wPB3UxwYrAia+ePw3xot+teYBOVApKnLSCbwi6
         3/5mQll1OJYREsV6H8yDXNCg2LiPzqJ2pfgqvS6BcDaCweC4Brx3w5rQCFquUjA3JKqE
         7d7BfvyQQBlTcfA8Bxb7tExo1IRJesTZveJGRS+5ea9kHkViBe83nQz6CBvcbWA0smOs
         u43g==
X-Gm-Message-State: AJIora+or0dFhox3yS0y6w+phAOYHH4Ied01l2f9tcNgzSwM/C69XZGn
        3e0M4zwGtru6u828bpiT5yM4xQ==
X-Google-Smtp-Source: AGRyM1tTcC8XQCvCGbbV3733NDMYY/C1kLs9792XFAckdaiHz/q/E2fq1m/b7ST5yNLUq66kTwVARA==
X-Received: by 2002:a9d:2f25:0:b0:616:9255:2ff with SMTP id h34-20020a9d2f25000000b00616925502ffmr5006588otb.87.1656626205292;
        Thu, 30 Jun 2022 14:56:45 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id r6-20020a056870580600b001089aef1815sm8952855oap.20.2022.06.30.14.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 14:56:44 -0700 (PDT)
Date:   Thu, 30 Jun 2022 16:56:42 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dylan Van Assche <me@dylanvanassche.be>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom/sdm845-shift-axolotl: Enable pmi9889
 LPG LED
Message-ID: <Yr4cGj7MujkXZ161@builder.lan>
References: <20220512054439.13971-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512054439.13971-1-me@dylanvanassche.be>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 12 May 00:44 CDT 2022, Dylan Van Assche wrote:

> Enables the RGB notification LED on the SHIFT 6mq (sdm845-shift-axolotl)
> with the Qualcomm Light Pulse Generator bindings by Bjorn Andersson [1].
> Patches are merged in for-next branch of linux-leds.
> Tested these changes on the SHIFT 6mq.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git/commit/?h=for-next&id=a8e53db46f19f67be6a26488aafb7d10c78e33bd
> 
> Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
> ---
>  .../boot/dts/qcom/sdm845-shift-axolotl.dts    | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
> index 847f6217a77b..af412ac2c9d0 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
> @@ -2,11 +2,13 @@
>  /*
>   * Copyright (c) 2022, Alexander Martinz <amartinz@shiftphones.com>
>   * Copyright (c) 2022, Caleb Connolly <caleb@connolly.tech>
> + * Copyright (c) 2022, Dylan Van Assche <me@dylanvanassche.be>
>   */
>  
>  /dts-v1/;
>  
>  #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  #include "sdm845.dtsi"
>  #include "pm8998.dtsi"
> @@ -554,6 +556,33 @@ &pmi8998_smb2 {
>  	monitored-battery = <&battery>;
>  };
>  
> +&pmi8998_lpg {

We don't have this node, because no one has reviewed
https://lore.kernel.org/all/20220505022706.1692554-1-bjorn.andersson@linaro.org/#t
yet.

If anyone could take a look I'd be happy to merge this as well.

Thanks,
Bjorn

> +	status = "okay";
> +
> +	multi-led {
> +		color = <LED_COLOR_ID_RGB>;
> +		function = LED_FUNCTION_STATUS;
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		led@3 {
> +			reg = <3>;
> +			color = <LED_COLOR_ID_BLUE>;
> +		};
> +
> +		led@4 {
> +			reg = <4>;
> +			color = <LED_COLOR_ID_GREEN>;
> +		};
> +
> +		led@5 {
> +			reg = <5>;
> +			color = <LED_COLOR_ID_RED>;
> +		};
> +	};
> +};
> +
>  &qup_uart9_default {
>  	pinconf-rx {
>  		pins = "gpio5";
> -- 
> 2.36.1
> 
