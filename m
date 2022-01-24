Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF710497FD7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 13:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240124AbiAXMsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 07:48:10 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:42967 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234753AbiAXMsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 07:48:09 -0500
Received: by mail-il1-f199.google.com with SMTP id a1-20020a92c541000000b002b7380b0279so9369077ilj.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 04:48:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=nTwVzC98bKSgURYblq8tPJjotSkvgFVHqZuAikrO0DM=;
        b=cR3cbKvXiPueJEnodYQSSrYSh/6St6LOsyWbqSKBAft5161+txZx/RkuQQPD24Sjwy
         x9KEQJ4ZavrdSMwP8/QNDhURAqdHWLWBEnSQDxXZNBKtXro4lipPz/H2nJMChBgrRQva
         tCBxWzqhhH4LQgxDFKvYdl7aZfXnkSUrlkcLg1OGpcaf+l0UOpSmRaDJSM5NS7PQ71Ib
         QGb+BCVzgauAbeeeAxJlgXTJk8qQMs3Pdad5VVo2rW18NCWzg/n+GbWLkvoFVz7OgzOc
         S+KihtRC4XbQ6JrOjFPQ2m//IVdyQvVdhq/SOizpeO/5XsMcKc5gmY4T0tiD+cK15dzJ
         21KA==
X-Gm-Message-State: AOAM530llDmMBUd9PufYxyTzyEr553vBedqmraowNE3/BAcZ07Q51qCi
        tU7k6uVX/URdEaJwscTkLKAMcxItBi5kTmOycnvkdbQiiDU8
X-Google-Smtp-Source: ABdhPJwTCSH+drYoGrpXl55byStu14bWiqpNiIbT0fuB8l2Y95hJ/VKxEs3ScmXbhOSFMgQgX7NEeIeJy6awk2amm24P43wcsF3i
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1847:: with SMTP id b7mr8166567ilv.300.1643028488915;
 Mon, 24 Jan 2022 04:48:08 -0800 (PST)
Date:   Mon, 24 Jan 2022 04:48:08 -0800
In-Reply-To: <20220124123421.3198-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000700efc05d65361fa@google.com>
Subject: Re: [syzbot] INFO: task hung in r871xu_dev_remove
From:   syzbot <syzbot+f39c1dad0b7db49ca4a8@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        paskripkin@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+f39c1dad0b7db49ca4a8@syzkaller.appspotmail.com

Tested on:

commit:         5472f14a Merge tag 'for_linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
kernel config:  https://syzkaller.appspot.com/x/.config?x=22b66456935ee10
dashboard link: https://syzkaller.appspot.com/bug?extid=f39c1dad0b7db49ca4a8
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15c38248700000

Note: testing is done by a robot and is best-effort only.
