Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3480B4D3172
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 16:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbiCIPIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 10:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiCIPIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 10:08:04 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2CF17EDA3;
        Wed,  9 Mar 2022 07:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CJjpvJ4D4oTHJIjBPxT3Y89iE6XRNUaLU9GXpNtInfs=; b=H7OaOGWjz19gTjjW4S4SqlPnjc
        a5h0H3XnKuP2v/h+dtFrdEgwN6wzr7OyrYdu6GA5cvXsD7jhiOiNS9Ul8PC1SMlshTQOpILMLft64
        GvTxp/TgNH2Sv/LnYe1t1H51u2cMSp9bb+ZxnquJgWs8NC9RKKnsz4AqtCEQZDaHHPrsx1B3RyIrK
        KwGdQQuU/0FrDGGzExnbUcqhJS0ETYJKJVwasum8XWSiYeTcUmEhcnRrAi5OFFK6UNGMmjiuj2MxZ
        E3eqMaXoymwhaNJmPv6ZmGvJcOAdW0m8baVUq3xQFSIgkY2Yy4NtKFOuYTbfU5LF4hFb0rAqG2ofU
        mNITWItQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57744)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1nRxu0-0001yY-8z; Wed, 09 Mar 2022 15:07:00 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1nRxtw-000828-Uq; Wed, 09 Mar 2022 15:06:56 +0000
Date:   Wed, 9 Mar 2022 15:06:56 +0000
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
Message-ID: <YijCkHHhpleeADAO@shell.armlinux.org.uk>
References: <CA+G9fYtpy8VgK+ag6OsA9TDrwi5YGU4hu7GM8xwpO7v6LrCD4Q@mail.gmail.com>
 <YiiDZ7jjG38gqP+Q@shell.armlinux.org.uk>
 <CAMj1kXHTdk1Abm7ShoZzrW6EpM9eyFMPSdaa58Ziie4ZMecCnQ@mail.gmail.com>
 <CA+G9fYvCvBBi+dZ+CnUy=ZK6GhCFhBw72_==Cav=Q8QP5T1r5w@mail.gmail.com>
 <CA+G9fYt73AYs=z-BeZh22RBp==sf73pKky6m4iPSH7a4FssK7w@mail.gmail.com>
 <CAMj1kXEFZVeWLaRQJmwO+Nn6uW4q6vXJOaNNTVKju1p2bMQksA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEFZVeWLaRQJmwO+Nn6uW4q6vXJOaNNTVKju1p2bMQksA@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 03:57:32PM +0100, Ard Biesheuvel wrote:
> On Wed, 9 Mar 2022 at 15:44, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >
> > On Wed, 9 Mar 2022 at 19:37, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > >
> > > On Wed, 9 Mar 2022 at 16:16, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >
> > > > On Wed, 9 Mar 2022 at 11:37, Russell King (Oracle)
> > > > <linux@armlinux.org.uk> wrote:
> > > > >
> > > > > On Wed, Mar 09, 2022 at 03:18:12PM +0530, Naresh Kamboju wrote:
> > > > > > While boting linux next-20220308 on BeagleBoard-X15 and qemu arm the following
> > > > > > kernel crash reported which is CONFIG_KASAN enabled build [1] & [2].
> > > > >
> > > > > The unwinder is currently broken in linux-next. Please try reverting
> > > > > 532319b9c418 ("ARM: unwind: disregard unwind info before stack frame is
> > > > > set up")
> >
> > I have reverted the suggested commit and built and boot failed due to reported
> > kernel crash [1].
> >
> > - Naresh
> >
> 
> Thanks Naresh,
> 
> This looks like it might be related to the issue Russell just sent a fix for:
> https://lore.kernel.org/linux-arm-kernel/CAMj1kXEqp2UmsyUe1eWErtpMk3dGEFZyyno3nqydC_ML0bwTLw@mail.gmail.com/T/#t
> 
> Could you please try that?

Well, we unwound until:

 __irq_svc from migrate_disable+0x0/0x70

and then crashed - and the key thing there is that we're at the start
of migrate_disable() when we took an interrupt.

For some reason, this triggers an access to address 0x10, which faults.
We then try unwinding again, and successfully unwind all the way back
to the same point (the line above) which then causes the unwinder to
again access address 0x10, and the cycle repeats with the stack
growing bigger and bigger.

I'd suggest also testing without the revert but with my patch.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
