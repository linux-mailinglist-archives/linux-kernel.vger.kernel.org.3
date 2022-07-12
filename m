Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D928E571516
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbiGLIvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiGLIvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:51:43 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D82A5E6E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:51:42 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id n18so11092682lfq.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vjHu968868HtBRMF6NYSXXaRFX5EKeerKBprL50iI0E=;
        b=B4Rg2xxpEzgxWoU2cgZY9zxkR+yH0vP0ittREWZnTv9ide6+6/h+OwcF7XZ/jPDUhD
         luRNBUbEgsoVHTsEnUfK0nTgOwSsJ2eeFrw29LtOkTucVWf9TGLAam31/lfBzW3VYH4L
         6HraAszhWXb6GKWkzgCvsisB0/qpjqzoTrmYCt5JqOI15cJUA+dj9pJaYYfGpbj+uUwR
         lZz1IGbe6in9spUndTj/WnYzqEPpLt++nNLVYLJWoHvd9ugRfNUtfbO2wcnx0Rbjfdn2
         5Jz8CVIa338s2zLcYWw9Fej9glRgLrn4qyjips9Nmo3WJB2YuyRfP+a5o9Xj1Af/0EKQ
         es1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vjHu968868HtBRMF6NYSXXaRFX5EKeerKBprL50iI0E=;
        b=nWQBDBJeIHtG4DJNJrI8w3ksAmZEW0uyYKP1bhQKR12hVbILHELzzJif+Z28/pXHXw
         RyWLE8zAylV1sCFT0DZkjEjUKgGnEDEgfyDvh9+u6LE9TbIW1cbVRbcKU9WhzG0bgx2A
         2QLgWfq89whAN5UF/mq/66/ZjkMXpoksxkRQxHIStGG2wVWZ79pRjeyfEyCvAFp4iogZ
         8RU2HTpmDbhNIQuzyg3n8nl/Afm93lBkvpXyDrXFAU+CKOvWwPL9hltcf2TwGMIcr01V
         8JHApEV8xmLpCmSWbcYQkjuuweHj8Zw0fuTVTH66uGfvgIFBcbOhOW/zE88irqi3k+ZZ
         WuDg==
X-Gm-Message-State: AJIora+5Nu4zEAfvKx8bATfnDfxb/ULJdMQKFYJ0bogQm3RPwD44OcNL
        V2NyZYtt4TaFIG/IK/As0uvchg==
X-Google-Smtp-Source: AGRyM1vsmzS4v4HFCqeaDGGnx1Zk47dL88gMC7MXgdrPxgTvK9Q4n1ARWFSGp3BEZ0ZjGbeNI7d8Bg==
X-Received: by 2002:a05:6512:3da8:b0:489:e6df:3dd0 with SMTP id k40-20020a0565123da800b00489e6df3dd0mr3719758lfv.224.1657615900524;
        Tue, 12 Jul 2022 01:51:40 -0700 (PDT)
Received: from [10.0.0.8] (fwa5cab-55.bb.online.no. [88.92.171.55])
        by smtp.gmail.com with ESMTPSA id o26-20020ac25e3a000000b004886508ca5csm2070843lfg.68.2022.07.12.01.51.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 01:51:39 -0700 (PDT)
Message-ID: <ecaf9d0f-6ddb-5842-790e-3d5ee80e2a77@linaro.org>
Date:   Tue, 12 Jul 2022 10:51:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH net-next 2/9] dt-bindings: net: Expand pcs-handle to
 an array
Content-Language: en-US
To:     Sean Anderson <sean.anderson@seco.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        "David S . Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
References: <20220711160519.741990-1-sean.anderson@seco.com>
 <20220711160519.741990-3-sean.anderson@seco.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220711160519.741990-3-sean.anderson@seco.com>
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

On 11/07/2022 18:05, Sean Anderson wrote:
> This allows multiple phandles to be specified for pcs-handle, such as
> when multiple PCSs are present for a single MAC. To differentiate
> between them, also add a pcs-names property.
> 
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> ---
> 
>  .../devicetree/bindings/net/ethernet-controller.yaml       | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> index 4f15463611f8..c033e536f869 100644
> --- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> +++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> @@ -107,11 +107,16 @@ properties:
>      $ref: "#/properties/phy-connection-type"
>  
>    pcs-handle:
> -    $ref: /schemas/types.yaml#/definitions/phandle
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>      description:
>        Specifies a reference to a node representing a PCS PHY device on a MDIO
>        bus to link with an external PHY (phy-handle) if exists.

You need to update all existing bindings and add maxItems:1.

>  
> +  pcs-names:

To be consistent with other properties this should be "pcs-handle-names"
and the other "pcs-handles"... and then actually drop the "handle".


> +    $ref: /schemas/types.yaml#/definitions/string-array
> +    description:
> +      The name of each PCS in pcs-handle.

You also need:
dependencies:
  pcs-names: [ pcs-handle ]

> +
>    phy-handle:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description:


Best regards,
Krzysztof
