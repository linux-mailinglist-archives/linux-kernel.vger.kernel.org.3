Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90804CDFE5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 22:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiCDVsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 16:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiCDVsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 16:48:08 -0500
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F0223BF08;
        Fri,  4 Mar 2022 13:47:19 -0800 (PST)
Received: by mail-oi1-f180.google.com with SMTP id x193so9236449oix.0;
        Fri, 04 Mar 2022 13:47:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v8uPxGmN/Yw0f1shToPT9W3nN9S4UgeJqSz8uMeBf4I=;
        b=psL7IHCn2OUdBRMZa4p6frq4OmL/tZ6iCjhoatUShHA1nMUMhjVITSrhL8xiaXRH2d
         O9SoJRN2Jo8dwtS0SBQtSK/UpDXfh249RyPxD158a1zp6xVR5LdWuZ1xH00mh39nrzOR
         EnX3qFsg5aM+vKh1Wi3Qsx6stKgXH4+nBocasZJ3VKtj724lHBk2CGg9QpTMmQMRy9qJ
         vs6Th18X3/dDiYFsSaprVlCTinGKdWeTSBiGHb4urLYFxWS1TZlh4dzOHUbwx9AdeTkX
         HZvmEOQJcpWEKXLwElygqRq01LCnvBZzZsXSR2T3tuop7XcvriyPQaQG0NORPhKlgclk
         chQA==
X-Gm-Message-State: AOAM531H0nS/ai2nBPvA5wMdW1hYSN4bc0rj2ywxvUnDX4BvZjp2r1RS
        lSToB4vhiNvUU85RMNB1tw==
X-Google-Smtp-Source: ABdhPJxpB08C6ssiZ00fO8S7d2fJJ296KZSsPzCPeeZQCV9EpMtuahVBNRj7tp23f2267B6/2Gya/A==
X-Received: by 2002:a05:6808:10d2:b0:2d9:a01a:4b9d with SMTP id s18-20020a05680810d200b002d9a01a4b9dmr357309ois.196.1646430439165;
        Fri, 04 Mar 2022 13:47:19 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id g12-20020a056870340c00b000d17b798ba9sm2924628oah.34.2022.03.04.13.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 13:47:17 -0800 (PST)
Received: (nullmailer pid 472361 invoked by uid 1000);
        Fri, 04 Mar 2022 21:47:16 -0000
Date:   Fri, 4 Mar 2022 15:47:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>, brgl@bgdev.pl,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        skhan@linuxfoundation.org, Luka Perkov <luka.perkov@sartura.hr>
Subject: Re: [PATCH v10 5/6] dt-bindings: mfd: Add Delta TN48M CPLD drivers
 bindings
Message-ID: <YiKI5LDWaxvlc9m5@robh.at.kernel.org>
References: <20220131133049.77780-1-robert.marko@sartura.hr>
 <20220131133049.77780-6-robert.marko@sartura.hr>
 <Yh8vJNc4D6rA68au@google.com>
 <Yh/kFzNuvbwA2qeE@robh.at.kernel.org>
 <CA+HBbNHComN9kgFp1Xr4mdedwYjDMbSUkw+6_KAe8+O4hrtvKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+HBbNHComN9kgFp1Xr4mdedwYjDMbSUkw+6_KAe8+O4hrtvKQ@mail.gmail.com>
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

On Thu, Mar 03, 2022 at 01:41:13PM +0100, Robert Marko wrote:
> On Wed, Mar 2, 2022 at 10:39 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Wed, Mar 02, 2022 at 08:47:32AM +0000, Lee Jones wrote:
> > > On Mon, 31 Jan 2022, Robert Marko wrote:
> > >
> > > > Add binding documents for the Delta TN48M CPLD drivers.
> > > >
> > > > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > >
> > > This is missing a DT review.
> >
> > How about this one[1]?
> >
> > Rob
> >
> > [1] https://lore.kernel.org/all/20210719225906.GA2769608@robh.at.kernel.org/
> 
> Hi Rob,
> Thanks for reaching out.
> 
> As you can see the bindings have evolved since v6,
> GPIO driver now only uses 2 distinct compatibles.

Fundamentally, it hasn't really changed.

There's 2 main issues. First, I don't see the need for any child nodes. 
This would be sufficient:

cpld@41 {
    compatible = "delta,tn48m-cpld";
    reg = <0x41>;
    #reset-cells = <1>;
    #gpio-cells = <2>;
    gpio-controller;
};

You only need child nodes if the sub-blocks have their own resources or 
are widely reused in different configurations.

The 2nd issue is whether GPIOs are even GPIOs at all. I don't recall 
that Linus ever agreed.

Both issues kind of boil down to is there even more that 1 variation of 
this h/w where you have differing connections? AFAICT, Delta tn48m is a 
pretty specific device and I would guess something implemented in a CPLD 
is likely to change on every board design. At least that's my experience 
with 'board level logic'.

Rob
