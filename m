Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52134D0298
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 16:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243708AbiCGPVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 10:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243691AbiCGPVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 10:21:40 -0500
X-Greylist: delayed 1235 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Mar 2022 07:20:45 PST
Received: from gateway24.websitewelcome.com (gateway24.websitewelcome.com [192.185.50.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA888D6B6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 07:20:45 -0800 (PST)
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 6E3CA3111D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 09:00:10 -0600 (CST)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id REqEn6xrJ9AGSREqFnRBzF; Mon, 07 Mar 2022 09:00:08 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dQrC4NPwOH1bBJ1s8Jj8y2mqjLke9bqZ691DQeDyyuw=; b=bZlBLS6zySUXqHuHeg5DwGvuQm
        hzFDmcDTJmfjJiXE0iky04k8rK2YvzWrETBnWlukqnRBGbf/lhY3nbfunMEAEn/wbWqJiV95iX499
        vhwXj8MQyfA+jpS/9xxuNDcjdVM1LUMpQ5rrujdx6lEFHdBt3ePDPgqToHIIgnV3LtZGDoDKrtaVK
        M0v+muupn88rXkNIgnI12zJgY7IDtBRpsy0ueUtD/bdD+RwFkVjYVMYPt+jhoqIL1iJ1YqZBiZKyx
        Fz9kbQfPvfndyf1xlCoFpfSe14YD2Vjg+Dvfy+BeVgSW1mvaeQfCgojN9qswwxKFyazOiAEBL8QeB
        K3p8FTmg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:58898 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nREqE-002RVL-Fw; Mon, 07 Mar 2022 15:00:06 +0000
Date:   Mon, 7 Mar 2022 07:00:04 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.17-rc7
Message-ID: <20220307150004.GA3279416@roeck-us.net>
References: <CAHk-=wjkkYX8OvTv60+XvQkAK4Pg0QC0Hn-4+n7Q0t1+QWw7Sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjkkYX8OvTv60+XvQkAK4Pg0QC0Hn-4+n7Q0t1+QWw7Sw@mail.gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nREqE-002RVL-Fw
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:58898
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 1
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 06, 2022 at 02:41:11PM -0800, Linus Torvalds wrote:
> No surprises this week - we still have a couple of pending things, but
> everything looks under control.
> 
> Knock wood.
> 
> Last week saw the usual number of small fixes all over - with btrfs
> standing out once again. But once again it's not like it's a lot of
> changes, it's just that the rest tends to be pretty small.
> 
> "The rest" in this case is mostly networking (drivers but also some
> core fixes), misc other drivers (gpu and input, with some noise
> elsewhere) and arch updates (mostly devicetree and some kvm fixes, but
> also RISC-V and s390).
> 
> Shortlog appended - and as things stand, I expect that final 5.17 will
> be next weekend unless something surprising comes up.
> 
> Please test,
> 

Build results:
	total: 155 pass: 153 fail: 2
Failed builds:
	powerpc:skiroot_defconfig
	sparc64:allmodconfig
Qemu test results:
	total: 488 pass: 488 fail: 0

Not sure if it adds value at this point to keep reporting details,
but here they are.

Building powerpc:skiroot_defconfig ... failed
--------------
arch/powerpc/kernel/stacktrace.c: In function 'handle_backtrace_ipi':
arch/powerpc/kernel/stacktrace.c:171:9: error: implicit declaration of function 'nmi_cpu_backtrace'

Introduced with commit 1614b2b11fab29 ("arch: Make ARCH_STACKWALK
independent of STACKTRACE"). Discussed at
https://lore.kernel.org/lkml/YeE2VWwHO50gFw9M@hirez.programming.kicks-ass.net/T/

Fix: https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20220212111349.2806972-1-mpe@ellerman.id.au/
The patch is available in linux-next. Comments in patchwork suggest
that it will only be pushed during the next merge window.

---
Building sparc64:allmodconfig ... failed
--------------
Error log:
<stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
sparc64-linux-ld: drivers/memory/omap-gpmc.o: in function `gpmc_probe_generic_child':
omap-gpmc.c:(.text.unlikely+0x14c4): undefined reference to `of_platform_device_create'

Introduced by commit 4cd335dae3cf ("mtd: rawnand: omap2: Prevent invalid
configuration and build error").
Reported: https://lore.kernel.org/lkml/20220219150836.GA1035394@roeck-us.net/T/#t
Fix: https://patchwork.ozlabs.org/project/linux-mtd/patch/20220219193600.24892-1-rogerq@kernel.org/
The patch is available in linux-next.

That, and the persistent terrible shape of linux-next, makes me wonder
if we need some kind of pre-commit and/or pre-push validation system.

Guenter
