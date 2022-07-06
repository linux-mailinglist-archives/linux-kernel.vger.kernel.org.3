Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6765680F9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 10:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbiGFITg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 04:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbiGFITf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 04:19:35 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEFA1F600
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 01:19:34 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id t25so24597035lfg.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 01:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gDjr8ks/zcETV46JsfKPfwR3f8/Qj094umNODYQnwfE=;
        b=vwpgEGu7gSpWjT7U08K4pkeu5xPCo1IsIY62sZGORbH1QlOSm5lkuAZeVggYLzb5xT
         sxFvZS/0Ujs5GjnRRq3RuihiwzDjFRlaTtZhKwAKBH1eLm1Obtmj4iapO++RvjY9lmMa
         ytGvxzXbGaZVV9qI2kIk3LPtTztVOqiCc+FnPxTwMnH1VXQm+JF4GsL98N4+hlJLLVmA
         WznOu0PVvLJuX8/ivOuhRVsqrH3OhzlAQ+/sjP46CLUjwbPc0pSIHaqSOtMK+m28C7IK
         ljLY93XtF7PWrfnqdvOjq/TLj5HZ2W/bRTj6Py8955zK96vadQD9q3aUT73ykjdeVs8h
         1TXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gDjr8ks/zcETV46JsfKPfwR3f8/Qj094umNODYQnwfE=;
        b=V1g/MU6TnitmhDTOYslYWX9lSZY5P4ctA9rsrQWpqsskRm06x0zj5NTx/iRIgD3G7C
         riItp/B78wAgfXWLiXlD9Pp9taTU4yAysRrOF1Pe9kiNYOfrtdB1Tsd9lMCU0s9DQr0b
         jncNUg6ABM456bZdawfabspyEfeRjVTyOk4KNYqQcY/DeMA+Hi0WXabmuSiADXl69bnT
         hLMEtTb312UJJWoOoT7EQYlEaAUnfzgbdIzEVauzvjtd9OpeGT8+3BggygIo/UucvPDU
         8T98wlF+kt/RBtjohqlO6LnHQ/eHiQo7x9dPiQDEsu2rj6lckHlTJQvtDxW5tIAF2FlN
         OCaw==
X-Gm-Message-State: AJIora/lnz2WgSAIqruFrckeHvDrETFSEyqlvwqbQklIRtf1GOsMYUbI
        KP4pytNdsAVS6YdL2GcNALV3CQ==
X-Google-Smtp-Source: AGRyM1sfqlcGekXlCPdHZ5+96hLd7k3jpzjFHgymZWad0IcOB6L5vuOsGawv+8fZnVsOqoIRkpWdRg==
X-Received: by 2002:a05:6512:3c3:b0:47d:ab07:50e7 with SMTP id w3-20020a05651203c300b0047dab0750e7mr23215123lfp.261.1657095572340;
        Wed, 06 Jul 2022 01:19:32 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id a1-20020a056512200100b004846548df9bsm610460lfb.267.2022.07.06.01.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 01:19:31 -0700 (PDT)
Message-ID: <189a226c-1664-9a07-cd0d-6ab8242d5443@linaro.org>
Date:   Wed, 6 Jul 2022 10:19:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 2/5] dt-bindings: display: bridge: cdns,dsi: Add
 compatible for dsi on j721e
Content-Language: en-US
To:     Rahul T R <r-ravikumar@ti.com>, dri-devel@lists.freedesktop.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     andrzej.hajda@intel.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, jonas@kwiboo.se, jernej.skrabec@gmail.com,
        airlied@linux.ie, daniel@ffwll.ch, p.zabel@pengutronix.de,
        tomi.valkeinen@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org, jpawar@cadence.com,
        sjakhade@cadence.com, mparab@cadence.com, a-bhatia1@ti.com,
        devicetree@vger.kernel.org, vigneshr@ti.com, lee.jones@linaro.org
References: <20220705121116.24121-1-r-ravikumar@ti.com>
 <20220705121116.24121-3-r-ravikumar@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220705121116.24121-3-r-ravikumar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2022 14:11, Rahul T R wrote:
> Add compatible to support dsi bridge on j721e
> 
> Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> ---
>  .../bindings/display/bridge/cdns,dsi.yaml     | 24 +++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,dsi.yaml b/Documentation/devicetree/bindings/display/bridge/cdns,dsi.yaml
> index ccedc73d8c18..33a88b39cf09 100644
> --- a/Documentation/devicetree/bindings/display/bridge/cdns,dsi.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/cdns,dsi.yaml
> @@ -14,13 +14,17 @@ description: |
>  
>  properties:
>    compatible:
> -    items:
> -      - const: cdns,dsi
> +    enum:
> +      - cdns,dsi
> +      - ti,j721e-dsi
>  
>    reg:
> +    minItems: 1
>      items:
>        - description:
>            Register block for controller's registers.
> +      - description:
> +          Register block for wrapper settings registers in case of TI J7 SoCs.
>  
>    clocks:
>      items:
> @@ -74,6 +78,22 @@ properties:
>  allOf:
>    - $ref: ../dsi-controller.yaml#
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: ti,j721e-dsi
> +    then:
> +      properties:
> +        reg:
> +          minItems: 2
> +          maxItems: 2
> +    else:
> +      properties:
> +        reg:
> +          minItems: 1

minItems are not needed here.

> +          maxItems: 1
> +
>  required:
>    - compatible
>    - reg


Best regards,
Krzysztof
