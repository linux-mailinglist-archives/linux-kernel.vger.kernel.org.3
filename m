Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5809F4B7653
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243835AbiBOTzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 14:55:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240057AbiBOTze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 14:55:34 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394E66BDF1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 11:55:23 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id m14so17752543lfu.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 11:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=od9Fv9jtSpr7wJ186PxRq7ulSmKEgnYjdZXcjAfazIo=;
        b=PH2AVilT2kpsLFO1HEukZSVhRun9ilfkrnq6W59AVR3hwgb1gm7pTqe1KNp033S5Km
         Y3V+U0IWpcw7iA0RxRPVr86sUFYAz/4PUgCe4eriG6I45tOuwDzdT+cuHXhkkjtkHkq/
         naCB45uKFm8OTA6iET/Jz8tKqsIZZmlMw0IJwtsU2HKpnAuv/++IXmP/A+UCA3Oucb80
         9HLzHxlNkyOrQzwYASpnNEqEXBYkIBYvhA2pLtQ3Iur4LdQ6JhHiP6RaCGq5nNi5cC2J
         7sIXklkRJZIHRJ5NGBtkAcotBL/f8HRjaKpoB9swrc469lUL+5Rjsu3KZ9R4tWaBybET
         L7OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=od9Fv9jtSpr7wJ186PxRq7ulSmKEgnYjdZXcjAfazIo=;
        b=cGt+Bt4XBhUXrx5QSuPNyuITPuJD0Ki/uY79K42ZHG6FkqwcVpZ9nJOMffzkKs3YW9
         szcBHnzaKrnGFnnUNQf2klesuyYBh9rl4qF915ON0grYL6g9Ub65QWj+ncYS4IRj5Kwt
         ltq3Ri/fN/GPyR4CzbQzw3z0xnpP1zGJ/aDpTtwDJsAJCUH6HHAzXp8M387L4WlerLUZ
         jAncBA6cgbf7I0AeN0B8AJrokYJgwefXOyNbiSXOz6YXzaAKeIDVP/YoTuA4Bcqra/U9
         FEAcFXy8y2cWw6Qly72SoUIDLud3JP11OIHRI62ofYseKiJXbEswZZR+bzwbuwvuzLad
         aSxQ==
X-Gm-Message-State: AOAM531wryVc7zeJc6e56QV2ZbFsDWlTz81hfVme/ahGPk/6guIKh1Kz
        0UJZctgD5E3o7aEEIX+9/FhTEA==
X-Google-Smtp-Source: ABdhPJzECnJd9c606qBv0fz/un9p5bu6tPClqHkkq6PByN5AK0Qwwk2/z0dziQr2abuBnJ5sUk9K3g==
X-Received: by 2002:a05:6512:c10:: with SMTP id z16mr493947lfu.387.1644954921579;
        Tue, 15 Feb 2022 11:55:21 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id b9sm4602308lfb.222.2022.02.15.11.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 11:55:20 -0800 (PST)
Message-ID: <f1b4b389-12f9-7c21-b117-f2fe6df58a89@linaro.org>
Date:   Tue, 15 Feb 2022 22:55:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 1/3] dt-bindings: phy: qcom,usb-snps-femto-v2: Add phy
 override params bindings
Content-Language: en-GB
To:     Sandeep Maheswaram <quic_c_sanm@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <wcheng@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     evicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com
References: <1644952755-15527-1-git-send-email-quic_c_sanm@quicinc.com>
 <1644952755-15527-2-git-send-email-quic_c_sanm@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1644952755-15527-2-git-send-email-quic_c_sanm@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 15/02/2022 22:19, Sandeep Maheswaram wrote:
> Add support for overriding SNPS phy tuning parameters in device tree
> bindings.

This does not really benefit the users and does not help developers.
Could you please change the dt bindings to specify values for 
thresholds, durations, impedance, etc. The values should be represented 
in the human units (e.g. us, Ohms, mV), not in the internal register 
'bits' representation.

> 
> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> ---
>   .../devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml  | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
> index 0dfe691..44cf3bf 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
> @@ -50,6 +50,22 @@ properties:
>     vdda33-supply:
>       description: phandle to the regulator 3.3V supply node.
>   
> +  qcom,override_x0:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Override value for hs disconnect and squelch detector threshold.
> +
> +  qcom,override_x1:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Override value for hs amplitude, pre-emphasis duration and amplitude.
> +
> +  qcom,override_x2:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Override value for hs rise/fall time, cross over voltage, output impedance.
> +
> +  qcom,override_x3:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Override value for ls/fs output impedance.
> +
>   required:
>     - compatible
>     - reg


-- 
With best wishes
Dmitry
