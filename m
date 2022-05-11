Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E92B523C5A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 20:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346161AbiEKSTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 14:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345354AbiEKSTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 14:19:52 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0927F140432
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 11:19:50 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id ch13so5650259ejb.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 11:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bGPi3sym2sxZNuq8XM44v+EhEVtJACn3fgf26OWgsSM=;
        b=xIyjh3l1EuCFk77BXzR8OmHseKLWjA3L+QFx7Esfu1gCdNNOljH4U8pzyTmTAfeUPl
         R1xQUxezEvy+2+R+WygC1u2eMVN10z2qzL9fm+aycu03bP7hbHKUCGl7b9pRwgDhevkE
         TmVH35KEAxXFUG4Z3TsTQZ2Zmm8zcl3aQZeJG/JQxZym8rsuDJQZN+8/AdTJEoCfOGb0
         e3g3pickNN5IzL8ph/3ZgmYaBRwlUY+N17yFU6NPUAWiMkTZ0T0W7yNGtX5lrdvFtQ2e
         7DXMB8yVaylPGxPzidZzahyxjDf3+funYGQx83vBwa7p0FMRVtXHj9FS+yaGBirFt04g
         21qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bGPi3sym2sxZNuq8XM44v+EhEVtJACn3fgf26OWgsSM=;
        b=3GtBQxNQQWNTQqOro5OKJDYyEQWxUpy0jOAPdg759fy16DqQhEtadjKQ+8MkXt4LBS
         qZUolmy2tvZ/5Wa8myZqhdV6crEnL2Bco3dpWIVV4VYu1orT6QWxqrQAlGbGd/ZXO4Ab
         QfL02craKRC8wvvxHgSCFe8ZQtc24ol2z7RtV4ku2rG92kBdN91AzMK9MzwaG+bYQ/Zy
         276CkSIjh0La+ZlxB3GaqTbiAtT79WA8ZMYdukhpHyAA3a6wjzvRq2zmbupz/J8QRyVj
         78vojwuHZbmyePi6Sfa9EsZ4KbwfW7EddVzY7ZOwhlK/ghvhvptg+ynASgoRBBHDDL3v
         +uyA==
X-Gm-Message-State: AOAM5302WPuUKRlRZQVBGfmHQDHJ+4RtHQg0c1x44gnFxCBxOxabvbwx
        B/ndM3TfxbHg7wh7eWvEDIRm0w==
X-Google-Smtp-Source: ABdhPJw66c9o+JFuSuktSAYjNSClBUHjxcCrVhgRBUlsQkLLo9gay5LhgxMMS79bGlogG5dtbdtSXw==
X-Received: by 2002:a17:907:72ce:b0:6f4:d139:c2b1 with SMTP id du14-20020a17090772ce00b006f4d139c2b1mr26220333ejc.563.1652293188527;
        Wed, 11 May 2022 11:19:48 -0700 (PDT)
Received: from [192.168.0.155] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id a11-20020a17090682cb00b006f3ef214db4sm1223826ejy.26.2022.05.11.11.19.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 11:19:47 -0700 (PDT)
Message-ID: <d296720d-ccbe-27f0-8ba1-9653af25dd52@linaro.org>
Date:   Wed, 11 May 2022 20:19:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [v4 1/3] dt-bindings: phy: qcom,usb-snps-femto-v2: Add phy
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
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com, quic_vpulyala@quicinc.com,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>
References: <1652282793-5580-1-git-send-email-quic_kriskura@quicinc.com>
 <1652282793-5580-2-git-send-email-quic_kriskura@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1652282793-5580-2-git-send-email-quic_kriskura@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2022 17:26, Krishna Kurapati wrote:
> From: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> 
> Add device tree bindings for SNPS phy tuning parameters.
> 
> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  .../bindings/phy/qcom,usb-snps-femto-v2.yaml       | 87 ++++++++++++++++++++++
>  1 file changed, 87 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
> index 1ce251d..70efffe 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
> @@ -53,6 +53,93 @@ properties:
>    vdda33-supply:
>      description: phandle to the regulator 3.3V supply node.
>  
> +  qcom,hs-disconnect-bps:
> +    $ref: /schemas/types.yaml#/definitions/int32
> +    description:
> +      This adjusts the voltage level for the threshold used to
> +      detect a disconnect event at the host. Possible values are.
> +      The values defined are in multiples of basis points (1bp = 0.01%).

This means there is some minimum and maximum (100%)?

> +      The hardware accepts only discrete values. The value closest to the
> +      provided input will be chosen as the override value for this param.
> +
> +  qcom,squelch-detector-bps:
> +    $ref: /schemas/types.yaml#/definitions/int32
> +    description:
> +      This adjusts the voltage level for the threshold used to
> +      detect valid high-speed data.
> +      The values defined are in multiples of basis points (1bp = 0.01%).
> +      The hardware accepts only discrete values. The value closest to the
> +      provided input will be chosen as the override value for this param.
> +
> +  qcom,hs-amplitude-bps:
> +    $ref: /schemas/types.yaml#/definitions/int32
> +    description:
> +      This adjusts the high-speed DC level voltage.
> +      The values defined are in multiples of basis points (1bp = 0.01%).
> +      The hardware accepts only discrete values. The value closest to the
> +      provided input will be chosen as the override value for this param.
> +
> +  qcom,pre-emphasis-duration-bps:
> +    $ref: /schemas/types.yaml#/definitions/int32
> +    description:
> +      This signal controls the duration for which the
> +      HS pre-emphasis current is sourced onto DP<#> or DM<#>.
> +      The HS Transmitter pre-emphasis duration is defined in terms of
> +      unit amounts. One unit of pre-emphasis duration is approximately
> +      650 ps and is defined as 1X pre-emphasis duration.
> +      The values defined are in multiples of basis points (1bp = 0.01%).
> +      The hardware accepts only discrete values. The value closest to the
> +      provided input will be chosen as the override value for this param.
> +
> +  qcom,pre-emphasis-amplitude-bps:
> +    $ref: /schemas/types.yaml#/definitions/int32
> +    description:
> +      This signal controls the amount of current sourced to
> +      DP<#> and DM<#> after a J-to-K or K-to-J transition.
> +      The HS Transmitter pre-emphasis current is defined in terms of unit
> +      amounts. One unit amount is approximately 2 mA and is defined as
> +      1X pre-emphasis current.
> +      The values defined are in multiples of basis points (1bp = 0.01%).
> +      The hardware accepts only discrete values. The value closest to the
> +      provided input will be chosen as the override value for this param.
> +
> +  qcom,hs-rise-fall-time-bps:
> +    $ref: /schemas/types.yaml#/definitions/int32
> +    description:
> +      This adjusts the rise/fall times of the high-speed waveform.
> +      The values defined are in multiples of basis points (1bp = 0.01%).
> +      The hardware accepts only discrete values. The value closest to the
> +      provided input will be chosen as the override value for this param.
> +
> +  qcom,hs-crossover-voltage-mv:
> +    $ref: /schemas/types.yaml#/definitions/int32
> +    description:
> +      This adjusts the voltage at which the DP<#> and DM<#>
> +      signals cross while transmitting in HS mode.
> +      The values defined are in milli volts. The hardware accepts only
> +      discrete values. The value closest to the provided input will be
> +      chosen as the override value for this param.
> +
> +  qcom,hs-output-impedance-mohm:
> +    $ref: /schemas/types.yaml#/definitions/int32

Here and in other places, please use standard units. See
dtschema/schemas/property-units.yaml in dtschema repo.


Best regards,
Krzysztof
