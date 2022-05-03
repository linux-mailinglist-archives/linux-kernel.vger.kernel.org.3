Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351D3517F4D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 10:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbiECIEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 04:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbiECID4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 04:03:56 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F281BE
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 01:00:25 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id j7-20020a056e02218700b002cd9e2f0ac7so8519493ila.16
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 01:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=DtIPv5yFBYKusT8mskdhmPUJ7UyZ51XiNQ6j7J1NCIM=;
        b=s87N6236R3SYUfLPWUD4tKSAyUmK3XjAgxqn+uAAJhcRZUo22cB23x5trkWBvlo+RA
         tIPLQFD2F1xK8K0t2He7P+FtpCsYA0ams71VkcztB+xKIEhjclHrNUfakx8IwWIAzhpT
         D7qtZwT924BMBpJAFtO6Z/DvKMPstdEq0+NvqQ3eHHzZjiHjdgrYBNE5qKyE7EaA2ukE
         fdZ8J9EVr7i3RiJB5djA3X4zW+8DSuJX+3BiWezTTiBqbJLe9ag/KfgfOqGDLD8S8NsB
         YHMa4SCImkucOa/G6zfYKvX+JOYJ3CYw09OgUs+D4Wv5TUNZin198rQtqLYrw05TviwN
         97BA==
X-Gm-Message-State: AOAM532fPZqoGmArBN9ctnywI5GrhN/5BoVrPJt7az2eNc0F93AJgydp
        87+YQzXhCwWPIA39alrM8OOcKs41Ym4LrSghy2hFljvbAIQU
X-Google-Smtp-Source: ABdhPJxEW3DxKPozMbE8VkazFxVnJsSTONXeSOu3P0Zz1ISlsi7I2BQR9iXR/42aD57sB+tPFOs5CGFC5oWAjx8byFJUBEjMSs85
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c4:b0:2cd:8f5e:7587 with SMTP id
 i4-20020a056e0212c400b002cd8f5e7587mr6245568ilm.187.1651564824367; Tue, 03
 May 2022 01:00:24 -0700 (PDT)
Date:   Tue, 03 May 2022 01:00:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ae165e05de16e60a@google.com>
Subject: [syzbot] linux-next boot error: kernel panic: VFS: Unable to mount
 root fs on unknown-block(NUM,NUM)
From:   syzbot <syzbot+76d3c2bc1d4d59794f86@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com, vgoyal@redhat.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    44a2f39e611a Add linux-next specific files for 20220503
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12487e32f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b442536afa797746
dashboard link: https://syzkaller.appspot.com/bug?extid=76d3c2bc1d4d59794f86
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+76d3c2bc1d4d59794f86@syzkaller.appspotmail.com

rdma_rxe: loaded
cfg80211: Loading compiled-in X.509 certificates for regulatory database
cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
ALSA device list:
  #0: Dummy 1
  #1: Loopback 1
  #2: Virtual MIDI Card 1
md: Waiting for all devices to be available before autodetect
md: If you don't use raid, use raid=noautodetect
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
VFS: Cannot open root device "sda1" or unknown-block(0,0): error -6
Please append a correct "root=" boot option; here are the available partitions:
0100            4096 ram0 
 (driver?)
0101            4096 ram1 
 (driver?)
0102            4096 ram2 
 (driver?)
0103            4096 ram3 
 (driver?)
0104            4096 ram4 
 (driver?)
0105            4096 ram5 
 (driver?)
0106            4096 ram6 
 (driver?)
0107            4096 ram7 
 (driver?)
0108            4096 ram8 
 (driver?)
0109            4096 ram9 
 (driver?)
010a            4096 ram10 
 (driver?)
010b            4096 ram11 
 (driver?)
010c            4096 ram12 
 (driver?)
010d            4096 ram13 
 (driver?)
010e            4096 ram14 
 (driver?)
010f            4096 ram15 
 (driver?)
fa00       262144000 nullb0 
 (driver?)
1f00             128 mtdblock0 
 (driver?)
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.18.0-rc5-next-20220503-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 panic+0x2d7/0x636 kernel/panic.c:274
 mount_block_root+0x237/0x312 init/do_mounts.c:432
 mount_root+0x36e/0x3be init/do_mounts.c:592
 prepare_namespace+0x1ff/0x234 init/do_mounts.c:644
 kernel_init_freeable+0x722/0x73a init/main.c:1631
 kernel_init+0x1a/0x1d0 init/main.c:1507
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298
 </TASK>
Kernel Offset: disabled


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
