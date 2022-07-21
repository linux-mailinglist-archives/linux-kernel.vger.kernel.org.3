Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE8057D18D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 18:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiGUQbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 12:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbiGUQbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 12:31:10 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583818964B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 09:31:09 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id d17so1463572lfa.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 09:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XqCXjyJcNo4bie6L272k55caJWyGzFA3DVChKjwNgtE=;
        b=tRoneYgywBVCnzHLV9n9uXSIbBepv52PjAWkI9DzIETo+rlEqYWrYWPDGk9nc4IDZb
         QFUHJu8BeJs0ONDUKrEKztuS6vY040n5VOpmEZSNXsowneQlBCz+t2tgMgXyrrKzlkFK
         VIep1T9/QPctONrz76ADyRs7656G5Ry1riRsTMGa5NOTrojTY/gK/j0kxyoqam24d/6O
         oOPOHRBtwPplRJx3TAFOowgQ3Aa1TwgIofC7iru5/c5Rs68cwayLby+oXGdocPDuAEKd
         ojLflHFmZEspqpo7BYOL1a+6G8hDdt96JxtUBA2DUPjtmQzUhBWdYohG34FHwvp+acKe
         bBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XqCXjyJcNo4bie6L272k55caJWyGzFA3DVChKjwNgtE=;
        b=FL3RI531Ii6hLs2yFnLlBTjo6pcHtQDZrCkk4pa5xDIiApYjn/EKyONu6f/JGbdR0l
         8oktbfxtfjsH8peG8VQTE/jF+sP3AeL5UgoTDUiDNru9WJJ6jLbXHYM4aj6fSFIX3+me
         ytoDsod8sKN4B7AvwaFzzvEHwtARDNdBP8xX3SUTcwXqbKZ/nH4X5M8Nyix+6dE9RiK9
         dGo1P13eRKwP7FeXLPavUi4QMCXiZHwEYza/OGklumu5ZJIa/DCV1//4r17Lo+ndkJRR
         XIMwxPIODVO0h+YDuEP22b0zmdXUFUBfZlblKsVPr2+cQVx/6IEOXFoUxgFDzGFPPHYc
         tRqw==
X-Gm-Message-State: AJIora/otf2S6SgyqTIFc93l7B1350H0cR8jYqMAmpAgbVUA2VikQHHR
        30oY7lLVNxMqZWQUXH4CSFjm3yxg5wZn0GeU
X-Google-Smtp-Source: AGRyM1sAaKr+9841XSwWQICd1ngfgvPUx3MtSz1Ek4ds5LmEuxk5ZZuHueYR18476IaPXWqQE4OVrg==
X-Received: by 2002:a05:6512:605:b0:489:ce37:df0f with SMTP id b5-20020a056512060500b00489ce37df0fmr21884270lfe.364.1658421067657;
        Thu, 21 Jul 2022 09:31:07 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id t4-20020a192d44000000b0048a751c966dsm45802lft.224.2022.07.21.09.31.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 09:31:07 -0700 (PDT)
Message-ID: <63e972f1-3410-1ce3-ee9c-71fa98304f34@linaro.org>
Date:   Thu, 21 Jul 2022 18:31:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] arm64: dts: qcom: introduce sa8540p-ride dts
Content-Language: en-US
To:     Parikshit Pareek <quic_ppareek@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220721154057.15276-1-quic_ppareek@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220721154057.15276-1-quic_ppareek@quicinc.com>
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

On 21/07/2022 17:40, Parikshit Pareek wrote:
> Create new dts file specific for Qdrive board based on sa8540p chipset.

s/dts/DTS/
s/sa8450p/SA8450P/

> Introduce common dtsi file sa8295p-adp.dtsi, to be included for adp and
> Qdrive board.

Thank you for your patch. There is something to discuss/improve.

> 
> Signed-off-by: Parikshit Pareek <quic_ppareek@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  arch/arm64/boot/dts/qcom/sa8295p-adp.dts      | 378 +----------------
>  arch/arm64/boot/dts/qcom/sa8295p-adp.dtsi     | 385 ++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sa8540p-adp-ride.dts |  15 +
>  4 files changed, 403 insertions(+), 376 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/sa8295p-adp.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/sa8540p-adp-ride.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 9e2a13d75f9d..fa0abcf7660b 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -51,6 +51,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qrb5165-rb5.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sa8155p-adp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sa8295p-adp.dtb
> +dtb-$(CONFIG_ARCH_QCOM) += sa8540p-adp-ride.dtb

Align formatting with the rest.

>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-idp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r1-lte.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> index 9398f0349944..adb6637117bc 100644
> --- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> @@ -2,388 +2,14 @@
>  /*
>   * Copyright (c) 2021, The Linux Foundation. All rights reserved.
>   * Copyright (c) 2022, Linaro Limited
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
>   */
>  
>  /dts-v1/;
>  
> -#include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> -#include <dt-bindings/spmi/spmi.h>
> -
> -#include "sa8540p.dtsi"
> +#include "sa8295p-adp.dtsi"
>  
>  / {
>  	model = "Qualcomm SA8295P ADP";
>  	compatible = "qcom,sa8295p-adp", "qcom,sa8540p";
> -
> -	aliases {
> -		serial0 = &qup2_uart17;
> -	};
> -
> -	chosen {
> -		stdout-path = "serial0:115200n8";
> -	};
> -};
> -

You need to split the patch. First into DTSI split, so we can easily
compare the diffs. Then add new board.


Best regards,
Krzysztof
