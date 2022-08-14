Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F335926E0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 00:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiHNWvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 18:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiHNWvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 18:51:18 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80ED1120B1;
        Sun, 14 Aug 2022 15:51:17 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id AECE15C0050;
        Sun, 14 Aug 2022 18:51:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 14 Aug 2022 18:51:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660517474; x=1660603874; bh=bY
        YlgIEhiHrems2iB+qx0I1QWHQaXBptHChcWPGu21E=; b=ZbP3675609WnvKXTzu
        T8/YZmhYnx6lkM6aeP0MXlejTZ24M5W+vGZgPDrmt+Ju5hX/G8TATWdtA5ruxCj6
        kV4IUDbSFUN9k2OuZqA5quugJm31Y3gU3BcrhMYksI6uSpg6kAaS4diigbBLOqqP
        NBTSl3mZAD7ewqGEIkQpLxCr4QmpyuZjXyI7cFaR0eqc9ND0N5jyHfmnp83AyQ4r
        YWisKGNprEJSvilzeTl3CxJbKroUoYN5oRT09CKvbrW3EjNk0XCsbLBhTpMFwNit
        M0WA5/6gIEoB7pd4asvFJhgNxNjqRrGNjeepECcPbO9k24gEtL4E/U/J1EyB+lFn
        tqYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660517474; x=1660603874; bh=bYYlgIEhiHrems2iB+qx0I1QWHQa
        XBptHChcWPGu21E=; b=n9DiK3rOh3odiAFOUCJRYCETOCB43E6qGU38IaNdIjP8
        cQTr4MpsbvSgrzw1thrWWlKQJGEJcVY9AGpk1WOHE3juR4SBEmAiQ7uJ8LGNSMVf
        8qTNRvw5xhfV3BFoFujZv/kLjQHpaDNbY1U+ax7q90oVG0ruDRF+p7RRwBQHHbvv
        cvv3EsU8rx5dx3Zzf4j6DxUzcE9GXT01sMIYRD4Xp9bQOLShO71qVWfOJdPmcqcg
        kO3yoYHuCWR/zXtwUgFqftkJnwTKxmx3vutYi0G/6HZFYoGirHkak1tEO8LU5WBQ
        V4sJnmypY7UeAw4gVO8KyxXq1RIedHxAXKRgsBwoVA==
X-ME-Sender: <xms:Ynz5YsZkoTy_U8EzX1Sr8gAWGoebE2aS-L4MriJDP1CDe0u8OL-a3A>
    <xme:Ynz5Ynbov7OJ0hY-cKyGhwG9cpwpk7VqdxaaUiHSz1k20KYUuYi9AQtDKDx1N7LA8
    g4Ei7p2IJCjSBW079Q>
X-ME-Received: <xmr:Ynz5Ym9WuIsaeb3udvGtGwbMMUtABgDs-qHJmnDYu3JB-Lcabg8NR0NQinjOUExOJneUjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeelgffhfeetlefhveffleevfffgtefffeelfedu
    udfhjeduteeggfeiheefteehjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhl
    sehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:Ynz5YmrzW1DXdHOBMMarGRMmX8Ojkzopgoz3591j5a9ghbv16qHr_w>
    <xmx:Ynz5Ynqk02G4VXlIlsxxVPqgKYyodP9QMaz-PVKasgM5gXFFcOertw>
    <xmx:Ynz5YkRAQbqZjWqz1P2ju7YM-sgueUvTme2A3MTypsjpH3zYpWAenA>
    <xmx:Ynz5YkhJtFUN_W2juBDayv_k6aEVvOb5qfk6mQhpc7G-WPJqsr6Y3w>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Aug 2022 18:51:13 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 58C38104A51; Mon, 15 Aug 2022 01:54:15 +0300 (+03)
Date:   Mon, 15 Aug 2022 01:54:15 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: Simplify load_unaligned_zeropad() (was Re: [GIT PULL] Ceph
 updates for 5.20-rc1)
Message-ID: <20220814225415.n546anzvud6sumux@box.shutemov.name>
References: <CAHk-=wh1xHi-WeytuAK1-iSsR0wi=6e4-WgFq6ZPt8Z1mvqoNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh1xHi-WeytuAK1-iSsR0wi=6e4-WgFq6ZPt8Z1mvqoNA@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 14, 2022 at 02:14:08PM -0700, Linus Torvalds wrote:
> On Sun, Aug 14, 2022 at 1:29 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I dug into it some more, and it is really "load_unaligned_zeropad()"
> > that makes clang really uncomfortable.
> >
> > The problem ends up being that clang sees that it's inside that inner
> > loop, and tries very hard to optimize the shift-and-mask that happens
> > if the exception happens.
> >
> > The fact that the exception *never* happens unless DEBUG_PAGEALLOC is
> > enabled - and very very seldom even then - is not something we can
> > really explain to clang.
> 
> Hmm.
> 
> The solution to that is actually to move the 'zeropad' part into the
> exception handler.
> 
> That makes both gcc and clang generate quite nice code for this all.
> But perhaps equally importantly, it actually simplifies the code
> noticeably:
> 
>  arch/x86/include/asm/extable_fixup_types.h |  2 ++
>  arch/x86/include/asm/word-at-a-time.h      | 50 +++---------------------------
>  arch/x86/mm/extable.c                      | 30 ++++++++++++++++++
>  3 files changed, 37 insertions(+), 45 deletions(-)
> 
> and that's with 11 of those 37 new lines being a new block comment.
> 
> It's mainly because now there's no need to worry about
> CONFIG_CC_HAS_ASM_GOTO_OUTPUT in load_unaligned_zeropad(), because the
> asm becomes a simple "address in, data out" thing.
> 
> And to make the fixup code simple and straightforward, I just made
> "load_unaligned_zeropad()" use fixed registers for address and output,
> which doesn't bother the compilers at all, they'll happily adjust
> their register allocation. The code generation ends up much better
> than with the goto and the subtle address games that never trigger
> anyway.
> 
> PeterZ - you've touched both the load_unaligned_zeropad() and the
> exception code last, so let's run this past you, but this really does
> seem to not only fix the code generation issue in fs/dcache.s, it just
> looks simpler too. Comments?

A bit of off-topic, but..

Recently, I dealt with few[1][2] issues in TDX guest that happens due to
unwanted loads generated by load_unaligned_zeropad(). They are tricky to
follow and I believe that most of developers are not aware of such sneaky
accesses (I was not, until stepped on it).

Do we gain enough benefit from the microoptimization to justify existing
load_unaligned_zeropad()? The helper has rather confusing side-effects.

[1] 1e7769653b06 ("x86/tdx: Handle load_unaligned_zeropad() page-cross to a shared page")
[2] https://lore.kernel.org/lkml/20220614120231.48165-11-kirill.shutemov@linux.intel.com/

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
