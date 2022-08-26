Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C445A292D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 16:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235939AbiHZOQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 10:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiHZOQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 10:16:16 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D113342F
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 07:16:14 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id l20-20020a056e02067400b002dfa7256498so1234405ilt.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 07:16:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=ksxSogszh3RDfpZCg9v7flKQN91BMpsdsn/LVGg+pEc=;
        b=ht/PPKDTzPx+7nTzVgIJZIgm8BXcH4PkwRRyl4TVIy3EaLsR4zfG3nqmnskO2nyNod
         Ygij68HrZqRzb5dc1pCg40yW9auUA4Q7Prlbzt2mWkpXTshhZhq3YwBhNRQHs2/7KLQH
         2JMsw/hWqsIk1To01ZKjFiFlqFRHfS7Po+Avx7qXr+ZSjt5/f80fqn1XHZdLUYodIbXL
         04NjNF2vg2GoB9rxuj+D/jpvrUSSoLXOFd4iHXKR2TV1ZQ27w0bobndXrs4ry1huFQ2U
         zcmGflx/ka56ycYeEN6GdfIePZrg1SUVDs9LXyO5/+yYg9RdqLgf+my5ISo0D64SGKvD
         pSkg==
X-Gm-Message-State: ACgBeo2WI1V1Hj3UVaGHZJQBqNXCSxkdbqpjguSHW73ewfIe1ZK5G1HX
        FC6i+d5kgrunANbJocjEYkoZfrWxpTuPUQm3x9RhasjhK1T2
X-Google-Smtp-Source: AA6agR4kOv8X5Fo/JMEEbnriaPqg+0280F0wRgLdITBf5g5ZFAiep3fzMdgJY3v0D6mt/0f1BkwWTqJbnzIWt3sbRgtQb1vFB2x0
MIME-Version: 1.0
X-Received: by 2002:a92:cd8e:0:b0:2df:3572:5b0 with SMTP id
 r14-20020a92cd8e000000b002df357205b0mr4165921ilb.226.1661523373901; Fri, 26
 Aug 2022 07:16:13 -0700 (PDT)
Date:   Fri, 26 Aug 2022 07:16:13 -0700
In-Reply-To: <20220826123257.3826-1-yin31149@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007ccfed05e7258e51@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in ntfs_attr_find
From:   syzbot <syzbot+5f8dcabe4a3b2c51c607@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, anton@tuxera.com,
        chenxiaosong2@huawei.com, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com, yin31149@gmail.com
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

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+5f8dcabe4a3b2c51c607@syzkaller.appspotmail.com

Tested on:

commit:         4c612826 Merge tag 'net-6.0-rc3' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=115a8b13080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=911efaff115942bb
dashboard link: https://syzkaller.appspot.com/bug?extid=5f8dcabe4a3b2c51c607
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1229de4d080000

Note: testing is done by a robot and is best-effort only.
