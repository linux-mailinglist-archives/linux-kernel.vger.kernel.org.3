Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A84F4E3F19
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 14:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235235AbiCVNGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 09:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbiCVNGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 09:06:46 -0400
Received: from gateway33.websitewelcome.com (gateway33.websitewelcome.com [192.185.145.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4501385BC0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 06:05:19 -0700 (PDT)
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id C039B1322F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 08:05:18 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id WeCMnx9d5dx86WeCMnikVr; Tue, 22 Mar 2022 08:05:18 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MxE07mPON8bBYJz+PnvdhC6D7SXQUQUwbhxn+4LZ528=; b=2fjG48UrIP8LPtie98zeiROBLq
        gNrp1no6FDtGclEZkeu4WfUEs2yC7a7/S+coPu0CcvaF69R3JMS/Fv5lMHwehrbuwewdK/UwDvkYm
        A7rSJzl7mU2+dEfZw5/ZTo3/9oBazm9RcjvGMAo/Ft+/UMXocUr79DsqDEbDtkDrLY/vr0lcf4L3u
        TjMOOE/2SLuq5CjHOFtJlzvlLYHcq9g95EK5bXhBK3NTkT55s5C3NVSZ0uENp/SrBwLDnuUDIqeuQ
        NW8mVYUQxMnnarRl1P2+Sb2NyacVTiK7YoRvkQtoAST8EplCedUPeErqung0n8VOsLWLJiLvoyEnt
        JqY98ntA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:57606 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nWeCM-002rZ3-4y; Tue, 22 Mar 2022 13:05:18 +0000
Date:   Tue, 22 Mar 2022 06:05:16 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Helge Deller <deller@gmx.de>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-parisc@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: hppa vDSO and compiler (non-)support
Message-ID: <20220322130516.GA724287@roeck-us.net>
References: <d2713ae1-0ca5-9e5a-b7d2-b7d0f1f5614a@kernel.org>
 <2e1f3e41-7097-e68d-d312-9319ad62565c@gmx.de>
 <d2a09bf3-9bd3-588a-99a1-598281d08678@kernel.org>
 <dd4e55aa-0b3e-6e18-7ec2-3bec02cafde0@kernel.org>
 <YjjJNb0D/b+ZXBVZ@ls3530>
 <28696c20-21ad-b0ac-8093-4ce07225fcd8@kernel.org>
 <812d4a38-8cb1-a7be-c504-87d095aea883@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <812d4a38-8cb1-a7be-c504-87d095aea883@gmx.de>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nWeCM-002rZ3-4y
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:57606
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

On Tue, Mar 22, 2022 at 10:42:33AM +0100, Helge Deller wrote:
> On 3/22/22 10:19, Jiri Slaby wrote:
> > Hello,
> >
> > On 21. 03. 22, 19:51, Helge Deller wrote:
> >> * Jiri Slaby <jirislaby@kernel.org>:
> >>> On 09. 03. 22, 6:48, Jiri Slaby wrote:
> >>>> On 08. 03. 22, 15:51, Helge Deller wrote:
> >>>>> On 3/8/22 12:06, Jiri Slaby wrote:
> >>>>>> since the "parisc: Add vDSO support" commit, I can no longer
> >>>>>> cross-build a hppa kernel. I see two issues:
> >>>>>>
> >>>>>> 1) CROSS32_COMPILE detection doesn't work here, as openSUSE
> >>>>>> provides hppa-suse-linux-* binaries. It's easy to overcome by
> >>>>>> "CROSS32_COMPILE=hppa-suse-linux-"
> >>>>>
> >>>> ...
> >>>>> Would it make sense to add the detection for SUSE too?
> >>>
> >>> So, could 1) be fixed on the Kconfig side? Or should I (people running SUSE)
> >>> use "CROSS32_COMPILE=hppa-suse-linux-"?
> >>
> >> Could you please try if this patch fixes it for you?
> >
> > Works like a charm:
> > $ make V=1 O=../a/arch/parisc/ ARCH=parisc -j6 drivers/tty/serial/mux.o
> > ...
> >>  hppa-suse-linux-gcc <flags deleted> -o drivers/tty/serial/mux.o /home/latest/linux/drivers/tty/serial/mux.c
> >>  if hppa-suse-linux-objdump -h drivers/tty/serial/mux.o | ...; fi
> >
> > Thanks.
> 
> Great!
> I've queued up a patch in for-next...
> 

Does that also fix the build problems now seen in mainline ?

Building parisc64:generic-64bit_defconfig ... failed
--------------
Error log:
arch/parisc/kernel/vdso64/Makefile:30: FORCE prerequisite is missing
arch/parisc/kernel/vdso32/sigtramp.S: Assembler messages:
arch/parisc/kernel/vdso32/sigtramp.S:39: Error: unknown pseudo-op: `.proc'
arch/parisc/kernel/vdso32/sigtramp.S:40: Error: unknown pseudo-op: `.callinfo'
arch/parisc/kernel/vdso32/sigtramp.S:41: Error: unknown pseudo-op: `.entry'
arch/parisc/kernel/vdso32/sigtramp.S:44: Error: no such instruction: `ldi 0,%r25'
arch/parisc/kernel/vdso32/sigtramp.S:45: Error: no such instruction: `ldi 173,%r20'
arch/parisc/kernel/vdso32/sigtramp.S:46: Error: no such instruction: `ble 0x100(%sr2,%r0)'
arch/parisc/kernel/vdso32/sigtramp.S:49: Error: no such instruction: `ldi 1,%r25'
arch/parisc/kernel/vdso32/sigtramp.S:50: Error: no such instruction: `ldi 173,%r20'
arch/parisc/kernel/vdso32/sigtramp.S:51: Error: no such instruction: `ble 0x100(%sr2,%r0)'
arch/parisc/kernel/vdso32/sigtramp.S:54: Error: unknown pseudo-op: `.exit'
arch/parisc/kernel/vdso32/sigtramp.S:55: Error: unknown pseudo-op: `.procend'
arch/parisc/kernel/vdso32/sigtramp.S:76: Error: unknown pseudo-op: `.stringz'
arch/parisc/kernel/vdso32/restart_syscall.S: Assembler messages:
arch/parisc/kernel/vdso32/restart_syscall.S:16: Error: bad or irreducible absolute expression
arch/parisc/kernel/vdso32/restart_syscall.S:16: Error: junk at end of line, first unrecognized character is `:'
arch/parisc/kernel/vdso32/restart_syscall.S:26: Error: no such instruction: `ldw 0(%sp),%r31'
arch/parisc/kernel/vdso32/restart_syscall.S:29: Error: no such instruction: `be 0x100(%sr2,%r0)'
arch/parisc/kernel/vdso32/restart_syscall.S:30: Error: no such instruction: `ldi 0,%r20'
arch/parisc/kernel/vdso32/restart_syscall.S:32: Error: .cfi_endproc without corresponding .cfi_startproc
make[2]: *** [arch/parisc/kernel/vdso32/Makefile:34: arch/parisc/kernel/vdso32/restart_syscall.o] Error 1
make[2]: *** Waiting for unfinished jobs....
make[2]: *** [arch/parisc/kernel/vdso32/Makefile:34: arch/parisc/kernel/vdso32/sigtramp.o] Error 1
make[1]: *** [arch/parisc/Makefile:177: vdso_prepare] Error 2
make: *** [Makefile:219: __sub-make] Error 2

This is with hppa64-linux-gcc (GCC) 11.2.0.

Thanks,
Guenter
