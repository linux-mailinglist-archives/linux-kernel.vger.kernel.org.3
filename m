Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1243B5234A1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 15:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237428AbiEKNsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 09:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbiEKNsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:48:17 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A9024F3D
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 06:48:16 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Kyx7c6Gtxz4xXS;
        Wed, 11 May 2022 23:48:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1652276895;
        bh=h4GsJHInoEmk4VosvrifFlBFgfvEydQXp/Z8HDdJba0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Bil9WRONdl9jfvolbTZd1gifCX6q11Kt7gVHiisrZUWqNuaI0H2scNc2YMKlTSJT8
         YT0FrAz7Qexhp1uUkeep0dfxCiw+nuZQKxbyVdhbDtdLMTTNtfla+Ove9+L1l1H+Bc
         F8gdYdqQrFm18aHu6uuTuwfdFvqzFvCSiHonaVLDkRG2YXYaEJFEAVP8MVC1jhBip1
         fw9wp9StQZDUymihehKjk43rWgE6oqiFQwMmqXfKZUrqsnajluEMQQYuy2TDyWQ2Bx
         OElYdv46mnVXyRtj1TfKlBr1QtdRWTSvAPIPbybp2xj4kSgVXRM72VSW7DA6+9MAqF
         klf9+CSDWFy3A==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Borislav Petkov <bp@alien8.de>,
        Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
In-Reply-To: <Ynt1z0eZ19eMqp8I@zn.tnic>
References: <165201148069.536527.1960632033331546251.tglx@xen13>
 <CAHk-=wjMmSZzMJ3Xnskdg4+GGz=5p5p+GSYyFBTh0f-DgvdBWg@mail.gmail.com>
 <ff841fdc-4db7-7a3d-8caf-d0cddd0dfa31@leemhuis.info>
 <Ynt1z0eZ19eMqp8I@zn.tnic>
Date:   Wed, 11 May 2022 23:48:11 +1000
Message-ID: <877d6s89k4.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Borislav Petkov <bp@alien8.de> writes:
> On Tue, May 10, 2022 at 01:27:54PM +0200, Thorsten Leemhuis wrote:
>> Many thx for reminding people about the tag.  FWIW, that's a problem in
>> a lot or subsystems and makes my regression tracking efforts hard, as my
>> tracking bot relies on the 'Link:' tag. If it's missing I thus have to
>> manually search if patches were posted or committed to fix a regression,
>> which makes the tracking hard and annoying. :-/
>
> Here's my experience with the Link thing:
>
> So it is trivial to take the Message-ID and turn it into a link tag and
> our automation does that.
>
> - Now, it is not a problem when that link tag points to a patch which is
> part of the thread which contains the initial bug report - you just go
> up-thread.
>
> - If the link tag points to a patch which is version N and it is the
> version which passed all review and gets committed, it is a bit harder
> to find the previous versions and find the whole discussion how it all
> arrived at version N. You can search by the Subject, ofc, which, if it
> hasn't been changed, will give you the previous threads. And so on ...
>
> - The problem is when the discussion happened somewhere and the patch
> got submitted separately. I can't think of a good way to automate
> that so we have to pay attention and fix the link tag by hand and add
> the relevant one. And I try to do that when I'm especially awake when
> applying the patch.

That doesn't scale though, it puts more work on maintainers, who already
don't have enough time.

The *submitter* should be putting all the relevant info in the patch,
including any links to other discussions, previous versions etc. etc.

Then the maintainer can automatically add the "Link:" tag pointing to
the submission, and everything is there in the archive.

One advantage of linking back to the original submission is that if the
patch doesn't have all the relevant info, anyone can post replies adding
context or linking to other places, even after the patch has been
committed.

cheers
