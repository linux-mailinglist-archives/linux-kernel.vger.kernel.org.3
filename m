Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D93250D3A5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 18:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235915AbiDXQzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 12:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235903AbiDXQzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 12:55:12 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C683E27CF0;
        Sun, 24 Apr 2022 09:52:11 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id t6-20020a056830224600b00605491a5cd7so9209024otd.13;
        Sun, 24 Apr 2022 09:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=canT3iBohVeX3ot0SwCLfDu/Mkppe05iPAa6Ok7QecQ=;
        b=jDfLzp48SqjbPbmP9kwjtBVRWpVhWgZ4yuNOE8o/CLQYUPKqDq7KGsxduU2ey71xbV
         N3EW2ByxhSpM+rBDLcIl/S7hXe3WHJpdSxTyAAfyi/UYqu1lLX2IqKwRlPF9puw1GaZv
         5xLT2f21dwiSpPAQrKjADZGQDRkCfNSeaXkADfXO7tQ+QPvQ7yY6oSkcPsyMx0f8jDpx
         buC+1ScXoy/H2hEbYC5ULAYe1REkUecnDgOJPOibq6tbvMtObGiN1lSpBhhMiS/tIvDu
         xUGm8G3JyxGwkZkzn5D3u5JE+OWncIUtGbZZIdXx3f40pfHOS5sX63pltG/Z+JNsc2nX
         cnMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=canT3iBohVeX3ot0SwCLfDu/Mkppe05iPAa6Ok7QecQ=;
        b=n6pNPANYMtQOUF2aQfd1sHcYsElmWUSrMRfkWWCewyT0SLjdEMluuQO5TePNkKnb3+
         cxGGo8bY/zm8bQXFibe5HNyHqQ00LwtOPcQM84jXvMXtX0nl7XC0s9UOsLIIryMYCt1K
         RbyQ8wYh5oCQSfP4KNGdDHp/zxpOMVX8Hs8vwKE4ELdrBAfqjCDtI5pbcrLdM0gV07Mb
         jLDup068/++GjLSBFgpON/loeofqqyI1s1NSLEFyY4DA/5HlbO/4/yCLq7mNshlGjb8L
         dv3P84QRdrVfvPYU2KQJH25b17++lhLUwygnhDB85MBRV+iNiJcGAB2zmCyvhI/BeO3S
         wEZA==
X-Gm-Message-State: AOAM5325L1T38asBsx0fLT7QCUPFzswRiblXMSxCMDn75sO0zaJf+7pG
        VJ8PPnNHW6IQxYUGFAr5SIg=
X-Google-Smtp-Source: ABdhPJzURro/CFSKtusa6PPR2ehgq73GKzEvC8GAUpHgYgPio5WPveBqYlBshZkPwqPNbAQ+CNRJEw==
X-Received: by 2002:a05:6830:19a:b0:605:46ec:949b with SMTP id q26-20020a056830019a00b0060546ec949bmr5052276ota.56.1650819130821;
        Sun, 24 Apr 2022 09:52:10 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o19-20020a4a9593000000b0032176119e65sm3342905ooi.34.2022.04.24.09.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 09:52:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 24 Apr 2022 09:52:09 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: hwmon: Document adt7475 pin-function
 properties
Message-ID: <20220424165209.GA748231@roeck-us.net>
References: <20220323034056.260455-1-chris.packham@alliedtelesis.co.nz>
 <20220323034056.260455-2-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323034056.260455-2-chris.packham@alliedtelesis.co.nz>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
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

Still waiting for DT maintainer approval.

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
