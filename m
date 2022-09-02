Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E595AB915
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 21:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbiIBT7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 15:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbiIBT7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 15:59:39 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FAE25E86;
        Fri,  2 Sep 2022 12:59:37 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-11e7e0a63e2so7390114fac.4;
        Fri, 02 Sep 2022 12:59:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ZSEmsdnAFtwpYkxc3t+QPwYaZfaZrvyrotsB92ufTO8=;
        b=dc+3Xlrc4yX8A5D8/Cq6c99VN6irr9ywG8NKw85V1fiDlQU8K1/fUDkEajVUjpsiIK
         FPNWt0niXva5a+sXeqFX8B6jFucUeLVkHbPrEB/6220dUYMGP/t18da+L3uyilqfwnTH
         KzaLms78D2eDWr2O5j1yYJabrbx0NwRw/FP94P64bgcBxl+RRcgpG+v63A989VViI8a4
         7zOjZY+tSehyFYs83EoS+6DTSCWPo2EMIFwuFMW/EQOJ09YCv2rFdlWpATmQDoTXSg7h
         mbWM9XcjlKfzP1ih+Ql5EMH1wyvm6L2dp1tNtiI5yzzum3nxJsiC7IeNZTknbVyRK9Rj
         DIBw==
X-Gm-Message-State: ACgBeo2+XrtXUzGh38TAggLBAn+0+SeQiSrJyG4gvDCDo0iJ1v5smLAt
        wkl7pV98JukqK1o0FXEfUg==
X-Google-Smtp-Source: AA6agR43YPE8TVECqeQQqdUwOh3eaXK4PDTZ3FBl10Zjbsalg/baeh5PB0L4dhWZHlr7INACa7NLtw==
X-Received: by 2002:a05:6808:1381:b0:345:fdd:554e with SMTP id c1-20020a056808138100b003450fdd554emr2740963oiw.278.1662148777217;
        Fri, 02 Sep 2022 12:59:37 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b31-20020a4a98e2000000b0044df311eee1sm901525ooj.33.2022.09.02.12.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 12:59:36 -0700 (PDT)
Received: (nullmailer pid 318646 invoked by uid 1000);
        Fri, 02 Sep 2022 19:59:35 -0000
Date:   Fri, 2 Sep 2022 14:59:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Eliav Farber <farbere@amazon.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, p.zabel@pengutronix.de,
        rtanwar@maxlinear.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        talel@amazon.com, hhhawa@amazon.com, jonnyc@amazon.com,
        hanochu@amazon.com, ronenk@amazon.com, itamark@amazon.com,
        shellykz@amazon.com, shorer@amazon.com, amitlavi@amazon.com,
        almogbs@amazon.com, dkl@amazon.com, rahul.tanwar@linux.intel.com,
        andriy.shevchenko@intel.com
Subject: Re: [PATCH v3 14/19] dt-bindings: hwmon: (mr75203) add
 "moortec,ts-series" property
Message-ID: <20220902195935.GA316069-robh@kernel.org>
References: <20220830192212.28570-1-farbere@amazon.com>
 <20220830192212.28570-15-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830192212.28570-15-farbere@amazon.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 07:22:07PM +0000, Eliav Farber wrote:
> Add optional "moortec,ts-series" property to define the temperature
> equation and coefficients that shall be used to convert the digital
> output to value in milli-Celsius.
> Supported series: 5 (default) and 6.
> 
> Series 5:
>   T = G + H * (n / cal5 - 0.5) + J * F
> Where: G = 60, H = 200, cal5 = 4094, J = -0.1, F = frequency clock in MHz
> 
> Series 6:
>    T = G + H * (n / cal5 - 0.5)
> Where: G = 57.4, H = 249.4, cal5 = 4096
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---
> V3 -> V2:
> - New patch to introduce "moortec,ts-series" property.
> 
>  .../devicetree/bindings/hwmon/moortec,mr75203.yaml     | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> index 4c983d8f8fe7..ec2dbe7da9c2 100644
> --- a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> @@ -64,6 +64,16 @@ properties:
>      default: 1
>      $ref: /schemas/types.yaml#definitions/uint8-array
>  
> +  moortec,ts-series:
> +    description:
> +      moortec,ts-series defines the temperature equation and coefficients that
> +      shall be used to convert the digital output to value in milli-Celsius.
> +      Supported series are 5 and 6.

No need to state constraints in free-form text descriptions.

> +    minimum: 5
> +    maximum: 6
> +    default: 5
> +    $ref: /schemas/types.yaml#definitions/uint32
> +
>  required:
>    - compatible
>    - reg
> -- 
> 2.37.1
> 
> 
