Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2D84A2FF7
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 15:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237141AbiA2OHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 09:07:12 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:50823 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234194AbiA2OHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 09:07:10 -0500
Received: by mail-io1-f72.google.com with SMTP id m185-20020a6bbcc2000000b00605898d6b61so6444847iof.17
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 06:07:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=0yID9FBNEnlHIDDPVExH7+jnkGuixmiFgWV9iVk8uAw=;
        b=Bip5g7yCmjqJGOzIg6oYds0VGALIgPTUlCHwX76pqoTuXtgqbWLMKghGUkaT9LAWWd
         XJ0NwzFEaOBfnrOSYt/lOjKrgV3hG8+zA9CEuv0wqdwNIvex+JwZwKJMVXW+55fXnQ1a
         WsCCp0XTQsuOG5ok277hjPuR2sdi+O9JlEK7hdS0U9o1op88L+nYZPWPj66jqDomZK1k
         XMlgEUrd9cX5pkWINH0vNivTlBj3vh5CyowdzIBDOd/zZ7jJPrlQZh/GYd4yIwp8vR7n
         sdUny4eXYjQ1vzmTvVoGRedpCJJXUcarhOOrqsViSsUzUsMEZ3VmwuWAn0CIVt1FmxGV
         6avA==
X-Gm-Message-State: AOAM531QWRh7m8Yh20dihEQillN5Ss4qI9yhp152rj8VojvvD+IoAwgU
        ij7QMlg8AdqUQuhpDSVzj9syibT7L5U/82rzyqhQvulcbleX
X-Google-Smtp-Source: ABdhPJys2smNcd54wqnufpsY+9aFghoE3qs6+teGCIqgvZBHcvUKkSP+xokUF3PxNaUW5iPcGnSHcmzTLIMObGaNGwv6yrAlWEs8
MIME-Version: 1.0
X-Received: by 2002:a6b:3b8a:: with SMTP id i132mr7981765ioa.85.1643465229580;
 Sat, 29 Jan 2022 06:07:09 -0800 (PST)
Date:   Sat, 29 Jan 2022 06:07:09 -0800
In-Reply-To: <000000000000ab6df705b453993a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000035befb05d6b91185@google.com>
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in
 bitfill_aligned (2)
From:   syzbot <syzbot+a4edd73d589b0b7efbeb@syzkaller.appspotmail.com>
To:     b.zolnierkie@samsung.com, bugs-a21@moonlit-rail.com,
        dri-devel@lists.freedesktop.org, javierm@redhat.com,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        maxime@cerno.tech, ngraniel@cocobongo.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 0499f419b76f94ede08304aad5851144813ac55c
Author: Javier Martinez Canillas <javierm@redhat.com>
Date:   Mon Jan 10 09:56:25 2022 +0000

    video: vga16fb: Only probe for EGA and VGA 16 color graphic cards

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1752f5c0700000
start commit:   2a987e65025e Merge tag 'perf-tools-fixes-for-v5.16-2021-12..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d5e878e3399b6cc
dashboard link: https://syzkaller.appspot.com/bug?extid=a4edd73d589b0b7efbeb
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16671badb00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=122beabdb00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: video: vga16fb: Only probe for EGA and VGA 16 color graphic cards

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
