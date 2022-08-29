Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122905A454C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 10:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiH2Ijf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 04:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiH2Ij3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 04:39:29 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B93258DE9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 01:39:17 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id b21-20020a5d8915000000b0068aaf634432so4338043ion.20
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 01:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=bwogNmvOAsrd16qwiBwRZ8ODMDO12ioOV6zILP7lCN4=;
        b=zaDUlKIJkC5eofLm4C6ccfLHeaIyIamQC65X0jN7v2jpX6mOxv0tI1PlPFDJGBUhk+
         n34pZgJ2t5ET8JLjfR5PdlzbwYnv+Rd4ViPvilV2fRaaGJywnp+44cS8x4ED5K38dBeY
         GNza4SabpL02MZR6El8E04Dqo9DirLXjxCudx97G/dM+iJcwBB+clR13eqvBUgVD5RFF
         YEnQDFnN7tat1ibD1RTbAHqbxtVfKYaFmisImxhTcaBNiAw9HZ8rdXH8mV2auy8VCshK
         9kwk7+29fhh5PURSPHOcNZ0QFVWZm6dAk8T1dH13isPVfPPE/9CY0TJflsC0yXbWmEsc
         Gx9Q==
X-Gm-Message-State: ACgBeo1Bvj1C6L5g7ljI6XeGBb4HsetjXdG+nRCSAApZn+/Hd6gQ78hq
        iVWX+PsW722OnBJ/wi6D+jh0NBSFgBGqmooXRVBEvIGz3Bqi
X-Google-Smtp-Source: AA6agR6qVxeRsozXRwFgGRUMMQieBmlXaiKrVUj7ccnUkBiRD6LTSFm7ImRh1EOQI3snlB0t/rjcw2jTN8y2xdiMTMYJmDypdQGu
MIME-Version: 1.0
X-Received: by 2002:a05:6638:140e:b0:343:4ed7:c0f9 with SMTP id
 k14-20020a056638140e00b003434ed7c0f9mr9458589jad.135.1661762356375; Mon, 29
 Aug 2022 01:39:16 -0700 (PDT)
Date:   Mon, 29 Aug 2022 01:39:16 -0700
In-Reply-To: <987ed804-e03b-5bd6-3cd8-cbc494261f3a@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f3f7cf05e75d3250@google.com>
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
