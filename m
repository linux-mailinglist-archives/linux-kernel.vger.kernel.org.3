Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B0452C007
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 19:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240306AbiERQdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 12:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240247AbiERQdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 12:33:00 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC457187072;
        Wed, 18 May 2022 09:32:57 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-d39f741ba0so3349719fac.13;
        Wed, 18 May 2022 09:32:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EE6DC5ExVq8aMmee7fTZv4EanXPMS3zovzIBFDm5qOE=;
        b=N7GTzGPw6hAModwK3YyKoJwo10kmlTDi07W5URh9rP6VbCLr2w9t159w5gWdpEcrcV
         /Q9Z8jA3payvKJeX1c9SL6z1OkKt2U/ATGflj5R2HB/GXDP5jB5ecAoy4h5aQTzmXRr2
         ZI4U2OSq3wIPp4XuASAxsuTUw4BW9tFzXLktZ3xDitbQnX+rBIc1N8DVgxyLf5/bwep2
         vlU2Gzmq1HrVjwNXw6HyD28WT44HN67zgusL80glIaWl6slHI/ct6JYSpA+/0Kg8Qwje
         BGZEYUsM+AmanhP4qF9g0NQOAWbACXaFhZ2mZsr65PKmwDxT1vEqvkX95tCYRU1RzaFz
         J2sg==
X-Gm-Message-State: AOAM533rKx3pYTeZ8QzUph+AuFaOHUWwsHhZEQMgyTVyZfTg2VKqireR
        qNi5VliN2qAPTB3Qpo5CBA==
X-Google-Smtp-Source: ABdhPJwmr/kDN+wzoMMh+jlHqvdXGEwQrm1thk30Gnkj4oU7nJTEBk8hoN2a/t33ZJCojbIQw4SvNQ==
X-Received: by 2002:a05:6870:41cc:b0:f1:b014:1107 with SMTP id z12-20020a05687041cc00b000f1b0141107mr164731oac.185.1652891576647;
        Wed, 18 May 2022 09:32:56 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r3-20020a4a83c3000000b0035eb4e5a6c2sm1123684oog.24.2022.05.18.09.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 09:32:55 -0700 (PDT)
Received: (nullmailer pid 3454369 invoked by uid 1000);
        Wed, 18 May 2022 16:32:55 -0000
Date:   Wed, 18 May 2022 11:32:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     jic23@kernel.org, lars@metafoo.de, Zhigang.Shi@liteon.com,
        krisman@collabora.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, alvaro.soliverez@collabora.com,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v4 1/3] dt-bindings: vendor-prefixes: Add 'ltr' as
 deprecated vendor prefix
Message-ID: <20220518163255.GE3302100-robh@kernel.org>
References: <20220511094024.175994-1-shreeya.patel@collabora.com>
 <20220511094024.175994-2-shreeya.patel@collabora.com>
 <20220516170058.GA2825626-robh@kernel.org>
 <83907dd2-2a53-2448-576b-ae26462d432a@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83907dd2-2a53-2448-576b-ae26462d432a@collabora.com>
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

On Tue, May 17, 2022 at 04:07:33PM +0530, Shreeya Patel wrote:
> 
> On 16/05/22 22:30, Rob Herring wrote:
> > On Wed, May 11, 2022 at 03:10:22PM +0530, Shreeya Patel wrote:
> > > 'liteon' is the correct vendor prefix for devices released by
> > > LITE-ON Technology Corp. But one of the released device which uses
> > > ltr216a light sensor exposes the vendor prefix name as 'ltr' through
> > > ACPI.
> > ACPI? NAK.
> > 
> > There are no cases of 'ltr' for DT, so fix ACPI.
> 
> Hi Rob,
> 
> Yes, we understand there are no cases of 'ltr', but we have released devices
> which uses this string for probing the ltrf216a light sensor driver ( x86
> with DT )

That's not what your commit message says.

Even if this is DT based, given an undocumented vendor string is used, 
it seems doubtful the rest of the binding would match upstream. What 
about the rest of the DTB? Got a pointer to it or want to publish it?

> If we don't document this in vendor-prefixes.yaml, then the following
> warning
> is generated.
> 
> WARNING: DT compatible string vendor "ltr" appears un-documented -- check
> ./Documentation/devicetree/bindings/vendor-prefixes.yaml 364: FILE:
> drivers/iio/light/ltrf216a.c:313: + { .compatible = "ltr,ltrf216a" },
> 
> 
> Can you suggest us what would be the right way to fix this warning if not
> documenting
> in vendor-prefixes.yaml?

Fix the DT. We don't accept bindings simply because they are already 
used in the field. If this was the only issue, it would be fine, but I 
suspect it's the tip of the iceberg.

Rob
