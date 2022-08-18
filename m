Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA21D5986B9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 17:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344000AbiHRPDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 11:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343977AbiHRPC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 11:02:59 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C05BD150;
        Thu, 18 Aug 2022 08:02:58 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id m6so1818417oib.4;
        Thu, 18 Aug 2022 08:02:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=B62GhRCYmYm4tGuI+9C2eiglOE1l1a8L2QPXzK2w5Nw=;
        b=2wfRHHVitzjTUNt/N2y+1o3PMUH5J1gR9oU4kGTL0rySi4sgkBElGTM2ifLwvTpwws
         SbuLmfZRg6iots9B10P2iwcONNcVOt9IOUe94gQfvlXeqGYN+NPnh/eznlhFxwNhgR+w
         8xs9k6NZ6P5Eap7Q0XWSVq4DjuIUfK5E6QHuVolMf3bV5i7n6GiNFl3Zc2rJIwkuVTrI
         Ki0779/s+ffs4h0HOzKMn2eXPrAMNQGgnHJlF22WvnbtnLcPwbkUSROuvxnw/ZUrd+ym
         b/mlkxz5lZUVlf8vEl90TmLQjbh3eU3GhJhlZWNzO73tdP/cg3cspHqgzMnOSAKYOrKk
         ZBQQ==
X-Gm-Message-State: ACgBeo2fQiqAQIrGPNFGvEiZOoFJp8eRRgfCp8CBDZAEJWHzmC9GmOJz
        K7Bv0MUY+zGKmHDMUlE0nA==
X-Google-Smtp-Source: AA6agR6HFP+ZXP/mb8Q3+MT057n3XE+bd4IrDx7sI7vANctWkbK2e3v9x/frlWXd9yBixAifrh9MIg==
X-Received: by 2002:aca:f16:0:b0:344:9d67:f3ce with SMTP id 22-20020aca0f16000000b003449d67f3cemr3678095oip.110.1660834977478;
        Thu, 18 Aug 2022 08:02:57 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:5fe0:b4f5:6e22:4704:df60:73a3])
        by smtp.gmail.com with ESMTPSA id m11-20020a4add0b000000b0044afc1ba91asm197452oou.44.2022.08.18.08.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 08:02:56 -0700 (PDT)
Received: (nullmailer pid 1865107 invoked by uid 1000);
        Thu, 18 Aug 2022 15:02:54 -0000
Date:   Thu, 18 Aug 2022 09:02:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Eliav Farber <farbere@amazon.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, mark.rutland@arm.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, talel@amazon.com, hhhawa@amazon.com,
        jonnyc@amazon.com, hanochu@amazon.com, ronenk@amazon.com,
        itamark@amazon.com, shellykz@amazon.com, shorer@amazon.com,
        amitlavi@amazon.com, almogbs@amazon.com, dwmw@amazon.co.uk,
        rtanwar@maxlinear.com
Subject: Re: [PATCH 03/16] hwmon: (mr75203) update Moortec PVT controller
 intel,vm-map property
Message-ID: <20220818150254.GH1829017-robh@kernel.org>
References: <20220816082757.11990-1-farbere@amazon.com>
 <20220816082757.11990-4-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816082757.11990-4-farbere@amazon.com>
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

On Tue, Aug 16, 2022 at 08:27:44AM +0000, Eliav Farber wrote:
> The "intel,vm-map property" is optional and not required.

Please follow the subject format for the subsystem (bindings).

> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---
>  Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> index 6f3e3c01f717..f9e849cc73e0 100644
> --- a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> @@ -48,12 +48,12 @@ required:
>    - compatible
>    - reg
>    - reg-names
> -  - intel,vm-map
>    - clocks
>    - resets
>    - "#thermal-sensor-cells"
>  
> -additionalProperties: false
> +additionalProperties:
> +  - intel,vm-map

Please test your changes. Not valid json-schema.

>  
>  examples:
>    - |
> -- 
> 2.37.1
> 
