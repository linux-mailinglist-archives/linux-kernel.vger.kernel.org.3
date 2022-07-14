Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA1E574D3B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 14:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238910AbiGNMOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 08:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239268AbiGNMOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 08:14:33 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C6C2B199
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 05:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8IsG3X6zCfF6DLdWoVTEy5WGlpBO4SysD3lWEtSUkiM=; b=jnnl+pDIp9qmpJESNHT4kZK9Sk
        wv6gsqi+CQ1dQqvqbWqrsgN/o6Q9ZUcR8/t8t37+FaKkyP2/zBN7JmcOK6VorXpf5Mo0ac0epXuBB
        NZRhSYJvIyY4pLELJxngsRsSbUPw/4wbtFdiQzirnWeYOdg7zCPBJFYZhR3uQmAd8apivkpdswyLj
        GgcwVFrNVAMe5RdkExrbtqDc9bUSyUK1i+Y9r4II38IqRnUkPoLJi9a4T41oCq6WfRx0Flki8VxBr
        gosBlbUYIvxyLgmzyGiIBsghk7C2y1P8A30o2qYnP5K3kUC72JqSTR8appZuJpfjT0qhl4AuIbRZ0
        OX/U1diw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33330)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1oBxjP-0005k5-MF; Thu, 14 Jul 2022 13:14:11 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1oBxjJ-0006b8-ND; Thu, 14 Jul 2022 13:14:05 +0100
Date:   Thu, 14 Jul 2022 13:14:05 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <YtAIjVDa7IKRO3JX@shell.armlinux.org.uk>
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net>
 <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
 <Ys8hqoiN5iWbslsM@shell.armlinux.org.uk>
 <CAHk-=wjNxyXQqn=k0KipzUPoBYWQhUwybxee8GTkF_Oz6RPVFw@mail.gmail.com>
 <e63e108b-c99c-9ab7-0638-367b72983b81@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e63e108b-c99c-9ab7-0638-367b72983b81@roeck-us.net>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 01:40:41PM -0700, Guenter Roeck wrote:
> On 7/13/22 13:21, Linus Torvalds wrote:
> > On Wed, Jul 13, 2022 at 12:49 PM Russell King (Oracle)
> > <linux@armlinux.org.uk> wrote:
> > > 
> > > There may be a patch that solves that, but it's never been submitted to
> > > my patch system:
> > > 
> > > https://lore.kernel.org/all/20220524025139.40212-1-wangkefeng.wang@huawei.com/
> > 
> > That patch looks sane to me, but I guess Guenter would need to check
> > ... Guenter?
> > 
> 
> That patch is (and has been) in linux-next for a long time,
> as commit d2ca1fd2bc70, and with the following tags.
> 
>     Fixes: 7719a68b2fa4 ("ARM: 9192/1: amba: fix memory leak in amba_device_try_add()")
>     Reported-by: Guenter Roeck <linux@roeck-us.net>
>     Tested-by: Guenter Roeck <linux@roeck-us.net>
>     Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>     Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> So, yes, it fixes the problem. I don't know where it is pulled from, though.
> I thought that it is from Russell's tree, given his Signed-off-by:,
> but I never really checked.

Ah, yes, it's in the same bracnh as 9192/1. So if Linus is reporting
that 9192/1 is still a problem in linux-next, then this patch does
_not_ fix it.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
