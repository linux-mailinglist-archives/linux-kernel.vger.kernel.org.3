Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081AC586E20
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 17:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbiHAPzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 11:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiHAPy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 11:54:56 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BF33DF33
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 08:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dHrWhCMfYLqzOiWjtXMitaQEVxQ2mnXrE1TT3YaAhKA=; b=Vjq8qoEp3iFqxLPYDnFnXbZcOx
        VnItroiiw0SwQj57Vx6tLKt/LoNv4X8EEmmsGX9OEgZxj3yNn3XIZ8+oN+Z9K/m9tVlW3Ry+t2J8l
        bE5zLoWa1ovKlIMZlV/Uv1MBfMTxc7HYSBVjrHZMGvdyoZe54Ue88BYWOMZ9Lnxx9t/xTobcd8ElV
        VuZWchNBz7fiNaInE0FaJg4qQtmB0XYlF0+vdZ+0lPvPUwYfxl1AuFGSDm81LFtJcV7OdVdCAht8t
        2Panm34vY2x83CWXT7xiuvo2GTUkI/nYdzOiGwXjSJBGZBZPvQD4h9pAsm+41cMjtvpRByXf3Wnjd
        g1dPKyIQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33654)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1oIXkp-00027E-Lg; Mon, 01 Aug 2022 16:54:51 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1oIXko-0007Ac-CE; Mon, 01 Aug 2022 16:54:50 +0100
Date:   Mon, 1 Aug 2022 16:54:50 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alexey Klimov <klimov.linux@gmail.com>,
        linux-m68k@lists.linux-m68k.org
Subject: Re: Linux 5.19-rc8
Message-ID: <Yuf3Sg57kbwO9jHa@shell.armlinux.org.uk>
References: <CAHk-=wgYpJTMMxmfbpqc=JVtSK0Zj4b15G=AvEYk6vPNySDSsA@mail.gmail.com>
 <YuAv+lV324G7pmlk@yury-laptop>
 <CAHk-=wg2-j8zocUjurAeg_bimNz7C5h5HDEXKK6PxDmR+DaHRg@mail.gmail.com>
 <YuBEIiLL1xZVyEFl@shell.armlinux.org.uk>
 <CAHk-=wjpYLLoi1m0VRfVoyzGgmMiNwBhQ0XXG0VWwjskcz5Cug@mail.gmail.com>
 <YuCDscyJotkjNQcH@shell.armlinux.org.uk>
 <CAAH8bW-BNfhuXF_2cO+x2Qc51G-DFskFmKw8hzDHhC+3Rn1ZUA@mail.gmail.com>
 <YuDsmmAnOsgNDuWQ@shell.armlinux.org.uk>
 <YuWk3titnOiQACzC@yury-laptop>
 <Yuf1xYLAhCMjwCYT@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yuf1xYLAhCMjwCYT@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 04:48:21PM +0100, Russell King (Oracle) wrote:
> Oh FFS.
> 
> I see you decided off your own back to remove the ARM version of the
> find_bit functions, with NO agreement from the arch maintainer. This
> is not on.

Sorry, my mistake, I'm getting confused with git over conflicts which
aren't making much sense.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
