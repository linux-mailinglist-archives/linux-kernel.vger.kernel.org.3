Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08AA24E970C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 14:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242694AbiC1Mxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 08:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242688AbiC1Mxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 08:53:33 -0400
Received: from mail.thepaulodoom.com (www.thepaulodoom.com [45.77.108.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BFB3C5D19F;
        Mon, 28 Mar 2022 05:51:43 -0700 (PDT)
Received: from hp-amd-paul (c-98-240-189-147.hsd1.mn.comcast.net [98.240.189.147])
        by vultr.guest (OpenSMTPD) with ESMTPSA id 6629f991 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 28 Mar 2022 12:51:41 +0000 (UTC)
Date:   Mon, 28 Mar 2022 07:51:37 -0500
From:   Paul Lemmermann <thepaulodoom@thepaulodoom.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: aes_generic: fixed styling warnings
Message-ID: <20220328125137.bsbvroyxcjw6rl5m@hp-amd-paul>
References: <20220326172051.14722-1-thepaulodoom@thepaulodoom.com>
 <CAMj1kXEQtTAMPLTtgc=9sDYvgxs+oihfnY7Q6bggC0p5u-V1Hw@mail.gmail.com>
 <20220327224009.2jotnczk67j4cfh2@hp-amd-paul>
 <CAMj1kXHCR1nD24WDnYpD4Nu23x9+hw+=7EXOpq7y7m9LDk2J0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHCR1nD24WDnYpD4Nu23x9+hw+=7EXOpq7y7m9LDk2J0w@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 09:39:14AM +0200, Ard Biesheuvel wrote:
> (please keep the cc's)
> 
> On Mon, 28 Mar 2022 at 00:46, Paul Lemmermann
> <thepaulodoom@thepaulodoom.com> wrote:
> >
> > On Sun, Mar 27, 2022 at 01:41:19PM +0200, Ard Biesheuvel wrote:
> > > On Sat, 26 Mar 2022 at 18:48, Paul Lemmermann
> > > <thepaulodoom@thepaulodoom.com> wrote:
> > > >
> > > > Fixed all styling warnings from the checkpatch.pl script.
> > > >
> > > > Signed-off-by: Paul Lemmermann <thepaulodoom@thepaulodoom.com>
> > >
> > > Did you test this code after 'fixing' it?
> > >
> > No, I did not. Now that I scrutinized it a bit more, I realized the
> > kernel coding conventions. Sorry about that, this is my first patch.
> 
> In that case, welcome!
> 
> This is not about coding conventions. This is about correctness.
> 
> For instance,
> 
> > > >
> > > > -#define f_nround(bo, bi, k)    do {\
> > > > +#define f_nround(bo, bi, k)    while (0) {\
> > > >         f_rn(bo, bi, 0, k);     \
> > > >         f_rn(bo, bi, 1, k);     \
> > > >         f_rn(bo, bi, 2, k);     \
> > > >         f_rn(bo, bi, 3, k);     \
> > > >         k += 4;                 \
> > > > -} while (0)
> > > > +}
> > > >
> 
> Why are you making this change, and why do you think it produces the
> same result?
> 
> > Can you remove everything in the patch past the section with line
> > 1144, or do I have to resubit the patch?
> >
> 
> checkpatch.pl is a useful tool for finding style issues, but please
> use it with care. And changing decades old code just to fix issues
> reported by checkpatch.pl is really just pointless churn.
> 
> So let's just drop this patch altogether, shall we? If you're
> interested in helping out, please have a look at the staging/ tree -
> there is a lot of code there that needs cleaning up.
> 
Yes, we can drop the patch. Thank you so much for your help and support.
Looking forward to contributing more to the Linux kernel.

Thanks,
Paul
