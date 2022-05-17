Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968E952997A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 08:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239474AbiEQGXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 02:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239403AbiEQGXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 02:23:08 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455B9443EB
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 23:23:05 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id l18so32628409ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 23:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=c4ENXCjOLk1+dgXS0L44HTmpqaPYATePjr2C7PlRSnY=;
        b=X54KsWPB0NVyyxAopjnRgU4ZOBrGbvlQ4FaNzE7BKYrtEqYlqOMCstiCOL//lQ8Dxw
         8rkRpqoCADABAM8/OuegxD/25O7f/nJPZoaLKTmjnmcO5e/rG65jTmm9ahJBsk4RyVNC
         Vtyp//l1Ok5j+8NwCWJlc+n3TbV44X5yO22wosq8xZ3qMCEdUvredEedxwk4R+boPRiu
         Y/1FTQlZj740YLjErI3CrutAOuImvAvRxoE+x8k9T/MFztuJvet3PY16TBgTKaNMVbhE
         zFw2Fsf+IcZ/qt9hwH4PXj1GSzulCd1cyTs95kQF8d8BeoEy/+RzVvtiuP/D6WKh/1XG
         bjRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=c4ENXCjOLk1+dgXS0L44HTmpqaPYATePjr2C7PlRSnY=;
        b=tr6uMAGG1uGtfRTEfk8q+uQsiqO8Kq0y8IW/A03ml6rwRSSvke9aKnlN+wH379vHe/
         3Evz+cRKjLogo1lEDOlRKB68DDV1j5WpkmXmsLOHGcWyMtYTASvUtYNbpvNmT9OYnT2m
         DK4N6oZDPASpdFVwmmFFl/MPKCYsNecL2H8Vx9VZwrfbIXYcJ9UMrqhJgKBPw+6sVzFA
         OeQcrgVu6TqRf81diUIJlk6t+/2m7VDtIQi4AKCGc7K0L28pYAoUdsIC3DT0YRD0Q0bm
         x9Hp6fUxDVR5YWA0q736HHnnA4Wo9Fx5OBYSVknhlaoYbLKVOV81vMgYLKvUKFCRvzbB
         s1tQ==
X-Gm-Message-State: AOAM533kyYMxeximrr6hCAaHtLOZc+YSSj1P1x5kJl/V6a9G6wVbWk3J
        /vD6j7Ko2+aQ/TwjVJDjUqJgsg==
X-Google-Smtp-Source: ABdhPJwEc9IVtajjmC4AchKGNCO1Lk9VipryyhfwItsHVzbgcFpffhGt50uBwsKK0NreDqXTje0i+g==
X-Received: by 2002:a17:906:656:b0:6f4:ebc2:da81 with SMTP id t22-20020a170906065600b006f4ebc2da81mr18501914ejb.757.1652768583817;
        Mon, 16 May 2022 23:23:03 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id es16-20020a056402381000b0042a96c77e9esm4448347edb.91.2022.05.16.23.23.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 23:23:03 -0700 (PDT)
Message-ID: <f042abfc-25c8-2684-3fec-fea17bab8087@linaro.org>
Date:   Tue, 17 May 2022 08:23:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [v5 1/3] dt-bindings: phy: qcom,usb-snps-femto-v2: Add phy
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
References: <1652723410-1630-1-git-send-email-quic_kriskura@quicinc.com>
 <1652723410-1630-2-git-send-email-quic_kriskura@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1652723410-1630-2-git-send-email-quic_kriskura@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2022 19:50, Krishna Kurapati wrote:
> From: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> 
> Add device tree bindings for SNPS phy tuning parameters.
> 
> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  .../bindings/phy/qcom,usb-snps-femto-v2.yaml       | 105 +++++++++++++++++++++
>  1 file changed, 105 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
> index 1ce251d..0a78db7 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
> @@ -53,6 +53,111 @@ properties:
>    vdda33-supply:
>      description: phandle to the regulator 3.3V supply node.
>  
> +  qcom,hs-disconnect-bp:
> +    $ref: /schemas/types.yaml#/definitions/int32

No need for ref for standard units.

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
> +    $ref: /schemas/types.yaml#/definitions/int32
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
> +    $ref: /schemas/types.yaml#/definitions/int32
> +    description:
> +      This adjusts the high-speed DC level voltage.
> +      The values defined are in multiples of basis points (1bp = 0.01%).
> +      The hardware accepts only discrete values. The value closest to the
> +      provided input will be chosen as the override value for this param.
> +    minimum: -660
> +    maximum: 2670
> +
> +  qcom,pre-emphasis-duration-bp:
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
> +    minimum: 10000
> +    maximum: 20000
> +
> +  qcom,pre-emphasis-amplitude-bp:
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
> +    minimum: 10000
> +    maximum: 40000
> +
> +  qcom,hs-rise-fall-time-bp:
> +    $ref: /schemas/types.yaml#/definitions/int32
> +    description:
> +      This adjusts the rise/fall times of the high-speed waveform.
> +      The values defined are in multiples of basis points (1bp = 0.01%).
> +      The hardware accepts only discrete values. The value closest to the
> +      provided input will be chosen as the override value for this param.
> +    minimim: -4100
> +    maximum: 5430
> +
> +  qcom,hs-crossover-voltage-microvolt:
> +    $ref: /schemas/types.yaml#/definitions/int32
> +    description:
> +      This adjusts the voltage at which the DP<#> and DM<#>
> +      signals cross while transmitting in HS mode.
> +      The values defined are in milli volts. The hardware accepts only
> +      discrete values. The value closest to the provided input will be
> +      chosen as the override value for this param.
> +    minimum: -31000
> +    maximum: 28000
> +
> +  qcom,hs-output-impedance-micro-ohm:

Please use standard unit suffixes, so micro-ohms.


Best regards,
Krzysztof
