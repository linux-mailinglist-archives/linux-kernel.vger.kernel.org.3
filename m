Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C65585F6E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 17:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236563AbiGaPMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 11:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233424AbiGaPM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 11:12:29 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88399DF8F
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 08:12:28 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id o5-20020a056e02102500b002ddcc65029cso5294168ilj.8
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 08:12:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=a+90tKGpxIgQGHZAFmR8vGKT1i1v6W2Mxa4cyi97svg=;
        b=t+P1H6UjhnqafisdGinLQya+vTBmMH0arkristVhcvZrNVs4qir4Mm12wuA9X9/ql5
         N2PG2gmq4JzAbnzNRmcPPsIMcZq18b9YfpnUSDxSa4mkgeddP2qPCA4yscLAR/jCH1RL
         zjPDSzbBXS5ppXKafjh5TnEj48KnaM0sp97Pv20mMVP0U96F9LMnqrv5NRAUBYlUYDcf
         7zsqSTqeRDrkO6kw04+X9l+Ds1em0luOdAJA9rFa4ykx92acsJacOvwzpHd/fRMcqVjs
         5csoW3ca+SL0aLIKWXQSOTsAOWJTg3EnzGcQ6t/3IC6qhPFj+MpPxccZKGJKTOMfkCxU
         oN/w==
X-Gm-Message-State: AJIora9JmNGED6fsd1A9I0eTKb5fBWEVITjj6qK/xIAm4vz+vFBaHHK1
        h2lezm6zhFDwcIvVS07btAAh0t1nO+o72ghBrde7PcabfLui
X-Google-Smtp-Source: AGRyM1s92FwyoWUQSUfpar2IQhAhdBOIZEm0A2lqgrIS6qOWhLh0KnMvlVVpLwMKTzuEeqpHos363hcB/ncoEVbCv7RBNhyX68JI
MIME-Version: 1.0
X-Received: by 2002:a92:ca07:0:b0:2dc:43d4:1e9a with SMTP id
 j7-20020a92ca07000000b002dc43d41e9amr4670237ils.240.1659280347953; Sun, 31
 Jul 2022 08:12:27 -0700 (PDT)
Date:   Sun, 31 Jul 2022 08:12:27 -0700
In-Reply-To: <000000000000bdee330594070441@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b901a205e51b4f46@google.com>
Subject: Re: [syzbot] memory leak in cap_inode_getsecurity
From:   syzbot <syzbot+942d5390db2d9624ced8@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        marka@mediation.com, phind.uet@gmail.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    6a010258447d Merge tag 'for-linus' of git://git.armlinux.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15883fee080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2a1dcc1942e30704
dashboard link: https://syzkaller.appspot.com/bug?extid=942d5390db2d9624ced8
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1568846a080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10f5e536080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+942d5390db2d9624ced8@syzkaller.appspotmail.com

executing program
BUG: memory leak
unreferenced object 0xffff88810f0ac060 (size 32):
  comm "syz-executor240", pid 3622, jiffies 4294961303 (age 14.040s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff814c6ecd>] __do_krealloc mm/slab_common.c:1185 [inline]
    [<ffffffff814c6ecd>] krealloc+0x4d/0xb0 mm/slab_common.c:1218
    [<ffffffff8162625c>] vfs_getxattr_alloc+0x13c/0x1c0 fs/xattr.c:379
    [<ffffffff822374b2>] cap_inode_getsecurity+0xb2/0x500 security/commoncap.c:400
    [<ffffffff8223d88c>] security_inode_getsecurity+0x7c/0xb0 security/security.c:1441
    [<ffffffff81625a0a>] xattr_getsecurity fs/xattr.c:327 [inline]
    [<ffffffff81625a0a>] vfs_getxattr+0x22a/0x290 fs/xattr.c:423
    [<ffffffff81c0ab02>] ovl_xattr_get+0x62/0xa0 fs/overlayfs/inode.c:404
    [<ffffffff81624742>] __vfs_getxattr+0x72/0xa0 fs/xattr.c:401
    [<ffffffff82236f52>] cap_inode_need_killpriv+0x22/0x40 security/commoncap.c:301
    [<ffffffff8223d773>] security_inode_need_killpriv+0x23/0x60 security/security.c:1419
    [<ffffffff8161074e>] dentry_needs_remove_privs fs/inode.c:1992 [inline]
    [<ffffffff8161074e>] dentry_needs_remove_privs+0x4e/0xa0 fs/inode.c:1982
    [<ffffffff815cfead>] do_truncate+0x7d/0x130 fs/open.c:57
    [<ffffffff815d0169>] vfs_truncate+0x209/0x240 fs/open.c:111
    [<ffffffff815d0268>] do_sys_truncate.part.0+0xc8/0xe0 fs/open.c:134
    [<ffffffff815d0303>] do_sys_truncate fs/open.c:128 [inline]
    [<ffffffff815d0303>] __do_sys_truncate fs/open.c:146 [inline]
    [<ffffffff815d0303>] __se_sys_truncate fs/open.c:144 [inline]
    [<ffffffff815d0303>] __x64_sys_truncate+0x33/0x50 fs/open.c:144
    [<ffffffff845b1955>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff845b1955>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd


