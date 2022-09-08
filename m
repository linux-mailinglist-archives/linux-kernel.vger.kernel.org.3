Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56C25B2665
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 21:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbiIHTCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 15:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbiIHTCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 15:02:19 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA8DB5A74;
        Thu,  8 Sep 2022 12:02:18 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id s14so9230556plr.4;
        Thu, 08 Sep 2022 12:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=sU7cMJ7dEW4p6eZ8nVaOtEoExjoSERC3QqL4dAdAAlk=;
        b=iSrtO1xBiWufKQIntzb2eZ6Dm/DVOzqMcpIj4uqYV2lNujobsxQqgX38s26UvsZpbk
         eg/y8a/z90g7jPLxAB2e0/c+Y4VkuTvswuOXrVHTHdyNx1G/UTOydXp7hFPyF68brDhh
         9NzMpJ8m3Ll7WZAajtTrLrSR8uapeDNHCgm8ar1b+SAiktkSBFU3LlGUwf/5rhAS/BSV
         B4HfFxr6ar1m6uiRqQC0zzhbJbB/msDhJnmSjkwnHiyeT/hY7WjzXUSmKuIJDNT6fabS
         Lyu6PtlLuBPYrw22n19VDH++0yLli0Vmyl5+KTnYLNDLKYXGuM9wfyPnpAv8IW5osAdA
         7CEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=sU7cMJ7dEW4p6eZ8nVaOtEoExjoSERC3QqL4dAdAAlk=;
        b=CVU1/RO7dN5N7U6CkB4fpHUuRJtRTKR7b5NX1h5W1pnvBuhiJH6ZiDeuo7Tz68qTmV
         O5UUIVYo/qa0Ck+WpZzCHZZEsP04lGBbWluHZ8NWdoZSek9N4uanXufwS+4m3ueo+Wlt
         gPUqpUU7Cj86+25EK4ealW/n8xKmNFnT6+W/I2XO/lngkFa0PrUUid7InoyspypCFFtn
         oP3rgXdZsvXr5yF36spBCx4GDpJ8ZTXOQcm1XNfQIvCrx6/cX3J1OS5E/igWOuRPIYje
         jektdUtgIg1cYiNB0MJm3LFI6ip/lrS4OT6zajkAO7SObJAbshvaMdf8Ro+GJWCsFUQ3
         64iQ==
X-Gm-Message-State: ACgBeo069Rxss+wLngdaweX1xWwSuz5S7mf7RApOBrdcMvZDDeYxDMXB
        skghvzQUHymRU7/2XAJYM3g=
X-Google-Smtp-Source: AA6agR5P4r3nHdXZ2frRrZxca4kyCCrPxwIqVS/B83xGC3lSxlzhrkWRthr/Ho/p6yjTN84bTSOieg==
X-Received: by 2002:a17:903:291:b0:172:f018:cdce with SMTP id j17-20020a170903029100b00172f018cdcemr10065826plr.91.1662663738084;
        Thu, 08 Sep 2022 12:02:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u23-20020a1709026e1700b00177ee563b6dsm2513514plk.33.2022.09.08.12.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 12:02:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 8 Sep 2022 12:02:16 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eliav Farber <farbere@amazon.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, p.zabel@pengutronix.de,
        rtanwar@maxlinear.com, andriy.shevchenko@intel.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hhhawa@amazon.com, jonnyc@amazon.com
Subject: Re: [PATCH v5 16/21] dt-bindings: hwmon: (mr75203) add
 "moortec,ts-series" property
Message-ID: <20220908190216.GA3423559@roeck-us.net>
References: <20220908152449.35457-1-farbere@amazon.com>
 <20220908152449.35457-17-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908152449.35457-17-farbere@amazon.com>
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

On Thu, Sep 08, 2022 at 03:24:44PM +0000, Eliav Farber wrote:
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
> V4 -> V3:
> - Remove constraints in free-form text descriptions.
> 
> V3 -> V2:
> - New patch to introduce "moortec,ts-series" property.
> 
>  .../devicetree/bindings/hwmon/moortec,mr75203.yaml       | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> index d6b03a6d7043..df849517464e 100644
> --- a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> @@ -91,6 +91,15 @@ properties:
>        Each channel should not appear more than once.
>      $ref: /schemas/types.yaml#/definitions/uint8-array
>  
> +  moortec,ts-series:
> +    description:
> +      Definition of the temperature equation and coefficients that shall be
> +      used to convert the digital output to value in milli-Celsius.
> +    minimum: 5
> +    maximum: 6
> +    default: 5
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +

I am not a dt expert, but I wonder if this should be handled
with different "compatible" properties. Sorry if this was already
addressed and I missed it.

Thanks,
Guenter
