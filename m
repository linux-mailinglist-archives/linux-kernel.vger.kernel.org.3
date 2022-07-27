Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591B7581CBA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 02:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240041AbiG0AP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 20:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiG0AP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 20:15:56 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5326819C2E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 17:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2T3hUKFNgtBW8OumyrTKwgozBtxLREQ5SuTUmSurTyM=; b=Qvbv1ZKqlbGOonvYL7mDWLSOHx
        2LeMGAHEXGQJtPNZMvoA23P7UJXDwFyqWax0qYqy9SYdaKjVihDm7p4HWTDjzNDFxXW88rpl8dxI9
        8Hd0h9ygt82QIRfJXlbTS0MrDszmrDrHwZGM9m8g1ndAD9V15M3nKCiZ+xLgn3hkfcoKxRni9XAFW
        P9p2zWNfr8gwQp1oNtVSm6opL9RIaGE9s9zSShCGfn9ChBZaH3uddav9SvwBa798HUsSghJ2ztto9
        EcWeaC31Bx+P7yrXQ/tw6qDwILk7yogVPm3v3CeW0Z+QMUPz+Gq473hmJl+NE1qaZHj4zJGQwrZVp
        9MkhKmkQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33582)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1oGUiL-0004hF-9q; Wed, 27 Jul 2022 01:15:49 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1oGUiH-0001iU-DX; Wed, 27 Jul 2022 01:15:45 +0100
Date:   Wed, 27 Jul 2022 01:15:45 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Yury Norov <yury.norov@gmail.com>, Dennis Zhou <dennis@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: Re: Linux 5.19-rc8
Message-ID: <YuCDscyJotkjNQcH@shell.armlinux.org.uk>
References: <CAHk-=wiWwDYxNhnStS0e+p-NTFAQSHvab=2-8LwxunCVuY5-2A@mail.gmail.com>
 <20220725161141.GA1306881@roeck-us.net>
 <CAHk-=whtGUwJwHUSNsXd4g7cok=n0Zwje7nACp8skh1fa2NtJA@mail.gmail.com>
 <YuAm5h1B6bsrR/9q@fedora>
 <CAHk-=wgYpJTMMxmfbpqc=JVtSK0Zj4b15G=AvEYk6vPNySDSsA@mail.gmail.com>
 <YuAv+lV324G7pmlk@yury-laptop>
 <CAHk-=wg2-j8zocUjurAeg_bimNz7C5h5HDEXKK6PxDmR+DaHRg@mail.gmail.com>
 <YuBEIiLL1xZVyEFl@shell.armlinux.org.uk>
 <CAHk-=wjpYLLoi1m0VRfVoyzGgmMiNwBhQ0XXG0VWwjskcz5Cug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjpYLLoi1m0VRfVoyzGgmMiNwBhQ0XXG0VWwjskcz5Cug@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 01:20:23PM -0700, Linus Torvalds wrote:
> On Tue, Jul 26, 2022 at 12:44 PM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > Overall, I would say it's pretty similar (some generic perform
> > marginally better, some native perform marginally better) with the
> > exception of find_first_bit() being much better with the generic
> > implementation, but find_next_zero_bit() being noticably worse.
> 
> The generic _find_first_bit() code is actually sane and simple. It
> loops over words until it finds a non-zero one, and then does trivial
> calculations on that last word.
> 
> That explains why the generic code does so much better than your byte-wise asm.
> 
> In contrast, the generic _find_next_bit() I find almost offensively
> silly - which in turn explains why your byte-wide asm does better.
> 
> I think the generic _find_next_bit() should actually do what the m68k
> find_next_bit code does: handle the first special word itself, and
> then just call find_first_bit() on the rest of it.
> 
> And it should *not* try to handle the dynamic "bswap and/or bit sense
> invert" thing at all. That should be just four different (trivial)
> cases for the first word.

Here's the results for the native version converted to use word loads:

[   37.319937]
               Start testing find_bit() with random-filled bitmap
[   37.330289] find_next_bit:                 2222703 ns, 163781 iterations
[   37.339186] find_next_zero_bit:            2154375 ns, 163900 iterations
[   37.348118] find_last_bit:                 2208104 ns, 163780 iterations
[   37.372564] find_first_bit:               17722203 ns,  16370 iterations
[   37.737415] find_first_and_bit:          358135191 ns,  32453 iterations
[   37.745420] find_next_and_bit:             1280537 ns,  73644 iterations
[   37.752143]
               Start testing find_bit() with sparse bitmap
[   37.759032] find_next_bit:                   41256 ns,    655 iterations
[   37.769905] find_next_zero_bit:            4148410 ns, 327026 iterations
[   37.776675] find_last_bit:                   48742 ns,    655 iterations
[   37.790961] find_first_bit:                7562371 ns,    655 iterations
[   37.797743] find_first_and_bit:              47366 ns,      1 iterations
[   37.804527] find_next_and_bit:               59924 ns,      1 iterations

which is generally faster than the generic version, with the exception
of the sparse find_first_bit (generic was:
[   25.657304] find_first_bit:                7328573 ns,    656 iterations)

find_next_{,zero_}bit() in the sparse case are quite a bit faster than
the generic code.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
