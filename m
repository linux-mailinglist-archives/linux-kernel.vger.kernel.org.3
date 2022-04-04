Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326794F0D80
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 04:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241569AbiDDCYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 22:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbiDDCYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 22:24:37 -0400
Received: from gateway23.websitewelcome.com (gateway23.websitewelcome.com [192.185.50.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F1932EE9
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 19:22:40 -0700 (PDT)
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 619C4F231
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 21:22:40 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id bCManQqrgXvvJbCManV6nK; Sun, 03 Apr 2022 21:22:40 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gubnIp1vkt4swdUoZ4KzWqOfZ/UVDJm8t561WWYV7Cw=; b=2eLwE2eCPNGzuJCizLGVIEbDEQ
        Bfkv9ooVCYQEw5DG6/OejNW7Ga2L8/IMWj9dsMyLK7PkzOR2hZtdcIzXSdIXuRXkCjqrSuvd1zpgQ
        9CT/ZljL4ROWkBO2Idj4ffayDJLFhbe6VRkrRm93Bdr/sBKKB9p3TQVUfWGmbcRPqj4sLlfPVGmTk
        P5qHj3+u5u0GQpMF9D2KSHia/INS8xmKoOCkWY9XDYPVVLKDskPiDUjoA7KFLGzoFxNM1fDiIZVYn
        xXZjAWgVFMYlwU5gieL9n6n+zihB/iAcuVcy3refW/Mn/IdhRj3KfqAegk1qtJcqIJ+BCo2ONC1km
        PG/ngpkg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:57842 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nbCMa-001ZpD-0q; Mon, 04 Apr 2022 02:22:40 +0000
Date:   Sun, 3 Apr 2022 19:22:39 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.18-rc1
Message-ID: <20220404022239.GA1186352@roeck-us.net>
References: <CAHk-=wg6FWL1xjVyHx7DdjD2dHZETA5_=FqqW17Z19X-WTfWSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg6FWL1xjVyHx7DdjD2dHZETA5_=FqqW17Z19X-WTfWSg@mail.gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nbCMa-001ZpD-0q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:57842
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 1
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 03, 2022 at 03:14:19PM -0700, Linus Torvalds wrote:
> So here we are, two weeks later, and the merge window is closed.
> 
> The full diffstat isn't useful, because this is another of those
> occasional releases where the AMD drm driver adds those generated
> register definitions, so the diff is absolutely dominated by register
> definitions for DCN 3.1.x and MP 13.0.x register definitions. Don't
> even go look - you'll go blind.
> 
> Another fairly big chunk of it (but nowhere _near_ the AMD GPU
> register definitions) is the updates for various Intel performance
> monitoring event tables.
> 
> But if you ignore those two areas, things look fairly normal. At that
> point, it's about 60%driver updates - with GPU updates are still
> fairly sizable, but now no longer so dominant as to hide everything
> else. And all the other usual suspects too: networking, sound, media,
> scsi, pinctrl, clk, etc..
> 
> The rest is fairly spread out  documentation and devicetree bindings
> (maybe I should just count that against drivers), architecture updates
> (biggest part of the diff: nds32 is gone, but there's all the usual
> x86, arm, arm64, powerpc, parisc, mips and riscv updates). Tooling
> updates (perf and selftests), and of course all the core kernel
> updates (filesystem, core, networking, VM).
> 
> As always, there's _way_ too many changes to list individually, and
> you're just getting the usual mergelog appended.
> 
> In fact, at least in pure commits, this has been a bigger merge window
> than we've had in some time. But let's hope it's all smooth sailing
> this release.
> 
> Sure, that will happen.
> 
> Go test, please,

Build results:
	total: 151 pass: 142 fail: 9
Failed builds:
	alpha:allmodconfig
	arm:allmodconfig
	csky:allmodconfig
	i386:allyesconfig
	i386:allmodconfig
	mips:allmodconfig
	parisc:allmodconfig
	powerpc:ppc32_allmodconfig
	xtensa:allmodconfig
Qemu test results:
	total: 488 pass: 488 fail: 0

Details below.

Guenter

---

Building alpha:allmodconfig ... failed
--------------
Error log:
<stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
In file included from include/linux/string.h:20,
                 from include/linux/bitmap.h:11,
                 from include/linux/cpumask.h:12,
                 from include/linux/smp.h:13,
                 from include/linux/lockdep.h:14,
                 from include/linux/spinlock.h:62,
                 from include/linux/wait.h:9,
                 from include/linux/wait_bit.h:8,
                 from include/linux/fs.h:6,
                 from include/linux/highmem.h:5,
                 from include/linux/bvec.h:10,
                 from include/linux/skbuff.h:17,
                 from include/../include/linux/if_arp.h:22,
                 from drivers/staging/r8188eu/core/rtw_br_ext.c:6:
In function '__nat25_add_pppoe_tag',
    inlined from 'nat25_db_handle' at drivers/staging/r8188eu/core/rtw_br_ext.c:479:11:
arch/alpha/include/asm/string.h:22:16: error: '__builtin_memcpy' forming offset [40, 2051] is out of the bounds [0, 40] of object 'tag_buf' with type 'unsigned char[40]'

Exposed by commit e6148767825c ("Makefile: Enable -Warray-bounds").
Fix at https://lore.kernel.org/lkml/20220403123628.3113382-1-linux@roeck-us.net/

--------------
Building arm:allmodconfig ... failed
Building csky:allmodconfig ... failed
Building i386:allyesconfig ... failed
Building mips:allmodconfig ... failed
Building parisc:allmodconfig ... failed
Building powerpc:ppc32_allmodconfig ... failed
Building xtensa:allmodconfig ... failed
--------------
Error log:
drivers/misc/habanalabs/common/memory.c: In function 'alloc_device_memory':
drivers/misc/habanalabs/common/memory.c:153:49: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
  153 |                                                 (u64) gen_pool_dma_alloc_align(vm->dram_pg_pool,

Fix at https://lore.kernel.org/lkml/20220401151450.3414694-1-linux@roeck-us.net/

--------------
Building powerpc:ppc32_allmodconfig ... failed
--------------
Error log:
drivers/tty/serial/mpc52xx_uart.c:967:23: error: initialization of 'unsigned int (*)(struct uart_port *)' from incompatible pointer type 'int (*)(struct uart_port *)' [-Werror=incompatible-pointer-types]
  967 |         .raw_rx_rdy = mpc5125_psc_raw_rx_rdy,

and many similar errors.

Caused by commit 18662a1d8f35 ("tty: serial: mpc52xx_uart: make rx/tx
hooks return unsigned"). Reported at
https://lore.kernel.org/lkml/20220403153607.GA3644508@roeck-us.net/
