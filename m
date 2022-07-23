Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB44757F214
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 01:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239086AbiGWX0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 19:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239028AbiGWX0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 19:26:37 -0400
X-Greylist: delayed 302 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 23 Jul 2022 16:26:33 PDT
Received: from m228-10.mailgun.net (m228-10.mailgun.net [159.135.228.10])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 34BA815726
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 16:26:33 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mixtli.metztli.it; q=dns/txt;
 s=mx; t=1658618793; x=1658827593; h=From: From: Date: Message-Id: To:
 To: Subject: Subject: Sender: Sender;
 bh=Wy7nM5HJLshLtphD4ZPaviHkvdj76zQlNqP1yxJy+JA=; b=m4z1ipsERgvXrmIyYBJbN2bU7uQf6jgmHwgVI3bFhSNxY+dO548hjyMyXEGifq7GGHI/9X7N
 OQBhbXdHKLIK/XX6aMMRjfD2r31ASbGZENWuJgR7fknyb/408TheKuOghzfhl0QOKNmrN15N
 9V2F2dk5+O8aEbjvXNJAmh5MLbM=
X-Mailgun-Sending-Ip: 159.135.228.10
X-Mailgun-Sid: WyIxYzIzYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgIjE3YjU0Il0=
Received: from tezcatlipoca.metztli.it
 (99-130-254-3.lightspeed.sntcca.sbcglobal.net [99.130.254.3]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 62dc827a3bbaff15a0204e7f (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Sat, 23 Jul 2022 23:21:30 GMT
Sender: jose.r.r=metztli.com@mixtli.metztli.it
Received: by tezcatlipoca.metztli.it (Postfix, from userid 1000)
        id C0ECCA51662; Sat, 23 Jul 2022 16:22:11 -0700 (PDT)
Subject: Issues with Reiser4 SFRN 4.0.2 modified patch for Linux 5.17.xy
To:     <edward.shishkin@gmail.com>, <reiserfs-devel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
X-Mailer: mail (GNU Mailutils 3.10)
Message-Id: <20220723232211.C0ECCA51662@tezcatlipoca.metztli.it>
Date:   Sat, 23 Jul 2022 16:22:11 -0700 (PDT)
From:   Metztli Information Technology <jose.r.r@metztli.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Niltze [Hello], Ed-

Having experienced hanging issue(s) with reiser4-for-5.16.patch.gz I decided to apply the patch to kernel 5.17.6/5.17.12 --
modifying the patch as I proceede along; here is my modified patch for linux 5.17.xy:
< https://metztli.blog/nochtli/tliltic?download=926 >

I have been running that reiser4 SFRN 4.0.2 -patched kernel for 42+ days
< https://metztli.it/bullseye/reiser4.0.2-amd-ryzen.png >
 in an online server, ruby, LEMP, etc., where
the only issue I experience is related to memory depletion, i.e., when building a kernel and/or sustained data intensive operations.

Similarly, running Intel version of kernel locally but interacting with desktop userland applications often degrades the
performance of the system by introducing a hang-like condition (see concatenated dmesg tail subsequently after the three(3) dotted segment below).

As Debian Bullseye backports is now at kernel 5.18.xy, I have tried to enhance your reiser4 patch to target that kernel as my Reiser4 netboot installers depend on it. Nevertheless, I have not succeeded in properly patching that newer kernel. Any updates would be appreciated.

...
[44950.574859] INFO: task umount:21534 blocked for more than 120 seconds.
[44950.574871]       Tainted: G            E     5.17.0-3+reiser4.0.2-amd64 #1 Debian 5.17.12-2+reiser4.0.2
[44950.574874] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[44950.574876] task:umount          state:D stack:    0 pid:21534 ppid:  3155 flags:0x00004000
[44950.574882] Call Trace:
[44950.574885]  <TASK>
[44950.574889]  __schedule+0x307/0x9e0
[44950.574901]  schedule+0x4e/0xc0
[44950.574906]  rwsem_down_write_slowpath+0x2a7/0x5a0
[44950.574913]  ? fsnotify_grab_connector+0x20/0x90
[44950.574919]  deactivate_super+0x2c/0x40
[44950.574926]  cleanup_mnt+0x131/0x190
[44950.574932]  task_work_run+0x5c/0x90
[44950.574936]  exit_to_user_mode_prepare+0x200/0x210
[44950.574943]  syscall_exit_to_user_mode+0x18/0x40
[44950.574947]  do_syscall_64+0x48/0xc0
[44950.574952]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[44950.574957] RIP: 0033:0x7f506e43ce27
[44950.574961] RSP: 002b:00007ffff5f00c78 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
[44950.574965] RAX: 0000000000000000 RBX: 00007f506e560264 RCX: 00007f506e43ce27
[44950.574967] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000055ff1a1c0f90
[44950.574969] RBP: 000055ff1a1bc9a0 R08: 0000000000000000 R09: 00007ffff5effa20
[44950.574971] R10: 000055ff1a1c0fb0 R11: 0000000000000246 R12: 0000000000000000
[44950.574973] R13: 000055ff1a1c0f90 R14: 000055ff1a1bcab0 R15: 000055ff1a1bcbd0
[44950.574977]  </TASK>
[45071.406956] INFO: task umount:21534 blocked for more than 241 seconds.
[45071.406972]       Tainted: G            E     5.17.0-3+reiser4.0.2-amd64 #1 Debian 5.17.12-2+reiser4.0.2
[45071.406977] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[45071.406982] task:umount          state:D stack:    0 pid:21534 ppid:  3155 flags:0x00004000
[45071.406994] Call Trace:
[45071.406998]  <TASK>
[45071.407006]  __schedule+0x307/0x9e0
[45071.407027]  schedule+0x4e/0xc0
[45071.407034]  rwsem_down_write_slowpath+0x2a7/0x5a0
[45071.407043]  ? fsnotify_grab_connector+0x20/0x90
[45071.407053]  deactivate_super+0x2c/0x40
[45071.407062]  cleanup_mnt+0x131/0x190
[45071.407070]  task_work_run+0x5c/0x90
[45071.407076]  exit_to_user_mode_prepare+0x200/0x210
[45071.407084]  syscall_exit_to_user_mode+0x18/0x40
[45071.407089]  do_syscall_64+0x48/0xc0
[45071.407098]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[45071.407107] RIP: 0033:0x7f506e43ce27
[45071.407112] RSP: 002b:00007ffff5f00c78 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
[45071.407119] RAX: 0000000000000000 RBX: 00007f506e560264 RCX: 00007f506e43ce27
[45071.407122] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000055ff1a1c0f90
[45071.407125] RBP: 000055ff1a1bc9a0 R08: 0000000000000000 R09: 00007ffff5effa20
[45071.407128] R10: 000055ff1a1c0fb0 R11: 0000000000000246 R12: 0000000000000000
[45071.407131] R13: 000055ff1a1c0f90 R14: 000055ff1a1bcab0 R15: 000055ff1a1bcbd0
[45071.407137]  </TASK>
[45192.238981] INFO: task umount:21534 blocked for more than 362 seconds.
[45192.239006]       Tainted: G            E     5.17.0-3+reiser4.0.2-amd64 #1 Debian 5.17.12-2+reiser4.0.2
[45192.239013] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[45192.239018] task:umount          state:D stack:    0 pid:21534 ppid:  3155 flags:0x00004000
[45192.239032] Call Trace:
[45192.239038]  <TASK>
[45192.239045]  __schedule+0x307/0x9e0
[45192.239070]  schedule+0x4e/0xc0
[45192.239082]  rwsem_down_write_slowpath+0x2a7/0x5a0
[45192.239095]  ? fsnotify_grab_connector+0x20/0x90
[45192.239111]  deactivate_super+0x2c/0x40
[45192.239124]  cleanup_mnt+0x131/0x190
[45192.239138]  task_work_run+0x5c/0x90
[45192.239148]  exit_to_user_mode_prepare+0x200/0x210
[45192.239160]  syscall_exit_to_user_mode+0x18/0x40
[45192.239169]  do_syscall_64+0x48/0xc0
[45192.239182]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[45192.239195] RIP: 0033:0x7f506e43ce27
[45192.239203] RSP: 002b:00007ffff5f00c78 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
[45192.239212] RAX: 0000000000000000 RBX: 00007f506e560264 RCX: 00007f506e43ce27
[45192.239218] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000055ff1a1c0f90
[45192.239222] RBP: 000055ff1a1bc9a0 R08: 0000000000000000 R09: 00007ffff5effa20
[45192.239227] R10: 000055ff1a1c0fb0 R11: 0000000000000246 R12: 0000000000000000
[45192.239232] R13: 000055ff1a1c0f90 R14: 000055ff1a1bcab0 R15: 000055ff1a1bcbd0
[45192.239241]  </TASK>
[45313.075008] INFO: task umount:21534 blocked for more than 483 seconds.
[45313.075038]       Tainted: G            E     5.17.0-3+reiser4.0.2-amd64 #1 Debian 5.17.12-2+reiser4.0.2
[45313.075050] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[45313.075059] task:umount          state:D stack:    0 pid:21534 ppid:  3155 flags:0x00004000
[45313.075078] Call Trace:
[45313.075083]  <TASK>
[45313.075091]  __schedule+0x307/0x9e0
[45313.075117]  schedule+0x4e/0xc0
[45313.075130]  rwsem_down_write_slowpath+0x2a7/0x5a0
[45313.075144]  ? fsnotify_grab_connector+0x20/0x90
[45313.075159]  deactivate_super+0x2c/0x40
[45313.075173]  cleanup_mnt+0x131/0x190
[45313.075186]  task_work_run+0x5c/0x90
[45313.075197]  exit_to_user_mode_prepare+0x200/0x210
[45313.075209]  syscall_exit_to_user_mode+0x18/0x40
[45313.075218]  do_syscall_64+0x48/0xc0
[45313.075231]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[45313.075243] RIP: 0033:0x7f506e43ce27
[45313.075252] RSP: 002b:00007ffff5f00c78 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
[45313.075261] RAX: 0000000000000000 RBX: 00007f506e560264 RCX: 00007f506e43ce27
[45313.075267] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000055ff1a1c0f90
[45313.075272] RBP: 000055ff1a1bc9a0 R08: 0000000000000000 R09: 00007ffff5effa20
[45313.075276] R10: 000055ff1a1c0fb0 R11: 0000000000000246 R12: 0000000000000000
[45313.075281] R13: 000055ff1a1c0f90 R14: 000055ff1a1bcab0 R15: 000055ff1a1bcbd0
[45313.075290]  </TASK>
[45433.903013] INFO: task umount:21534 blocked for more than 604 seconds.
[45433.903038]       Tainted: G            E     5.17.0-3+reiser4.0.2-amd64 #1 Debian 5.17.12-2+reiser4.0.2
[45433.903045] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[45433.903050] task:umount          state:D stack:    0 pid:21534 ppid:  3155 flags:0x00004000
[45433.903064] Call Trace:
[45433.903069]  <TASK>
[45433.903077]  __schedule+0x307/0x9e0
[45433.903102]  schedule+0x4e/0xc0
[45433.903114]  rwsem_down_write_slowpath+0x2a7/0x5a0
[45433.903128]  ? fsnotify_grab_connector+0x20/0x90
[45433.903143]  deactivate_super+0x2c/0x40
[45433.903157]  cleanup_mnt+0x131/0x190
[45433.903170]  task_work_run+0x5c/0x90
[45433.903182]  exit_to_user_mode_prepare+0x200/0x210
[45433.903193]  syscall_exit_to_user_mode+0x18/0x40
[45433.903202]  do_syscall_64+0x48/0xc0
[45433.903215]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[45433.903227] RIP: 0033:0x7f506e43ce27
[45433.903236] RSP: 002b:00007ffff5f00c78 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
[45433.903246] RAX: 0000000000000000 RBX: 00007f506e560264 RCX: 00007f506e43ce27
[45433.903252] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000055ff1a1c0f90
[45433.903256] RBP: 000055ff1a1bc9a0 R08: 0000000000000000 R09: 00007ffff5effa20
[45433.903261] R10: 000055ff1a1c0fb0 R11: 0000000000000246 R12: 0000000000000000
[45433.903266] R13: 000055ff1a1c0f90 R14: 000055ff1a1bcab0 R15: 000055ff1a1bcbd0
[45433.903275]  </TASK>
[45554.735055] INFO: task umount:21534 blocked for more than 724 seconds.
[45554.735078]       Tainted: G            E     5.17.0-3+reiser4.0.2-amd64 #1 Debian 5.17.12-2+reiser4.0.2
[45554.735085] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[45554.735090] task:umount          state:D stack:    0 pid:21534 ppid:  3155 flags:0x00004000
[45554.735105] Call Trace:
[45554.735110]  <TASK>
[45554.735119]  __schedule+0x307/0x9e0
[45554.735144]  schedule+0x4e/0xc0
[45554.735156]  rwsem_down_write_slowpath+0x2a7/0x5a0
[45554.735169]  ? fsnotify_grab_connector+0x20/0x90
[45554.735184]  deactivate_super+0x2c/0x40
[45554.735199]  cleanup_mnt+0x131/0x190
[45554.735211]  task_work_run+0x5c/0x90
[45554.735222]  exit_to_user_mode_prepare+0x200/0x210
[45554.735234]  syscall_exit_to_user_mode+0x18/0x40
[45554.735243]  do_syscall_64+0x48/0xc0
[45554.735255]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[45554.735268] RIP: 0033:0x7f506e43ce27
[45554.735276] RSP: 002b:00007ffff5f00c78 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
[45554.735286] RAX: 0000000000000000 RBX: 00007f506e560264 RCX: 00007f506e43ce27
[45554.735292] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000055ff1a1c0f90
[45554.735296] RBP: 000055ff1a1bc9a0 R08: 0000000000000000 R09: 00007ffff5effa20
[45554.735301] R10: 000055ff1a1c0fb0 R11: 0000000000000246 R12: 0000000000000000
[45554.735306] R13: 000055ff1a1c0f90 R14: 000055ff1a1bcab0 R15: 000055ff1a1bcbd0
[45554.735315]  </TASK>
[45675.567002] INFO: task umount:21534 blocked for more than 845 seconds.
[45675.567025]       Tainted: G            E     5.17.0-3+reiser4.0.2-amd64 #1 Debian 5.17.12-2+reiser4.0.2
[45675.567033] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[45675.567038] task:umount          state:D stack:    0 pid:21534 ppid:  3155 flags:0x00004000
[45675.567052] Call Trace:
[45675.567058]  <TASK>
[45675.567066]  __schedule+0x307/0x9e0
[45675.567090]  schedule+0x4e/0xc0
[45675.567102]  rwsem_down_write_slowpath+0x2a7/0x5a0
[45675.567116]  ? fsnotify_grab_connector+0x20/0x90
[45675.567131]  deactivate_super+0x2c/0x40
[45675.567145]  cleanup_mnt+0x131/0x190
[45675.567158]  task_work_run+0x5c/0x90
[45675.567168]  exit_to_user_mode_prepare+0x200/0x210
[45675.567180]  syscall_exit_to_user_mode+0x18/0x40
[45675.567189]  do_syscall_64+0x48/0xc0
[45675.567201]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[45675.567214] RIP: 0033:0x7f506e43ce27
[45675.567222] RSP: 002b:00007ffff5f00c78 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
[45675.567231] RAX: 0000000000000000 RBX: 00007f506e560264 RCX: 00007f506e43ce27
[45675.567237] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000055ff1a1c0f90
[45675.567242] RBP: 000055ff1a1bc9a0 R08: 0000000000000000 R09: 00007ffff5effa20
[45675.567246] R10: 000055ff1a1c0fb0 R11: 0000000000000246 R12: 0000000000000000
[45675.567251] R13: 000055ff1a1c0f90 R14: 000055ff1a1bcab0 R15: 000055ff1a1bcbd0
[45675.567260]  </TASK>
[45796.398969] INFO: task umount:21534 blocked for more than 966 seconds.
[45796.398994]       Tainted: G            E     5.17.0-3+reiser4.0.2-amd64 #1 Debian 5.17.12-2+reiser4.0.2
[45796.399002] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[45796.399007] task:umount          state:D stack:    0 pid:21534 ppid:  3155 flags:0x00004000
[45796.399021] Call Trace:
[45796.399027]  <TASK>
[45796.399035]  __schedule+0x307/0x9e0
[45796.399060]  schedule+0x4e/0xc0
[45796.399072]  rwsem_down_write_slowpath+0x2a7/0x5a0
[45796.399085]  ? fsnotify_grab_connector+0x20/0x90
[45796.399100]  deactivate_super+0x2c/0x40
[45796.399114]  cleanup_mnt+0x131/0x190
[45796.399127]  task_work_run+0x5c/0x90
[45796.399138]  exit_to_user_mode_prepare+0x200/0x210
[45796.399149]  syscall_exit_to_user_mode+0x18/0x40
[45796.399158]  do_syscall_64+0x48/0xc0
[45796.399170]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[45796.399182] RIP: 0033:0x7f506e43ce27
[45796.399191] RSP: 002b:00007ffff5f00c78 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
[45796.399201] RAX: 0000000000000000 RBX: 00007f506e560264 RCX: 00007f506e43ce27
[45796.399206] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000055ff1a1c0f90
[45796.399211] RBP: 000055ff1a1bc9a0 R08: 0000000000000000 R09: 00007ffff5effa20
[45796.399216] R10: 000055ff1a1c0fb0 R11: 0000000000000246 R12: 0000000000000000
[45796.399221] R13: 000055ff1a1c0f90 R14: 000055ff1a1bcab0 R15: 000055ff1a1bcbd0
[45796.399230]  </TASK>
[45917.231038] INFO: task umount:21534 blocked for more than 1087 seconds.
[45917.231062]       Tainted: G            E     5.17.0-3+reiser4.0.2-amd64 #1 Debian 5.17.12-2+reiser4.0.2
[45917.231070] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[45917.231075] task:umount          state:D stack:    0 pid:21534 ppid:  3155 flags:0x00004000
[45917.231089] Call Trace:
[45917.231094]  <TASK>
[45917.231102]  __schedule+0x307/0x9e0
[45917.231127]  schedule+0x4e/0xc0
[45917.231139]  rwsem_down_write_slowpath+0x2a7/0x5a0
[45917.231152]  ? fsnotify_grab_connector+0x20/0x90
[45917.231168]  deactivate_super+0x2c/0x40
[45917.231181]  cleanup_mnt+0x131/0x190
[45917.231194]  task_work_run+0x5c/0x90
[45917.231205]  exit_to_user_mode_prepare+0x200/0x210
[45917.231217]  syscall_exit_to_user_mode+0x18/0x40
[45917.231226]  do_syscall_64+0x48/0xc0
[45917.231238]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[45917.231251] RIP: 0033:0x7f506e43ce27
[45917.231259] RSP: 002b:00007ffff5f00c78 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
[45917.231269] RAX: 0000000000000000 RBX: 00007f506e560264 RCX: 00007f506e43ce27
[45917.231275] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000055ff1a1c0f90
[45917.231279] RBP: 000055ff1a1bc9a0 R08: 0000000000000000 R09: 00007ffff5effa20
[45917.231284] R10: 000055ff1a1c0fb0 R11: 0000000000000246 R12: 0000000000000000
[45917.231289] R13: 000055ff1a1c0f90 R14: 000055ff1a1bcab0 R15: 000055ff1a1bcbd0
[45917.231298]  </TASK>
[46038.062935] INFO: task umount:21534 blocked for more than 1208 seconds.
[46038.062959]       Tainted: G            E     5.17.0-3+reiser4.0.2-amd64 #1 Debian 5.17.12-2+reiser4.0.2
[46038.062967] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[46038.062972] task:umount          state:D stack:    0 pid:21534 ppid:  3155 flags:0x00004000
[46038.062987] Call Trace:
[46038.062992]  <TASK>
[46038.063000]  __schedule+0x307/0x9e0
[46038.063024]  schedule+0x4e/0xc0
[46038.063036]  rwsem_down_write_slowpath+0x2a7/0x5a0
[46038.063050]  ? fsnotify_grab_connector+0x20/0x90
[46038.063065]  deactivate_super+0x2c/0x40
[46038.063079]  cleanup_mnt+0x131/0x190
[46038.063092]  task_work_run+0x5c/0x90
[46038.063103]  exit_to_user_mode_prepare+0x200/0x210
[46038.063115]  syscall_exit_to_user_mode+0x18/0x40
[46038.063123]  do_syscall_64+0x48/0xc0
[46038.063135]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[46038.063149] RIP: 0033:0x7f506e43ce27
[46038.063161] RSP: 002b:00007ffff5f00c78 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
[46038.063175] RAX: 0000000000000000 RBX: 00007f506e560264 RCX: 00007f506e43ce27
[46038.063184] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000055ff1a1c0f90
[46038.063192] RBP: 000055ff1a1bc9a0 R08: 0000000000000000 R09: 00007ffff5effa20
[46038.063200] R10: 000055ff1a1c0fb0 R11: 0000000000000246 R12: 0000000000000000
[46038.063209] R13: 000055ff1a1c0f90 R14: 000055ff1a1bcab0 R15: 000055ff1a1bcbd0
[46038.063221]  </TASK>
[51091.892156] sysrq: Show Blocked State
[51091.892227] task:kworker/u16:3   state:D stack:    0 pid:21032 ppid:     2 flags:0x00004000
[51091.892234] Workqueue: writeback wb_workfn (flush-8:0)
[51091.892243] Call Trace:
[51091.892245]  <TASK>
[51091.892249]  __schedule+0x307/0x9e0
[51091.892258]  schedule+0x4e/0xc0
[51091.892263]  io_schedule+0x47/0x70
[51091.892268]  folio_wait_bit_common+0x147/0x390
[51091.892274]  ? file_fdatawait_range+0x20/0x20
[51091.892278]  folio_wait_writeback+0x28/0x80
[51091.892285]  jwait_io+0x4b/0x60 [reiser4]
[51091.892310]  reiser4_write_logs+0x897/0xc70 [reiser4]
[51091.892341]  ? commit_txnh+0x3db/0x580 [reiser4]
[51091.892367]  ? reiser4_txn_restart+0x1e/0x70 [reiser4]
[51091.892392]  ? flush_some_atom+0x330/0x570 [reiser4]
[51091.892418]  ? reiser4_writeout+0x10a/0x180 [reiser4]
[51091.892447]  ? reiser4_writeback_inodes+0xb0/0xe0 [reiser4]
[51091.892474]  ? writeback_sb_inodes+0x8f/0xb0
[51091.892478]  ? __writeback_inodes_wb+0x4c/0xe0
[51091.892482]  ? wb_writeback+0x1d7/0x2c0
[51091.892486]  ? wb_workfn+0x2ed/0x510
[51091.892489]  ? psi_task_switch+0xbc/0x1f0
[51091.892493]  ? _raw_spin_unlock+0x16/0x30
[51091.892497]  ? process_one_work+0x1e5/0x3b0
[51091.892501]  ? rescuer_thread+0x390/0x390
[51091.892504]  ? worker_thread+0x50/0x3a0
[51091.892506]  ? rescuer_thread+0x390/0x390
[51091.892509]  ? kthread+0xe7/0x110
[51091.892513]  ? kthread_complete_and_exit+0x20/0x20
[51091.892517]  ? ret_from_fork+0x22/0x30
[51091.892523]  </TASK>
[51091.892527] task:umount          state:D stack:    0 pid:21534 ppid:  3155 flags:0x00004000
[51091.892531] Call Trace:
[51091.892533]  <TASK>
[51091.892535]  __schedule+0x307/0x9e0
[51091.892541]  schedule+0x4e/0xc0
[51091.892545]  rwsem_down_write_slowpath+0x2a7/0x5a0
[51091.892549]  ? fsnotify_grab_connector+0x20/0x90
[51091.892556]  deactivate_super+0x2c/0x40
[51091.892561]  cleanup_mnt+0x131/0x190
[51091.892567]  task_work_run+0x5c/0x90
[51091.892571]  exit_to_user_mode_prepare+0x200/0x210
[51091.892576]  syscall_exit_to_user_mode+0x18/0x40
[51091.892580]  do_syscall_64+0x48/0xc0
[51091.892585]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[51091.892590] RIP: 0033:0x7f506e43ce27
[51091.892594] RSP: 002b:00007ffff5f00c78 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
[51091.892597] RAX: 0000000000000000 RBX: 00007f506e560264 RCX: 00007f506e43ce27
[51091.892600] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000055ff1a1c0f90
[51091.892601] RBP: 000055ff1a1bc9a0 R08: 0000000000000000 R09: 00007ffff5effa20
[51091.892603] R10: 000055ff1a1c0fb0 R11: 0000000000000246 R12: 0000000000000000
[51091.892605] R13: 000055ff1a1c0f90 R14: 000055ff1a1bcab0 R15: 000055ff1a1bcbd0
[51091.892609]  </TASK>


Best Professional Regards.

Jose R R
http://metztli.it
---------------------------------------------------------------------------------------------
Download Metztli Reiser4: Debian Bullseye w/ Linux 5.16.20 AMD64
---------------------------------------------------------------------------------------------
feats ZSTD compression https://sf.net/projects/metztli-reiser4/
---------------------------------------------------------------------------------------------
or SFRN 5.1.3, Metztli Reiser5 https://sf.net/projects/debian-reiser4/
-------------------------------------------------------------------------------------------
Official current Reiser4 resources: https://reiser4.wiki.kernel.org/
