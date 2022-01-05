Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A753485331
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 14:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236788AbiAENFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 08:05:09 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:45736 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236072AbiAENFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 08:05:07 -0500
Received: by mail-il1-f198.google.com with SMTP id k14-20020a056e021a8e00b002b4b2388c48so20930437ilv.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 05:05:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=HSRdWTMwZ0NVGbhn82fv0ZdfTEVZeKB9Mpbh30gZMkU=;
        b=SSRHAyWTfS7g7Zn5uduoscuUBmvrpK+quXyJCUDVvqaBCcA4Zd3A8hl3FFEOWaeEiu
         foo0ThcI6hQv7AXNWEnK6p17mxBWsZZqFdHVOjrgh6pJlm4q9vwCFKY5Wt7MlB5YvrbS
         OU3I79EzpUgnJLyhIMpp6AfPVfg7299YNUnRDXnRPDJ5eiq1latqhkF1tYJAFDf7iXQq
         Av7KSHo6jGHhX3eso/qXIJ0RwG5KO+GoMmHwvMk6FhZVplFNR09vES/KLjt76rgdrM6U
         RlEoHw4GxdD7spWZwtRjo3CQPNDVbWaPw1jKJXGv0bYIsiyFnW6Bt23jMbHaYhsV/VP4
         Z5DQ==
X-Gm-Message-State: AOAM533JBB3U23wN86hxCK3oJ1q6jzzOXiE5LR3Ru/PRPqBsvt3xGYkc
        jX4V5QBBXG/wi0YmjdHyGrczC/98SFnS70mD7/vEpFzR6rLJ
X-Google-Smtp-Source: ABdhPJy5x96xjIKmmkdWPCYacNAFMeYNDaWDDSM8GrSzjPCLFjWw7wZ0/pJUL3qkYuuidqhU5Y+GAzF7q6+5X9nh6352KMTjpd7z
MIME-Version: 1.0
X-Received: by 2002:a02:cf82:: with SMTP id w2mr24004765jar.314.1641387906942;
 Wed, 05 Jan 2022 05:05:06 -0800 (PST)
Date:   Wed, 05 Jan 2022 05:05:06 -0800
In-Reply-To: <66341bb1-a479-cdc8-0928-3c882ac77712@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000021c8c305d4d56799@google.com>
Subject: Re: [syzbot] KMSAN: uninit-value in ax88178_reset
From:   syzbot <syzbot+6ca9f7867b77c2d316ac@syzkaller.appspotmail.com>
To:     andrew@lunn.ch, davem@davemloft.net, glider@google.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux@rempel-privat.de,
        netdev@vger.kernel.org, paskripkin@gmail.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+6ca9f7867b77c2d316ac@syzkaller.appspotmail.com

Tested on:

commit:         81c325bb kmsan: hooks: do not check memory in kmsan_in..
git tree:       https://github.com/google/kmsan.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=46a956fc7a887c60
dashboard link: https://syzkaller.appspot.com/bug?extid=6ca9f7867b77c2d316ac
compiler:       clang version 14.0.0 (/usr/local/google/src/llvm-git-monorepo 2b554920f11c8b763cd9ed9003f4e19b919b8e1f), GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10d0da73b00000

Note: testing is done by a robot and is best-effort only.
