Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE785986D2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 17:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344039AbiHRPFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 11:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344028AbiHRPFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 11:05:15 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6A056BAA;
        Thu, 18 Aug 2022 08:05:14 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id h21so1304778qta.3;
        Thu, 18 Aug 2022 08:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=UuLLOoIfXDmSYWjZC290GUw+IzJXaVpWsPuShy/dmPI=;
        b=B5Ujm8eW2Q1/s7Z+vq8H1AizL2iy91WEZB4ME7JRAsBsBx9ZJRbcBpUYrgeam78M35
         6tQ5PGNoNlKPmqg8Wrpth9W3EAAYsx/j1XoFHV14pOSmuKyUAd5kKgOGYzAK+2RvA7Yb
         s6gZKTmaw5bvhYHDsG4Soqeha/hXEQvfGdukx6ebSuG6WRklRCHEPrhX9xgRCsfH8tb/
         tIc4N814gw4pir+dUW3xQSPaUWvHPI9SQWP9O60/lhnRDWv3F8hiUHQGKeD39U3gOE2s
         1cKTHxJDziOdZA70pCZeEPADm/covHtOJe7k8g6rNWXXjmnBh4DlFDjmrFZXqavlGRe1
         iReQ==
X-Gm-Message-State: ACgBeo0k4h6Jt++rSH53ILbdw9JU9KQrS/Cm67Eer30IqGRpLiBChieY
        kyKNJg1KAPEKcdmZZwd5WQ==
X-Google-Smtp-Source: AA6agR4JUcSJgb/u8fdF/2bXPaKAB3WimFqT3XSc0IWlU8K2rDZ891Q/oFgGD9Ass8SXa2uJp5YBDQ==
X-Received: by 2002:ac8:5d49:0:b0:344:9232:be56 with SMTP id g9-20020ac85d49000000b003449232be56mr2377878qtx.122.1660835113502;
        Thu, 18 Aug 2022 08:05:13 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:5fe0:b4f5:6e22:4704:df60:73a3])
        by smtp.gmail.com with ESMTPSA id o10-20020ac87c4a000000b0034305a91aaesm1220545qtv.83.2022.08.18.08.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 08:05:13 -0700 (PDT)
Received: (nullmailer pid 1868209 invoked by uid 1000);
        Thu, 18 Aug 2022 15:05:10 -0000
Date:   Thu, 18 Aug 2022 09:05:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Eliav Farber <farbere@amazon.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, mark.rutland@arm.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, talel@amazon.com, hhhawa@amazon.com,
        jonnyc@amazon.com, hanochu@amazon.com, ronenk@amazon.com,
        itamark@amazon.com, shellykz@amazon.com, shorer@amazon.com,
        amitlavi@amazon.com, almogbs@amazon.com, dwmw@amazon.co.uk,
        rtanwar@maxlinear.com
Subject: Re: [PATCH 13/16] hwmon: (mr75203) add thermal coefficient
 properties for Moortec PVT controller
Message-ID: <20220818150510.GI1829017-robh@kernel.org>
References: <20220816082757.11990-1-farbere@amazon.com>
 <20220816082757.11990-14-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816082757.11990-14-farbere@amazon.com>
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

On Tue, Aug 16, 2022 at 08:27:54AM +0000, Eliav Farber wrote:
> Add optional "ts-coeff-g", "ts-coeff-h", "ts-coeff-cal5" and
> "ts-coeff-j" properties to be used instead of defaults for the
> thermal equasion.
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---
>  .../bindings/hwmon/moortec,mr75203.yaml       | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> index e2a55001eefc..867664bd937f 100644
> --- a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> @@ -62,6 +62,30 @@ properties:
>        used to normalzie the voltage output results.
>      $ref: /schemas/types.yaml#definitions/uint32
>  
> +  ts-coeff-g:

Needs a vendor prefix

> +    description:
> +      G coefficient for thermal equation.
> +    maxItems: 1

It's a scalar. 'maxItems' is for arrays/matrices.

> +    $ref: /schemas/types.yaml#definitions/uint32
> +
> +  ts-coeff-h:
> +    description:
> +      H coefficient for thermal equation.
> +    maxItems: 1
> +    $ref: /schemas/types.yaml#definitions/uint32
> +
> +  ts-coeff-cal5:
> +    description:
> +      cal5 coefficient for thermal equation (can't be 0).

minimum: 1

Other constraints on all these?

> +    maxItems: 1
> +    $ref: /schemas/types.yaml#definitions/uint32
> +
> +  ts-coeff-j:
> +    description:
> +      J coefficient for thermal equation.
> +    maxItems: 1
> +    $ref: /schemas/types.yaml#definitions/int32
> +
>  required:
>    - compatible
>    - reg
> @@ -75,6 +99,10 @@ additionalProperties:
>    - reset-control-skip
>    - vm-active-channels
>    - vm-pre-scalar-ch#
> +  - ts-coeff-g
> +  - ts-coeff-h
> +  - ts-coeff-cal5
> +  - ts-coeff-j
>  
>  examples:
>    - |
> @@ -90,5 +118,10 @@ examples:
>          resets = <&rcu0 0x40 7>;
>          vm-active-channels = [08 10 02];
>          vm-pre-scalar-ch5 = <2>;
> +        ts-coeff-g = <57400>;
> +        ts-coeff-h = <249400>;
> +        ts-coeff-cal5 = <4096>;
> +        ts-coeff-j = <0>;
> +
>          #thermal-sensor-cells = <1>;
>      };
> -- 
> 2.37.1
> 
