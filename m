Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6BA4FFAB8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 17:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236706AbiDMP5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 11:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236729AbiDMP5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 11:57:33 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E71C0633AB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 08:55:11 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id BB99E92009C; Wed, 13 Apr 2022 17:55:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id B4A0E92009B;
        Wed, 13 Apr 2022 16:55:10 +0100 (BST)
Date:   Wed, 13 Apr 2022 16:55:10 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Thomas Gleixner <tglx@linutronix.de>
cc:     Daniel Vacek <neelx@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/apic: Clarify i82489DX bit overlap in APIC_LVT0
In-Reply-To: <875yndf760.ffs@tglx>
Message-ID: <alpine.DEB.2.21.2204131450220.9383@angie.orcam.me.uk>
References: <20220202140244.1681140-1-neelx@redhat.com> <874k361liu.ffs@tglx> <CACjP9X_A7aLmvypyOz1UrXM571gx_X5q7=w-1j+G+MSbCteiEw@mail.gmail.com> <87ee22f3ci.ffs@tglx> <alpine.DEB.2.21.2204122235140.9383@angie.orcam.me.uk> <875yndf760.ffs@tglx>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas,

> >  For the record, it's documented in the i82498DX datasheet[1] and user 
> > manual[2]:
> >
> > 'Bits [19:18] Timer Base: This field selects the time base input to be 
> > used by the timer.
> 
> That's true, but how many people aside of you and me still have access
> to the i82498DX related documentation? The interwebs has no trace of
> them.

 Hmm, actually now that you mention it I recall that archive.org does have 
scanned copies of the 1995 Intel486 Microprocessors and Pentium Processors 
databooks, and they include the i82489DX datasheet and manual respectively 
starting from pages 4-220 (857) and 2-579 (600).  See:

<https://archive.org/details/bitsavers_intel80486croprocessorsandRelatedProductsJan95_58561506>

<https://archive.org/details/bitsavers_intelpentirocessorsandRelatedComponents_64170750>

I have uploaded clean copies of the discrete documents to my site now too, 
made via a PostScript printer driver with the "print" function of software 
included with Intel Data on Demand CDs to handle the proprietary document 
format used there.  Sadly these are bitmaps rather than searchable PDFs, 
but they might be easier to refer to.  No better format has been tracked 
down.  See:

<ftp://ftp.linux-mips.org/pub/linux/mips/people/macro/APIC/>

Because why not?

> With the above I explicitely meant the undocumented bit overlap both in
> the current SDMs and the kernel source.

 Fair enough.  The lore has probably been already forgotten within Intel.

  Maciej
