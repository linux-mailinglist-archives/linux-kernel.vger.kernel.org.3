Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8BD8574D53
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 14:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238911AbiGNMU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 08:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238850AbiGNMUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 08:20:50 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0A83A4BC
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 05:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3ZwteaP4NnrDJ+pme08P/9gfb4eLG/+pqy4tLFWFnzA=; b=QOv58TMYcmxUyS6UiJ7BnIiiKt
        BuKeR2bXbIJea1RuS2ywAiSh4CrY1ftuzQ1kgxypa+bWwr4Knu+1U4Gl3F9RvD5HBVRNuqOCi6qMP
        op2zsevbvDPqe14yPqg+jNOLVmdsiaq5xuAjDjHVWG9r2v0eo51xZPfFkcUGSy1eqWktsQ/8uDV6E
        RjK0z9/fAxxersZPCCUVdD2HUNplnVAaTtmQ640zhlQRiXrsFoJljFckvvDIEYwULcEihJxgT4IxN
        kjLTs41Gt/3bQ+GDElnAvRn/k17ieHOf0PFMn4apLVapgSf1KUUrdrTfAl8laypddwx48Pf02t+rQ
        +j+UuMaQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33332)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1oBxpe-0005ka-77; Thu, 14 Jul 2022 13:20:38 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1oBxpc-0006bM-NC; Thu, 14 Jul 2022 13:20:36 +0100
Date:   Thu, 14 Jul 2022 13:20:36 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Paul Mackerras <paulus@ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: Linux 5.19-rc6
Message-ID: <YtAKFNgeC1vXjHYI@shell.armlinux.org.uk>
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net>
 <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
 <Ys8hqoiN5iWbslsM@shell.armlinux.org.uk>
 <CAHk-=wjNxyXQqn=k0KipzUPoBYWQhUwybxee8GTkF_Oz6RPVFw@mail.gmail.com>
 <e63e108b-c99c-9ab7-0638-367b72983b81@roeck-us.net>
 <CAHk-=wh-SE=s+bJq_jwuQ6zfnifaAwYdXikpXo8iZ4JbbNph4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh-SE=s+bJq_jwuQ6zfnifaAwYdXikpXo8iZ4JbbNph4Q@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 01:42:15PM -0700, Linus Torvalds wrote:
> On Wed, Jul 13, 2022 at 1:40 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > That patch is (and has been) in linux-next for a long time,
> > as commit d2ca1fd2bc70, and with the following tags.
> >
> >      Fixes: 7719a68b2fa4 ("ARM: 9192/1: amba: fix memory leak in amba_device_try_add()")
> >      Reported-by: Guenter Roeck <linux@roeck-us.net>
> >      Tested-by: Guenter Roeck <linux@roeck-us.net>
> >      Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> >      Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> >
> > So, yes, it fixes the problem. I don't know where it is pulled from, though.
> > I thought that it is from Russell's tree, given his Signed-off-by:,
> > but I never really checked.
> 
> Heh. Yeah, with that sign-off, I bet it's in Russell's queue, bit it
> just ended up in the "for next release" branch. Russell?

Oh, I see, I never rebased my "misc" branch from the last cycle, so it
looks to me like 9192/1 was due for _this_ merge window - so I merged
the fix for it into that same branch, rather than the "fixes" branch.
I've moved it over to the correct branch now.

Looks like there's another fix that's in that very same state as well.

Expect a pull request shortly.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
