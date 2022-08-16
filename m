Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E4F59583D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234655AbiHPKaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234592AbiHPK3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:29:36 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896CB37FBA
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 01:40:25 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id f16-20020a6b6210000000b006889725d748so1614895iog.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 01:40:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=PMYTHRbtvAEUd3T6QKRglcE0B3kW1AGCdIwCegasyhg=;
        b=fH5AW9IZFUTSpTqZI+MS3nDpNfdLfv4iz9HC+5EYn8eMSFUGBjtwkCsa14wSSZ+jJA
         4dSXmDuxfPzhxNR/elcDJlcfw3YtyAF3iDmFMa+rTB036bYTN2RKvZ+tonQEdCzf6hyV
         zMuBeJybk67IGPJAdjix81aKKkOu/zcyKJIC7h/QRbVASv3LWS45yOZn28QuyoZGy3Hf
         PCwsh4gPc1VAz9dZftg+OC3GV5RX8HDuTgYB3ui5yoiK/fHMt68A8mNRSqTqQSDKTGkd
         1OcGWD28DAFQ+mdsp/ubFtzma/jhsnJLwN6JdrW1vJRx4dsgzu5IkYV+rFsm09Xkc2L/
         u6jA==
X-Gm-Message-State: ACgBeo0hD/gbojXTbf9bTiHLOAtcb1K+EvS+meKlXcGdZlWHAgUr0SBt
        VLlrKBu+Pdu5k2TGkvKjaa7HxTp9Q2/9JSm2ltFakX96cAkY
X-Google-Smtp-Source: AA6agR71RC3xdK2zD3XAyNJHr2X6cD84VRTqsloHMKcLgPMTSDCckmbvDkPI+pZClgxu+Oh2TASiveXvxq3Vb4ETCKzVjJ/KPuuA
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a84:b0:2e5:c2aa:5c65 with SMTP id
 k4-20020a056e021a8400b002e5c2aa5c65mr3639144ilv.152.1660639224537; Tue, 16
 Aug 2022 01:40:24 -0700 (PDT)
Date:   Tue, 16 Aug 2022 01:40:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000142b0b05e657b3d8@google.com>
Subject: [syzbot] upstream boot error: BUG: unable to handle kernel paging
 request in kernfs_create_dir_ns
From:   syzbot <syzbot+4742b8091a2010ffd765@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
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

Hello,

syzbot found the following issue on:

HEAD commit:    4a9350597aff Merge tag 'sound-fix-6.0-rc1' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1056a56b080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d647c9572405910
dashboard link: https://syzkaller.appspot.com/bug?extid=4742b8091a2010ffd765
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4742b8091a2010ffd765@syzkaller.appspotmail.com

usbcore: registered new interface driver ath9k_htc
usbcore: registered new interface driver carl9170
usbcore: registered new interface driver ath6kl_usb
usbcore: registered new interface driver ar5523
usbcore: registered new interface driver ath10k_usb
usbcore: registered new interface driver rndis_wlan
mac80211_hwsim: initializing netlink
usbcore: registered new interface driver atusb
mac802154_hwsim mac802154_hwsim: Added 2 mac802154 hwsim hardware radios
VMware vmxnet3 virtual NIC driver - version 1.7.0.0-k-NAPI
usbcore: registered new interface driver catc
usbcore: registered new interface driver kaweth
pegasus: Pegasus/Pegasus II USB Ethernet driver
usbcore: registered new interface driver pegasus
usbcore: registered new interface driver rtl8150
usbcore: registered new interface driver r8152
hso: drivers/net/usb/hso.c: Option Wireless
usbcore: registered new interface driver hso
usbcore: registered new interface driver lan78xx
usbcore: registered new interface driver asix
usbcore: registered new interface driver ax88179_178a
usbcore: registered new interface driver cdc_ether
usbcore: registered new interface driver cdc_eem
usbcore: registered new interface driver dm9601
usbcore: registered new interface driver sr9700
usbcore: registered new interface driver CoreChips
usbcore: registered new interface driver smsc75xx
usbcore: registered new interface driver smsc95xx
usbcore: registered new interface driver gl620a
usbcore: registered new interface driver net1080
usbcore: registered new interface driver plusb
usbcore: registered new interface driver rndis_host
usbcore: registered new interface driver cdc_subset
usbcore: registered new interface driver zaurus
usbcore: registered new interface driver MOSCHIP usb-ethernet driver
usbcore: registered new interface driver int51x1
usbcore: registered new interface driver cdc_phonet
usbcore: registered new interface driver kalmia
usbcore: registered new interface driver ipheth
usbcore: registered new interface driver sierra_net
usbcore: registered new interface driver cx82310_eth
usbcore: registered new interface driver cdc_ncm
usbcore: registered new interface driver huawei_cdc_ncm
usbcore: registered new interface driver lg-vl600
usbcore: registered new interface driver qmi_wwan
usbcore: registered new interface driver cdc_mbim
usbcore: registered new interface driver ch9200
usbcore: registered new interface driver r8153_ecm
VFIO - User Level meta-driver version: 0.3
aoe: AoE v85 initialised.
BUG: unable to handle page fault for address: ffffdc000000000f
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11826067 P4D 11826067 PUD 0 
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.19.0-syzkaller-14090-g4a9350597aff #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:kernfs_root fs/kernfs/kernfs-internal.h:68 [inline]
RIP: 0010:kernfs_new_node fs/kernfs/dir.c:655 [inline]
RIP: 0010:kernfs_create_dir_ns+0x7a/0x220 fs/kernfs/dir.c:1010
Code: 89 4c 24 04 4d 85 e4 4c 0f 44 e3 e8 80 25 7f ff 8b 4c 24 04 48 b8 00 00 00 00 00 fc ff df 49 8d 7c 24 78 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 4d 01 00 00 49 8b 7c 24 78 45 89 f9 6a 01 41 89
RSP: 0000:ffffc9000027fb38 EFLAGS: 00010a06
RAX: dffffc0000000000 RBX: ffff888016ffb0e8 RCX: 00000000000041ed
RDX: 1fffe0000000000f RSI: ffffffff81fc1040 RDI: ffff000000000078
RBP: 0000000000000000 R08: 0000000000000000 R09: ffff888147771400
R10: ffffed10281e6c62 R11: 0000000000000000 R12: ffff000000000000
R13: ffffffff8a90b800 R14: ffff888147771400 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffdc000000000f CR3: 000000000bc8e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 sysfs_create_dir_ns+0x127/0x290 fs/sysfs/dir.c:59
 create_dir lib/kobject.c:63 [inline]
 kobject_add_internal+0x2c9/0x8f0 lib/kobject.c:223
 kobject_add_varg lib/kobject.c:358 [inline]
 kobject_init_and_add+0x101/0x160 lib/kobject.c:441
 bus_add_driver+0x1e8/0x640 drivers/base/bus.c:611
 driver_register+0x220/0x3a0 drivers/base/driver.c:240
 i2c_register_driver+0xe1/0x1d0 drivers/i2c/i2c-core-base.c:1861
 do_one_initcall+0xfe/0x650 init/main.c:1296
 do_initcall_level init/main.c:1369 [inline]
 do_initcalls init/main.c:1385 [inline]
 do_basic_setup init/main.c:1404 [inline]
 kernel_init_freeable+0x6b1/0x73a init/main.c:1611
 kernel_init+0x1a/0x1d0 init/main.c:1500
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
Modules linked in:
CR2: ffffdc000000000f
---[ end trace 0000000000000000 ]---
RIP: 0010:kernfs_root fs/kernfs/kernfs-internal.h:68 [inline]
RIP: 0010:kernfs_new_node fs/kernfs/dir.c:655 [inline]
RIP: 0010:kernfs_create_dir_ns+0x7a/0x220 fs/kernfs/dir.c:1010
Code: 89 4c 24 04 4d 85 e4 4c 0f 44 e3 e8 80 25 7f ff 8b 4c 24 04 48 b8 00 00 00 00 00 fc ff df 49 8d 7c 24 78 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 4d 01 00 00 49 8b 7c 24 78 45 89 f9 6a 01 41 89
RSP: 0000:ffffc9000027fb38 EFLAGS: 00010a06
RAX: dffffc0000000000 RBX: ffff888016ffb0e8 RCX: 00000000000041ed
RDX: 1fffe0000000000f RSI: ffffffff81fc1040 RDI: ffff000000000078
RBP: 0000000000000000 R08: 0000000000000000 R09: ffff888147771400
R10: ffffed10281e6c62 R11: 0000000000000000 R12: ffff000000000000
R13: ffffffff8a90b800 R14: ffff888147771400 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffdc000000000f CR3: 000000000bc8e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	89 4c 24 04          	mov    %ecx,0x4(%rsp)
   4:	4d 85 e4             	test   %r12,%r12
   7:	4c 0f 44 e3          	cmove  %rbx,%r12
   b:	e8 80 25 7f ff       	callq  0xff7f2590
  10:	8b 4c 24 04          	mov    0x4(%rsp),%ecx
  14:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  1b:	fc ff df
  1e:	49 8d 7c 24 78       	lea    0x78(%r12),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 4d 01 00 00    	jne    0x181
  34:	49 8b 7c 24 78       	mov    0x78(%r12),%rdi
  39:	45 89 f9             	mov    %r15d,%r9d
  3c:	6a 01                	pushq  $0x1
  3e:	41                   	rex.B
  3f:	89                   	.byte 0x89


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
