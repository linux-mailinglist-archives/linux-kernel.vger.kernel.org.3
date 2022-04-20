Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DE8508CFC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359218AbiDTQS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348512AbiDTQS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:18:26 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A86E27CC8;
        Wed, 20 Apr 2022 09:15:38 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id r8so2585188oib.5;
        Wed, 20 Apr 2022 09:15:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mMtqLmkNBwbaTgADKyEBhTC53U6B2x21wOWtV99B4Jk=;
        b=rjFb/+DE8UBGOXzR3cI5xj+TRXSrHofAYMundlEN7VP8pZ6cTOog1Xw8TBjTqCHQnu
         VmDFzV3BuiDdWcK8qpvswkUcBhTT+32+7kiDsYV4ZkwniSkEI3AtgJHPgsN/jqK9F+ma
         iIB4mVWjLdufBvgYkdaQb+GPNRWoPKunFNOeFAxo2gpRZSLU/TJJ5wFNDu5Ulxh4nox8
         cyjXNpKAfi5UA3lflj7+R4gw6+pswgC3GBcAUrNgqHVjkeNUQiS5KV7VacorqspnsQCC
         tnmptEz3SoCYTf4NtQY4BGrKyoXyr6Mt6K+Rh4NFQc/F3+h1Dfb9cQJ05j0ELPRHE9tM
         yVmw==
X-Gm-Message-State: AOAM5330fXXLSr7gK68CDBKqtrrSe5COCbtOvj1q7HjHKUyzoWb1ba43
        AX7smyaI3p4pm0+kJc9TfQ==
X-Google-Smtp-Source: ABdhPJwUNQ7FBgit0u+Y1WJjPH+rXvzlqZYthoA9oJQSfjV65Mp88v/mECrK91YMRuCQXkqpzFo9lA==
X-Received: by 2002:a05:6808:3009:b0:2f9:6119:d676 with SMTP id ay9-20020a056808300900b002f96119d676mr2108712oib.205.1650471337926;
        Wed, 20 Apr 2022 09:15:37 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l14-20020a4ac60e000000b0032993003287sm6845329ooq.38.2022.04.20.09.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 09:15:37 -0700 (PDT)
Received: (nullmailer pid 1410409 invoked by uid 1000);
        Wed, 20 Apr 2022 16:15:36 -0000
Date:   Wed, 20 Apr 2022 11:15:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v5 1/5] dt-bindings: display: ssd1307fb: Deprecate "-i2c"
 compatible strings
Message-ID: <YmAxqNb7nKlypkqD@robh.at.kernel.org>
References: <20220419214824.335075-1-javierm@redhat.com>
 <20220419214824.335075-2-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419214824.335075-2-javierm@redhat.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Apr 2022 23:48:19 +0200, Javier Martinez Canillas wrote:
> The current compatible strings for SSD130x I2C controllers contain both an
> "fb" and "-i2c" suffixes. It seems to indicate that are for a fbdev driver
> and also that are for devices that can be accessed over an I2C bus.
> 
> But a DT is supposed to describe the hardware and not Linux implementation
> details. So let's deprecate those compatible strings and add new ones that
> only contain the vendor and device name, without any of these suffixes.
> 
> These will just describe the device and can be matched by both I2C and SPI
> DRM drivers. The required properties should still be enforced for old ones.
> 
> While being there, just drop the "sinowealth,sh1106-i2c" compatible string
> since that was never present in a released Linux version.
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Acked-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> 
> (no changes since v3)
> 
> Changes in v3:
> - Drop the "sinowealth,sh1106-i2c", wasn't in a released version (Chen-Yu Tsai)
> - Continue enforcing required properties for deprecated strings (Maxime Ripard)
> 
> Changes in v2:
> - Drop the -i2c suffixes from the compatible strings too (Geert Uytterhoeven)
> 
>  .../bindings/display/solomon,ssd1307fb.yaml   | 44 +++++++++++++------
>  1 file changed, 31 insertions(+), 13 deletions(-)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

