Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911515748C4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 11:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237622AbiGNJ0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 05:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237857AbiGNJZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:25:52 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8601EC55
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 02:24:28 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id x10so991739ljj.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 02:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RIxuG/dWnqPo1zA+7iiSWWGISkJu/Q1yXByyi5sW6U8=;
        b=lHItioyrMcudO1VZcpnWVPESfr1Qk/hh+owstM81ntCb3Qxosq2w2IYo7CW0WwKq3e
         /BPS1vgpHNVg7VgI9Z8QBewKc+GOw1br1gmSwmkvuuBcKK3IM2Ao41rKm8iPgx+FcpHN
         C3POgdOjUU4nzr1hrB99JC5i9mhGZaSVTFv8MVU2UnqbbWXIYgSvd7wTnpUzzgpjv/0/
         Vto2erTm/6hODJGYcGp8DWu2BaBS5m84Cm/oZ+HbOZt571WLStEHPmpTmnWhnJDAQvFm
         Os9ddYHeHlzVb0mT9WXV0t5TBYzb4P52C6iPSwBx4V9uwQdR/JvLSejbQS2bIoiWG6uC
         lRtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RIxuG/dWnqPo1zA+7iiSWWGISkJu/Q1yXByyi5sW6U8=;
        b=Dd6aEYADNtITLMK2yXrNhyPStFk7WD0K10V4KpQDUXEw8VWNQ4GVuteWS6tVeKoWo6
         Zj4TK5W0NyH/LguQg4tIUrr4nL1p8upLV3ncUgo72hkMbkqUpz7plWwiKFlFy2hcP5c/
         d0HO4tIBUfKAbyMYpLMJ05/eL/rU76CLqiWNcwu8n3zq+rBksgUJ86s+QzKnOLTreEG9
         qdA6aGfxipIpL7rd7jCCffo0AyN+aZ80qZcE+vvziz2P7uhzRRwsfrPG8MXy7hoScQkE
         E4kJAdLp2XRT2EaLdT3PZAcdXwm/3GUe1NvtiYihF7IWs80P5zmAoJTh8HdSpJ5tTQ0y
         kyYA==
X-Gm-Message-State: AJIora/5jKUOr7uvwQUEneJvmwoUD+PDfu62Ydlx3/SLwqPC3lI5eIDR
        Knv0b+SjXMJQnhF6pqtuTnLh1g==
X-Google-Smtp-Source: AGRyM1umRoewL9yaPTS/tooayVYudGK1+3bahkbSalpzztsgA3NuexMrwv0s9xCdLxj1UJ3muI8JDg==
X-Received: by 2002:a2e:93c8:0:b0:24e:eabd:bf6e with SMTP id p8-20020a2e93c8000000b0024eeabdbf6emr3844403ljh.347.1657790667064;
        Thu, 14 Jul 2022 02:24:27 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id z20-20020a2eb534000000b0025d6ecbc897sm184901ljm.46.2022.07.14.02.24.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 02:24:26 -0700 (PDT)
Message-ID: <b98aefd2-b0d3-66da-01d4-754c206d6fca@linaro.org>
Date:   Thu, 14 Jul 2022 11:24:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 19/30] dt-bindings: phy: add QMP USB PHY schema
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220707134725.3512-1-johan+linaro@kernel.org>
 <20220707134725.3512-20-johan+linaro@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220707134725.3512-20-johan+linaro@kernel.org>
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

On 07/07/2022 15:47, Johan Hovold wrote:
> The QMP PHY DT schema is getting unwieldy. Break out the USB PHY
> binding in a separate file.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  ...com,qmp-phy.yaml => qcom,qmp-usb-phy.yaml} | 69 +++++--------------
>  1 file changed, 18 insertions(+), 51 deletions(-)
>  rename Documentation/devicetree/bindings/phy/{qcom,qmp-phy.yaml => qcom,qmp-usb-phy.yaml} (82%)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.yaml
> similarity index 82%
> rename from Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> rename to Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.yaml
> index 21d6ec875529..66cabf4d5722 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.yaml
> @@ -1,11 +1,10 @@
>  # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> -
>  %YAML 1.2
>  ---
> -$id: "http://devicetree.org/schemas/phy/qcom,qmp-phy.yaml#"
> -$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +$id: http://devicetree.org/schemas/phy/qcom,qmp-usb-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Qualcomm QMP PHY controller
> +title: Qualcomm QMP PHY controller (USB)
>  
>  maintainers:
>    - Vinod Koul <vkoul@kernel.org>
> @@ -51,20 +50,20 @@ properties:
>    ranges: true
>  
>    clocks:
> -    minItems: 1
> +    minItems: 3
>      maxItems: 4
>  
>    clock-names:
> -    minItems: 1
> +    minItems: 3
>      maxItems: 4
>  
>    resets:
> -    minItems: 1
> -    maxItems: 3
> +    minItems: 2

Skip minItems (equal to max)

> +    maxItems: 2
>  
>    reset-names:
> -    minItems: 1
> -    maxItems: 3
> +    minItems: 2

The same.



Best regards,
Krzysztof
