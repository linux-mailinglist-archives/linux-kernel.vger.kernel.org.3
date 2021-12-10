Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2343D470565
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240318AbhLJQSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:18:45 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:35390 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240274AbhLJQSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:18:44 -0500
Received: by mail-il1-f198.google.com with SMTP id m9-20020a056e021c2900b002a1d679b412so10859848ilh.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 08:15:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=hCvnT54V6dz5hU6SrRLw5pSFpj+AS8Nd4KGYLHFcp0Y=;
        b=22Qe79zp6VJwI5Nzwk097CwX6UgFKt+u9ouywW084n58wRA3Y8FiqQAs5W/whZDK+5
         qRKvs+7SYtKu0biRkPZW0ffroe7hD+UGQAs4GqxS2FHbE9Ynk0t4AIL3hZxNu+LMVGRW
         ynI6FlaLZ/HKUfNY289dWRwygxbTsyq3mdYFjSPWt6103aSz5uRJXD5A+BwwOc4wJey2
         3kMwNYa5+BCUCVSe5asJkMhU+ejCKcB7AqnQWna9zLm2hKSJX/OTAT5jwZJQh3yX5gEh
         ZsNor+kRxuObGJN2OxpSKstMiDMbdLw7zFHgx/sY3SX1IArEexNxQo6FKrhv+kvRx20W
         F+aw==
X-Gm-Message-State: AOAM5304Cwkath7LwTWAmYFWD2ajg9zt10IVIpSvN/ruylhii5wEveaZ
        9K3nUuHjqKH0k4zGjAV6V7glntgNq7XGwX8YIsjPei3llFxe
X-Google-Smtp-Source: ABdhPJy0+1Kzubb2wOyqTwA+WeSKW/Ony0nSbvBW6B2pEY/r1R4dlA0k9FeachkuKy5dZIjLG6abPYZiWcQpTE+gWzMTJVMs9Ewh
MIME-Version: 1.0
X-Received: by 2002:a92:d28d:: with SMTP id p13mr24204351ilp.163.1639152908858;
 Fri, 10 Dec 2021 08:15:08 -0800 (PST)
Date:   Fri, 10 Dec 2021 08:15:08 -0800
In-Reply-To: <8544854b-226d-befd-bd91-5af182c2b03d@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dd7d7e05d2cd063a@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Write in io_queue_worker_create
From:   syzbot <syzbot+b60c982cb0efc5e05a47@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+b60c982cb0efc5e05a47@syzkaller.appspotmail.com

Tested on:

commit:         263568d1 io-wq: check for wq exit after adding new wor..
git tree:       git://git.kernel.dk/linux-block io_uring-5.16
kernel config:  https://syzkaller.appspot.com/x/.config?x=6c3ab72998e7f1a4
dashboard link: https://syzkaller.appspot.com/bug?extid=b60c982cb0efc5e05a47
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2

Note: testing is done by a robot and is best-effort only.
