Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286104E1D74
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 19:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343550AbiCTStd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 14:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240513AbiCTSt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 14:49:28 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE4A3389A;
        Sun, 20 Mar 2022 11:48:04 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id k125so10426525qkf.0;
        Sun, 20 Mar 2022 11:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zNUU20JYr/XCYRrX4tGKAZ+3B2SaozQZu855ahnTeKE=;
        b=glTDFPoca9PS2ONsuCo+PuObwnUsz37m0GEghXHJ4RaRYO4z2gqTIXIXPXYGSTWjwi
         qOkA7ZBwKHSLnpnlLJFio+x5n1OZWGumDTMR+Z0jomdRIvxKr2wz7hOhoLJlTSAf7xco
         oo6jZ+Rgk2C0bMVtlrRGLvdg5SRiR2hnqL5bvETA734Y6rxipo01jxtwKHjGyU4XhEPi
         uSYysjFFmyYMezdVpTsl8jCrly9p6bLpSVInUkQ5e282j5dFK+D03bXwWzC2fKxi/5gz
         uJnFX/FiN9Loxycu9H+PVrbX7nMpFRQLogs4DmJXFRxb1MbKRy2Gw+ik9p9OsTweMkXT
         w6jw==
X-Gm-Message-State: AOAM532NuANWwv8DM1rtYsEJOgu2GyFrbCPYvcZonoCQGMy9kPD38fPS
        Y0XgvwT7LI5UzCHFimfzYQ==
X-Google-Smtp-Source: ABdhPJyhERCoe29vpwn80+Bn0p6qmL/P6VevxfzOyv+qt6vppZBPu8RpmQgniVLAwbjJLDfybonECQ==
X-Received: by 2002:a05:620a:25cb:b0:67e:9ae8:1563 with SMTP id y11-20020a05620a25cb00b0067e9ae81563mr1128808qko.222.1647802084011;
        Sun, 20 Mar 2022 11:48:04 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:c6d:21ec:c4f5:bb3:5269:3b0e])
        by smtp.gmail.com with ESMTPSA id s31-20020a05622a1a9f00b002e1df010316sm10605821qtc.80.2022.03.20.11.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 11:48:02 -0700 (PDT)
Received: (nullmailer pid 3198157 invoked by uid 1000);
        Sun, 20 Mar 2022 18:47:56 -0000
Date:   Sun, 20 Mar 2022 14:47:56 -0400
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
Message-ID: <Yjd23Gro6B6zWCrO@robh.at.kernel.org>
References: <20220317191527.96237-1-singh.kuldeep87k@gmail.com>
 <20220317191527.96237-3-singh.kuldeep87k@gmail.com>
 <558f0c92-c499-daca-e1ad-2b16137f8c06@arm.com>
 <20220317212508.GB99538@9a2d8922b8f1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317212508.GB99538@9a2d8922b8f1>
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

On Fri, Mar 18, 2022 at 02:55:08AM +0530, Kuldeep Singh wrote:
> On Thu, Mar 17, 2022 at 08:25:12PM +0000, Robin Murphy wrote:
> > On 2022-03-17 19:15, Kuldeep Singh wrote:
> > > Renesas RZ/N1D platform uses compatible "arm,cortex-a7-timer" in
> > > conjugation with "arm,armv7-timer". Since, initial entry is not
> > > documented, it start raising dtbs_check warnings.
> > > 
> > > ['arm,cortex-a7-timer', 'arm,armv7-timer'] is too long
> > > 'arm,cortex-a7-timer' is not one of ['arm,armv7-timer', 'arm,armv8-timer']
> > > 'arm,cortex-a7-timer' is not one of ['arm,cortex-a15-timer']
> > > 
> > > Document this compatible to address it. The motivation to add this
> > > change is taken from an already existing entry "arm,cortex-a15-timer".
> > > Please note, this will not hurt any arch timer users.
> > 
> > Eh, if it's never been documented or supported, I say just get rid of it.
> > The arch timer interface is by definition part of a CPU, and we can tell
> > what the CPU is by reading its ID registers. Indeed that's how the driver
> > handles the non-zero number of CPU-specific errata that already exist - we
> > don't need compatibles for that.
> > 
> > In some ways it might have been nice to have *SoC-specific* compatibles
> > given the difficulty some integrators seem to have had in wiring up a stable
> > count *to* the interface, but it's not like they could be magically added to
> > already-deployed DTs after a bug is discovered, and nor could we have
> > mandated them from day 1 just in case and subsequently maintained a binding
> > that is just an ever-growing list of every SoC. Oh well.
> 
> Robin, A similar discussion was already done on v1 thread. Please see
> below for details:
> https://lore.kernel.org/linux-devicetree/20220317065925.GA9158@9a2d8922b8f1/
> https://lore.kernel.org/linux-devicetree/726bde76-d792-febf-d364-6eedeb748c3b@canonical.com/
> 
> And final outcome of discussion turns out to add this compatible string.

I agree with Robin on dropping. More specific here is not useful. If 
we're going to add some cores, then we should add every core 
implementation.

If one has a big.LITTLE system with A15/A7 what would be the right 
compatible value?

> 
> I see people with different set of perspective in regard to whether keep
> compatible string or not. We should have some sort of evidences to
> support claims so that next time when similar situation arises, we'll be
> aware beforehand how to proceed.

Every situation tends to be different.

Rob
