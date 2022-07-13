Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A81573D59
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 21:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236845AbiGMTt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 15:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiGMTt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 15:49:26 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB11026102
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 12:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vLDEqhzo2TaQVwqjUuNT+W0GxvNmOEUkAw73oQRdZgM=; b=qDvNOAgq0NAckeNXodpxM/2sNr
        XXzohI48XYlUc+QzgVkHAnsxXPEJg+UhJnJE5agvMXCyZ625ZYkSmBLlspeiq2dwlhGP5Mdu254xX
        6gCqzUM7W/dnCtlkzn81TGJDdGyHihRArgI+6HXun7sZt9ZeWfgibhRFyIi1tVkOAT8Re7GFzYequ
        6WUJX8AyDSwz0qBFhRuS7fGa12F4/O9Eo58PZk6qxHslGQRaBz7zlDYk2Tlj2Gn8oj9j+rrmCiAIf
        WKY9w3ykUJazd4lNTqPSarhmuCkaHngOBXqizVrRrlLUG0qF6U/BuidZJf4XuoWPy5Bxf5XzcZEAR
        uMe+3n1A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33320)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1oBiM4-0004yJ-0v; Wed, 13 Jul 2022 20:49:04 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1oBiLy-0005vT-Po; Wed, 13 Jul 2022 20:48:58 +0100
Date:   Wed, 13 Jul 2022 20:48:58 +0100
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
Message-ID: <Ys8hqoiN5iWbslsM@shell.armlinux.org.uk>
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net>
 <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 12:36:50PM -0700, Linus Torvalds wrote:
> On Tue, Jul 12, 2022 at 10:07 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > OF: amba_device_add() failed (-19) for /amba/smc@10100000
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 1 at lib/refcount.c:28 of_platform_bus_create+0x33c/0x3dc
> > refcount_t: underflow; use-after-free.
> 
> This too has been going on since -rc1, but it's not obvious what caused it.
> 
> At a guess, looking around the amba changes, I'm assuming it's
> 
>   7719a68b2fa4 ("ARM: 9192/1: amba: fix memory leak in amba_device_try_add()")
> 
> Does reverting that commit make it go away?

There may be a patch that solves that, but it's never been submitted to
my patch system:

https://lore.kernel.org/all/20220524025139.40212-1-wangkefeng.wang@huawei.com/

I'm sorry, but I'm utterly crap at picking up patches off mailing lists,
so if stuff doesn't end up inthe patch system, it gets missed.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
