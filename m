Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9D758EC4F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 14:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbiHJMw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 08:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbiHJMwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 08:52:06 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F411A85FA8;
        Wed, 10 Aug 2022 05:52:02 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id j11so2540471vkk.11;
        Wed, 10 Aug 2022 05:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=gQnGt11sYU7TtGfIaF/K3id3GmDhDH8Hzmxk1FvB3Rg=;
        b=ohxecnxKVbVYdEqQHq1cPJSjtbsa5aNQplATqS3pziEQPnO2DbFmDaaQsI6TPkr6yw
         c7FEBx2ww98QlsGA3foqHcoho1MJVTUqm8AmJFbwqBgESBehQ8cLQj7od0O1OX0R2qvX
         qvppy/6fOFTUA1jNwWukVKTxj+MN6hViyE9tPv2lyH1Kd+B0J2eqSW48pVe5VxDOXqrn
         DgAzLH6rAW4tr7DMZajj4I7bvwfyqYSRNh8bBUQeuFSRMLVB+6w9+9bvsL+WpYbSIKQ6
         Zb3xqr8++nIpLqKi/yxs7dt94ZvPq0kXFMTCmRPuUrM2K8SpqDqtASfhGPQ/9054aB02
         q2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=gQnGt11sYU7TtGfIaF/K3id3GmDhDH8Hzmxk1FvB3Rg=;
        b=5Z6UtfdMwH28EfjLrqp4kNJjKibmzR3wMTXPaE0i5Bo9GvQrj9PUUkTSEOOkYf/0wH
         kajfmrH96OnHDzPDYL+UQX0j2QS8Xn+jxHoaYOdd9Xz3B0HUSXIZeMr7oLRc3O0E7VSK
         Fu+k8Vhd4Os7VQna3yWRDGJcCe0fmFAD4PJhOs8dWhimG6lGJi9d0Xt/URfBi455m80Q
         eBZwKDSFK7bKF5wcIgmkpUoa6MZWEpysnTY04XhszJTkhG7Yk6vcf5QhwrXMOCQe6KCS
         bTbzdvHcrr2FCcuVgODCIWgRgfndldfcPPNkqGFdzJJZ5GCgfpMCqVkN4cwLKPMI38XE
         ZX6w==
X-Gm-Message-State: ACgBeo0U7dnU8fLEiTM/3xu5rIMJ7vDCCi/vfpfsu8IrZ/JTrRN4eezh
        YDn+mD76nUIGcJXokRQvYJuzi5joQS92zVhvS0QuwnOsSp8bQaOuTQg=
X-Google-Smtp-Source: AA6agR7xKKVL1WgRzo5qtaO2WJuce837T2d2yBpRwMQQOuZrqhpGUT6gsMzRTgs/aaVjo+FHzmnztrvdbOpd4X0n0Ko=
X-Received: by 2002:a05:6122:10e8:b0:377:412e:a69e with SMTP id
 m8-20020a05612210e800b00377412ea69emr11283505vko.17.1660135922023; Wed, 10
 Aug 2022 05:52:02 -0700 (PDT)
MIME-Version: 1.0
From:   Rondreis <linhaoguo86@gmail.com>
Date:   Wed, 10 Aug 2022 20:51:51 +0800
Message-ID: <CAB7eex+pLs0JkLB0DOW72tdd4+4XDdHkOeUJtcRc0GKfmPpHJA@mail.gmail.com>
Subject: linux v5.18 warn in imon_probe
To:     sean@mess.org, mchehab@kernel.org, linux-media@vger.kernel.org,
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

Hello,

When fuzzing the Linux kernel driver v5.18.0, the following crash was triggered.

HEAD commit: 4b0986a3613c92f4ec1bdc7f60ec66fea135991f (HEAD, tag: v5.18)
git tree: upstream

kernel config: https://pastebin.com/KecL2gaG
C reproducer: https://pastebin.com/F9uLd7Ax
console output: https://pastebin.com/c7CR3ZN1

Basically, in the c reproducer, we use the gadget module to emulate
the process of attaching a usb device (vendor id: 0x15c2, product
id:0x36, with function: midi).
To reproduce this crash, we utilize a third-party library to emulate
the attaching process: https://github.com/linux-usb-gadgets/libusbgx.
Just clone this repository, make install it, and compile the c
reproducer with ``` gcc crash.c -lusbgx -o crash ``` will do the
trick.

It seems that when usb_probe_interface calls the imon probe modules,
the imon_init_intf1 function did something wrong, causeing the kernel
to produce such an error message.

The crash report is as follow:

```
imon:imon_probe: failed to initialize context!
imon 2-1:1.0: unable to register, err -19
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(lock->magic != lock)
WARNING: CPU: 2 PID: 2324 at kernel/locking/mutex.c:582
__mutex_lock_common kernel/locking/mutex.c:582 [inline]
WARNING: CPU: 2 PID: 2324 at kernel/locking/mutex.c:582
__mutex_lock+0xf56/0x1f50 kernel/locking/mutex.c:747
Modules linked in:
CPU: 2 PID: 2324 Comm: kworker/2:2 Not tainted 5.19.0-rc4-00208-g69cb6c6556ad #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Workqueue: usb_hub_wq hub_event
RIP: 0010:__mutex_lock_common kernel/locking/mutex.c:582 [inline]
RIP: 0010:__mutex_lock+0xf56/0x1f50 kernel/locking/mutex.c:747
Code: 08 84 d2 0f 85 c7 0f 00 00 8b 15 5d 50 4e 03 85 d2 0f 85 d9 f1
ff ff 48 c7 c6 00 83 47 86 48 c7 c7 40 81 47 86 e8 38 12 d1 ff <0f> 0b
e9 bf f1 ff ff 0f 0b e9 6b f4 ff ff 48 8b 85 d0 fe ff ff 48
RSP: 0018:ffffc90002e2ef60 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffffc9000dec9000 RSI: ffff8881108fb900 RDI: fffff520005c5dde
RBP: ffffc90002e2f0c0 R08: ffffffff812c3638 R09: 0000000000000000
R10: 0000000000000005 R11: ffffed1023524ef1 R12: 0000000000000000
R13: dffffc0000000000 R14: ffff88811011ede0 R15: 0000000000000002
FS: 0000000000000000(0000) GS:ffff88811a900000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000001000003ff CR3: 000000010f696000 CR4: 0000000000350ee0
Call Trace:
<TASK>
imon_init_intf1 drivers/media/rc/imon.c:2323 [inline]
imon_probe+0x1e0/0x2bf0 drivers/media/rc/imon.c:2451
usb_probe_interface+0x310/0x800 drivers/usb/core/driver.c:396```
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
