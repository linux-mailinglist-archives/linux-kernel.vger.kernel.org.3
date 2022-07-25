Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3AD457FF67
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 14:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234864AbiGYM7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 08:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbiGYM7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 08:59:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D86B1FA
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 05:59:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 602DCB80EB1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 12:59:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD26C341C6;
        Mon, 25 Jul 2022 12:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658753952;
        bh=qZ7cSckGA22g2DQPcAkq2U832I1kC6AlyyO4svOJTf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aY6XTKO0rcCik/LByRoaweygcgBFiODLB65LIAIn4VKqiMBf1Gm4WoAnQsenCBE72
         aIjvCNLtIOvlA+RnLyKbgsuwlE8uEZmUalhGt9q4pV3U+f+sefIteBRAOOLJnrabUg
         1qnCumEFUGO97fI+9925QLaGYQqUya365wvI9L0g=
Date:   Mon, 25 Jul 2022 14:59:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        kernel test robot <lkp@intel.com>,
        "Justin M. Forbes" <jforbes@fedoraproject.org>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Jason A. Donenfeld" <zx2c4@kernel.org>
Subject: Re: [linux-stable-rc:linux-5.15.y 6874/8723]
 arch/arm/lib/xor-neon.c:30:2: warning: This code requires at least version
 4.6 of GCC
Message-ID: <Yt6Tm4teRfNEvwcw@kroah.com>
References: <202207250449.BYMZbIA2-lkp@intel.com>
 <Yt3KObFVIUI2mFGt@zx2c4.com>
 <CAMj1kXHTf4f+onREnWhYk-vYXkPaQtPpZz+SqFCP+Ey7+bOXkQ@mail.gmail.com>
 <Yt5Y/cIKIDlyFWMQ@kroah.com>
 <CAMj1kXGPjFAY0y-SPZv64CRhpo9s1+__z4bya86aMcTs9=f8pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMj1kXGPjFAY0y-SPZv64CRhpo9s1+__z4bya86aMcTs9=f8pw@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 02:41:42PM +0200, Ard Biesheuvel wrote:
> On Mon, 25 Jul 2022 at 10:49, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Jul 25, 2022 at 07:42:07AM +0200, Ard Biesheuvel wrote:
> > > On Mon, 25 Jul 2022 at 00:40, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > > >
> > > > Hi Ard,
> > > >
> > > > On Mon, Jul 25, 2022 at 04:14:48AM +0800, kernel test robot wrote:
> > > > > All warnings (new ones prefixed by >>):
> > > > >
> > > > > >> arch/arm/lib/xor-neon.c:30:2: warning: This code requires at least version 4.6 of GCC [-W#warnings]
> > > > >    #warning This code requires at least version 4.6 of GCC
> > > > >     ^
> > > > >    1 warning generated.
> > > > >
> > > > >
> > > > > vim +30 arch/arm/lib/xor-neon.c
> > > > >
> > > > > 01956597cbc46d Ard Biesheuvel 2013-05-17  16
> > > > > 01956597cbc46d Ard Biesheuvel 2013-05-17  17  /*
> > > > > 01956597cbc46d Ard Biesheuvel 2013-05-17  18   * Pull in the reference implementations while instructing GCC (through
> > > > > 01956597cbc46d Ard Biesheuvel 2013-05-17  19   * -ftree-vectorize) to attempt to exploit implicit parallelism and emit
> > > > > 01956597cbc46d Ard Biesheuvel 2013-05-17  20   * NEON instructions.
> > > > > 01956597cbc46d Ard Biesheuvel 2013-05-17  21   */
> > > > > 01956597cbc46d Ard Biesheuvel 2013-05-17  22  #if __GNUC__ > 4 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 6)
> > > > > 01956597cbc46d Ard Biesheuvel 2013-05-17  23  #pragma GCC optimize "tree-vectorize"
> > > > > 01956597cbc46d Ard Biesheuvel 2013-05-17  24  #else
> > > > > 01956597cbc46d Ard Biesheuvel 2013-05-17  25  /*
> > > > > 01956597cbc46d Ard Biesheuvel 2013-05-17  26   * While older versions of GCC do not generate incorrect code, they fail to
> > > > > 01956597cbc46d Ard Biesheuvel 2013-05-17  27   * recognize the parallel nature of these functions, and emit plain ARM code,
> > > > > 01956597cbc46d Ard Biesheuvel 2013-05-17  28   * which is known to be slower than the optimized ARM code in asm-arm/xor.h.
> > > > > 01956597cbc46d Ard Biesheuvel 2013-05-17  29   */
> > > > > 01956597cbc46d Ard Biesheuvel 2013-05-17 @30  #warning This code requires at least version 4.6 of GCC
> > > > > 01956597cbc46d Ard Biesheuvel 2013-05-17  31  #endif
> > > > > 01956597cbc46d Ard Biesheuvel 2013-05-17  32
> > > >
> > > > Does this file need a depends on ≥4.6 thing in Kconfig? Or is something
> > > > else happening here since 4.6 isn't even supported by the kernel these
> > > > days?
> > > >
> > >
> > > Hi Jason,
> > >
> > > This is explained/fixed in
> > >
> > > commit a69cb445f7d129abf7c50d48c8a8eca7c8d5df15
> > > Author: Ard Biesheuvel <ardb@kernel.org>
> > > Date:   Sat Feb 5 16:23:46 2022 +0100
> > >
> > >     crypto: arm/xor - make vectorized C code Clang-friendly
> > >
> > >     The ARM version of the accelerated XOR routines are simply the 8-way C
> > >     routines passed through the auto-vectorizer with SIMD codegen enabled.
> > >     This used to require GCC version 4.6 at least, but given that 5.1 is now
> > >     the baseline, this check is no longer necessary, and actually
> > >     misidentifies Clang as GCC < 4.6 as Clang defines the GCC major/minor as
> > >     well, but makes no attempt at doing this in a way that conveys feature
> > >     parity with a certain version of GCC (which would not be a great idea in
> > >     the first place).
> > >
> > > which landed in v5.18. Note that the patch depends on its parent,
> > > which touches many different architectures, so it may not be
> > > backportable cleanly.
> >
> > I would love to backport this as it bugs me to no end on some various
> > gerrit systems all the time.  I'll look into it later this week unless
> > someone beats me to it :)
> >
> 
> If backporting is an issue, we could just drop this warning - GCC
> before 4.6 hasn't been supported for a while anyway, and Clang never
> had the SIMD accelerated XOR to begin with (it needs the __restrict
> annotations that the parent patch introduces)

I would love to drop the warning, as it triggers when clang tries to
build this file.

thanks,

greg k-h
