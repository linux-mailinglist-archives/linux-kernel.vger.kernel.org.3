Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B08058A837
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 10:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240091AbiHEIkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 04:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234956AbiHEIkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 04:40:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A850C64;
        Fri,  5 Aug 2022 01:40:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1239BB82659;
        Fri,  5 Aug 2022 08:40:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB55C433D6;
        Fri,  5 Aug 2022 08:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659688809;
        bh=hAlOWo0xSVS1q+XjsMEjNMfwAR8lstA2lMQ30Qmj/V8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QdrmKQ5hAFYAOFqUDfvhlIll4nYmCnsUP//sQ+J7r0UxNJiuPIBQkyrChaZH4I/Ah
         orlYKPOQKJYgxbqZDy5WykOFeKLQhMKhP14Bd1kgdML9VNzr5o2GvsbwAEOH6x8Ezj
         gEj7LwrgsQB/v4COdsgGSGpJRgXHxLuyIoxF4/p/5q3OHLSTqvR/YlEMoewfdqsLFA
         hpzNYh6ztezevoe7rSP06oKlwkDxM/lQZ7MnqslLYddMAuKWPE2YPgx+oHTMXsZ/JU
         c0qObE9ymz6oFhGNO7ye/aCL3NT7H75B0uieX0Q8cxnN8kvxYHRfQdgM2TMnS/293k
         p/M1JecFKsBkQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oJssi-0008UA-Bi; Fri, 05 Aug 2022 10:40:32 +0200
Date:   Fri, 5 Aug 2022 10:40:32 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-lenovo-thinkpad-x13s: Add LID
 switch
Message-ID: <YuzXgGQkLEqwqp31@hovoldconsulting.com>
References: <20220730193617.1688563-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220730193617.1688563-1-bjorn.andersson@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 30, 2022 at 12:36:17PM -0700, Bjorn Andersson wrote:
> Add gpio-keys for exposing the LID switch state.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> index 84dc92dda0b8..f3246cc13d15 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> @@ -7,6 +7,8 @@
>  /dts-v1/;
>  
>  #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/gpio-keys.h>
> +#include <dt-bindings/input/input.h>
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  
>  #include "sc8280xp.dtsi"
> @@ -26,6 +28,21 @@ backlight {
>  		pinctrl-0 = <&edp_bl_en>, <&edp_bl_pwm>;
>  	};
>  
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&hall_int_state>;
> +
> +		switch-lid {
> +			gpios = <&tlmm 107 GPIO_ACTIVE_LOW>;
> +			linux,input-type = <EV_SW>;
> +			linux,code = <SW_LID>;
> +			wakeup-source;
> +			wakeup-event-action = <EV_ACT_DEASSERTED>;
> +		};
> +	};
> +
>  	vreg_edp_bl: regulator-edp-bl {
>  		compatible = "regulator-fixed";
>  
> @@ -347,6 +364,14 @@ reset {
>  		};
>  	};
>  
> +	hall_int_state: hall-int-state {

This node should go before the keyboard node to maintain the sort order.

Also, none of the other labels have a "state" suffix and the other
active-low pin node names have a "-n" suffix.

So I believe this should be

	hall_int_n: hall-int-n-state

for consistency.

> +		pins = "gpio107";
> +		function = "gpio";
> +

Newline not needed (nor used in the other nodes).

> +		input-enable;
> +		bias-disable;
> +	};
> +
>  	qup0_i2c4_default: qup0-i2c4-default-state {
>  		pins = "gpio171", "gpio172";
>  		function = "qup4";

Looks good otherwise and appears to work as intended:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>

Johan
