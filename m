Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1F258EC48
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 14:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbiHJMuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 08:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbiHJMut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 08:50:49 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0573127CF8;
        Wed, 10 Aug 2022 05:50:49 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id s18so5733959uac.10;
        Wed, 10 Aug 2022 05:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=u9HzZ8DsgI9iKYzLtTEMKzhlDYNmnztrsJyoQBfbgiU=;
        b=X2AC8TYKn79PMiUuJjYrx+fcXLeQdfsmRyi7XrPmlxf0WYPsKLZjPvOFIZkDka22b5
         YJ7JgdwQCELjH0h9u9wL2e7VQ5/x3rfsMOdafH9br5+WN+OjPS51otDaRiP+zeL78hq3
         jJf+7ee3V26hsG/RRNl+pJYMZ2CYgkuEh6FEILyRUght7P2vbIwlDdZVDMKLikY/T1Ov
         7XOEDy8ABnv3CzQpVuFLDWXN5blavp7nAxYJwi2YdgqpaJIO3XbXIs7nJ+2DFqaTzuxv
         EbEu0dHGZgtlHW0vOVcWf4Kk6bz+wEsVCCREsCDCpkS6+NU1fSsl2RP/05lggL4npsLu
         fO6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=u9HzZ8DsgI9iKYzLtTEMKzhlDYNmnztrsJyoQBfbgiU=;
        b=HuPx8BonUdZ1DOT24DHxs0I4CQSb8oCl9iOJV45VyDplpFWHoIFKVP2RIfIbHndhZ4
         0U5/eDHM+09qOJddbEA1vr8M5DRo9LZ0Y+RlalO66MmeNlNBm0sUIU1MohWcpBJxogUw
         OxbUy0HB9qV5BC9sq3tQUAUOFLkfyYm+iXxdzYxmAkmZWLs6IYoc0Lu+V7fBHgwqwZZj
         V35TEXDao5t7AjsV/wzVbwDl5Eyuw8kvIT/fK8icXo+J9UDLrEPkMryzHojvjTGF9oV7
         uJi5wdausHFc1dnyimh2oqYnfITWX36WhveRHbs8EfZ2OnhRmUsMt4vXXEABPH3OzqFH
         MErw==
X-Gm-Message-State: ACgBeo0JW3xGAKiHSFtxy2IwQ9POdy7hOZ11pl05UWPZG8RYz0yiG/fH
        xNK0hIfJRY8fd5jtD5QzPicsUUQgkNIxV1hkH4w=
X-Google-Smtp-Source: AA6agR65zs/dCLuEvTYFrTnwBgMLevuPGb9hbni2HeonS9akr8SPN2zjZH+C9jN7S7mxFmLVYb0J+F1odGaeBZYeH7E=
X-Received: by 2002:ab0:6197:0:b0:387:8e6e:91b8 with SMTP id
 h23-20020ab06197000000b003878e6e91b8mr11955716uan.26.1660135848002; Wed, 10
 Aug 2022 05:50:48 -0700 (PDT)
MIME-Version: 1.0
From:   Rondreis <linhaoguo86@gmail.com>
Date:   Wed, 10 Aug 2022 20:50:37 +0800
Message-ID: <CAB7eex+XpF0RdFTe_ZWhTpKou=WzA2-1Q2DUxoUBb3yo9f3e0g@mail.gmail.com>
Subject: warn in mceusb_dev_probe in linux v5.18
To:     justin@coraid.com, axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Title: WARNING in mceusb_dev_probe

Hello,

When fuzzing the Linux kernel driver v5.18.0, the following crash was triggered.

HEAD commit: 4b0986a3613c92f4ec1bdc7f60ec66fea135991f (HEAD, tag: v5.18)
git tree: upstream

kernel config: https://pastebin.com/KecL2gaG
C reproducer: https://pastebin.com/UyrcmcDs
console output: https://pastebin.com/XT7jayHs

Basically, in the c reproducer, we use the gadget module to emulate
the process of attaching a usb device (vendor id: 0x45e, product id:
0x6d, with function: loopback_null).
To reproduce this crash, we utilize a third-party library to emulate
the attaching process: https://github.com/linux-usb-gadgets/libusbgx.
Just clone this repository, make install it, and compile the c
reproducer with ``` gcc crash.c -lusbgx -o crash ``` will do the
trick.

The crash report is as follow:

```
input: Media Center Ed. eHome Infrared Remote Transceiver (045e:006d)
as /devices/platform/dummy_hcd.5/usb6/6-1/6-1:1.0/rc/rc0/input4
------------[ cut here ]------------
usb 6-1: BOGUS control dir, pipe 80000380 doesn't match bRequestType 40
WARNING: CPU: 0 PID: 2465 at drivers/usb/core/urb.c:410
usb_submit_urb+0x1326/0x1820 drivers/usb/core/urb.c:410
Modules linked in:
CPU: 0 PID: 2465 Comm: kworker/0:2 Not tainted 5.19.0-rc4-00208-g69cb6c6556ad #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Workqueue: usb_hub_wq hub_event
RIP: 0010:usb_submit_urb+0x1326/0x1820 drivers/usb/core/urb.c:410
Code: 7c 24 40 e8 ac 23 91 fd 48 8b 7c 24 40 e8 b2 70 1b ff 45 89 e8
44 89 f1 4c 89 e2 48 89 c6 48 c7 c7 a0 30 a9 86 e8 48 07 11 02 <0f> 0b
e9 1c f0 ff ff e8 7e 23 91 fd 0f b6 1d 63 22 83 05 31 ff 41
RSP: 0018:ffffc900032becf0 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff8881100f3058 RCX: 0000000000000000
RDX: ffffc90004961000 RSI: ffff888114c6d580 RDI: fffff52000657d90
RBP: ffff888105ad90f0 R08: ffffffff812c3638 R09: 0000000000000000
R10: 0000000000000005 R11: ffffed1023504ef1 R12: ffff888105ad9000
R13: 0000000000000040 R14: 0000000080000380 R15: ffff88810ba96500
FS: 0000000000000000(0000) GS:ffff88811a800000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe810bda58 CR3: 000000010b720000 CR4: 0000000000350ef0
Call Trace:
<TASK>
usb_start_wait_urb+0x101/0x4c0 drivers/usb/core/message.c:58
usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
usb_control_msg+0x31c/0x4a0 drivers/usb/core/message.c:153
mceusb_gen1_init drivers/media/rc/mceusb.c:1431 [inline]
mceusb_dev_probe+0x258e/0x33f0 drivers/media/rc/mceusb.c:1807
usb_probe_interface+0x310/0x800 drivers/usb/core/driver.c:396
call_driver_probe drivers/base/dd.c:555 [inline]
really_probe drivers/base/dd.c:634 [inline]
really_probe+0x23e/0xa80 drivers/base/dd.c:579
__driver_probe_device+0x338/0x4d0 drivers/base/dd.c:764
driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:794
__device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:917
bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
__device_attach+0x283/0x490 drivers/base/dd.c:989
bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
device_add+0xc9b/0x1da0 drivers/base/core.c:3417
usb_set_configuration+0x1019/0x1900 drivers/usb/core/message.c:2170
usb_generic_driver_probe+0x9d/0xe0 drivers/usb/core/generic.c:238
usb_probe_device+0xd9/0x2a0 drivers/usb/core/driver.c:293
call_driver_probe drivers/base/dd.c:555 [inline]
really_probe drivers/base/dd.c:634 [inline]
really_probe+0x23e/0xa80 drivers/base/dd.c:579
__driver_probe_device+0x338/0x4d0 drivers/base/dd.c:764
driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:794
__device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:917
bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
__device_attach+0x283/0x490 drivers/base/dd.c:989
bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
device_add+0xc9b/0x1da0 drivers/base/core.c:3417
usb_new_device.cold+0x4b8/0x10ca drivers/usb/core/hub.c:2566
hub_port_connect drivers/usb/core/hub.c:5363 [inline]
hub_port_connect_change drivers/usb/core/hub.c:5507 [inline]
port_event drivers/usb/core/hub.c:5663 [inline]
hub_event+0x232d/0x4180 drivers/usb/core/hub.c:5745
process_one_work+0x9cc/0x1650 kernel/workqueue.c:2289
worker_thread+0x623/0x1070 kernel/workqueue.c:2436
kthread+0x2ef/0x3a0 kernel/kthread.c:376
ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
</TASK>


```
