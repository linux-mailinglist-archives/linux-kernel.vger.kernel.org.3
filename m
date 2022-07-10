Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D89556CEE5
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 14:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiGJMJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 08:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGJMJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 08:09:08 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1385FF4
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 05:09:07 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id z15-20020a5e860f000000b0067b75905a72so1437193ioj.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 05:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=epou9RWig8HA8TLCWLBb4ZySx06Vqb96nm3hDRhalFs=;
        b=c20FKeZGxNTosJJ98s8CBOxeLPO8aPdtD2EuAUX9GzKqiuqVh+s0wloTManGSXRUEG
         i4em6vzqiLlbn0ZuNV0qgurn6IUojdXZt6MkV3FAPXNOS6aQml12XfMfiItsBWbO8kLu
         ZX8co7vW0aSEcGoQMEmQk3DnEHR09/qKTcD8peR6fyu6Z/NkCA2HYMV9ozLfKQsaa117
         mYNSktK+nwfkymPxT5hzhezpqhj6yD/NssOxolGkMlzw2JHBfuz2jf/uFSSfqoEyF+v4
         bm4cOIJeTvuT2u3pA3NTuSxhAi7sEUb4AJSWP67KXXY3+M5gmrSKfvXJzJPNk61JXs9z
         Id/A==
X-Gm-Message-State: AJIora+jOFhaejrL8LMvs+7XCbZEZYE3vL6DGqRbc88HV1msYMXi30Fj
        9dkA5XbRp5B/u7cZ1ndBAcA0XzWjztitE4uDnsRV6OTF3XCU
X-Google-Smtp-Source: AGRyM1sk1d/eute9l6IoqQmF283TygGF+cPxbET3l/N2O4IpqRy+Bv77WtsnET7VyUrPjLCiLEaCNbgVvKjzdzRl1SZCjE9UWf8c
MIME-Version: 1.0
X-Received: by 2002:a05:6638:15c5:b0:33f:d14:beb9 with SMTP id
 i5-20020a05663815c500b0033f0d14beb9mr7083247jat.217.1657454946854; Sun, 10
 Jul 2022 05:09:06 -0700 (PDT)
Date:   Sun, 10 Jul 2022 05:09:06 -0700
In-Reply-To: <20220710100747.2575-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000056af2d05e3724d21@google.com>
Subject: Re: [syzbot] INFO: task hung in io_uring_del_tctx_node (2)
From:   syzbot <syzbot+771a9fd5d128e0a5708c@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+771a9fd5d128e0a5708c@syzkaller.appspotmail.com

Tested on:

commit:         cb71b93c Add linux-next specific files for 20220628
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11f557ec080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=badbc1adb2d582eb
dashboard link: https://syzkaller.appspot.com/bug?extid=771a9fd5d128e0a5708c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=113c2eb7f00000

Note: testing is done by a robot and is best-effort only.
