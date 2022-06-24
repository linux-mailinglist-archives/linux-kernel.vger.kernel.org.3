Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E182559F3B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 19:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiFXRSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiFXRR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:17:59 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26579E64
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:17:57 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id ej4so4378851edb.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QO2xbsZ3DwvoKI/D5PILJK1SdhtLthoBmyVWXf1LehI=;
        b=riSm0FlJgfp0dBXID4v2NQTo8SOXgPflsvQMGoR86iK28ba4yxmwUwoptM5dWWwqiK
         l92EzP4jSf90Vr6x5ir0jYK5+FZ4heKpnbMunI96UycBMM/+hJ215k0q1ix6PoOI2thy
         lF0Wa4WLjnysW1sJOztWQ+P7JfqPzrCtfa7vIQVND31KXECN2mFIKtRLXEmjAht+RmTi
         YCgR9I+Q1NnYWY0f23VoAhWfs5dezqTksdH8IFWUG4gdSQjTNv8d9dn1JHcvhEhfCxI3
         aXbV6F/rzDH7S+weQyW9AQPMaB8I7rhhDZ6oT43UElcY5k5ZXd95jkJ9AVsarenT5E4O
         bzKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QO2xbsZ3DwvoKI/D5PILJK1SdhtLthoBmyVWXf1LehI=;
        b=trUyQ3JWQMCDO/MTcA1dV88KEU/RNrabr9f8y+OfDRLLFuP18hxswaEsFPQPK3lQwg
         2/WCqWkk4T7g+S3mngIDzzO16XoD/HweqT6Y2GJWQunYyr5KH5p3zjdqHe0gbcWzxDfN
         QIdUesuS0V44r73epzkgwDFmEJD1tl5GvrjqHw19tLSXs00hDXNkGsC90Bp/vhpzynOn
         m7dSaSSavISMNf+qqDva/9xdP3qu+odHb5D4hZLeGoYjvUT0Dwntd7ZA8uR6uYVas+kt
         KqrYle69HIWDL3eYbFZiHrdSzL8BusEuyTjKqpw2pWPlGfjnkeai+MspsHSHQ3g4GHDu
         j5ng==
X-Gm-Message-State: AJIora/SPUNrbsJyhO7cmgddCEBdMCfS5gtq11Llb8cSK8QPfVszBXRN
        IdS4MB1reW2An0V2YIL7xBLjtQ==
X-Google-Smtp-Source: AGRyM1vVErSqX7pCRC/e1QSjDBJkieHwm2TXbOHt/piwTVUPc3SDtWWTG3XRwFKOkHtmw9wUqQ2Gfw==
X-Received: by 2002:aa7:c45a:0:b0:435:d7a4:99bc with SMTP id n26-20020aa7c45a000000b00435d7a499bcmr168035edr.158.1656091075738;
        Fri, 24 Jun 2022 10:17:55 -0700 (PDT)
Received: from [192.168.0.237] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id z4-20020a1709060f0400b00722f069fd40sm1411264eji.159.2022.06.24.10.17.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 10:17:55 -0700 (PDT)
Message-ID: <eb00b6c3-ae5e-9858-ab5f-fd78229ff436@linaro.org>
Date:   Fri, 24 Jun 2022 19:17:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH RESEND v9 5/5] arm64: dts: apm: Harmonize DWC USB3 DT
 nodes name
Content-Language: en-US
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-snps-arc@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220624141622.7149-1-Sergey.Semin@baikalelectronics.ru>
 <20220624141622.7149-6-Sergey.Semin@baikalelectronics.ru>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220624141622.7149-6-Sergey.Semin@baikalelectronics.ru>
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

On 24/06/2022 16:16, Serge Semin wrote:
> In accordance with the DWC USB3 bindings the corresponding node
> name is suppose to comply with the Generic USB HCD DT schema, which
> requires the USB nodes to have the name acceptable by the regexp:
> "^usb(@.*)?" . Make sure the "snps,dwc3"-compatible nodes are correctly
> named despite of the warning comment about possible backward
> compatibility issues.

Sometimes node name is exposed to user-space which depends on it. How
did you check there is no issue here?

> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm64/boot/dts/apm/apm-shadowcat.dtsi | 4 ++--
>  arch/arm64/boot/dts/apm/apm-storm.dtsi     | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi b/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
> index a83c82c50e29..832dd85b00bd 100644
> --- a/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
> +++ b/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
> @@ -597,8 +597,8 @@ serial0: serial@10600000 {
>  			interrupts = <0x0 0x4c 0x4>;
>  		};
>  
> -		/* Do not change dwusb name, coded for backward compatibility */
> -		usb0: dwusb@19000000 {
> +		/* Node-name might need to be coded as dwusb for backward compatibility */
> +		usb0: usb@19000000 {
>  			status = "disabled";
>  			compatible = "snps,dwc3";
>  			reg =  <0x0 0x19000000 0x0 0x100000>;
> diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
> index 0f37e77f5459..1520a945b7f9 100644
> --- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
> +++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
> @@ -923,8 +923,8 @@ sata3: sata@1a800000 {
>  			phy-names = "sata-phy";
>  		};
>  
> -		/* Do not change dwusb name, coded for backward compatibility */
> -		usb0: dwusb@19000000 {
> +		/* Node-name might need to be coded as dwusb for backward compatibility */
> +		usb0: usb@19000000 {
>  			status = "disabled";
>  			compatible = "snps,dwc3";
>  			reg =  <0x0 0x19000000 0x0 0x100000>;
> @@ -933,7 +933,7 @@ usb0: dwusb@19000000 {
>  			dr_mode = "host";
>  		};
>  
> -		usb1: dwusb@19800000 {
> +		usb1: usb@19800000 {
>  			status = "disabled";
>  			compatible = "snps,dwc3";
>  			reg =  <0x0 0x19800000 0x0 0x100000>;


Best regards,
Krzysztof
