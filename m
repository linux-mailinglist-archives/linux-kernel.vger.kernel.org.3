Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A5C532DCF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 17:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239072AbiEXPrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 11:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239065AbiEXPrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 11:47:06 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AB46D957;
        Tue, 24 May 2022 08:47:05 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-f1eafa567cso19316622fac.8;
        Tue, 24 May 2022 08:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z//6WfrePUVSRJ8xvhdm8OGFD1fAIoJvz+KPrDeYZiU=;
        b=W2DLnVyq8ImLujMtgFA5MPrqxzCbBNAuNm6ITdBVS7TvCH4fYGISd6Di48Frv6JuWw
         Mh51NERR6odX9L8UJ0hY+Smrrx5FwbVK+5jMWP//QfwR8kVEysd5e58g/1kgD3ULSHIP
         AtILP2HIO1Auog469Bmrc3bL1omzVQ/kifpfnCfx/CfvdAQszprkEJpmrOqjGW8DRD7z
         93YjwEmmLtdZEThheWmlxq4c6XjJNQ2QWnE+rROzBJwzMua+usiOc2sE+XkEghbplnfF
         tvOFUTa4QhQZeQaEM1HpZkfHaS00cAWYW1yQiL+7MsC82dj98HqF1gtfqmwzD5nF/5nQ
         W8gA==
X-Gm-Message-State: AOAM5313FyOgBQ0DClTfBmBSjS81DzkcRiUnIdNNrqxhbTwnMA60rG9N
        F7e5FsepZI9ajpne97vesJE1ccS6ZA==
X-Google-Smtp-Source: ABdhPJxGHjUK+uccKHWZgjUZy9Ltn4kUmiM2LhZTy6e+gub3ldkNmSr6OrRkD5zYtjUTOhUHJkgJLA==
X-Received: by 2002:a05:6870:61ca:b0:f1:aaef:e2b9 with SMTP id b10-20020a05687061ca00b000f1aaefe2b9mr2834492oah.130.1653407224977;
        Tue, 24 May 2022 08:47:04 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j15-20020a9d7f0f000000b006060322124esm5100262otq.30.2022.05.24.08.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 08:47:04 -0700 (PDT)
Received: (nullmailer pid 3860327 invoked by uid 1000);
        Tue, 24 May 2022 15:47:03 -0000
Date:   Tue, 24 May 2022 10:47:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     jic23@kernel.org, lars@metafoo.de, Zhigang.Shi@liteon.com,
        krisman@collabora.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, alvaro.soliverez@collabora.com,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v4 1/3] dt-bindings: vendor-prefixes: Add 'ltr' as
 deprecated vendor prefix
Message-ID: <20220524154703.GD3730540-robh@kernel.org>
References: <20220511094024.175994-1-shreeya.patel@collabora.com>
 <20220511094024.175994-2-shreeya.patel@collabora.com>
 <20220516170058.GA2825626-robh@kernel.org>
 <83907dd2-2a53-2448-576b-ae26462d432a@collabora.com>
 <20220518163255.GE3302100-robh@kernel.org>
 <f37bccaf-233c-a244-3d81-849a988b1a92@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f37bccaf-233c-a244-3d81-849a988b1a92@collabora.com>
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

On Mon, May 23, 2022 at 08:27:56PM +0530, Shreeya Patel wrote:
> 
> On 18/05/22 22:02, Rob Herring wrote:
> > On Tue, May 17, 2022 at 04:07:33PM +0530, Shreeya Patel wrote:
> > > On 16/05/22 22:30, Rob Herring wrote:
> > > > On Wed, May 11, 2022 at 03:10:22PM +0530, Shreeya Patel wrote:
> > > > > 'liteon' is the correct vendor prefix for devices released by
> > > > > LITE-ON Technology Corp. But one of the released device which uses
> > > > > ltr216a light sensor exposes the vendor prefix name as 'ltr' through
> > > > > ACPI.
> > > > ACPI? NAK.
> > > > 
> > > > There are no cases of 'ltr' for DT, so fix ACPI.
> > > Hi Rob,
> > > 
> > > Yes, we understand there are no cases of 'ltr', but we have released devices
> > > which uses this string for probing the ltrf216a light sensor driver ( x86
> > > with DT )
> > That's not what your commit message says.
> > 
> > Even if this is DT based, given an undocumented vendor string is used,
> > it seems doubtful the rest of the binding would match upstream. What
> > about the rest of the DTB? Got a pointer to it or want to publish it?
> > 
> > > If we don't document this in vendor-prefixes.yaml, then the following
> > > warning
> > > is generated.
> > > 
> > > WARNING: DT compatible string vendor "ltr" appears un-documented -- check
> > > ./Documentation/devicetree/bindings/vendor-prefixes.yaml 364: FILE:
> > > drivers/iio/light/ltrf216a.c:313: + { .compatible = "ltr,ltrf216a" },
> > > 
> > > 
> > > Can you suggest us what would be the right way to fix this warning if not
> > > documenting
> > > in vendor-prefixes.yaml?
> > Fix the DT. We don't accept bindings simply because they are already
> > used in the field. If this was the only issue, it would be fine, but I
> > suspect it's the tip of the iceberg.
> 
> 
> Hi Rob,
> 
> To make things more clear, following is the modalias info of the device.
> 
> (B+)(root@linux iio:device0)# cat
> /sys/bus/i2c/devices/i2c-PRP0001\:01/modalias
> of:NltrfTCltr,ltrf216a
> 
> It's a dt namespace on an ACPI based device. We used an of_device_id table
> to be able to probe the driver
> using the vendor prefix and compatible string.

Again, it's ACPI so I don't care. If someone cares about using DT 
bindings in ACPI they can step up and help maintain them. It's not a DT 
vs. ACPI thing, but just that I can only maintain so much and have to 
draw the line somewhere.

> But when we compile the driver, we get the following warning and hence we
> documented it in vendor-prefixes.yaml
> and also added a complete device tree file [Patch 3/3] just to get rid of
> the warning. In real life we are not using
> the device tree file at all.
> 
> WARNING: DT compatible string vendor "ltr" appears un-documented -- check
> ./Documentation/devicetree/bindings/vendor-prefixes.yaml 364: FILE:
> drivers/iio/light/ltrf216a.c:313: + { .compatible = "ltr,ltrf216a" },

So, is someone telling you to fix this?


> There are many existing devices used by people which has the vendor prefix
> name as 'ltr'
> and it won't be possible to change that hence we are trying to upstream it.

There are millions if not billions of DT based devices using 
undocumented bindings. If those used "ltr,ltrf216a", I wouldn't accept 
it either.

Rob
