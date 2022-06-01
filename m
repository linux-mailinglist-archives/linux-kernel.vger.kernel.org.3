Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153ED53A37D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 13:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352383AbiFALDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 07:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352027AbiFALDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 07:03:06 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB60880C7
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 04:03:05 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id y19so2967202ejq.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 04:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Fx8hR1Ri3SI+El5o0pYbgj5MaJ9J6XG9nU7Eot+VsE4=;
        b=MeOcRsNNDpR2TdsfCNoPv1bhmFR50EDF+h4eSzXkdEAaZevad9M87SRiKUk8pV0g9j
         2gJf2C6qPmnZDs++7hMvdVMIgbHzeWBAa39aQ05mS8E+RlB7YOLulnEXkn0yeTr7UZlG
         dHUu4pZow6Dz2xI4feNTxmEao/FC/H8+cO4mC5qR25dlHLbtj7GhJyErgBZ4JS/yeH8P
         vJFwIfH/AppSSEdAA9UWyQmZ5G3/pe69XkYnzbunbVFgPeacefwwYNTXVC1tfcMWaU37
         zC/uS0BiUKdSugKSLLzTvpn3GhjA02WFmVWIBoTtl2G/sO54Xa4MDc/he9aXNcCNV3J/
         bE0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Fx8hR1Ri3SI+El5o0pYbgj5MaJ9J6XG9nU7Eot+VsE4=;
        b=3B3S1Gax0I5kMVvhOhDEr8KbrOohCN7+aAFgbd0EMfJLbUHoM4hnCqjR/E3By7QyjH
         G4T4vTj1ZKCtbnLuMaMWZuTDR3EXE6IVw20In0ahIVB8kwncp5/9Go3HQ2EuTn8AED3V
         WauuTmlDyFsAx5f+B0yoJgwwg9QkCQvxM0NL7IWRJrsUb8WF/7u4LkNyqnHa9ji91WtI
         XVpPRjF3SsbYwHP9VUYL4diAVDQpQ8pGonHyS1O8nF54i+DtgwT5dAMStbePpCVuvQto
         84dAlCEpk2HLjZoUhnN5QyJG0zomEUd9dCe1R5vMhlnNqSOPKf4KeXPhJhgQ1Wz5aqN+
         37nw==
X-Gm-Message-State: AOAM533vT+U3lyNm4tudd6GtuhWpKOsBz+rL1zSk0P4Ba9UtScFR4yGO
        0gAg0nT2QpJktk20oRSUHBNwbg==
X-Google-Smtp-Source: ABdhPJx8JasyPtz+hxWfWP8/TEBgs8JT4t4mRChQwxbKC9/9UHQ2XCCi/aoLnTme0X9PguEAh3VY7Q==
X-Received: by 2002:a17:907:7f0b:b0:6ff:4502:9c2f with SMTP id qf11-20020a1709077f0b00b006ff45029c2fmr20854513ejc.532.1654081383714;
        Wed, 01 Jun 2022 04:03:03 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id mj4-20020a170906af8400b006ff0fe78cb7sm589619ejb.133.2022.06.01.04.03.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 04:03:03 -0700 (PDT)
Message-ID: <55af0870-ff8b-3577-8520-95c1063ecc86@linaro.org>
Date:   Wed, 1 Jun 2022 13:03:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 10/11] ARM: dts: qcom: sdx65: Add Watchdog support
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wim@linux-watchdog.org,
        linux@roeck-us.net
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        manivannan.sadhasivam@linaro.org
References: <1654080312-5408-1-git-send-email-quic_rohiagar@quicinc.com>
 <1654080312-5408-11-git-send-email-quic_rohiagar@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1654080312-5408-11-git-send-email-quic_rohiagar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2022 12:45, Rohit Agarwal wrote:
> Enable Watchdog support for Application Processor Subsystem (APSS) block
> on SDX65 platform.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>  arch/arm/boot/dts/qcom-sdx65.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
> index 5e4687d..c76f330 100644
> --- a/arch/arm/boot/dts/qcom-sdx65.dtsi
> +++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
> @@ -513,6 +513,13 @@
>  			#clock-cells = <0>;
>  		};
>  
> +		watchdog@17817000 {
> +			compatible = "qcom,apss-wdt-sdx65", "qcom,kpss-wdt";
> +			reg = <0x17817000 0x1000>;
> +			clocks = <&sleep_clk>;
> +		};
> +

Just one line break, please.



Best regards,
Krzysztof
