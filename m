Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8E9585C99
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 01:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbiG3XQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 19:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbiG3XQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 19:16:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA6365F5
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 16:16:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7E3260FCB
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 23:16:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C887C433C1;
        Sat, 30 Jul 2022 23:16:05 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="SUdHm9Vd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1659222963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AzCdRPj05yjL8h85+6gig1pAniprat2lIv4CqlJ0538=;
        b=SUdHm9VdcBySkgCGqKK/SvTxdxaNdVZYwa4T1eNvhkLbUlm7F3tOQ3EUNsh2phAGbQZx2K
        VBQPiV/0m3zyeXpM22Lvzg5igCOEd8/snd4QY65ABaVLJjBe5TyR+HHiFg1q+GpSAmuq2k
        zigzuYJno3uB5FW3QMZon4YKaeGjwMs=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f4e515bd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sat, 30 Jul 2022 23:16:03 +0000 (UTC)
Date:   Sun, 31 Jul 2022 01:15:59 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        kernel test robot <lkp@intel.com>,
        "Justin M. Forbes" <jforbes@fedoraproject.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Jason A. Donenfeld" <zx2c4@kernel.org>
Subject: Re: [linux-stable-rc:linux-5.15.y 6874/8723]
 arch/arm/lib/xor-neon.c:30:2: warning: This code requires at least version
 4.6 of GCC
Message-ID: <YuW7r1pyBAeNKlPG@zx2c4.com>
References: <202207250449.BYMZbIA2-lkp@intel.com>
 <Yt3KObFVIUI2mFGt@zx2c4.com>
 <CAMj1kXHTf4f+onREnWhYk-vYXkPaQtPpZz+SqFCP+Ey7+bOXkQ@mail.gmail.com>
 <Yt5Y/cIKIDlyFWMQ@kroah.com>
 <CAMj1kXGPjFAY0y-SPZv64CRhpo9s1+__z4bya86aMcTs9=f8pw@mail.gmail.com>
 <CAK8P3a0g4NT1oDW5gq7YO540Eo0UDoqbK1tmtb8QHteiDNXj5Q@mail.gmail.com>
 <CAK8P3a2ZfEr+4OWWteZHpDYGw8U0dQgMfF_OFwQDEtY=GaTfQA@mail.gmail.com>
 <YuVBOOrdoBDUhRxJ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YuVBOOrdoBDUhRxJ@kroah.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 30, 2022 at 04:33:28PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Jul 25, 2022 at 04:35:38PM +0200, Arnd Bergmann wrote:
> > On Mon, Jul 25, 2022 at 2:55 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > 
> > > The other easy workaround would be to just turn off the xor-neon code
> > > when building with clang, e.g. using this Makefile hack:
> > >
> > > diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
> > > index 6d2ba454f25b..8e4fe6421dd2 100644
> > > --- a/arch/arm/lib/Makefile
> > > +++ b/arch/arm/lib/Makefile
> > > @@ -43,8 +43,10 @@ endif
> > >  $(obj)/csumpartialcopy.o:      $(obj)/csumpartialcopygeneric.S
> > >  $(obj)/csumpartialcopyuser.o:  $(obj)/csumpartialcopygeneric.S
> > >
> > > +ifdef CONFIG_CC_IS_CLANG
> > >  ifeq ($(CONFIG_KERNEL_MODE_NEON),y)
> > >    NEON_FLAGS                   := -march=armv7-a -mfloat-abi=softfp -mfpu=neon
> > >    CFLAGS_xor-neon.o            += $(NEON_FLAGS)
> > >    obj-$(CONFIG_XOR_BLOCKS)     += xor-neon.o
> > >  endif
> > > +endif
> > 
> > Nevermind, this does not actually work. Just turning off the warning
> > is probably best then, as actually disabling this code would still
> > be invasive not do much beyond saving a little bit of kernel .text size.
> 
> Ok, if it triggers again, and I get annoyed, I'll write a patch,
> otherwise I'll just leave it alone unless someone else wants to send it
> to me...

The patch is trivial, if your idea is just to remove the #warning,
right? Might as well just do it now and get it over with.

Jason
