Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEC3592868
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 06:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiHOEJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 00:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbiHOEJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 00:09:37 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581E913FAC;
        Sun, 14 Aug 2022 21:09:36 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id DF4E73200392;
        Mon, 15 Aug 2022 00:09:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 15 Aug 2022 00:09:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660536572; x=1660622972; bh=M/
        57m3rYinyY8ynL79QTtOnSCaFEbW7dwVUnftQVE3k=; b=O0SWkcq1vcaSezSxnO
        JLrzfTnh9OyhTrO1pzCXfCQO4wbhxcsz5dmztPIjCp2oLhikQq0ZLnwZFx37lQHD
        0Y83gH/uyAj3UgepARLJFiBT1Izg2D6x22M0u8zLjGN+cSlI1GIRmGDOd1hvc96h
        68qpkCQ4PROIwBMmnecbithB6vU+z81cOBDiNvwxWqa7jRApvC5H10QSvZcPEbPt
        ZZDR1779XY4aGiwwmi5bVATI0l1XXsI4OG4dzTLLuqIpZjtGXwiMniEYGUNlONjB
        ae8osU+GhJDrz9QuY2QsQXGgh6l6yY7PtR4nsx8acTFq8QB3HQnRcRDOUz14Af0Y
        dfzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660536572; x=1660622972; bh=M/57m3rYinyY8ynL79QTtOnSCaFE
        bW7dwVUnftQVE3k=; b=uJvA3q5IdFlVVBgCXV5uRf+N7a0/iTEm7Imv8jwCJtYr
        kX6UZsjeArxOK0n44vmS8Q0F9LpYlo8C2abIgSmieudkR8yKy54uaetsvnG8+FFq
        YkFLGeYExaOdPAGNcJNLtqM8UDoTuhv9h2XrvyICVKa/9L9I0RK8o55qcV6qExAs
        QFgp7oK/P3f+dXXcBrx2nh6XhH32qWi6oUpJXEu6hKXdGdxr5LPYsg/z91AskmI5
        0uBRK5VAZuj7MYqDMlpPPUF5gVNKUBnuAytQJKSE9JaTGBHtIfv7SFcmXhjMG6RJ
        8zCdFggvJ8SgmoYDENBeM7Deta2kPzllrQNUlvkpcQ==
X-ME-Sender: <xms:-8b5YkGHOpqVkNo82MsJMOs5WSGIx7JCBMbOI7eRugLP9nLI_myVTg>
    <xme:-8b5YtUYUpamkJe4J40FgcIrj7H5rCRflo67qvSkSNPIlpUw1kBM7KP5oFiryBvgC
    _WwUal9KojJOeFmln4>
X-ME-Received: <xmr:-8b5YuJIAFVKniIDoreI4oEqcYl69wH1X4_QRFhJolP1PSkT7Tn64FKN81ZowUfo14Xg6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:-8b5YmGA1eML-0v6kXuidD3YY9KENNlufSufi701SoOKxwsO_GEdvQ>
    <xmx:-8b5YqWT7oaThEn3L0eF_6PZ89L3W2dx7LeGm3PSJOqf6_cwOzpMoA>
    <xmx:-8b5YpO3PX_3Dk-pafts1RS5qewL8RYFdZFkvvIqPfP7QoZRK9mEyw>
    <xmx:_Mb5YhPVTFd6tG9DHwZ8N46Oza0Guvkt8YquIPVOIGtsuUA51UEOzg>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Aug 2022 00:09:31 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id F0080104A60; Mon, 15 Aug 2022 07:12:32 +0300 (+03)
Date:   Mon, 15 Aug 2022 07:12:32 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mike Rapoport <rppt@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
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
Message-ID: <20220815041232.kypaxhhnvobgb35t@box.shutemov.name>
References: <CAHk-=wh1xHi-WeytuAK1-iSsR0wi=6e4-WgFq6ZPt8Z1mvqoNA@mail.gmail.com>
 <20220814225415.n546anzvud6sumux@box.shutemov.name>
 <CAHk-=wiOqbuzy7xzsLrN8LXKGGUUMH109wcKOXx_PV9PkHa=Zw@mail.gmail.com>
 <CAHk-=whSGBmH7zKvD-=qJLkWPSGZo1cM7GyLH=8cuide7+ri_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whSGBmH7zKvD-=qJLkWPSGZo1cM7GyLH=8cuide7+ri_Q@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 14, 2022 at 08:43:09PM -0700, Linus Torvalds wrote:
> On Sun, Aug 14, 2022 at 3:59 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > If TDX has problems with it, then TDX needs to be fixed. And it's
> > simple enough - just make sure you have a guard page between any
> > kernel RAM mapping and whatever odd crazy page.
> 
> .. thinking about this more, I thought we had already done that in the
> memory initialization code - ie make sure that we always leave a gap
> between any page we mark and any IO memory after it.

ioremap()ed memory should not be a problem as it is not RAM from kernel
PoV and it is separated from memory allocated by buddy allocator.

But DMA buffer can be allocated from general pool of memory. We share it
TDX for I/O too. It does not cause problems as long as direct mapping is
adjusted to map it as shared. #VE handler is already aware of
load_unaligned_zeropad().

So far, so good.

But if somebody would try to be clever -- allocate memory and vmap() as
shared (with proper VMM notification), but leave direct mapping intact --
we have a problem. load_unaligned_zeropad() can step onto private mapping
of the shared memory in direct mapping and crash whole TD guest.

The worst part is that for somebody who is not aware about
load_unaligned_zeropad(), the vmap() trick is totally reasonable approach:
it helps to avoid direct mapping fragmentation. We considered the trick
for one of TDX-specific drivers.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
