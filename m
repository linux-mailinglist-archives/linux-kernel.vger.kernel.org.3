Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC078598D8A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 22:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345555AbiHRUMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 16:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345490AbiHRUMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 16:12:15 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066DCD31F7;
        Thu, 18 Aug 2022 13:07:56 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id m2so2410289pls.4;
        Thu, 18 Aug 2022 13:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=SHmhnKOWEnMPXTr1npqUAIqccKa9qmawwg5jERMog4k=;
        b=dY+MC654YJKie0TQlbszc5HqEHdSZD4JcFCRHXXwd9QyR1bvRrP5uMIlIvrgCyhfTz
         6K87i7oljTIb7BSYyX55/9upwqGa2NvJgp5dZgL3hq0+0ls9tUk2CpyhD0WZ84RTsDBF
         ZHCyQPkDrRHCh73W0YFPt9HFQ+a4awysQS4M+NAKX76YJd2nRkDd+yqQg2cMF26PzOxP
         PJd8zi5wPjRdwlE3/fOnD4tIaZgZAtErOoqCINemD17Pniw2rB7xXrhuC3s0yBbd/APb
         nF+ks9TrtiyOM8QlKYvXH+TpYJ8thVd5fLohK6NIkN9omcUBapu1rDt7rCV9bQE9YTkY
         zO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=SHmhnKOWEnMPXTr1npqUAIqccKa9qmawwg5jERMog4k=;
        b=wE1aR1lW8xqeIszQGZ0nOwQvo7ifIXX1yNFUuJ7Vz+xxp8LZ1Q/0lMMXtLvXAY4aTt
         UflMJ2MCxYR8W28oEuDv6yeE7aYVvmjqm8lpAGU0F/sPIGljubWXYJWFoNhK8pS5y/tJ
         l/206O6U0PwA1miF71GIvGFmH6grdKFxkILJVSCqg4sNzJoggsbfXI7dfS35r6Sa7NBG
         5pfGZaP7Hx8BIYamTEn9uahDEm3VAqFVaLuDYGqB9m2AUj6MP0QW5ch9Xj8hcRbu2out
         YEzLiAgYQJJA/MLLqhx8rT8YuS3d8olkS7ztaDLNFS9jXCMte5TCl/CHTVkfTjcNcxVc
         kuIw==
X-Gm-Message-State: ACgBeo08ZrGly6qXGZP1PY6mFxPIUZIqVGMkC+s/DMHnv+4sbQ4c9ylp
        7gqkr/RNc64ZXRqYfByioKM=
X-Google-Smtp-Source: AA6agR6zivLRd+05MWUWn3NuX3B6pr3e+82o1RPZZGqNFpjIlLsoNlJXbfdh1CKOefzRR24+LpcYqg==
X-Received: by 2002:a17:903:41cd:b0:16e:e0c0:96d1 with SMTP id u13-20020a17090341cd00b0016ee0c096d1mr4221306ple.169.1660853275519;
        Thu, 18 Aug 2022 13:07:55 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c10-20020aa7952a000000b005281d926733sm2003202pfp.199.2022.08.18.13.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 13:07:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 18 Aug 2022 13:07:53 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eliav Farber <farbere@amazon.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, talel@amazon.com, hhhawa@amazon.com,
        jonnyc@amazon.com, hanochu@amazon.com, ronenk@amazon.com,
        itamark@amazon.com, shellykz@amazon.com, shorer@amazon.com,
        amitlavi@amazon.com, almogbs@amazon.com, dwmw@amazon.co.uk,
        rtanwar@maxlinear.com
Subject: Re: [PATCH v2 07/16] hwmon: (mr75203) add VM active channels
 property for Moortec PVT controller
Message-ID: <20220818200753.GA3288506@roeck-us.net>
References: <20220817054321.6519-1-farbere@amazon.com>
 <20220817054321.6519-8-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817054321.6519-8-farbere@amazon.com>
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

On Wed, Aug 17, 2022 at 05:43:12AM +0000, Eliav Farber wrote:
> Add optional "vm-active-channels" property to define the number of
> active channels per VM.
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---
>  .../devicetree/bindings/hwmon/moortec,mr75203.yaml       | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> index da9c3cdcb6f0..6111b5069b3c 100644
> --- a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> @@ -49,6 +49,13 @@ properties:
>        reset-control-skip bool property defines if obtaining a
>        reference to a reset controller should be skipped.
>  
> +  vm-active-channels:
> +    description:
> +      vm-active-channels defines the number of channels per VM
> +      that are actually used and are connected to some source.
> +      A value of 0 means that the entire VM sensor is nou used.

not ?

> +    $ref: /schemas/types.yaml#definitions/uint8-array
> +
>  required:
>    - compatible
>    - reg
> @@ -60,6 +67,7 @@ required:
>  additionalProperties:
>    - intel,vm-map
>    - reset-control-skip
> +  - vm-active-channels
>  
>  examples:
>    - |
> @@ -73,5 +81,6 @@ examples:
>          intel,vm-map = [03 01 04 ff ff];
>          clocks = <&osc0>;
>          resets = <&rcu0 0x40 7>;
> +        vm-active-channels = [08 10 02];

Is that how properties are defined nowadays ? I am left with
no clues how this is supposed to be interpreted by a driver.
What does "08 10 02" mean ? How does that refer to "the number of
active channels per VM" ?

Also, I am not a devicetree expert, but I am quite sure that all
those chip specific properties would need a vendor prefix.

Guenter

>          #thermal-sensor-cells = <1>;
>      };
