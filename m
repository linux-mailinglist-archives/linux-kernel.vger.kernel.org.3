Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C735E5A9B75
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 17:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbiIAPVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 11:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbiIAPVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 11:21:38 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609EB62A8A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 08:21:36 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id br21so19148693lfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 08:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=ufzezn2FS2/AnewWg9FUJ5Ryg8+cSOWbtjRpSOhaf5g=;
        b=s/wlxrWDeyaHEMxeJ2xCWJeBhtex8WtxZTV6TMp6zyCWC5aK0I3ZDothFncgFcEaBF
         npYgCx9MlVGoKhvrEgslds/F/qtcQ3PuWoSfs4M2N6RcznYwdt/X8QJVddbCYumLqJsp
         MzqJPNGTgnc5oZjOg6B0EpC5xo3d4rBRKpnZFZFhNRTjgwo/Rc5E/N7PV60TuWhvUmX1
         kxMqKibUgJPO8cHA93b8X23g/mLJ+fI12exrehrX631jobVcgLhXb7GLTU1VnnssH9lD
         AA3glhPxiABBPYjy8hntsz6WZhkblwGD9FQe6BwJWdmoCeEA5Sfv02f/xfpzCp+MbMOs
         msoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ufzezn2FS2/AnewWg9FUJ5Ryg8+cSOWbtjRpSOhaf5g=;
        b=zZbo1XRElzZK7HU1jkYze/XPtZkiF1nvjidGPSabmo+R4EKi2oXprqK4x+uCNuJSds
         5IkQguOOxxdpWltvL+7M4/GBlmdxTt1b5NK6M1pjwE8HlJYzAxX4NfO48/ZnE8R2NuMT
         uexKk8ppLnQ5IUjjV1s01gmbuS7YfEPwSq0eCWLDKvzGcCrWyVizcF21XHwy0t5Nwzxf
         XDm8Yt+SUIqqNjpkX1b15EpielKVMvTAiqNvLDTR8CplxfX7VaYqkAqo/sZXCMVwVgqt
         HVMf27fRVxGmFNsKZKDZviFYbAEwaM1jndEBkplfLDR7I/NC256bi1ORGUs0t//9+VCo
         UI/w==
X-Gm-Message-State: ACgBeo1gyGMkLWrxS8K54Ll3k7EeIcgz8AivR/ymQ40C9rQXK6AqpWc5
        zrnHFcxen47LyWu6qiinV/FL8Q==
X-Google-Smtp-Source: AA6agR48dxWMskFdDWOlPNEkMp4j8Y0fJXT9BaTWhHIlGEOetE8aJiu5Jbr5fiiB3zchqSmkQEF+Nw==
X-Received: by 2002:a05:6512:146:b0:494:6704:885a with SMTP id m6-20020a056512014600b004946704885amr6551636lfo.447.1662045694718;
        Thu, 01 Sep 2022 08:21:34 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id x5-20020ac259c5000000b0048af3154456sm1305906lfn.146.2022.09.01.08.21.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 08:21:34 -0700 (PDT)
Message-ID: <4b681c03-7f5a-0234-2276-316e0bad1de5@linaro.org>
Date:   Thu, 1 Sep 2022 18:21:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v4 1/2] dt-bindings: phy: ti: phy-gmii-sel: Add bindings
 for J7200
Content-Language: en-US
To:     Siddharth Vadapalli <s-vadapalli@ti.com>, robh+dt@kernel.org,
        lee.jones@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        kishon@ti.com, vkoul@kernel.org, dan.carpenter@oracle.com,
        grygorii.strashko@ti.com, rogerq@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
References: <20220901085506.138633-1-s-vadapalli@ti.com>
 <20220901085506.138633-2-s-vadapalli@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220901085506.138633-2-s-vadapalli@ti.com>
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

On 01/09/2022 11:55, Siddharth Vadapalli wrote:
> TI's J7200 SoC supports additional PHY modes like QSGMII and SGMII
> that are not supported on earlier SoCs. Add a compatible for it.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>  .../mfd/ti,j721e-system-controller.yaml       |  6 ++++
>  .../bindings/phy/ti,phy-gmii-sel.yaml         | 30 ++++++++++++++++++-
>  2 files changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
> index 1aeac43cad92..802374e7645f 100644
> --- a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
> +++ b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
> @@ -54,6 +54,12 @@ patternProperties:
>      description:
>        Clock provider for TI EHRPWM nodes.
>  
> +  "phy@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/phy/phy-provider.yaml

You need instead ref to specific device bindings/schema. Probably to
/schemas/phy/ti,phy-gmii-sel.yaml#

This was entirely different in v3, so your change is very confusing.

> +    description:
> +      This is the register to set phy mode through phy-gmii-sel driver.

I don't understand the description. Please focus on the hardware not
some drivers - what is here? Phy for something?

> +
>  required:
>    - compatible
>    - reg
> diff --git a/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml b/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
> index ff8a6d9eb153..0ffb97f1a77c 100644
> --- a/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
> +++ b/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
> @@ -53,12 +53,24 @@ properties:
>        - ti,am43xx-phy-gmii-sel
>        - ti,dm814-phy-gmii-sel
>        - ti,am654-phy-gmii-sel
> +      - ti,j7200-cpsw5g-phy-gmii-sel
>  
>    reg:
>      maxItems: 1
>  
>    '#phy-cells': true
>  
> +  ti,qsgmii-main-ports:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: |
> +      Required only for QSGMII mode. Array to select the port for
> +      QSGMII main mode. Rest of the ports are selected as QSGMII_SUB
> +      ports automatically. Any one of the 4 CPSW5G ports can act as the
> +      main port with the rest of them being the QSGMII_SUB ports.
> +    items:
> +      minimum: 1
> +      maximum: 4
> +
>  allOf:
>    - if:
>        properties:
> @@ -73,6 +85,22 @@ allOf:
>          '#phy-cells':
>            const: 1
>            description: CPSW port number (starting from 1)

Blank line


> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - ti,j7200-cpsw5g-phy-gmii-sel
> +    then:
> +      properties:
> +        '#phy-cells':
> +          const: 1
> +          description: CPSW port number (starting from 1)
> +        ti,qsgmii-main-ports:
> +          maxItems: 1

It does not really make sense to limit items here, in the context of
this patch. You got a comment for it already. Your patch should make
sense on its own.

> +    else:
> +      properties:
> +        ti,qsgmii-main-ports: false

Blank line

>    - if:
>        properties:
>          compatible:
> @@ -97,7 +125,7 @@ additionalProperties: false
>  
>  examples:
>    - |
> -    phy_gmii_sel: phy-gmii-sel@650 {
> +    phy_gmii_sel: phy@650 {

Split cleanup into separate patch.

>          compatible = "ti,am3352-phy-gmii-sel";
>          reg = <0x650 0x4>;
>          #phy-cells = <2>;


Best regards,
Krzysztof
