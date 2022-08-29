Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438215A454B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 10:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiH2Ij1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 04:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiH2IjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 04:39:24 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC06858B41
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 01:39:19 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id c7-20020a056e020bc700b002e59be6ce85so5475865ilu.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 01:39:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=mTl70EAB1fp0fWtuJtxECweXvpPEMSaJrdoQq7O8l1w=;
        b=22vyh7pHpKI/GKGFqwGXYEGpZRquoG/hhX2MBWlrmXTSp6Np//DeuT98FcrAPJjt5g
         YLct+3cCMmu0zGflI3bo022ArvJJlsQyyJmuszMuW+5NKcms8tHHDudenS5rxpA6v/1M
         ffzDR1FmWnQ8KiTBJMh0dY+f3jodAj35EWrV9U3o0U91tXp+HfkY4LU+WFY7vu3qHkZx
         iwdNss8dgOix7DTVAmZ4pGr00zuqE+3pgG2gtRZmZXJYcgvRWbFdwSBnoZc4zQ8FIzUG
         jnpg8lQJOdTgnDHF5EfvqSwtnHuwp0nQXCPM7DpVIe6aQpjNiMvMNA1E4ReklJhL2RO2
         wm2g==
X-Gm-Message-State: ACgBeo3JKhlUTGA4i1RHX3sd+gZBlZ2ticLEj+5JQxY73QTQ0Kwll4po
        BkqogHngEiugjQEaZ2dHOO2OSkaIlVhY5WWigHwQ1B29pdsy
X-Google-Smtp-Source: AA6agR7Ag2EpkrDD8P67+w573vXe5ftMzF775kgr2odamZ2SeqbnreeEXp7dn/XvJFOe+sel420spITHWdvSN3Yl2ZdfxE3kNuDU
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1cae:b0:2e9:e450:fbf2 with SMTP id
 x14-20020a056e021cae00b002e9e450fbf2mr9276509ill.311.1661762358112; Mon, 29
 Aug 2022 01:39:18 -0700 (PDT)
Date:   Mon, 29 Aug 2022 01:39:18 -0700
In-Reply-To: <987ed804-e03b-5bd6-3cd8-cbc494261f3a@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000e775605e75d3378@google.com>
Subject: Re: [syzbot] BUG: unable to handle kernel NULL pointer dereference in tiocsti
From:   syzbot <syzbot+032314e8d7de2bdb97f7@syzkaller.appspotmail.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> #syz dup: BUG: unable to handle kernel NULL pointer dereference in 

can't find the dup bug

> gsmld_receive_buf
>
> On 24. 08. 22, 18:35, syzbot wrote:
>> Hello,
>> 
>> syzbot found the following issue on:
>> 
>> HEAD commit:    1c23f9e627a7 Linux 6.0-rc2
>> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
>> console output: https://syzkaller.appspot.com/x/log.txt?x=17eefdcb080000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3045c937aad027f7
>> dashboard link: https://syzkaller.appspot.com/bug?extid=032314e8d7de2bdb97f7
>> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
>> userspace arch: arm64
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1190eb6b080000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16a1e50d080000
>> 
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+032314e8d7de2bdb97f7@syzkaller.appspotmail.com
>> 
>> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
>> Mem abort info:
>>    ESR = 0x0000000086000006
>>    EC = 0x21: IABT (current EL), IL = 32 bits
>>    SET = 0, FnV = 0
>>    EA = 0, S1PTW = 0
>>    FSC = 0x06: level 2 translation fault
>> user pgtable: 4k pages, 48-bit VAs, pgdp=000000010b28b000
>> [0000000000000000] pgd=080000010b411003, p4d=080000010b411003, pud=080000010b47b003, pmd=0000000000000000
>> Internal error: Oops: 86000006 [#1] PREEMPT SMP
>> Modules linked in:
>> CPU: 1 PID: 3028 Comm: syz-executor908 Not tainted 6.0.0-rc2-syzkaller-16440-g1c23f9e627a7 #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/20/2022
>> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> pc : 0x0
>> lr : gsmld_receive_buf+0x140/0x214 drivers/tty/n_gsm.c:2861
>> sp : ffff80000ffe3cb0
>> x29: ffff80000ffe3cc0 x28: 0000000000000000 x27: 0000000000000000
>> x26: 0000000000000000 x25: 0000000000000000 x24: ffff80000d937000
>> x23: ffff80000d681e40 x22: ffff0000cb2dc000 x21: ffff80000ffe3d21
>> x20: ffff80000c205988 x19: ffff80000ffe3d24 x18: 00000000000000c0
>> x17: ffff80000dd7a698 x16: 0000000000000000 x15: 0000000000000000
>> x14: 0000000000000000 x13: 0000000000000004 x12: ffff80000d681e78
>> x11: ff808000098e7e04 x10: 0000000000000000 x9 : ffff8000098e7e04
>> x8 : 0000000000000000 x7 : ffff8000098dcea4 x6 : 0000000000000000
>> x5 : ffff80000e087890 x4 : 0000000000000002 x3 : 0000000000000001
>> x2 : ffff80000ffe3d20 x1 : 0000000000000000 x0 : ffff0000cb2dc000
>> Call trace:
>>   0x0
>>   tiocsti+0x168/0x1c4 drivers/tty/tty_io.c:2293
>>   tty_ioctl+0x284/0x9f4 drivers/tty/tty_io.c:2692
>>   vfs_ioctl fs/ioctl.c:51 [inline]
>>   __do_sys_ioctl fs/ioctl.c:870 [inline]
>>   __se_sys_ioctl fs/ioctl.c:856 [inline]
>>   __arm64_sys_ioctl+0xd0/0x140 fs/ioctl.c:856
>>   __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
>>   invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
>>   el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
>>   do_el0_svc+0x48/0x154 arch/arm64/kernel/syscall.c:206
>>   el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:624
>>   el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
>>   el0t_64_sync+0x18c/0x190
>> Code: bad PC value
>> ---[ end trace 0000000000000000 ]---
>> 
>> 
>> ---
>> This report is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>> 
>> syzbot will keep track of this issue. See:
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>> syzbot can test patches for this issue, for details see:
>> https://goo.gl/tpsmEJ#testing-patches
>
> -- 
> js
>
> -- 
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/987ed804-e03b-5bd6-3cd8-cbc494261f3a%40kernel.org.
