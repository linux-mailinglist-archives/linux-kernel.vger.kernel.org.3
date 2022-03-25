Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6059F4E7BD3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbiCYVY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 17:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233363AbiCYVY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 17:24:56 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5CA20C2CA;
        Fri, 25 Mar 2022 14:23:21 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-d39f741ba0so9294582fac.13;
        Fri, 25 Mar 2022 14:23:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AMIxKTHOocv7P7mjlTg/cziGQ3ni+gwA2uTnznijLXs=;
        b=av4MQMqnylrcEiaeRVh7qAKjbmqQ/lEIHYseXeanfhsWeuqYBCXqZnGHAnbF0btRXs
         uvT14FJO+zV87Xtvn90/EOHVRtH9MLp250fjfzWHGPYy2M+hp7TcPS+rdLH9CZeYKqSD
         cM0wWKTuJ95/pa2+cGuiFJAsZLq8hsJenaIFVBpLDkTQAL92uM3gVzgvuDlfMmuCuJ0a
         RxgcW2TljhbvxC0wKputbx8CR5NzVFY6e0gZUYozY45P7VXGYMpcPFgzk75BrEQvPrug
         kLRYgPxlsyHtllFGb1Dvs6UjCiuBV5MW6D0Eca8ZwlgGjGBRHbwMJEOM7FXgEgQtP5Ho
         vacQ==
X-Gm-Message-State: AOAM5326j/iyMfi0j86qEWbkk7F0B7KfIlHUruARqryy5VKeS+lbUpFa
        6v+FwEIewiJ/jBH41NQMPQ==
X-Google-Smtp-Source: ABdhPJxPDx6D9hSAOFwDrZoFRwtDy8TBaPpEGzhIXk15tERJysKzIfhoFTO6nQ4zlbK5Cl3pvCblDw==
X-Received: by 2002:a05:6870:328d:b0:da:b3f:2b2b with SMTP id q13-20020a056870328d00b000da0b3f2b2bmr9743355oac.202.1648243400680;
        Fri, 25 Mar 2022 14:23:20 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 89-20020a9d0be2000000b005ae194ec5absm3110323oth.15.2022.03.25.14.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 14:23:19 -0700 (PDT)
Received: (nullmailer pid 477388 invoked by uid 1000);
        Fri, 25 Mar 2022 21:23:18 -0000
Date:   Fri, 25 Mar 2022 16:23:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kuldeep Singh <singh.kuldeep87k@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/3] dt-bindings: timer: Document arm, cortex-a7-timer
 in arch timer
Message-ID: <Yj4yxjQ2rQ4HW4uR@robh.at.kernel.org>
References: <20220317191527.96237-1-singh.kuldeep87k@gmail.com>
 <20220317191527.96237-3-singh.kuldeep87k@gmail.com>
 <558f0c92-c499-daca-e1ad-2b16137f8c06@arm.com>
 <20220317212508.GB99538@9a2d8922b8f1>
 <Yjd23Gro6B6zWCrO@robh.at.kernel.org>
 <44f3abe1-09a2-657f-7637-afa34781709b@arm.com>
 <20220323183544.GA95717@9a2d8922b8f1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323183544.GA95717@9a2d8922b8f1>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 12:05:44AM +0530, Kuldeep Singh wrote:
> On Mon, Mar 21, 2022 at 11:52:27AM +0000, Robin Murphy wrote:
> > On 2022-03-20 18:47, Rob Herring wrote:
> > > On Fri, Mar 18, 2022 at 02:55:08AM +0530, Kuldeep Singh wrote:
> > > > On Thu, Mar 17, 2022 at 08:25:12PM +0000, Robin Murphy wrote:
> > > > > On 2022-03-17 19:15, Kuldeep Singh wrote:
> > > > > > Renesas RZ/N1D platform uses compatible "arm,cortex-a7-timer" in
> > > > > > conjugation with "arm,armv7-timer". Since, initial entry is not
> > > > > > documented, it start raising dtbs_check warnings.
> > > > > > 
> > > > > > ['arm,cortex-a7-timer', 'arm,armv7-timer'] is too long
> > > > > > 'arm,cortex-a7-timer' is not one of ['arm,armv7-timer', 'arm,armv8-timer']
> > > > > > 'arm,cortex-a7-timer' is not one of ['arm,cortex-a15-timer']
> > > > > > 
> > > > > > Document this compatible to address it. The motivation to add this
> > > > > > change is taken from an already existing entry "arm,cortex-a15-timer".
> > > > > > Please note, this will not hurt any arch timer users.
> > > > > 
> > > > > Eh, if it's never been documented or supported, I say just get rid of it.
> > > > > The arch timer interface is by definition part of a CPU, and we can tell
> > > > > what the CPU is by reading its ID registers. Indeed that's how the driver
> > > > > handles the non-zero number of CPU-specific errata that already exist - we
> > > > > don't need compatibles for that.
> > > > > 
> > > > > In some ways it might have been nice to have *SoC-specific* compatibles
> > > > > given the difficulty some integrators seem to have had in wiring up a stable
> > > > > count *to* the interface, but it's not like they could be magically added to
> > > > > already-deployed DTs after a bug is discovered, and nor could we have
> > > > > mandated them from day 1 just in case and subsequently maintained a binding
> > > > > that is just an ever-growing list of every SoC. Oh well.
> > > > 
> > > > Robin, A similar discussion was already done on v1 thread. Please see
> > > > below for details:
> > > > https://lore.kernel.org/linux-devicetree/20220317065925.GA9158@9a2d8922b8f1/
> > > > https://lore.kernel.org/linux-devicetree/726bde76-d792-febf-d364-6eedeb748c3b@canonical.com/
> > > > 
> > > > And final outcome of discussion turns out to add this compatible string.
> > > 
> > > I agree with Robin on dropping. More specific here is not useful. If
> > > we're going to add some cores, then we should add every core
> > > implementation.
> 
> Sure Rob, I will drop A7/15-timer entry from compatibles.
> This means only two entries i.e arm,armv7/8-timer will be there under
> compatibles now.
> 
> I actually added A7-timer because A15-timer was already present in
> binding. Since, it was added by you that's why I added this one.
> I will update compatibles accordingly as you said above.

The A15 compatible is likely there because upstream dts files used it 
and it's a judgement call of supporting in the schema vs. making dts 
changes. Just like the PL022. Maybe there are A7 cases, but fewer to 
fix. I don't remember.

So no real object to removing it, but I can think of better things to 
work on. Here's a list of most occurring compatibles with no schema[1]. 
Or find a platform and work towards getting 0 warnings.


> > Yeah, what I was trying to convey is that a compatible like
> > "arm,cortex-a76-timer" has the problem of being both too specific *and* not
> > specific enough to be genuinely useful *for the particular case of the arch
> > timer*. It's an architectural interface, where the actual functional
> > features are described through the interface itself, so the purpose of the
> > DT entry is really just to indicate that the standard interface is present
> > and describe how its externally-routed interrupts are wired up.
> > 
> > However, it's also true that implementations of standard functionality
> > sometimes have bugs that software needs to know about, but in order for
> > specific DT compatibles to be useful in that respect they really need to
> > identify the *exact* implementation, e.g. to know that
> > "arm,cortex-a76-r0p0-timer" has a bug which needs working around, but
> > "arm,cortex-a76-r4p0-timer" does not. There might be cases where every known
> > version of a CPU is equally affected (e.g. Cortex-A73), but it doesn't hold
> > as a general assumption. Furthermore as mentioned, the other class of bugs
> > which affect this interface are not in the CPU's implementation of the
> > interface at all, but in the external SoC logic that provides the counter
> > value, and therefore it can be identification of the overall SoC that
> > matters regardless of which CPU IP(s) may be present.
> > 
> > If we'd had the benefit of 10 years worth of hindsight 10 years ago, we
> > probably wouldn't have defined "arm,cortex-a15-timer" either. However the
> > fact that we can't erase the legacy of that decision doesn't make an
> > argument for repeating it now.
> > 
> > > If one has a big.LITTLE system with A15/A7 what would be the right
> > > compatible value?
> > > 
> > > > 
> > > > I see people with different set of perspective in regard to whether keep
> > > > compatible string or not. We should have some sort of evidences to
> > > > support claims so that next time when similar situation arises, we'll be
> > > > aware beforehand how to proceed.
> > > 
> > > Every situation tends to be different.
> > 
> > Indeed, I certainly don't have a personal perspective of "delete all the
> > bindings!" in general - only when they're truly redundant (functionally, any
> > driver that can touch the arch timer registers can also read the CPU ID
> > registers, but even in the DT there should already be compatibles for the
> > CPUs themselves).
> 
> Thanks Robin for providing inputs.
> I agree with your opinion of having soc specific compatibles which is
> also mentioned under dos and dont's of bindings and other cases will
> require investigation though.
> https://www.kernel.org/doc/html/latest/devicetree/bindings/writing-bindings.html

There's always exceptions to guidelines. This is one of them.

Rob

[1] https://gitlab.com/robherring/linux-dt/-/jobs/2250856818#L7769
