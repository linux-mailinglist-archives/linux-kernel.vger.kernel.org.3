Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845B247B94C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 06:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbhLUFVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 00:21:08 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:42659 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbhLUFVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 00:21:07 -0500
Received: by mail-il1-f198.google.com with SMTP id b16-20020a92db10000000b002b3a09b269eso2625462iln.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 21:21:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=pAkGYvpJnzLica1LfFPS5fVVW20iI4ebrlJU4TBRC1w=;
        b=mGyATVOMdYTWGG7L58aPUh42F1jwHDudX670Qnk73rqDhiQ4A1m4r8s1xckryS4k21
         zFoZAGVoZmWmbxge/Mk7OiwBPLUmSYu7ACbwbol2r7hxlK6ypS5tmAbOag2a4AP0qS8h
         jHcO0gT9QfV6laWIsg2YIV8HHi8GSE96dSa+c2xNefCKx0eoCc6AWQMaMDKfOMF2bKXq
         ZpiS9K2xqS8GWtDNJUL+jXOHsCAseEx34H8317g5/AwWoEymxMX0diCy1MJWdPgKkrll
         3zfUi740yN3DugXbBuoP8zW66NlztjZ7KQ6BRc5KEJhzRT3WgstN5sB7l/qDIIavVySf
         6AoQ==
X-Gm-Message-State: AOAM532EP9DKGGV0bk0aMSy6qFLNl+zBzaNpR8u7VKvC2kx8lBI4bNi5
        HmeK/fTD6Wjx4xzJZZaaYSJV1B6wtEHtjcVYINBtiF0v58xY
X-Google-Smtp-Source: ABdhPJzS3GVIK0iN6UAGQUIYIE7VHAjysuGY/+j4c2ZHySOCtT0bggn2d6ZgGUznxMwY4oZx0iqBl07uUkLjNeNC4zm/b04G1ZFQ
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:190e:: with SMTP id w14mr694808ilu.191.1640064067391;
 Mon, 20 Dec 2021 21:21:07 -0800 (PST)
Date:   Mon, 20 Dec 2021 21:21:07 -0800
In-Reply-To: <7ded6b2a-1f95-73a2-c074-2841dd5aaf96@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000025571305d3a12cdd@google.com>
Subject: Re: [syzbot] general protection fault in set_task_ioprio
From:   syzbot <syzbot+8836466a79f4175961b0@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+8836466a79f4175961b0@syzkaller.appspotmail.com

Tested on:

commit:         e1ad6d38 Merge branch 'for-5.17/block' into for-next
git tree:       git://git.kernel.dk/linux-block for-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=f22078a087d573ce
dashboard link: https://syzkaller.appspot.com/bug?extid=8836466a79f4175961b0
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: testing is done by a robot and is best-effort only.
