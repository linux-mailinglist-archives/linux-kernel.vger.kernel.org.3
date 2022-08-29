Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301B35A4551
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 10:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiH2Iki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 04:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiH2Ikg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 04:40:36 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BA32DA83
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 01:40:35 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id y1-20020a056602200100b006893cd97da9so4270919iod.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 01:40:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=j7w9bf+ITDPc8TlQPw6wNiMpGqgHM+2YfN6ly1njXhc=;
        b=v7aoTKSQahp6CSL5mA5H4e1FzeoXw/qRBzCn8QnNUadx4WIBUiW7CZbY9kZyX1fN7/
         YWh5QPTfrJFQgwJxNObzhun06xHSuFCMe7StkWG4lHn9JvZhSk+1Y1POWvOLcqNVF4uk
         v0xPHOh1LvPGDWzDaPW/DmpvP/yoEa7fyNZUW3PF3kELq+4LmuGu3TdX8GVkW8BwuR/+
         Rbpp5IdMI0MMu0h8ZKotK7csE17e8qBqPiRgG9TLphJFsNrNceYN2BM/4L9FHNmhMHuw
         XPQjeIeoald+tkeA9ZEuSD98nT6eNWWuPI3cpRIFOG9OLLGmiHK1RJxcO42hNXc+FKj1
         mbYg==
X-Gm-Message-State: ACgBeo1K2WTtIAXVg3BpM5OY7nLYXF8zf0rTIhBpJDiaJ9qUvLesnZXM
        92rA+YO3AEnoUyx9RIWUeSiCIpw6hs009BPfa/5IwAneEARS
X-Google-Smtp-Source: AA6agR59760yqEfuZ+I+TqCLLuYMQlqSDMD9oJbXkrvlsfsX4t37njm3Rd6vZy603O5S6Vna8Y8WvBb3boZvJPVgEqvYDwaBs/qm
MIME-Version: 1.0
X-Received: by 2002:a92:db04:0:b0:2e5:dbb6:1285 with SMTP id
 b4-20020a92db04000000b002e5dbb61285mr9522468iln.275.1661762434864; Mon, 29
 Aug 2022 01:40:34 -0700 (PDT)
Date:   Mon, 29 Aug 2022 01:40:34 -0700
In-Reply-To: <d0188e1d-374d-5256-7c15-f91989195ce2@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a19c8005e75d37b3@google.com>
Subject: Re: [syzbot] BUG: unable to handle kernel NULL pointer dereference in tty_ldisc_receive_buf
From:   syzbot <syzbot+be4b95faeb7a9073bb88@syzkaller.appspotmail.com>
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
>> console output: https://syzkaller.appspot.com/x/log.txt?x=177ac367080000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3045c937aad027f7
>> dashboard link: https://syzkaller.appspot.com/bug?extid=be4b95faeb7a9073bb88
>> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
>> userspace arch: arm64
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1701758d080000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17473aad080000
>> 
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+be4b95faeb7a9073bb88@syzkaller.appspotmail.com
>> 
>> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
>> Mem abort info:
>>    ESR = 0x0000000086000006
>>    EC = 0x21: IABT (current EL), IL = 32 bits
>>    SET = 0, FnV = 0
>>    EA = 0, S1PTW = 0
>>    FSC = 0x06: level 2 translation fault
>> user pgtable: 4k pages, 48-bit VAs, pgdp=000000010b44f000
>> [0000000000000000] pgd=080000010b5f3003, p4d=080000010b5f3003, pud=080000010b1ce003, pmd=0000000000000000
>> Internal error: Oops: 86000006 [#1] PREEMPT SMP
>> Modules linked in:
>> CPU: 1 PID: 28 Comm: kworker/u4:1 Not tainted 6.0.0-rc2-syzkaller-16440-g1c23f9e627a7 #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/20/2022
>> Workqueue: events_unbound flush_to_ldisc
>> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> pc : 0x0
>> lr : gsmld_receive_buf+0x140/0x214 drivers/tty/n_gsm.c:2861
>> sp : ffff80000f603c30
>> x29: ffff80000f603c40 x28: 0000000000000000 x27: 00000000000003d9
>> x26: 0000000000000000 x25: 0000000000000000 x24: ffff80000d937000
>> x23: ffff80000d681e40 x22: ffff0000c929b800 x21: 0000000000000000
>> x20: ffff80000c205988 x19: ffff0000c91cf446 x18: ffff80000d2dec40
>> x17: 0000000000000008 x16: 0000000000000000 x15: 0000000000000000
>> x14: 0000000000000000 x13: 0000000000000004 x12: ffff80000d681e78
>> x11: ff808000098e7e04 x10: 0000000000000000 x9 : ffff8000098e7e04
>> x8 : 0000000000000000 x7 : ffff8000098dac3c x6 : 0000000000000000
>> x5 : 0000000000000000 x4 : 0000000000000001 x3 : 00000000000003da
>> x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000c929b800
>> Call trace:
>>   0x0
>>   tty_ldisc_receive_buf+0xb8/0xcc drivers/tty/tty_buffer.c:461
>>   tty_port_default_receive_buf+0x54/0x8c drivers/tty/tty_port.c:39
>>   receive_buf drivers/tty/tty_buffer.c:511 [inline]
>>   flush_to_ldisc+0x150/0x358 drivers/tty/tty_buffer.c:561
>>   process_one_work+0x2d8/0x504 kernel/workqueue.c:2289
>>   worker_thread+0x340/0x610 kernel/workqueue.c:2436
>>   kthread+0x12c/0x158 kernel/kthread.c:376
>>   ret_from_fork+0x10/0x20
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
> suse labs
>
