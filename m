Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5B2523D9B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 21:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347012AbiEKTfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 15:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiEKTfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 15:35:13 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E806C177898
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 12:35:11 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 712BA1EC0535;
        Wed, 11 May 2022 21:35:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1652297706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=B7VXmh66M+2El9UzptpiYafUbsBm6o9pydX/9uOO3yk=;
        b=naMVL+3QI0M+uWHrRrw4Tv1CFrKKeItd5vbrSLAE2aOwAEu/foCljd+DPxtjL+fhdUrDiM
        VwHOH4X9fQbC/exGi2o6//8xNSN5KXHMD+UGBfDW1C4qwNxjwBsHFjzDDBguPIU1vJbncY
        FS/IzxDz2/3YxjjYLzE8WkAUfLvUjKg=
Date:   Wed, 11 May 2022 21:35:09 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zhangfei Gao <zhangfei.gao@foxmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: Link: tag and links to submission and reports (was: Re: [GIT
 pull] core/urgent for v5.18-rc6)
Message-ID: <YnwP7QmPzyv5FhrZ@zn.tnic>
References: <165201148069.536527.1960632033331546251.tglx@xen13>
 <CAHk-=wjMmSZzMJ3Xnskdg4+GGz=5p5p+GSYyFBTh0f-DgvdBWg@mail.gmail.com>
 <ff841fdc-4db7-7a3d-8caf-d0cddd0dfa31@leemhuis.info>
 <Ynt1z0eZ19eMqp8I@zn.tnic>
 <YnvbLx9FKgQwZJ/F@mit.edu>
 <CAHk-=wgUVHucyjp6M7qmn8b=aqwucfS4SQpqOCR5sKr16zoO5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgUVHucyjp6M7qmn8b=aqwucfS4SQpqOCR5sKr16zoO5g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 08:55:34AM -0700, Linus Torvalds wrote:
> On Wed, May 11, 2022 at 8:50 AM Theodore Ts'o <tytso@mit.edu> wrote:
> >
> > I would argue that it should be the patch submitter's responsibility
> > to explicitly add a URL to the problem report.
> 
> I agree in the perfect case.
> 
> But in practice, we have a lot more patch submitters than we have
> maintainers, and not all "leaf developers" necessarily know how to do
> everything.
> 
> So the maintainer should probably expect to fix things up. Not always,
> but also not a "the developer should have done this, so I won't do it"
> 
> This isn't so different from the fact that not everybody writes
> English proficiently - people do hopefully end up fixing things up as
> they get passed onwards.

And, in addition, what happens most often in my experience is I
constantly get to point submitters to our process documentation -
submitting-patches especially - as not a small number of them are not
aware of different aspects of the whole patch dance: tags, SOB chains,
etc. And the Link tag is no exception here.

So yeah, the maintainer is kinda the last one to make sure the patch
looks somewhat sane and documents the whole issue so that years from
now, it can still be understood what we were fixing there.

And I guess important part of that documentation is setting the proper
Link so...

And as said, yeah, we won't be perfect and catch all cases but at least
we can pay attention.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
