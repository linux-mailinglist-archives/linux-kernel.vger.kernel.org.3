Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F913580404
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 20:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbiGYSa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 14:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiGYSa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 14:30:57 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C9E13D1F;
        Mon, 25 Jul 2022 11:30:56 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-10bd4812c29so15801992fac.11;
        Mon, 25 Jul 2022 11:30:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FEooM2RT53g6tnmnQNbJRb91DOY7HMArXQf84dlNSkI=;
        b=oeiPZtgn80QrHXsjEiItM6uOpZ5g9IvLYybch+8NTdGLA/PpqeshF0H/ivaGyX3C9Y
         IfA5xl2+RnB+SpzOFYMZGKV5wTfb162+oRBajYYY8/NsJsKklGwW8VA8zdthj370SBb2
         JLZRX6d05Fzgcpe1bCEoOJCJLmQN75V1WxcK+0mMCscsIkIJtrkmuJbo+G7A1I/xVlnc
         OaJNV0tZAfnIAFccpm32D6XZ8ZbvDJL28/Gv6xI8ra23E0L2ubruf6K6ObJpsNXdb+XN
         gXKAAhEF0a9QtRYVWxcPQcwrzt3TYMlSIaKm8DNUwVnAKbO0ip1BN1xkugU1zMwV9WT/
         7BaQ==
X-Gm-Message-State: AJIora+VX//Er7RysbERCQWsy0AvVW86p7bLNk6zfN+rTHVy2sceNzBN
        61pW5L+mS/5s2t6nG7GYRBPUgDTspQ==
X-Google-Smtp-Source: AGRyM1vRZ+8PMG1t9D17j7BFUwsAeYGwVsJCeWuLF64Xel9A8HWkj1FtmFh4QSPgjUumYoKZAhSJLA==
X-Received: by 2002:a05:6870:b48c:b0:10d:f6a2:8d9e with SMTP id y12-20020a056870b48c00b0010df6a28d9emr5492256oap.227.1658773856060;
        Mon, 25 Jul 2022 11:30:56 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id x52-20020a9d37b7000000b0061cc1ba78e5sm5255756otb.3.2022.07.25.11.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 11:30:55 -0700 (PDT)
Received: (nullmailer pid 2459631 invoked by uid 1000);
        Mon, 25 Jul 2022 18:30:52 -0000
Date:   Mon, 25 Jul 2022 12:30:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mike Yang <reimu@sudomaker.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Zhou Yanjie <zhouyanjie@wanyeetech.com>,
        tudor.ambarus@microchip.com, p.yadav@ti.com, michael@walle.cc,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        krzysztof.kozlowski+dt@linaro.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        aidanmacdonald.0x0@gmail.com, tmn505@gmail.com,
        paul@crapouillou.net, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        jinghui.liu@ingenic.com, sernia.zhou@foxmail.com
Subject: Re: [PATCH 2/3] dt-bindings: SPI: Add Ingenic SFC bindings.
Message-ID: <20220725183052.GA2392099-robh@kernel.org>
References: <1658508510-15400-1-git-send-email-zhouyanjie@wanyeetech.com>
 <1658508510-15400-3-git-send-email-zhouyanjie@wanyeetech.com>
 <487a93c4-3301-aefd-abba-aabf4cb8ec90@linaro.org>
 <37062a5d-9da3-fbaf-89bd-776f32be36d9@wanyeetech.com>
 <d1a0dd15-3621-14e9-b931-417cefaab017@linaro.org>
 <b5505a46-ce76-d0aa-009e-81d9ba16e1d5@sudomaker.com>
 <YtxLoPOykLDTzTn9@sirena.org.uk>
 <f05045fa-9ecd-d312-0eaa-5d19498453fc@linaro.org>
 <b52a8e97-3b8e-c67b-4440-2d7428edb4fa@sudomaker.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b52a8e97-3b8e-c67b-4440-2d7428edb4fa@sudomaker.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 24, 2022 at 04:49:25AM +0800, Mike Yang wrote:
> On 7/24/22 04:07, Krzysztof Kozlowski wrote:
> > On 23/07/2022 21:27, Mark Brown wrote:
> >> On Sun, Jul 24, 2022 at 02:47:14AM +0800, Mike Yang wrote:
> >>> On 7/24/22 01:43, Krzysztof Kozlowski wrote:
> >>>> On 23/07/2022 18:50, Zhou Yanjie wrote:
> >>
> >>>>> No offense, does it really need to be named that way?
> >>>>> I can't seem to find documentation with instructions on this :(
> >>
> >> ...
> >>
> >>>> All bindings are to follow this rule, so I don't understand why you
> >>>> think it is an exception for you?
> >>
> >>> Zhou didn't ask you to make an exception. They have a valid
> >>> point and they're asking why.
> >>
> >>> You may want to avoid further incidents of this kind by stop
> >>> being bossy and actually writing a guideline of naming these
> >>> .yaml files and publish it somewhere online.

I don't like your tone. Patches are welcome to fix deficiencies in 
documentation. Out of the hundreds of bindings a year, I see <5 
documentation patches a year.

The documentation clearly says to run 'make dt_binding_check' and that 
was obviously not followed here. 

> >> Yeah, I do have to say that I was also completely unaware that
> >> there was any enforced convention here.
> > 
> > Indeed, it's not a enforced pattern. But there are many other
> > insignificant ones which we also tend to forget during review, like
> > using words "Device Tree bindings" in title or using unnecessary quotes
> > around "refs" (also in ID of schema). It's not a big deal, but I ask
> > when I notice it.
> 
> Good. Thanks for paying attention to these details.
> 
> 
> >> Zhou already mentioned he was unable find the naming guidelines of these .yaml files.
> >>
> >> Apparently you think it's unacceptable for new contributors of a certain subsystem to use existing code as examples, and/or they're responsible for figuring out what's a good example and what's a bad one in the existing codebase.

Please wrap your lines on replies.


> > 
> > It's everywhere in the kernel, what can I say? If you copy existing
> > code, you might copy poor code...
> 
> Still, it shouldn't be a responsibility of new contributors to 
> determine the quality of an existing piece of code, unless there are 
> clear guidelines (i.e. one should use the new "cs-gpios" attribute in SPI controllers).

Generally the guidance is to look at newer drivers for current best 
practices.


> >>> It might never grow to new devices (because they might be different), so
> >>> that is not really an argument.
> >>
> >> It is an argument. A very valid one.
> >>
> >> "they *might* be different". You may want to get your hands on real hardware and try another word. Or at least read the datasheets instead of believing your imagination.
> >>
> >> I would enjoy duplicating the st,stm32-spi.yaml into st,stm32{f,h}{0..7}-spi.yaml if I'm bored at a Sunday afternoon.
> >>
> >>>
> >>> All bindings are to follow this rule, so I don't understand why you
> >>> think it is an exception for you?
> >>
> >> Zhou didn't ask you to make an exception. They have a valid point and they're asking why.
> > 
> > Hm, everyone has the same valid point and such recommendation is to
> > everyone, although it is nothing serious.
> > 
> >> You may want to avoid further incidents of this kind by stop being bossy and actually writing a guideline of naming these .yaml files and publish it somewhere online.
> > 
> > I did not see any incident here... Process of review includes comments
> > and there is nothing bad happening when you receive a comment. No
> > incident...
> 
> 
> Okay. After careful inspection of the Ingenic datasheets, now I have 
> the conclusion: The Ingenic X1000, X1021, X1500, X1501, X1520, X1600, 
> X1800, X1830, X2000, X2100, X2500 have the same SFC controller.

So if they are all 'the same', then I expect they all have a fallback 
compatible with x1000 and using that for the filename makes sense.


> X1600 has a newer version (let's say v2) of the SFC, and X2000-2500 
> have v3. Others have the original version (let's say v1). Each new 
> version introduced new features such as arbitrary DMA sizes, and the 
> rest features are the same.

So backwards compatible? If so, then they should have x1000 for 
fallback.

> 
> So IMO the name "ingenic,sfc.yaml" is perfectly logical.

Covering all 3 versions? If so and not backwards compatible, then I 
would agree.

Rob
