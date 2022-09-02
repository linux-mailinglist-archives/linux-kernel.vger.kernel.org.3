Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574A85AB8F9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 21:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbiIBTuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 15:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiIBTuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 15:50:17 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1332C6DAE7;
        Fri,  2 Sep 2022 12:50:16 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-11f0fa892aeso7288349fac.7;
        Fri, 02 Sep 2022 12:50:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=pO2ZRD3dlbIF9AwTohcNB2XnkjmllILUC+CS7CC8pzs=;
        b=wT9zcneX9IlTUgTv9VDU/ZQPVfoyav3Gu+vbVZ+MULhsbY2GNVqmZGYeVWCjFmVIkc
         tPXazRE3yd8nkuxHFEUjJ/BEtCSYqGIgnSHD3bAIWXgaciihFzKEvEST8Lmg3vqP8KQn
         RNAArGwo56aaRK8DCiJEgP+wbX4ffrlMI8RImWRBj9JE+W4pDFunJUhCPbuK3SMHpxpp
         hkGPzdaaPCOtlEsBZdnumJsqGcfV4mACIhOzd3R8TbulaPyXSU015pc5yGFerEYQcA2p
         gmMJyrpo82OHWr0qT62p6KsdyhONO8DmftnUqZIZGr7eUzt8KY0nGsfdbbx6nVRxy74y
         s/6Q==
X-Gm-Message-State: ACgBeo0isvcBrz+1T3w7gJZ5Mscos+AoF0gYbQhxXu08qCaeiWoXfhHu
        9WnBTGZsSf8K0WpE07eF1Q==
X-Google-Smtp-Source: AA6agR6rWwvKUnxOh7SLCT4kH9XI6QWmsO1ukR+PgCxTAwjaBD3HVm/aNiHnmn3/qJLAA77ltoZxGA==
X-Received: by 2002:a05:6808:643:b0:343:1207:b0b7 with SMTP id z3-20020a056808064300b003431207b0b7mr2632956oih.97.1662148215141;
        Fri, 02 Sep 2022 12:50:15 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d24-20020a056870961800b0011382da43aesm1739088oaq.16.2022.09.02.12.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 12:50:14 -0700 (PDT)
Received: (nullmailer pid 305293 invoked by uid 1000);
        Fri, 02 Sep 2022 19:50:13 -0000
Date:   Fri, 2 Sep 2022 14:50:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Eliav Farber <farbere@amazon.com>
Cc:     linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        almogbs@amazon.com, hanochu@amazon.com, dkl@amazon.com,
        shellykz@amazon.com, devicetree@vger.kernel.org, ronenk@amazon.com,
        itamark@amazon.com, jonnyc@amazon.com,
        rahul.tanwar@linux.intel.com, talel@amazon.com, jdelvare@suse.com,
        andriy.shevchenko@intel.com, linux-kernel@vger.kernel.org,
        shorer@amazon.com, hhhawa@amazon.com, amitlavi@amazon.com,
        robh+dt@kernel.org, rtanwar@maxlinear.com, p.zabel@pengutronix.de
Subject: Re: [PATCH v3 01/19] dt-bindings: hwmon: (mr75203) update
 "intel,vm-map" property to be optional
Message-ID: <20220902195013.GA305241-robh@kernel.org>
References: <20220830192212.28570-1-farbere@amazon.com>
 <20220830192212.28570-2-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830192212.28570-2-farbere@amazon.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Aug 2022 19:21:54 +0000, Eliav Farber wrote:
> Change "intel,vm-map" property to be optional instead of required.
> 
> The driver implementation indicates it is not mandatory to have
> "intel,vm-map" in the device tree:
>  - probe doesn't fail in case it is absent.
>  - explicit comment in code - "Incase intel,vm-map property is not
>    defined, we assume incremental channel numbers".
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---
> V3 -> V2:
> - Change this patch to be first in the series.
> - Add explanation why "intel,vm-map" is not required.
> 
>  Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
