Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28284D8C52
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 20:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244009AbiCNT0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 15:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236868AbiCNT0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 15:26:35 -0400
Received: from gateway22.websitewelcome.com (gateway22.websitewelcome.com [192.185.47.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1393A71B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 12:25:24 -0700 (PDT)
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id E7BFA46683
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 14:25:23 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id TqJnnTqzeRnrrTqJnn2CDJ; Mon, 14 Mar 2022 14:25:23 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zNmz/LR/MxmiKfkxA1NwrfrYM9Lyxf6My9NCY5jjoMc=; b=BetTZVPpINsPU13l8qAkbxFpvv
        VesVoWDG3bqIADW2WYjm0BwAimzas3BhTLGACwCq/olx5qP2p29wwaLr9Iusj6+Hk/UiwS4cc5kDD
        TMcCeCpUZqfcPo47XycMKPFye44p8WPhHz5MRPs5D9LAtIBBb0uqhz0q4NmjHIfGkVSaZ0PREAnys
        Rz+IqSx8/XShy1K5IocAYUYKEDiM2gWsfzxY2Hl9CzyJCQnTw0Nxzp2s/wxJlDfw4edtrfH3zByza
        l3t+hQK7lhseHcnImHmA955lbjD964M4y5LVRdHt14/1pdhFujTzVeWXmkKbmcjh4CdRaKkkPBNb+
        C0W9Rl/w==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:57458 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nTqJn-0007K2-Eh; Mon, 14 Mar 2022 19:25:23 +0000
Date:   Mon, 14 Mar 2022 12:25:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marcelo Roberto Jimenez <marcelo.jimenez@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: Linux 5.17-rc8
Message-ID: <20220314192522.GA3031157@roeck-us.net>
References: <CAHk-=wiHa0vsZseZES=1T0rJ4Z_bC5cwHMUJfqFL9hVpvB283g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiHa0vsZseZES=1T0rJ4Z_bC5cwHMUJfqFL9hVpvB283g@mail.gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nTqJn-0007K2-Eh
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:57458
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 3
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 13, 2022 at 01:43:59PM -0700, Linus Torvalds wrote:
> So last weekend, I thought I'd be releasing the final 5.17 today.
> 
[ ... ]

> Anyway, let's not keep the testing _just_ to automation - the more the
> merrier, and real-life loads are always more interesting than what the
> automation farms do. So please do give this last rc a quick try,
> 

Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 488 pass: 484 fail: 4
Failed tests:
	arm:imx25-pdk:imx_v4_v5_defconfig:nonand:mem128:net,default:imx25-pdk:initrd
	arm:imx25-pdk:imx_v4_v5_defconfig:nonand:sd:mem128:net,default:imx25-pdk:rootfs
	arm:imx25-pdk:imx_v4_v5_defconfig:nonand:usb0:mem128:net,default:imx25-pdk:rootfs
	arm:imx25-pdk:imx_v4_v5_defconfig:nonand:usb1:mem128:net,default:imx25-pdk:rootfs

This is a new problem. It bisects to commit fc328a7d1fcc ("gpio: Revert
regression in sysfs-gpio (gpiolib.c)"). The network connection fails
in the affected tests. Reverting the offending commit (ie reverting the
revert) fixes the problem.

Guenter


---
# bad: [09688c0166e76ce2fb85e86b9d99be8b0084cdf9] Linux 5.17-rc8
# good: [ea4424be16887a37735d6550cfd0611528dbe5d9] Merge tag 'mtd/fixes-for-5.17-rc8' of git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux
git bisect start 'HEAD' 'ea4424be1688'
# bad: [55b4083b44361d833c93216a619d3b4e6d03a0c9] Merge tag 'soc-fixes-5.17-3' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
git bisect bad 55b4083b44361d833c93216a619d3b4e6d03a0c9
# good: [36168e387fa7d0f1fe0cd5cf76c8cea7aee714fa] ARM: Do not use NOCROSSREFS directive with ld.lld
git bisect good 36168e387fa7d0f1fe0cd5cf76c8cea7aee714fa
# bad: [1db333d9a51f3459fba1bcaa564d95befe79f0b3] Merge tag 'spi-fix-v5.17-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi
git bisect bad 1db333d9a51f3459fba1bcaa564d95befe79f0b3
# good: [b5521fe9a9336caa1caa2db126f1d3ba1bc8303e] Merge tag 'xsa396-5.17-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip
git bisect good b5521fe9a9336caa1caa2db126f1d3ba1bc8303e
# bad: [55d01c98a88b346e217eaa931b32e7baea905c9a] gpio: sim: fix a typo
git bisect bad 55d01c98a88b346e217eaa931b32e7baea905c9a
# bad: [660c619b9d7ccd28648ee3766cdbe94ec7b27402] gpiolib: acpi: Convert ACPI value of debounce to microseconds
git bisect bad 660c619b9d7ccd28648ee3766cdbe94ec7b27402
# bad: [fc328a7d1fcce263db0b046917a66f3aa6e68719] gpio: Revert regression in sysfs-gpio (gpiolib.c)
git bisect bad fc328a7d1fcce263db0b046917a66f3aa6e68719
# good: [5f84e73f9a8f14b95115b0eb2080da6d9fa7a82e] gpio: tegra186: Add IRQ per bank for Tegra241
git bisect good 5f84e73f9a8f14b95115b0eb2080da6d9fa7a82e
# first bad commit: [fc328a7d1fcce263db0b046917a66f3aa6e68719] gpio: Revert regression in sysfs-gpio (gpiolib.c)
