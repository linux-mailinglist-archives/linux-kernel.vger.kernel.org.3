Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1345B2979
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 00:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiIHWkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 18:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiIHWka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 18:40:30 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA265D0224;
        Thu,  8 Sep 2022 15:40:27 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-127ba06d03fso24757351fac.3;
        Thu, 08 Sep 2022 15:40:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=UqRtNdBjaZuYngMpGzHkxPlD2Z2tvghx3hs0PUOk8Ro=;
        b=kM+G+O1EbRPy3eGlx6q6ci3mlaBm7FHInWrKpsO6GSUmZI4fmuasTliGuoyIA4rjv0
         7t8Mzn1fHmN00qvW29oGnvTijFq6OeMPjW1YAvda9cf/iGJOrRnvz/MHwyYnecOLd6sr
         ezeUtohld9xhIAvmeMDvhGZMLAFWiNxozGnRRzBOh88POhymyYUr6gNMLzTjC5dhA/BA
         PoyTTlfieoPXmel6/5gxbns0LYCDhLfi7xVMFexvYcHYd1sbPk8bwwAXv7ytHPYHMkdr
         /3jWT5NDoiVOG1AEt5Z6g65CGL2ih+D2P4jOhW/X/r5APITakqz6tCaAzy6OSSrf2raC
         uQ/A==
X-Gm-Message-State: ACgBeo1lAdZrfM+5n7hBagvzQFX0VY9OTIV7e9vbiJL8EXwk2N6oEmzW
        OIcfg5ZDuLzZZ+yHDyxC5w==
X-Google-Smtp-Source: AA6agR4kPuvSIo/PK+ej3hWozKVvbOSKuzx2XBHYHML7hitYH8ivSF0WAozOM4f3BvqePVMjOUQIOw==
X-Received: by 2002:a05:6808:21a6:b0:344:beb5:1fb1 with SMTP id be38-20020a05680821a600b00344beb51fb1mr2446228oib.175.1662676826989;
        Thu, 08 Sep 2022 15:40:26 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id cm16-20020a056870b61000b0011eeff77d1bsm258281oab.10.2022.09.08.15.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 15:40:26 -0700 (PDT)
Received: (nullmailer pid 3472851 invoked by uid 1000);
        Thu, 08 Sep 2022 22:40:25 -0000
Date:   Thu, 8 Sep 2022 17:40:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Eliav Farber <farbere@amazon.com>
Cc:     jdelvare@suse.com, rtanwar@maxlinear.com,
        devicetree@vger.kernel.org, jonnyc@amazon.com,
        andriy.shevchenko@intel.com, linux@roeck-us.net,
        linux-hwmon@vger.kernel.org, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org, hhhawa@amazon.com
Subject: Re: [PATCH v4 09/21] dt-bindings: hwmon: (mr75203) change "resets"
 property to be optional
Message-ID: <20220908224025.GA3472774-robh@kernel.org>
References: <20220906083356.21067-1-farbere@amazon.com>
 <20220906083356.21067-10-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906083356.21067-10-farbere@amazon.com>
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

On Tue, 06 Sep 2022 08:33:44 +0000, Eliav Farber wrote:
> Change "resets" property to be optional instead of required, for SOCs
> that don't support a reset controller.
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---
> V4 -> V3:
> - Fix "reset" to "resets".
> 
> V3 -> v2:
> - Change "reset" property to be optional instead of adding new
>   "reset-control-skip" property.
> 
>  Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
