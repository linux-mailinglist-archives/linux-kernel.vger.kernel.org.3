Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2609351429C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 08:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354765AbiD2Gtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 02:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347623AbiD2Gti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 02:49:38 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D5D4EF42
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 23:46:21 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id bv19so13614032ejb.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 23:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xrvbVTYSX718CzoTpb87YI9jX7d2f6okuPzmrfDd5oE=;
        b=xNVFNFY3Yyl8v2oJkDosbR3b1ZGnJSLguQsNF3lKuBhGL2kxMx7xSGtK7IRL49NmC1
         fy8DaSfoY9BdGhtGFNFovlrJyW3A8R9DoUtUb8Y7+VxHCvAlN0WIv9ebko+UKVB+T7YK
         2P3Bn2+9zX7wy832/UWEI+rG/3G+TaZAeaG2xjqYe+NHkz3AHCpMUkykrxExfupZaEH4
         ckyAWBfHZxpmgwIIttJxvE16ActebkFCSDYMKm0/ESuWI0Tl3ZmTxKioSv686do1zUU8
         zI0dcSl3OWlbmfRo9RnuL1Xi6RfC51JpYdjEv3XDOjmKKYb5oMSr5Z3eNLDrdMXObegy
         zVTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xrvbVTYSX718CzoTpb87YI9jX7d2f6okuPzmrfDd5oE=;
        b=tRK50lob6AvUz7lNU+/fEJJwWA81NU4qaBj14kIwbkhdbcImCaU4VgSLyy0aoVL7pC
         kFylJBEICmYJPq9p4is573e8E5IC2PsxpEEzMQ3R6D3lQxtydMWpZbx/DyTmteQQkmRZ
         sCFoKUU/DFxZZuKVmjdjz3n55RKL+1X8tYdH8QPD2/1zFbRYLrIymOIl51SjOSJ/cKLi
         +FDW/m79bYBSEjG0hCEeCC4dwFx6LM3/jNLg9WzBJoqzbJ5ovGyJseQ7QMyxbi8dWh1o
         Q44b8RSp97R1hiPruJpjKxp/q5y5+afxr1D79/D0U56SV13DU1NrDzx4k4vsykti+VdC
         mJpg==
X-Gm-Message-State: AOAM530bEqfFO0ELqTqvH07T4ynllz90enZT+hgn0IPvL29sOS+1NevB
        h29Fd38Zemf9ZpVR1FFhVDELrQ==
X-Google-Smtp-Source: ABdhPJyuO3oZ/QiDbGWXSb64bqbYgx5YfcpXNcJaXAf8/j0v4zYwZp7O7t6DpPDOfTAGtkYuWXD+RA==
X-Received: by 2002:a17:907:3f8f:b0:6f3:d4a0:e80c with SMTP id hr15-20020a1709073f8f00b006f3d4a0e80cmr8215819ejc.709.1651214779739;
        Thu, 28 Apr 2022 23:46:19 -0700 (PDT)
Received: from [192.168.0.168] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id og39-20020a1709071de700b006f3ef214e61sm345251ejc.199.2022.04.28.23.46.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 23:46:19 -0700 (PDT)
Message-ID: <b279040a-a782-a2ca-2acb-2d8f07709081@linaro.org>
Date:   Fri, 29 Apr 2022 08:46:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] dt-bindings: mtd: partitions: Add binding for
 Sercomm parser
Content-Language: en-US
To:     Mikhail Zhilkin <csharper2005@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     NOGUCHI Hiroshi <drvlabo@gmail.com>, Karim <Karimdplay@gmail.com>,
        M <x1@disroot.org>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220406195557.1956-1-csharper2005@gmail.com>
 <20220406195946.2019-1-csharper2005@gmail.com>
 <8d0d8b27-35ff-3693-cf80-897b80c26b4e@linaro.org>
 <57bebf2f-af4c-b2d9-10e5-19e5104946fb@gmail.com>
 <29cfa017-bbaf-3aba-fe1d-06771957dbaa@linaro.org>
 <1b391399-984b-7a63-3265-62ef09caec39@gmail.com>
 <bd533827-b575-caad-c230-af060851b231@gmail.com>
 <db70e53b-7484-43bf-e9c8-b6a2dce1fbb5@linaro.org>
 <25da3f43-c46e-8108-2da9-0e4f2b7cc1a4@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <25da3f43-c46e-8108-2da9-0e4f2b7cc1a4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/04/2022 17:24, Mikhail Zhilkin wrote:
> 
> Hi, Krzysztof,
> 
> On 4/10/2022 11:18 AM, Krzysztof Kozlowski wrote:
>> I am sorry, but you changed now a lot in the bindings and it looks
>> entirely different. Things previously being correct now are wrong, so
>> rather start from your old bindings...
> 
> 
> Looks like I'm a bit confused... I use dual "compatible" in my real dts
> and I realized that:
> 
> 1. Therefore I have to use  dual "compatible" in example too:
> 
> compatible = "sercomm,sc-partitions", "fixed-partitions";
> 
> 2. When I'm trying to reuse "fixed-partitions" compatible from
> fixed-partitions.yaml in my new .yaml I get "too long" errors.

Yes, the fixed-partitions.yaml would have to be changed to allow extension.

> 
> Real dts:
> 
> Link:
> https://github.com/openwrt/openwrt/blob/edcc1a9a734bb3fcdc9242025290d3f173e71b78/target/linux/ramips/dts/mt7621_beeline_smartbox-giga.dts#L79
> 
> So, I currently found another solution - to extend fixed-partitions.yaml
> with "sercomm,sc-partitions". Is It ok from your side? Can I use this
> code in v3?

Not really, I don't understand why do you need it and it does not
include our previous talks.

> 
> diff --git
> a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
> b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
> index ea4cace6a955..9eebe39a57fb 100644
> --- a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
> +++ b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
> @@ -19,7 +19,11 @@ maintainers:
>  
>  properties:
>    compatible:
> -    const: fixed-partitions
> +    oneOf:
> +      - const: fixed-partitions
> +      - items:
> +          - const: sercomm,sc-partitions
> +          - const: fixed-partitions
>  
>    "#address-cells": true
>  
> @@ -27,7 +31,18 @@ properties:
>  
>  patternProperties:
>    "@[0-9a-f]+$":
> -    $ref: "partition.yaml#"
> +    allOf:
> +      - $ref: "partition.yaml#"
> +      - if:
> +          properties:
> +            compatible:
> +              contains:
> +                const: sercomm,sc-partitions
> +        then:
> +          properties:
> +            scpart-id:

It still misses vendor prefix and we agreed you don't need it, didn't we?


Best regards,
Krzysztof
