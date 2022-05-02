Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4438F516A11
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 06:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357654AbiEBEjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 00:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383272AbiEBEjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 00:39:14 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606363968B;
        Sun,  1 May 2022 21:35:47 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-e93bbb54f9so13327312fac.12;
        Sun, 01 May 2022 21:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4aRqwIkwDJYc7xJMvlCzQxcYevfXwiP5U9KIPUt6OwE=;
        b=iOtzSMMqVcjFOTZs/2KlB1JAmySoO9YPem/Noe+N6elbHp6bD35FJlJkdMN1hf1U7y
         ahBtYqfiRT8sY52wFwsd7njB325XjB7G55uRb3hS/GTdn3XWoInzUX0ME7hiH+BxitwO
         tWUolpgilt+hvs92F3OHWeyMah3RwRXu+XR6qbWq4sJcj2TJMQ60FAKgohIogY5FlIQZ
         8tzH36eC1YIU0VNrMOl/FJKbyQk2DfdhYyO8jgsC6khu6FqYBcsyQ6fNNb2SajXsOknq
         xDeOqMtEAwJDPGe5ZSIcQtfX/Zgg7BEbUytNpfZ449/R0NKHz/KI+Z86ZQw/lPaLmhXX
         GqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=4aRqwIkwDJYc7xJMvlCzQxcYevfXwiP5U9KIPUt6OwE=;
        b=5h6GakKtM8Q/3Oxl/SmrTS5aB54X8vd27iQ2MFvNRYalRWBvSOHr0eiQ3O2gw4LRXq
         4QphWucAedClW1nAV1JfyIIqD39s4EjlARoxFikfbThoWGGJ4BR2dNcvxVkj7/2IsxsD
         asAdpFCB7/MHFSANjjTwiOuZJoVrqIEO9YTKkQ64EZYrVEOS9KYekJuG3pzv8PzL7TZ7
         QtOjfkIgeCKpFPABizihj8kg6Mjw4oFx38t+pMhwJCA40vjhcsGwgZBvI/eT8MMfgiyg
         3GHy8cZu50fOT+exo2REz5nIKdtoxNVIZZrKXSWW/L59tSMbnmcKwb7Cta9nDVbu1hA1
         25yQ==
X-Gm-Message-State: AOAM532s8VGJDf4nJNm6DtY2ubzqgCfpUv2ESKQXoyWtqkGW8tZ3SHeE
        GGc7F0X6KgZd0GkRhNYIW5j2dVKN9xRDig==
X-Google-Smtp-Source: ABdhPJwHdlhZbZWiz0Oe+VyG8mZzq3VNEvr28Vhr80gXNc6dOmRj026zvdAgoGHKDFfOuutsoeX6cw==
X-Received: by 2002:a05:6870:79e:b0:e1:f5bb:4627 with SMTP id en30-20020a056870079e00b000e1f5bb4627mr5537751oab.74.1651466146780;
        Sun, 01 May 2022 21:35:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i23-20020a4addd7000000b0035eb4e5a6d6sm3509916oov.44.2022.05.01.21.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 21:35:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 1 May 2022 21:35:44 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: hwmon: Document adt7475 pin-function
 properties
Message-ID: <20220502043544.GA1719126@roeck-us.net>
References: <20220323034056.260455-1-chris.packham@alliedtelesis.co.nz>
 <20220323034056.260455-2-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323034056.260455-2-chris.packham@alliedtelesis.co.nz>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 04:40:54PM +1300, Chris Packham wrote:
> The adt7473, adt7475, adt7476 and adt7490 have pins that can be used for
> different functions. Add bindings so that it is possible to describe
> what pin functions are intended by the hardware design.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied to hwmon-next.

Thanks,
Guenter

> ---
> 
> Notes:
>     Changes in v3:
>     - None
>     Changes in v2:
>     - Add review from Krzysztof
> 
>  .../devicetree/bindings/hwmon/adt7475.yaml    | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/adt7475.yaml b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
> index 7d9c083632b9..22beb37f1bf1 100644
> --- a/Documentation/devicetree/bindings/hwmon/adt7475.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
> @@ -61,6 +61,26 @@ patternProperties:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      enum: [0, 1]
>  
> +  "adi,pin(5|10)-function":
> +    description: |
> +      Configures the function for pin 5 on the adi,adt7473 and adi,adt7475. Or
> +      pin 10 on the adi,adt7476 and adi,adt7490.
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum:
> +      - pwm2
> +      - smbalert#
> +
> +  "adi,pin(9|14)-function":
> +    description: |
> +      Configures the function for pin 9 on the adi,adt7473 and adi,adt7475. Or
> +      pin 14 on the adi,adt7476 and adi,adt7490
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum:
> +      - tach4
> +      - therm#
> +      - smbalert#
> +      - gpio
> +
>  required:
>    - compatible
>    - reg
> @@ -79,6 +99,8 @@ examples:
>          adi,bypass-attenuator-in0 = <1>;
>          adi,bypass-attenuator-in1 = <0>;
>          adi,pwm-active-state = <1 0 1>;
> +        adi,pin10-function = "smbalert#";
> +        adi,pin14-function = "tach4";
>        };
>      };
>  
