Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD0B542C69
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235794AbiFHKBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235496AbiFHKAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:00:34 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8604BB94
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 02:36:27 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id d14so719304eda.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 02:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=eI4rRuIF5rwXNrtStQNZCOGZWwsWfQkS5JLBX7fWVXQ=;
        b=DRxCBnOFXtFvXDB08Qu2T1k921VY6qvaJVNLpoCyU0XijkcKt5mfQl5JSSJvkoo08u
         8Cnp+cSjN747ozsJLyWF2jGta2Vm92/pWAJfM3gnGC6INl0qkuXS5QGYxT+0bh8WZedZ
         RiUV7ELu1zvO86fy8VHFet50nvw7jNk1Rvcg8an/xzgDGwfpIWQKX62OUDuECECcejwa
         BAusj4YBGjftykGx4pcb39RkMzT5yH25BhynJ+VAjWWbq1I5Gm8q3n7TAb+Q/CS8Dyfj
         5cMg14rbj3Q3OPiUYo/Vzjp+6G36z32cjdwsCFScEBs0VgGirlHlmbBqfyZ6h1NmDNy4
         85ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eI4rRuIF5rwXNrtStQNZCOGZWwsWfQkS5JLBX7fWVXQ=;
        b=ZzwE/OBUhtoS5j+ebrJ+sSAPk4N3AVKi0rL4L0PasaRR7wDmMZyTLXMrXkornXLh9V
         nO7AXVuX932yAAv7wjq3iczSC0bxKkCxlqASvGbhF6MR49TrKjef13b4tLDK2+qEEA/p
         GTLPvJjupQcQUAWZDN32q5d14ag4hDH1Ed2lcsYtiDhmCv9J+1oE1wvl3Oti7cgWeNda
         x7yOg5Qp0ZYgaBqciv+VUoPzsaN+knCBqe18WrWSWKERJUelL77ISyX4SGs85Fs46rak
         sgWuBxaGt0CtALVGY4c1eSfGVPgMtN/1ye086sLhhuANYS89kDkWJ9dTup1kqEM8+McG
         2G2A==
X-Gm-Message-State: AOAM530IqZokKztE/hHpsEU/1F1dUqG79tBhkvy8rtnI53vbaS8lVyUs
        0PINT+cj+XFBzzErqX+QBarD3w==
X-Google-Smtp-Source: ABdhPJx2vRZB9jUOwfNQSE3tD1mYIxgaNMiVS9zySc4nX10DE5LPoeunwV0M4wGchyKlmJW2htL1uA==
X-Received: by 2002:a05:6402:1d51:b0:41f:cf6c:35a5 with SMTP id dz17-20020a0564021d5100b0041fcf6c35a5mr38740410edb.25.1654680986080;
        Wed, 08 Jun 2022 02:36:26 -0700 (PDT)
Received: from [192.168.0.191] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id fg24-20020a1709069c5800b006fe9ec4ba9esm8735506ejc.52.2022.06.08.02.36.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 02:36:25 -0700 (PDT)
Message-ID: <00cf0a30-46d5-f566-af35-9f7c33ec4182@linaro.org>
Date:   Wed, 8 Jun 2022 11:36:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v8 1/3] dt-bindings: phy: qcom,usb-snps-femto-v2: Add phy
 override params bindings
Content-Language: en-US
To:     Krishna Kurapati <quic_kriskura@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com, quic_vpulyala@quicinc.com,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>
References: <1654066564-20518-1-git-send-email-quic_kriskura@quicinc.com>
 <1654066564-20518-2-git-send-email-quic_kriskura@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1654066564-20518-2-git-send-email-quic_kriskura@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2022 08:56, Krishna Kurapati wrote:
> From: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> 
> Add device tree bindings for SNPS phy tuning parameters.
> 
> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/phy/qcom,usb-snps-femto-v2.yaml       | 96 ++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
> index 1ce251d..daeeb04 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
> @@ -53,6 +53,102 @@ properties:
>    vdda33-supply:
>      description: phandle to the regulator 3.3V supply node.
>  
> +  qcom,hs-disconnect-bp:
> +    description:
> +      This adjusts the voltage level for the threshold used to
> +      detect a disconnect event at the host. Possible values are.
> +      The values defined are in multiples of basis points (1bp = 0.01%).
> +      The hardware accepts only discrete values. The value closest to the
> +      provided input will be chosen as the override value for this param.
> +    minimum: -272
> +    maximum: 2156
> +
> +  qcom,squelch-detector-bp:
> +    description:
> +      This adjusts the voltage level for the threshold used to
> +      detect valid high-speed data.
> +      The values defined are in multiples of basis points (1bp = 0.01%).
> +      The hardware accepts only discrete values. The value closest to the
> +      provided input will be chosen as the override value for this param.
> +    minimum: -2090
> +    maximum: 1590
> +
> +  qcom,hs-amplitude-bp:
> +    description:
> +      This adjusts the high-speed DC level voltage.
> +      The values defined are in multiples of basis points (1bp = 0.01%).
> +      The hardware accepts only discrete values. The value closest to the
> +      provided input will be chosen as the override value for this param.
> +    minimum: -660
> +    maximum: 2670
> +
> +  qcom,pre-emphasis-duration-bp:
> +    description:
> +      This signal controls the duration for which the
> +      HS pre-emphasis current is sourced onto DP<#> or DM<#>.
> +      The HS Transmitter pre-emphasis duration is defined in terms of
> +      unit amounts. One unit of pre-emphasis duration is approximately
> +      650 ps and is defined as 1X pre-emphasis duration.
> +      The values defined are in multiples of basis points (1bp = 0.01%).
> +      The hardware accepts only discrete values. The value closest to the
> +      provided input will be chosen as the override value for this param.
> +    minimum: 10000
> +    maximum: 20000
> +
> +  qcom,pre-emphasis-amplitude-bp:
> +    description:
> +      This signal controls the amount of current sourced to
> +      DP<#> and DM<#> after a J-to-K or K-to-J transition.
> +      The HS Transmitter pre-emphasis current is defined in terms of unit
> +      amounts. One unit amount is approximately 2 mA and is defined as
> +      1X pre-emphasis current.
> +      The values defined are in multiples of basis points (1bp = 0.01%).
> +      The hardware accepts only discrete values. The value closest to the
> +      provided input will be chosen as the override value for this param.
> +    minimum: 10000
> +    maximum: 40000
> +
> +  qcom,hs-rise-fall-time-bp:
> +    description:
> +      This adjusts the rise/fall times of the high-speed waveform.
> +      The values defined are in multiples of basis points (1bp = 0.01%).
> +      The hardware accepts only discrete values. The value closest to the
> +      provided input will be chosen as the override value for this param.
> +    minimum: -4100
> +    maximum: 5430
> +
> +  qcom,hs-crossover-voltage-microvolt:
> +    description:
> +      This adjusts the voltage at which the DP<#> and DM<#>
> +      signals cross while transmitting in HS mode.
> +      The values defined are in milli volts.

It's not accurate anymore - it's microvolt. I propose to skip this one
sentence, because unit is obvious from the type.

> +    maximum: 28000
> +
> +  qcom,hs-output-impedance-micro-ohms:
> +    description:
> +      In some applications, there can be significant series resistance
> +      on the D+ and D- paths between the transceiver and cable. This adjusts
> +      the driver source impedance to compensate for added series
> +      resistance on the USB. The values defined are in milli ohms.

The same. Other places might need similar change.

Best regards,
Krzysztof
