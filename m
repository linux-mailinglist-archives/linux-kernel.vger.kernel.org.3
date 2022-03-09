Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319864D272B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiCIBTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 20:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbiCIBS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:18:27 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92CF12E17D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 17:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NUm+eI6I7vXUsufLZj3Ybgr0AUlu0fM8Z9nEWhEtbG4=; b=J2BvjLjQK+kQUeBycrbQzD2N01
        A0P8NwaE/jEcHIfpsidYyEwAeE8FMX11IhtmE+1KgjrRosjKJVQn5rpovGCyA4IvS4GS3GepULNK/
        UB5BNggxnhRB6wzPMjwJKYlql7mW/PYlYh99BLVYWlBM7CFK4wtG88BpBFGvNQS7a8cFGcGSXA+rt
        wJFoXSaWRY63BKrmoxjDnAV3Ajz9PW0Yg4L8ncfnuhEqQLZFYXyHB6AKHNhNLCFaF8mLsjsTk9Ss2
        k8GRAIVPNCqoXbRgNaodtHvNAjBaq9pjIaTkFhEVLPEASrihE96DwNWHuD2ymD9PlD9U8UaJAZwy3
        sUZQyoMg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57732)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1nRkoN-0001C5-Et; Wed, 09 Mar 2022 01:08:19 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1nRkoL-0007Or-U2; Wed, 09 Mar 2022 01:08:17 +0000
Date:   Wed, 9 Mar 2022 01:08:17 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: boot flooded with unwind: Index not found
Message-ID: <Yif+AY3DShT9Z6Q+@shell.armlinux.org.uk>
References: <CAMj1kXEy6n3zZ8Z51kP=tTuOU0xCXLLfC-b6BMpdsjMoM7zGBg@mail.gmail.com>
 <Yh8tWdiWPgZLyQtx@Red>
 <CAMj1kXGRtdftpoqmd7HBonBBS67jO=YWzoESPAagGfQBZUDQWg@mail.gmail.com>
 <Yh8w7ldudhmbYv4N@Red>
 <CAMj1kXHri2_tnYhu2gE9xTUOxLY9v1=zODCo1BGfjFTKukiedA@mail.gmail.com>
 <Yh9CbcrfDvN2Z9Y9@Red>
 <Yh9RI64fThQfnJgS@shell.armlinux.org.uk>
 <CAMj1kXGVwXzAAyDeJqAi+eK1hOB3uShiBb_LORL-_YNvikbsAw@mail.gmail.com>
 <Yh9TdbWwHX/5Bhmt@shell.armlinux.org.uk>
 <YifuVmkcb1ie7bzk@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YifuVmkcb1ie7bzk@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 12:01:26AM +0000, Russell King (Oracle) wrote:
> To reinterate what I've just put on IRC - we have not got to the bottom
> of this problem yet - it still very much exists.
> 
> There seems to be something of a fundamental issue with the unwinder,
> it now appears to be going wrong and failing to unwind beyond a
> couple of functions, and the address it's coming out with appears to
> be incorrect. I've only just discovered this because I created my very
> own bug, and yet again, the timing sucks with the proximity of the
> merge window.
> 
> I'm getting:
> 
> [   13.198803] [<c0017728>] (unwind_backtrace) from [<c0012828>] (show_stack+0x10/0x14)
> [   13.198820] [<c0012828>] (show_stack) from [<c2be78d4>] (0xc2be78d4)
> 
> for the WARN_ON() stacktrace, and that address that apparently called
> show_stack() is most definitely rubbish and incorrect. This makes any
> WARN_ON() condition undebuggable.
> 
> This is with both 9183/1 and 9184/1 applied on top of pulling your
> "arm-ftrace-for-rmk" tag and also with just the "arm-vmap-stacks-v6"
> tag. This seems to point at one of these patches breaking the
> unwinder:
> 
> a1c510d0adc6 ARM: implement support for vmap'ed stacks
> 532319b9c418 ARM: unwind: disregard unwind info before stack frame is set up

The above commit appears to be what's breaking the unwinder. Without
this I get sane stacktraces. With it, the unwinder spits out stupid
function addresses.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
