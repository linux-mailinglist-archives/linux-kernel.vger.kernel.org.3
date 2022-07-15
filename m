Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250C4576101
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 13:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbiGOL7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 07:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234855AbiGOL7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 07:59:14 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2283C1BE91
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 04:59:14 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id 11-20020a056e0216cb00b002dc7bfe6ad0so2669339ilx.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 04:59:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=lU6919p1fQXZXW5uVXDlDaBEyKPWJXQO/Yj2SZDGuEk=;
        b=aj9GFsX2soad9GDe0cGKy1oc5a6a4d8MZDsYjwuBn4pbvfCPhBlMRdcWWtQfgFNYU/
         8r74UqvtU67xNOI7HxdHFtuOGa77f9892oYJMV6f8Erk4XUd3q1imUyjw8pMuabZc3Ol
         vQg0P4oMR4X4nGTaefEMJWWN5zSGTwZ1jF9l9AbYvNaBkHMg8WilY/jVwU6dOeRin9jA
         2LFEwQIei8h/5fn7dSy5UR9sDywSkRx9Vg1ZEiLV6e36VvdXk1f5gmAuFSfXNfKoro1S
         SKX7vBQWhFVxP2uN4SjU8JDcQ8cz7+to3MNMrkFhRhu63tuNe47127lspLF2/reCh207
         rdUg==
X-Gm-Message-State: AJIora+XNL+nRupIjM0EzVhVrrtOcms1Qw6DsoTdgkk+kbz6Fdhu2IgA
        ft26trN245vewnjcNs4OPbhMT7epwA/kAiTTxYZ04eM2EnT2
X-Google-Smtp-Source: AGRyM1sy39xTaPftBhg6gDOBjBYzyngzL2fWm7WZtgK4R4c92+doSsbWnXqWOqxakfdt6I0YE9S0bRfVvYs/t0RXNizgLYHGIGvz
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:156d:b0:2dc:9027:accb with SMTP id
 k13-20020a056e02156d00b002dc9027accbmr6889686ilu.46.1657886353141; Fri, 15
 Jul 2022 04:59:13 -0700 (PDT)
Date:   Fri, 15 Jul 2022 04:59:13 -0700
In-Reply-To: <20220715114848.1124-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000028375a05e3d6bf94@google.com>
Subject: Re: [syzbot] INFO: trying to register non-static key in ieee80211_do_stop
From:   syzbot <syzbot+eceab52db7c4b961e9d6@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
SYZFATAL: executor failed NUM times: failed to create temp dir: mkdir ./syzkaller-testdir5ADDR: read-only file system

2022/07/15 11:58:52 SYZFATAL: executor failed 11 times: failed to create temp dir: mkdir ./syzkaller-testdir573412366: read-only file system


Tested on:

commit:         b11e5f6a net: sunhme: output link status with a single..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14133fa4080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa95f12403a2e0d2
dashboard link: https://syzkaller.appspot.com/bug?extid=eceab52db7c4b961e9d6
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13043006080000

