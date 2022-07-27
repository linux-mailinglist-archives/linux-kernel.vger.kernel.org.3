Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8780758215A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 09:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiG0Hnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 03:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiG0Hnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 03:43:33 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55982CCB9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 00:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nWI4+bMNRsKZuR1zDo0J/8/VoTTMvpi5bUHrbI3E1Zo=; b=0tUytPCrlUVkYmJJxvNRAhSjw2
        I2k9BcuRSHNV7BmZ/AKiPL/dR9y5r6rI5HKymB67HqmPcGTvU25XO5h3oAtDviFvpFxez0JoJ4f79
        wj5XPYcs0whsVz01AJ35PSpCwbJi+n5NTzUK+EDYCpUgAa+TjXNCYP6GKfhPU/Bizuy+kI/+aacJ0
        jdnegVom9R8V4J1WD3lMjvkjHqJ+Vt7ODkMjudIFQe96SmcXTsMtx9oAsOv4j0FMlsWz3aChVxtad
        l1mbcWnkg0VzwGYVCto+Y8YonPm3xFxsZRRgrgH3fnsewv9Fv0hZq0kIjAT7vk0lqPlBAddvcZ2s9
        o7mQa8aw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33590)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1oGbhV-00053q-Gn; Wed, 27 Jul 2022 08:43:25 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1oGbhS-00026p-OW; Wed, 27 Jul 2022 08:43:22 +0100
Date:   Wed, 27 Jul 2022 08:43:22 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: Re: Linux 5.19-rc8
Message-ID: <YuDsmmAnOsgNDuWQ@shell.armlinux.org.uk>
References: <20220725161141.GA1306881@roeck-us.net>
 <CAHk-=whtGUwJwHUSNsXd4g7cok=n0Zwje7nACp8skh1fa2NtJA@mail.gmail.com>
 <YuAm5h1B6bsrR/9q@fedora>
 <CAHk-=wgYpJTMMxmfbpqc=JVtSK0Zj4b15G=AvEYk6vPNySDSsA@mail.gmail.com>
 <YuAv+lV324G7pmlk@yury-laptop>
 <CAHk-=wg2-j8zocUjurAeg_bimNz7C5h5HDEXKK6PxDmR+DaHRg@mail.gmail.com>
 <YuBEIiLL1xZVyEFl@shell.armlinux.org.uk>
 <CAHk-=wjpYLLoi1m0VRfVoyzGgmMiNwBhQ0XXG0VWwjskcz5Cug@mail.gmail.com>
 <YuCDscyJotkjNQcH@shell.armlinux.org.uk>
 <CAAH8bW-BNfhuXF_2cO+x2Qc51G-DFskFmKw8hzDHhC+3Rn1ZUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAH8bW-BNfhuXF_2cO+x2Qc51G-DFskFmKw8hzDHhC+3Rn1ZUA@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 06:33:55PM -0700, Yury Norov wrote:
> On Tue, Jul 26, 2022 at 5:15 PM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > On Tue, Jul 26, 2022 at 01:20:23PM -0700, Linus Torvalds wrote:
> > > On Tue, Jul 26, 2022 at 12:44 PM Russell King (Oracle)
> > > <linux@armlinux.org.uk> wrote:
> > > >
> > > > Overall, I would say it's pretty similar (some generic perform
> > > > marginally better, some native perform marginally better) with the
> > > > exception of find_first_bit() being much better with the generic
> > > > implementation, but find_next_zero_bit() being noticably worse.
> > >
> > > The generic _find_first_bit() code is actually sane and simple. It
> > > loops over words until it finds a non-zero one, and then does trivial
> > > calculations on that last word.
> > >
> > > That explains why the generic code does so much better than your byte-wise asm.
> > >
> > > In contrast, the generic _find_next_bit() I find almost offensively
> > > silly - which in turn explains why your byte-wide asm does better.
> > >
> > > I think the generic _find_next_bit() should actually do what the m68k
> > > find_next_bit code does: handle the first special word itself, and
> > > then just call find_first_bit() on the rest of it.
> > >
> > > And it should *not* try to handle the dynamic "bswap and/or bit sense
> > > invert" thing at all. That should be just four different (trivial)
> > > cases for the first word.
> >
> > Here's the results for the native version converted to use word loads:
> >
> > [   37.319937]
> >                Start testing find_bit() with random-filled bitmap
> > [   37.330289] find_next_bit:                 2222703 ns, 163781 iterations
> > [   37.339186] find_next_zero_bit:            2154375 ns, 163900 iterations
> > [   37.348118] find_last_bit:                 2208104 ns, 163780 iterations
> > [   37.372564] find_first_bit:               17722203 ns,  16370 iterations
> > [   37.737415] find_first_and_bit:          358135191 ns,  32453 iterations
> > [   37.745420] find_next_and_bit:             1280537 ns,  73644 iterations
> > [   37.752143]
> >                Start testing find_bit() with sparse bitmap
> > [   37.759032] find_next_bit:                   41256 ns,    655 iterations
> > [   37.769905] find_next_zero_bit:            4148410 ns, 327026 iterations
> > [   37.776675] find_last_bit:                   48742 ns,    655 iterations
> > [   37.790961] find_first_bit:                7562371 ns,    655 iterations
> > [   37.797743] find_first_and_bit:              47366 ns,      1 iterations
> > [   37.804527] find_next_and_bit:               59924 ns,      1 iterations
> >
> > which is generally faster than the generic version, with the exception
> > of the sparse find_first_bit (generic was:
> > [   25.657304] find_first_bit:                7328573 ns,    656 iterations)
> >
> > find_next_{,zero_}bit() in the sparse case are quite a bit faster than
> > the generic code.
> 
> Look at find_{first,next}_and_bit results. Those two have no arch version
> and in both cases use generic code. In theory they should be equally fast
> before and after, but your testing says that generic case is slower even
> for them, and the difference is comparable with real arch functions numbers.
> It makes me feel like:
>  - there's something unrelated, like governor/throttling that affect results;
>  - the numbers are identical, taking the dispersion into account.
> 
> If the difference really concerns you, I'd suggest running the test
> several times
> to measure confidence intervals.

Given that the benchmark is run against random bitmaps and with
interrupts enabled, there is going to be noise in the results.

Here's the second run:

[26234.429389]
               Start testing find_bit() with random-filled bitmap
[26234.439722] find_next_bit:                 2206687 ns, 164277 iterations
[26234.448664] find_next_zero_bit:            2188368 ns, 163404 iterations
[26234.457612] find_last_bit:                 2223742 ns, 164278 iterations
[26234.482056] find_first_bit:               17720726 ns,  16384 iterations
[26234.859374] find_first_and_bit:          370602019 ns,  32877 iterations
[26234.867379] find_next_and_bit:             1280651 ns,  74091 iterations
[26234.874107]
               Start testing find_bit() with sparse bitmap
[26234.881014] find_next_bit:                   46142 ns,    656 iterations
[26234.891900] find_next_zero_bit:            4158987 ns, 327025 iterations
[26234.898672] find_last_bit:                   49727 ns,    656 iterations
[26234.912504] find_first_bit:                7107862 ns,    656 iterations
[26234.919290] find_first_and_bit:              52092 ns,      1 iterations
[26234.926076] find_next_and_bit:               60856 ns,      1 iterations

And a third run:

[26459.679524]
               Start testing find_bit() with random-filled bitmap
[26459.689871] find_next_bit:                 2199418 ns, 163311 iterations
[26459.698798] find_next_zero_bit:            2181289 ns, 164370 iterations
[26459.707738] find_last_bit:                 2213638 ns, 163311 iterations
[26459.732224] find_first_bit:               17764152 ns,  16429 iterations
[26460.133823] find_first_and_bit:          394886375 ns,  32672 iterations
[26460.141818] find_next_and_bit:             1269693 ns,  73485 iterations
[26460.148545]
               Start testing find_bit() with sparse bitmap
[26460.155433] find_next_bit:                   40753 ns,    653 iterations
[26460.166307] find_next_zero_bit:            4148211 ns, 327028 iterations
[26460.173078] find_last_bit:                   50017 ns,    653 iterations
[26460.187007] find_first_bit:                7205325 ns,    653 iterations
[26460.193790] find_first_and_bit:              49358 ns,      1 iterations
[26460.200577] find_next_and_bit:               62332 ns,      1 iterations

My gut feeling is that yes, there is some variance, but not on an
order that is significant that would allow us to say "there's no
difference".

find_next_bit results for random are: 2222703, 2206687, 2199418,
which is an average of 2209603 and a variance of around 0.5%.
The difference between this and the single generic figure I have
is on the order of 20%.

I'll do the same with find_first_bit for random: 17722203, 17720726,
and 17764152. Average is 17735694. Variance is around 0.1% or 0.2%.
The difference between this and the single generic figure I have is
on the order of 5%. Not so large, but still quite a big difference
compared to the variance.

find_first_bit for sparse: 7562371, 7107862, 7205325. Average is
7291853. Variance is higher at about 4%. Difference between this and
the generic figure is 0.5%, so this one is not significantly
different.

The best result looks to be find_next_zero_bit for the sparse bitmap
case. The generic code measures 5.5ms, the native code is sitting
around 4.1ms. That's a difference of around 34%, and by just looking
at the range in the figures above we can see this is a significant
result without needing to do the calculations. Similar is true of
find_next_bit for the sparse bitmap.

So, I think the results are significant in most cases and variance
doesn't account for the differences. The only one which isn't is
find_first_bit for the sparse case.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
