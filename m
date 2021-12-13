Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56DC5473200
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240965AbhLMQkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:40:16 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:39649 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240951AbhLMQkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:40:12 -0500
Received: by mail-il1-f198.google.com with SMTP id d3-20020a056e021c4300b002a23bcd5ee7so15203218ilg.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 08:40:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=3ID3XANipYuWRqgtPQ1BWFFiHhMGJojTDZG87ujp4KY=;
        b=o3u2iO/jcUE7O8geLTAHHRRCD+fZm5T6vk5RUcE3HFJ83WYBxiCnRTOMM1X5lsmZ2t
         rBNtNiF0+Uq+QS48H6X97JNqP8JoNOM/+WNDHnKV801RnnoFoJ2CjtzlHafiG5iiDfgx
         /XL3gWK6SaDItYXdiwtvLwyk0otncDCH/VXFup5xtcLp7PJlwpdBkQ/Pvhi04iK6GqXJ
         QhZJwDptDPRvsEWOh6KnY7UBjNYWwJWytkPPs/sl6MXb6Trrr1Lq7bIOyzSdgYHPjB8v
         CmkkU/aIWnYIcgEy4qtjRhgHBeR+ex2lgcfVPJPiGeov/pDsew/Hh+U0Jwry4dyYBuZx
         iFjA==
X-Gm-Message-State: AOAM5302xh7D/OE1i+s5VYa4JclfNezbgwmIZC+00LG7mku2cCxGHMPE
        qW83um2XysDPeaVpdBVVwV9L4lw4r4Waq9RO1ybaZOi8PMfD
X-Google-Smtp-Source: ABdhPJxnluLGA2ihn4eZD4ifoLmKB715ATvxozGrTPZEpBkNwTIO3XvJfes46/CiIaBlqjUweE8RJD/5lOM7GyE7ylqU+tT2teSE
MIME-Version: 1.0
X-Received: by 2002:a92:d6c7:: with SMTP id z7mr35334339ilp.92.1639413611269;
 Mon, 13 Dec 2021 08:40:11 -0800 (PST)
Date:   Mon, 13 Dec 2021 08:40:11 -0800
In-Reply-To: <494d69b4-d9da-b698-39e6-ed41b64a09a7@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f0971c05d309b9c2@google.com>
Subject: Re: [syzbot] possible deadlock in io_worker_cancel_cb
From:   syzbot <syzbot+b18b8be69df33a3918e9@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, haoxu@linux.alibaba.com,
        io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+b18b8be69df33a3918e9@syzkaller.appspotmail.com

Tested on:

commit:         d800c65c io-wq: drop wqe lock before creating new worker
git tree:       git://git.kernel.dk/linux-block io_uring-5.16
kernel config:  https://syzkaller.appspot.com/x/.config?x=6c3ab72998e7f1a4
dashboard link: https://syzkaller.appspot.com/bug?extid=b18b8be69df33a3918e9
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2

Note: testing is done by a robot and is best-effort only.
