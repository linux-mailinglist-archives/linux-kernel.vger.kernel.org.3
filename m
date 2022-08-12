Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560B9590E34
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 11:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238065AbiHLJfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 05:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238088AbiHLJf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 05:35:27 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A47A6274
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 02:35:25 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id q10-20020a056e020c2a00b002dedb497c7fso231505ilg.16
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 02:35:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=M9Zg/O4oEVrqFSkp5sxj3W6dTTDvm7oHCcAw0qxJiCI=;
        b=yAb1N+kgCDcETSj6dENY7IaD2R/SFW929UK2IrqMsX9OiBqh/HAu1TBETE76qiVDeU
         1EJ3Uemx9cWf9MLSw/4a6RmPve/xI7uVTyorr2qeuSxtOaiFUnE1PumhLbioRdW8BuA2
         DO3j23gq7CnRJw/EW/al6LOO7BWb+DDzbXrg21zWCGIUTPv7H6t8ksyK08XtXenA6pbh
         9T3lq0nyoGtWEhrgDdDnAGXOM5qTgTvCz82UNgDKBw2S2pXzPn9lfG6YwTI8ikMeiop7
         cQaIHpbuYODFh287oAIyVUrIQ3rcUBrXWf70wDREeVIibPrr0VGW6IOCFlu7iKc4afz0
         bTtw==
X-Gm-Message-State: ACgBeo3nUHy5mykry/TB57M3RDM9RuDYw5tDHFohL989yrnrjGC1Tm5w
        w5PsVxICRNIjnnri88IYFUNFTcbGZ6/KiIkHfuJTsN18vRnp
X-Google-Smtp-Source: AA6agR4Vxrz4Des5Gn183gE0q3033dO/Xc/psN3RvxnIySfLjdChMu9RgnUuBZ9GPwFZP/DLUIw4qMO7gBxqojahCRfZBPG1rYhG
MIME-Version: 1.0
X-Received: by 2002:a02:998f:0:b0:343:3309:97e8 with SMTP id
 a15-20020a02998f000000b00343330997e8mr1484686jal.47.1660296924724; Fri, 12
 Aug 2022 02:35:24 -0700 (PDT)
Date:   Fri, 12 Aug 2022 02:35:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006b89c205e608008d@google.com>
Subject: [syzbot] KASAN: global-out-of-bounds Read in macvlan_hard_header (3)
From:   syzbot <syzbot+f98474db42abaf86c7b5@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
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

HEAD commit:    8eaa1d110800 net/mlx5e: xsk: Discard unaligned XSK frames ..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=1317f1c1080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=467d6845c5dcb05f
dashboard link: https://syzkaller.appspot.com/bug?extid=f98474db42abaf86c7b5
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f98474db42abaf86c7b5@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_CHANGE): team1: link becomes ready
==================================================================
BUG: KASAN: global-out-of-bounds in dev_hard_header include/linux/netdevice.h:3043 [inline]
BUG: KASAN: global-out-of-bounds in macvlan_hard_header+0x12b/0x150 drivers/net/macvlan.c:594
Read of size 8 at addr ffffffff8f2bd590 by task kworker/1:1/32

CPU: 1 PID: 32 Comm: kworker/1:1 Not tainted 5.19.0-rc8-syzkaller-00130-g8eaa1d110800 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Workqueue: mld mld_ifc_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0xf/0x495 mm/kasan/report.c:313
 print_report mm/kasan/report.c:429 [inline]
 kasan_report.cold+0xf4/0x1c6 mm/kasan/report.c:491
 dev_hard_header include/linux/netdevice.h:3043 [inline]
 macvlan_hard_header+0x12b/0x150 drivers/net/macvlan.c:594
 dev_hard_header include/linux/netdevice.h:3046 [inline]
 neigh_resolve_output net/core/neighbour.c:1523 [inline]
 neigh_resolve_output+0x4b3/0x840 net/core/neighbour.c:1508
 neigh_output include/net/neighbour.h:549 [inline]
 ip6_finish_output2+0x564/0x1520 net/ipv6/ip6_output.c:134
 __ip6_finish_output net/ipv6/ip6_output.c:195 [inline]
 ip6_finish_output+0x844/0x1170 net/ipv6/ip6_output.c:206
 NF_HOOK_COND include/linux/netfilter.h:296 [inline]
 ip6_output+0x1ed/0x540 net/ipv6/ip6_output.c:227
 dst_output include/net/dst.h:451 [inline]
 NF_HOOK include/linux/netfilter.h:307 [inline]
 NF_HOOK include/linux/netfilter.h:301 [inline]
 mld_sendpack+0xa09/0xe70 net/ipv6/mcast.c:1820
 mld_send_cr net/ipv6/mcast.c:2121 [inline]
 mld_ifc_work+0x71c/0xdc0 net/ipv6/mcast.c:2653
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>

The buggy address belongs to the variable:
 nr_zapped_lock_chains+0x10/0x40

Memory state around the buggy address:
 ffffffff8f2bd480: 00 00 00 00 f9 f9 f9 f9 04 f9 f9 f9 f9 f9 f9 f9
 ffffffff8f2bd500: 04 f9 f9 f9 f9 f9 f9 f9 04 f9 f9 f9 f9 f9 f9 f9
>ffffffff8f2bd580: 00 f9 f9 f9 f9 f9 f9 f9 00 00 00 00 00 00 00 00
                         ^
 ffffffff8f2bd600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffffff8f2bd680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
