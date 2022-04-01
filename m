Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416D74EF7BB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 18:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243511AbiDAQVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 12:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352183AbiDAQSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 12:18:09 -0400
Received: from gateway22.websitewelcome.com (gateway22.websitewelcome.com [192.185.47.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE581E1131
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 08:41:39 -0700 (PDT)
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 6C7759D0F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 10:41:39 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id aJP9nXPupXvvJaJP9neSfj; Fri, 01 Apr 2022 10:41:39 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:
        To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jYAFnwL/trWc/tMIlxDuzyohVvM2VKCSHxk9x+Omj0s=; b=XyifY4BY2SuYmYWXVgnx1XKJxW
        LJZRjk7WxqQw6djH49Dp/OwHHqZoDQy6U74WAiMvQCOKSOeZgCSfv2ZukuF3qihwgFLB0BamUEwAE
        9s3ecFs3n93DuMTnzLcT/bUoBw/ZXN9s/8X8VfC7nwYvZoKjgV+GXVEMXXOesvXJUTPhAjA3yGYXa
        /5DDY8vwa1sm902VWVIf3GwXIIvdydbEbN3Xh8ez7BZXG3CIJFgp3GSXN6SFmn0pf28TVEltVclAR
        cTTO4+jVWc+rhkdr5S9/dxhvfYXtoVf0yukFMphqor6tfl60rxgHO7NUXU/MhdagY81QZbW8yPLFI
        Lu5y9x4g==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:57806 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1naJP9-004BW2-01; Fri, 01 Apr 2022 15:41:39 +0000
Date:   Fri, 1 Apr 2022 08:41:37 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Helge Deller <deller@gmx.de>
Cc:     James.Bottomley@HansenPartnership.com,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] parisc: Switch from GENERIC_CPU_DEVICES to
 GENERIC_ARCH_TOPOLOGY
Message-ID: <20220401154137.GA3745625@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1naJP9-004BW2-01
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:57806
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 22
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

Hi,

On Thu, Mar 24, 2022 at 07:46:50PM +0100, Helge Deller wrote:
> Switch away from the own cpu topology code to common code which is used
> by ARM64 and RISCV. That will allow us to enable CPU hotplug later on.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>

This patch results in the following traceback when
booting generic-32bit_defconfig - SMP in qemu.

[    9.432811] ------------[ cut here ]------------
[    9.433305] WARNING: CPU: 0 PID: 1 at fs/sysfs/group.c:115 internal_create_group+0x360/0x394
[    9.433825] Modules linked in:
[    9.434267] CPU: 0 PID: 1 Comm: swapper Not tainted 5.17.0-32bit+ #1
[    9.434621] Hardware name: 9000/778/B160L
[    9.434889]
[    9.435014]      YZrvWESTHLNXBCVMcbcbcbcbOGFRQPDI
[    9.435201] PSW: 00000000000001001011111100001111 Not tainted
[    9.435392] r00-03  0004bf0f 114305c0 103518bc 11430600
[    9.435578] r04-07  0000003c 10db3d20 10b27ecc 00000000
[    9.435725] r08-11  106f6c88 00000001 00000000 00000000
[    9.435876] r12-15  10c59000 00000000 00000001 00000000
[    9.436022] r16-19  00000028 00080000 00000000 10db4ad8
[    9.436168] r20-23  0000012c 10eb0a00 106f6c88 00000000
[    9.436314] r24-27  10b27ecc 00000000 00000000 10cf00e0
[    9.436460] r28-31  00000000 ae147af8 114306c0 101a66d8
[    9.436625] sr00-03  00000000 00000000 00000000 00000000
[    9.436785] sr04-07  00000000 00000000 00000000 00000000
[    9.436942]
[    9.437006] IASQ: 00000000 00000000 IAOQ: 1035186c 10351870
[    9.437161]  IIR: 03ffe01f    ISR: 00000000  IOR: 10e02d68
[    9.437307]  CPU:        0   CR30: 1141a010 CR31: 00000000
[    9.437470]  ORIG_R28: 00000000
[    9.437579]  IAOQ[0]: internal_create_group+0x360/0x394
[    9.437753]  IAOQ[1]: internal_create_group+0x364/0x394
[    9.437913]  RP(r2): sysfs_create_group+0x1c/0x2c
[    9.438180] Backtrace:
[    9.438892]  [<103518bc>] sysfs_create_group+0x1c/0x2c
[    9.439116]  [<106f6cb0>] topology_add_dev+0x28/0x38
[    9.439407]  [<101a66d8>] cpuhp_invoke_callback.constprop.0+0xcc/0x17c
[    9.440321]  [<101a68b0>] __cpuhp_setup_state_cpuslocked+0x128/0x210
[    9.440545]  [<101a69c0>] __cpuhp_setup_state+0x28/0x38
[    9.440657]  [<10126fa4>] topology_sysfs_init+0x3c/0x4c
[    9.440795]  [<1018510c>] do_one_initcall+0x68/0x510
[    9.440918]  [<10101420>] kernel_init_freeable+0x1d4/0x268
[    9.441040]  [<10aa7bdc>] kernel_init+0x2c/0x150
[    9.441191]  [<1018201c>] ret_from_kernel_thread+0x1c/0x24
[    9.441574]
[    9.441716] ---[ end trace 0000000000000000 ]---

Reverting the offending commit fixes the problem.
Bisect log is attached.

Guenter

---
# bad: [e8b767f5e04097aaedcd6e06e2270f9fe5282696] Merge tag 'for-linus-5.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml
# good: [d888c83fcec75194a8a48ccd283953bdba7b2550] fs: fix fd table size alignment properly
git bisect start 'HEAD' 'd888c83fcec7'
# good: [2a44cdaa01837355b14b9221e87d75963846296c] Merge tag 'dmaengine-5.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine
git bisect good 2a44cdaa01837355b14b9221e87d75963846296c
# bad: [b8321ed4a40c02054f930ca59d3570caa27bc86c] Merge tag 'kbuild-v5.18-v2' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild
git bisect bad b8321ed4a40c02054f930ca59d3570caa27bc86c
# bad: [93235e3df29c084a37e0daed17801c6adfce4cb6] Merge tag 'v5.18-p1' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
git bisect bad 93235e3df29c084a37e0daed17801c6adfce4cb6
# good: [84b3b8df51e26b8bc2c7178b068ef447473d4609] dt-bindings: pwm: renesas,pwm: Include generic PWM schema
git bisect good 84b3b8df51e26b8bc2c7178b068ef447473d4609
# bad: [a9fe7fa7d874a536e0540469f314772c054a0323] parisc: Fix patch code locking and flushing
git bisect bad a9fe7fa7d874a536e0540469f314772c054a0323
# bad: [95370b4031ec67f9749e5873ae7139a53cc6bf53] parisc: Move store_cpu_topology() into text section
git bisect bad 95370b4031ec67f9749e5873ae7139a53cc6bf53
# good: [ed9794812b0a61f62317991c5c3e6c78749a0bdc] parisc: Detect hppa-suse-linux-gcc compiler for cross-building
git bisect good ed9794812b0a61f62317991c5c3e6c78749a0bdc
# good: [1e93848a385ed2c2df9cb246b073dc8c66d10793] parisc: Ensure set_firmware_width() is called only once
git bisect good 1e93848a385ed2c2df9cb246b073dc8c66d10793
# bad: [62773112acc55d29727465d075fc61ed08a0a532] parisc: Switch from GENERIC_CPU_DEVICES to GENERIC_ARCH_TOPOLOGY
git bisect bad 62773112acc55d29727465d075fc61ed08a0a532
# first bad commit: [62773112acc55d29727465d075fc61ed08a0a532] parisc: Switch from GENERIC_CPU_DEVICES to GENERIC_ARCH_TOPOLOGY
