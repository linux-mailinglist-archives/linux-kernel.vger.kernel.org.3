Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF0B583E10
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 13:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236520AbiG1LuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 07:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236850AbiG1LuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 07:50:19 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0D813E1E
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 04:50:18 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id w15so2433642lft.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 04:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7xpPHdGqf/twjarqLThIKnxxVR76bJ0+Y4hOdD6FTH0=;
        b=u9RxphfEhlesMJTgJ2DTHDXp2Is+k+Yy6xHKD/10S8uOdq7uzCt1W2XYvdxDzhXztZ
         c33fK2uiiX/zGMz54CexpA3Sllzj/9EaYd7ZV0sbG7JTAaljvjGU1o0APd4Tf+oiOuRi
         dHLO3+QXs45GLqryQq2oN147NTNMGzEGq8WTpGHCo77FZDgC80+mgbvsjE0aUcYNpe3Z
         Oc+XaUdhjtuENe6nqBnYhxu2KGzzP0NESPHglrlcTK54eC5hP5bC/NH54ZMrMawjUz1U
         gXwELDJTyehwB9Jv3q9JOyyXsvKF9aCL8TfoPxcXR2sXRYnOHNTbBtVazD49FNOqrXJI
         iOXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7xpPHdGqf/twjarqLThIKnxxVR76bJ0+Y4hOdD6FTH0=;
        b=SLxRfnv++XxeGo9UEk/+/XsqWrfwoOP6E/TDaaEQkFYy+fWaF9mvufmCvM76bfqBLy
         GZtw1YuTdw+UysPvweWMkk1C2hKPjlex26LJZwfItBl67QKoPSs+5/iuFA9lOKoLMxZk
         WSxIKuSHw3L4PdyvRziqxdBnRWWZfma17gmVEfaICyjJ9tjjUGhTCTYf1ugppC1iklRI
         PJJALrl/CO1yEwTq6aFKnGOxC3LSx+bx00o78Eye21HIIOoGijpaqNFwnDQXyh1rc6X/
         FXk+uU/3KYe+6F3GPCZE/s+VCGwpfqLOh87ZvborMFj08CMR0fh2H/9tydTmj7tLXIyO
         XHrw==
X-Gm-Message-State: AJIora/4Inwlle4ONAtPaU4WIF6X2913WhrwBHgK0Z7h140ylPuY7i75
        roA8gN7StHPxSKmHlnIhf1XBhw==
X-Google-Smtp-Source: AGRyM1v/NiequENiAj7aR5vCW9GvvpY8xU5xz6IyBFp6PvvVx8Zz8iDfP8Up4QHmcWvCQ7F+NHVtWQ==
X-Received: by 2002:a05:6512:3403:b0:481:60ae:7ebc with SMTP id i3-20020a056512340300b0048160ae7ebcmr10262663lfr.358.1659009016201;
        Thu, 28 Jul 2022 04:50:16 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id s6-20020a056512202600b0048a833a14edsm163625lfs.201.2022.07.28.04.50.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 04:50:15 -0700 (PDT)
Message-ID: <76ed8999-c211-f8ea-c70c-21fddd75a896@linaro.org>
Date:   Thu, 28 Jul 2022 13:50:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/3] ARM: dts: qcom: msm8960: add references to USB1
Content-Language: en-US
To:     Shinjo Park <peremen@gmail.com>
Cc:     David Heidelberg <david@ixit.cz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220728111635.30540-1-peremen@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220728111635.30540-1-peremen@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2022 13:16, Shinjo Park wrote:
> Use the same USB definition as qcom-apq8064.dtsi, tested on Casio GzOne.
> 
> Signed-off-by: Shinjo Park <peremen@gmail.com>
> Reviewed-by: David Heidelberg <david@ixit.cz>

Thank you for your patch. There is something to discuss/improve.

Similar problems as with previous patch - thread your patches and how
did you get review?

> ---
>  arch/arm/boot/dts/qcom-msm8960.dtsi | 32 +++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
> index 991eb1948..a32073d61 100644
> --- a/arch/arm/boot/dts/qcom-msm8960.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
> @@ -4,6 +4,7 @@
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/clock/qcom,gcc-msm8960.h>
>  #include <dt-bindings/clock/qcom,lcc-msm8960.h>
> +#include <dt-bindings/reset/qcom,gcc-msm8960.h>
>  #include <dt-bindings/mfd/qcom-rpm.h>
>  #include <dt-bindings/soc/qcom,gsbi.h>
>  
> @@ -201,6 +202,37 @@ regulators {
>  			};
>  		};
>  
> +		usb1: usb@12500000 {
> +			compatible = "qcom,ci-hdrc";
> +			reg = <0x12500000 0x200>,
> +			      <0x12500200 0x200>;
> +			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc USB_HS1_XCVR_CLK>, <&gcc USB_HS1_H_CLK>;
> +			clock-names = "core", "iface";
> +			assigned-clocks = <&gcc USB_HS1_XCVR_CLK>;
> +			assigned-clock-rates = <60000000>;
> +			resets = <&gcc USB_HS1_RESET>;
> +			reset-names = "core";
> +			phy_type = "ulpi";
> +			ahb-burst-config = <0>;
> +			phys = <&usb_hs1_phy>;
> +			phy-names = "usb-phy";
> +			status = "disabled";

status is the last property.

> +			#reset-cells = <1>;



Best regards,
Krzysztof
