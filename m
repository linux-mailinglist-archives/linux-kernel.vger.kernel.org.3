Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD994EF868
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 18:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350210AbiDAQyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 12:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350124AbiDAQyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 12:54:25 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B2632F;
        Fri,  1 Apr 2022 09:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648831664;
        bh=0HyeYomZ5lOTsyyinxOGGIQHC79+DqNRtDL7kyL00Gc=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=U+ib/KRkZD2UQiBIbjX5gWIV/HxybAYB+kRXomYSGeIHKRAiVl2Pb45LiLITXQ0u9
         KVeLbRAseTrRs8vB3/tODpNwQiSdfd2UT5H4oY8fHfb5heHgrJNXqr9g5vWQvyBian
         gF88C2PLKFHcBpbgBCKz4kJ5iD/VIcsdUtHvzFIg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.191.12]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mlf0K-1oHseD3VcA-00iiBC; Fri, 01
 Apr 2022 18:47:43 +0200
Message-ID: <57e79014-25e6-62d3-27de-64797e43992b@gmx.de>
Date:   Fri, 1 Apr 2022 18:47:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] parisc: Switch from GENERIC_CPU_DEVICES to
 GENERIC_ARCH_TOPOLOGY
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     James.Bottomley@HansenPartnership.com,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220401154137.GA3745625@roeck-us.net>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220401154137.GA3745625@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AUAkjhZqRwH5cIANaEeAWyrzouHzqYmAl4Pz9AxvpHeccyoiAM7
 vyZyDYmwC8TunWSgXVMuw4pcqyvZHKJnq1CO08WG9cFoQY0tz2zS1Kbc8K3fiCYjJ/klGBP
 qgEjXotP5V8xrw+mFCIlgePwSDr7jxsL6W/RXLyqs1HEaT4iZGQ/SFbIdrDmYG2O8pbS6ev
 I3jYVSMiYQfx8Neh7K+8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XsIaF4vLPeo=:ZIIj0aimVzR6jSmvruEIMy
 zyd5N8sOMgsjl71aN2Br12C8iIrFYT+VbyS1HERVZ6jTUzahaD3hD18clfT+kLzVPllKkiDrm
 BOO8BWGcc7bXQI57v01NwBWFSuQffU+rn7d5m5ATvf4j3A/rCzf/FbHuz/NX24BvcE6C5qYjm
 AoFXnFiVRFb+8/eHLV7E7zWDJhc14OcIQlmwI5dKHCj05o9GB9grlKnK8+KQyAqvFvXvYNdWm
 bYJcVtjzo9iyK0YK0wTwZPqryIDZw5l7YrvS7J9roaX1AiWYYKqnGADpGDVNRit98ALMDmNDs
 PAHUGvwqI8+HyraYzMgrUuE4Ur8uJv6Sf09ib0on7yv3FTw2NKvx3OhL1K+cbc9iG+cVTiY72
 Ogv69f9OhDufVcwgKlxgpp/Y3l3d/pK0E+2srHoxhazi2VJIYkj8r6GP+8gMLISIRaxMtzm1T
 /mQCFakqGnoDCsle5YytgSNEDZF4tr2JBhGGRfdZe8sctRXi03w6ThCZbi+Jom1F1RC1WsLu/
 3tjn3KkhWX6dmWo2ztmVXkyHvWqEQ9ShhoguSkC9+EJ3Fl5jVlchHUelLETmC6Bi0b29IUAD3
 6SjRAFnm4i6EXGo21dzqJBQb+j0LzW4juVT/rR1wtnsAYmK6K8xOBM8uTWIn1sGo6Xf8cT0hZ
 Kv3wEqPeuweUjf/1GUhsIhKLXXxZHplzqs9tVw/yJJ/HNL8z4w+8F2UsxcCA9bJE1yhC7MLj3
 ZLPGmKDsVVnWbewYQWvIkkMrhF3XWzQvAQa+ufDdIHKqSt5YUFuDHkOO+nF6TvSZsSvkoHsRI
 fjiKov2H8gttdn359Svp1FMeoUFL/SKa/+Ikbqyt0Ikp++fO9AcpV4H3NlkBQPhUVVVxraxkA
 EHYVY2pnQG1CMKwVzOOnHsSrBz5YFumtdD5i06uXhDxGGLk5kKKejZfho/11dLkXAz7uMi1IE
 p3gYV1IAQ9ceJZNix76sQYJc5G7lFqWTzGVlZ3M6oNAeB5UKC+FJOFCBd3kR3pW9KA78TWbRc
 HbQ16X1boU/1rb1Igt3LWBRrukkE160Bt6GOAgSiQ+wjp38Z4oUvixs5/0mVQWnl7cBava7pu
 L95L1FcT/i6m1A=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi G=C3=BCnter,

On 4/1/22 17:41, Guenter Roeck wrote:
> On Thu, Mar 24, 2022 at 07:46:50PM +0100, Helge Deller wrote:
>> Switch away from the own cpu topology code to common code which is used
>> by ARM64 and RISCV. That will allow us to enable CPU hotplug later on.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>
> This patch results in the following traceback when
> booting generic-32bit_defconfig - SMP in qemu.

That's strange, because I just built this generic-32bit_defconfig myself a=
nd
it boots up nicely in qemu for me. The only thing missing is CONFIG_CGROUP=
S=3Dy so that
systemd can start.

I'm not sure how I can debug/reproduce your bug report...

Helge

> [    9.432811] ------------[ cut here ]------------
> [    9.433305] WARNING: CPU: 0 PID: 1 at fs/sysfs/group.c:115 internal_c=
reate_group+0x360/0x394
> [    9.433825] Modules linked in:
> [    9.434267] CPU: 0 PID: 1 Comm: swapper Not tainted 5.17.0-32bit+ #1
> [    9.434621] Hardware name: 9000/778/B160L
> [    9.434889]
> [    9.435014]      YZrvWESTHLNXBCVMcbcbcbcbOGFRQPDI
> [    9.435201] PSW: 00000000000001001011111100001111 Not tainted
> [    9.435392] r00-03  0004bf0f 114305c0 103518bc 11430600
> [    9.435578] r04-07  0000003c 10db3d20 10b27ecc 00000000
> [    9.435725] r08-11  106f6c88 00000001 00000000 00000000
> [    9.435876] r12-15  10c59000 00000000 00000001 00000000
> [    9.436022] r16-19  00000028 00080000 00000000 10db4ad8
> [    9.436168] r20-23  0000012c 10eb0a00 106f6c88 00000000
> [    9.436314] r24-27  10b27ecc 00000000 00000000 10cf00e0
> [    9.436460] r28-31  00000000 ae147af8 114306c0 101a66d8
> [    9.436625] sr00-03  00000000 00000000 00000000 00000000
> [    9.436785] sr04-07  00000000 00000000 00000000 00000000
> [    9.436942]
> [    9.437006] IASQ: 00000000 00000000 IAOQ: 1035186c 10351870
> [    9.437161]  IIR: 03ffe01f    ISR: 00000000  IOR: 10e02d68
> [    9.437307]  CPU:        0   CR30: 1141a010 CR31: 00000000
> [    9.437470]  ORIG_R28: 00000000
> [    9.437579]  IAOQ[0]: internal_create_group+0x360/0x394
> [    9.437753]  IAOQ[1]: internal_create_group+0x364/0x394
> [    9.437913]  RP(r2): sysfs_create_group+0x1c/0x2c
> [    9.438180] Backtrace:
> [    9.438892]  [<103518bc>] sysfs_create_group+0x1c/0x2c
> [    9.439116]  [<106f6cb0>] topology_add_dev+0x28/0x38
> [    9.439407]  [<101a66d8>] cpuhp_invoke_callback.constprop.0+0xcc/0x17=
c
> [    9.440321]  [<101a68b0>] __cpuhp_setup_state_cpuslocked+0x128/0x210
> [    9.440545]  [<101a69c0>] __cpuhp_setup_state+0x28/0x38
> [    9.440657]  [<10126fa4>] topology_sysfs_init+0x3c/0x4c
> [    9.440795]  [<1018510c>] do_one_initcall+0x68/0x510
> [    9.440918]  [<10101420>] kernel_init_freeable+0x1d4/0x268
> [    9.441040]  [<10aa7bdc>] kernel_init+0x2c/0x150
> [    9.441191]  [<1018201c>] ret_from_kernel_thread+0x1c/0x24
> [    9.441574]
> [    9.441716] ---[ end trace 0000000000000000 ]---
>
> Reverting the offending commit fixes the problem.
> Bisect log is attached.
>
> Guenter
>
> ---
> # bad: [e8b767f5e04097aaedcd6e06e2270f9fe5282696] Merge tag 'for-linus-5=
.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml
> # good: [d888c83fcec75194a8a48ccd283953bdba7b2550] fs: fix fd table size=
 alignment properly
> git bisect start 'HEAD' 'd888c83fcec7'
> # good: [2a44cdaa01837355b14b9221e87d75963846296c] Merge tag 'dmaengine-=
5.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine
> git bisect good 2a44cdaa01837355b14b9221e87d75963846296c
> # bad: [b8321ed4a40c02054f930ca59d3570caa27bc86c] Merge tag 'kbuild-v5.1=
8-v2' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbu=
ild
> git bisect bad b8321ed4a40c02054f930ca59d3570caa27bc86c
> # bad: [93235e3df29c084a37e0daed17801c6adfce4cb6] Merge tag 'v5.18-p1' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
> git bisect bad 93235e3df29c084a37e0daed17801c6adfce4cb6
> # good: [84b3b8df51e26b8bc2c7178b068ef447473d4609] dt-bindings: pwm: ren=
esas,pwm: Include generic PWM schema
> git bisect good 84b3b8df51e26b8bc2c7178b068ef447473d4609
> # bad: [a9fe7fa7d874a536e0540469f314772c054a0323] parisc: Fix patch code=
 locking and flushing
> git bisect bad a9fe7fa7d874a536e0540469f314772c054a0323
> # bad: [95370b4031ec67f9749e5873ae7139a53cc6bf53] parisc: Move store_cpu=
_topology() into text section
> git bisect bad 95370b4031ec67f9749e5873ae7139a53cc6bf53
> # good: [ed9794812b0a61f62317991c5c3e6c78749a0bdc] parisc: Detect hppa-s=
use-linux-gcc compiler for cross-building
> git bisect good ed9794812b0a61f62317991c5c3e6c78749a0bdc
> # good: [1e93848a385ed2c2df9cb246b073dc8c66d10793] parisc: Ensure set_fi=
rmware_width() is called only once
> git bisect good 1e93848a385ed2c2df9cb246b073dc8c66d10793
> # bad: [62773112acc55d29727465d075fc61ed08a0a532] parisc: Switch from GE=
NERIC_CPU_DEVICES to GENERIC_ARCH_TOPOLOGY
> git bisect bad 62773112acc55d29727465d075fc61ed08a0a532
> # first bad commit: [62773112acc55d29727465d075fc61ed08a0a532] parisc: S=
witch from GENERIC_CPU_DEVICES to GENERIC_ARCH_TOPOLOGY

