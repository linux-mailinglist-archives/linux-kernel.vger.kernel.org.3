Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6264D5444
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 23:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344206AbiCJWKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 17:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343815AbiCJWKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 17:10:40 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29504DA87C;
        Thu, 10 Mar 2022 14:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=n6DIoThXu6+2o1MnVoANgPmGbVAPFUq9XQ9ZlvmYihM=; b=svgcWFlC7tHQ4R+LvnKXqtgZtW
        odGemenDWx2KeCUZx3WC3v3olcCJV73vy7HM9BT2Ec0cDz/8BADaQUSn+mjZIMH9WM/v8O38MMwd1
        GvI4e+XOlhkjsqRR8qOyv/gElZDz13MW6yFbplaGOvNKMvWct2ni2gIbMmrU0f5JC6/HI75LsczPm
        o7mvs+3WWcbtUczqBxxVOljqZi+srtZ2mIMqLdiU+IXmmymMQzn5kP9suKZyvS1LHdhOzXiOjhtS0
        Fvt92G12OPL6it1IdiQbEdsqu8hVmvhbfXU/mumi7n3Ndjjd2zugyrSTlekVmX6alP6vA4edIreyr
        Og6UkRJw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57780)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1nSQyQ-0001jL-N3; Thu, 10 Mar 2022 22:09:31 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1nSQyO-0000xj-3P; Thu, 10 Mar 2022 22:09:28 +0000
Date:   Thu, 10 Mar 2022 22:09:28 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [next] arm: Internal error: Oops: 5 PC is at
 __read_once_word_nocheck
Message-ID: <Yip3GJDbJIYNeg44@shell.armlinux.org.uk>
References: <CAMj1kXE02HH7vRUjF3iKAL+1idKTy-oOYyGnBd3g90m6eObBxg@mail.gmail.com>
 <YikByJteDEtKi4Xv@shell.armlinux.org.uk>
 <CAMj1kXGnwbe=YYWaRxaXioEfTJOdXg9JYcNddO8iifpWLRZCWg@mail.gmail.com>
 <Yinwq3Z9l0selLLS@shell.armlinux.org.uk>
 <Yin2jQqW+pUWJZ7E@shell.armlinux.org.uk>
 <CAMj1kXGkUJ=-4oA4GvBZNK94A1MrZ7UwKDN_tJRgwq8KF06VmA@mail.gmail.com>
 <CA+G9fYvEANOMekjvtu7agdVYQ_b8OMtxQdyAV2JT_vMdBU3VRA@mail.gmail.com>
 <CAMj1kXEVVZTKX_86bbTfLpFuDriV0-uwCMgSKDP+dzcD1L4XCw@mail.gmail.com>
 <CA+G9fYuO-sy+sZnhSz=A7Xm0LdSp2AT+7jCKLB33tZzK4izj3g@mail.gmail.com>
 <CAMj1kXGb_0FNU7capJEDWTZF2OegmZyBphhH8GuNqL7+YYLjZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGb_0FNU7capJEDWTZF2OegmZyBphhH8GuNqL7+YYLjZQ@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 11:06:17PM +0100, Ard Biesheuvel wrote:
> On Thu, 10 Mar 2022 at 22:50, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >
> > On Fri, 11 Mar 2022 at 02:55, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Thu, 10 Mar 2022 at 22:18, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > > >
> > > > Hi Ard and Russell,
> > > >
> > > > The boot test pass on linux next-20220310 tag with  KASAN=y on BeagleBoard x15
> > > > device. but LTP cve tests reproduced the reported kernel crash  [1].
> > > > From the available historical data I can confirm that this is an
> > > > intermittent issue on
> > > > BeagleBoard x15 devices.
> > > >
> > > > OTOH, the kernel crash is always reproducible on qemu-arm with KASAN=y
> > > > while booting which has been known to fail for a long time.
> > > >
> > > > From the Ardb tree I have boot tested qemu-arm with KASAN=y the reported
> > > > kernel crash is always reproducible.
> > > >
> > > > The build steps [3] and extra Kconfigs.
> > > >
> > > > - Naresh
> > > > [1] https://lkft.validation.linaro.org/scheduler/job/4701310
> > > > [2] https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/
> > > > [3] https://builds.tuxbuild.com/2661dIAPUjE2DMJvye91He2gus0/tuxmake_reproducer.sh
> > >
> > > Thanks Naresh. I'm having trouble to make sense of this, though. The
> > > linked output log appears to be from a build that lacks my 'ARM:
> > > entry: fix unwinder problems caused by IRQ stacks' patch, as it
> > > doesn't show any occurrences of call_with_stack() on any of the call
> > > stacks.
> > >
> > > Do you have a link to the vmlinux and zImage files for this build?
> >
> > Yes.
> >
> > vmlinux.xz:  https://builds.tuxbuild.com/26BmIasJnAyCii0SkgbKarkF369/vmlinux.xz
> > zImage: https://builds.tuxbuild.com/26BmIasJnAyCii0SkgbKarkF369/zImage
> > System.map: https://builds.tuxbuild.com/26BmIasJnAyCii0SkgbKarkF369/System.map
> > Build log: https://builds.tuxbuild.com/26BmIasJnAyCii0SkgbKarkF369/
> >
> 
> This kernel does not appear to have
> 
> ARM: unwind: set frame.pc correctly for current-thread unwinding
> ARM: entry: fix unwinder problems caused by IRQ stacks
> ARM: Revert "unwind: dump exception stack from calling frame"
> 
> so it is expected that the same issue is still being observed.
> 
> Could you please try -next with those patches applied?

I concur, from my inspection of the above referenced vmlinux file.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
