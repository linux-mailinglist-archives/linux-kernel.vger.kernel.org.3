Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40DC75AB908
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 21:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbiIBT5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 15:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiIBT5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 15:57:40 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD9CD346B;
        Fri,  2 Sep 2022 12:57:39 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-12243fcaa67so7307047fac.8;
        Fri, 02 Sep 2022 12:57:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=6lgPBkWCVtHB/nw/Rli0i6tqziEvTio+eJ1CLyqJH70=;
        b=D1k2qeGWUFlLTUmGRf4DmP42dhNIHk9psDBn8DQ+FTMGW0nHFIy8ReBCgMokvTKf3L
         hVV9iOzEILbi0ATeJ9trodtn76XuUp9Bnj3TjRNZKVfRvlgT5j+w8NrpLpSKPun/PGhQ
         0LXZvkSi6nFSuUte7uFyyrBxKlqxW9jKDopM2uDA/HHLkltn8JMsMSCPxPjvqqo5vubD
         7IbYonUafTD5P/UxCelYrmYTqbq4Gag3A6/4UXqH6YgOno9vd24DqP3vOsmWcfse3RwW
         ReDTSRyCP3VMvq4D3k2bgenI4RS2UZL1h/MieTVUlYrYmsJ1abI031SlhK8ZyW3xZu7o
         6vLg==
X-Gm-Message-State: ACgBeo0Wlly2t1GKmfZoCgFmrGZDsdn41bMEvrUELMmbcSv+UFCNc8cA
        P3K6hYYVe043pg16dojWDQ==
X-Google-Smtp-Source: AA6agR5met1SMUF1qsJ76dJU52AGcgRifL31LB03aIjN1U6GtnZh9mLsuvophhLuReeHkK/rHN+2+w==
X-Received: by 2002:a05:6808:1242:b0:345:7e6b:961b with SMTP id o2-20020a056808124200b003457e6b961bmr2594131oiv.290.1662148659156;
        Fri, 02 Sep 2022 12:57:39 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d8-20020a05680805c800b00344e3751fc4sm1304346oij.36.2022.09.02.12.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 12:57:38 -0700 (PDT)
Received: (nullmailer pid 315919 invoked by uid 1000);
        Fri, 02 Sep 2022 19:57:37 -0000
Date:   Fri, 2 Sep 2022 14:57:37 -0500
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
Subject: Re: [PATCH v3 10/19] dt-bindings: hwmon: (mr75203) add
 "moortec,vm-pre-scaler" property
Message-ID: <20220902195737.GA306891-robh@kernel.org>
References: <20220830192212.28570-1-farbere@amazon.com>
 <20220830192212.28570-11-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830192212.28570-11-farbere@amazon.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 07:22:03PM +0000, Eliav Farber wrote:
> Add support for mr76006 pre-scaler which provides divide-by-2 scaling of
> input voltage, which can then be presented for VM for measurement within
> its range (the VM input range is limited to -0.1V to 1V).
> 
> The new "moortec,vm-pre-scaler" property lists the channels that use a
> pre-scaler.
> 
> The driver will use this list to multiply the voltage result by 2, to
> present to the user the actual voltage input source.
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---
> V3 -> V2:
> - Add "moortec" prefix to property name.
> - Change property format to be a single u8 array.
> - Fix typo: scalar --> scaler.
> 
>  .../devicetree/bindings/hwmon/moortec,mr75203.yaml    | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> index 69cc6caceb2c..4c983d8f8fe7 100644
> --- a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> @@ -54,6 +54,16 @@ properties:
>      default: 16
>      $ref: /schemas/types.yaml#definitions/uint8-array
>  
> +  moortec,vm-pre-scaler:
> +    description:
> +      moortec,vm-pre-scaler property is an array of channels that use a mr76006
> +      pre-scaler to divides the input source by 2.

to divide the

You don't need the property name in the description. The entries are the 
pre-scaler values for each channel? The array index is the channel? If 
so, then 'an array of pre-scaler values for each channel ...'.

> +      The pre-scaler is used for input sources that exceed the VM input range.
> +      The driver uses this information to present to the user the actual value
> +      of the voltage source.
> +    default: 1

It's an array, so a scalar default doesn't make sense.

> +    $ref: /schemas/types.yaml#definitions/uint8-array

Constraints? I assume there's a finite number of channels to set the 
array size bounds for example.

> +
>  required:
>    - compatible
>    - reg
> @@ -76,5 +86,6 @@ examples:
>          clocks = <&osc0>;
>          resets = <&rcu0 0x40 7>;
>          moortec,vm-active-channels = <0x10 0x05>;
> +        moortec,vm-pre-scaler = <5 6>;
>          #thermal-sensor-cells = <1>;
>      };
> -- 
> 2.37.1
> 
> 
