Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC41D4825CB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 21:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbhLaUoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 15:44:07 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:36759 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbhLaUoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 15:44:06 -0500
Received: by mail-il1-f199.google.com with SMTP id m15-20020a056e021c2f00b002b536f2ae9dso11472932ilh.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 12:44:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Of3gUYtQNOdGN0VCHZ9V9d8Ng0GEU6SSLufzFHaw2CE=;
        b=MfYejTDeNnkSjSQkHhYpKhR5jhqVgOhlxxz6hFo1ADxdh6r1v1nQUGGeNpZq2evDMb
         5SEHJIyuv9yqvwpajLHzQ+UnJidfRC2aH5qpHpor+J/BrPgcgL3Hkd4M3lPBlehnPBBS
         E2G6ZFMDoEUQxmOhDL7mAglsJoPtR762zlUoaF9cFeQrIG8CIQ1YzOSz34SHbhMnIqb1
         8GXTf+gy77LAYTw0VwbIhOJY5nyDaxMDYPATDO6j26XvNdbe+Kc8ll0GGV/IJPHkt87L
         Qcu03wEHvVbeBSOnd9Of6fo+cMHTWMNpyBRCoqqa7pkOP2A2L8stqumObf/sDOIYitAG
         pHLQ==
X-Gm-Message-State: AOAM533vAevr4+J4Hrvsi2ybIvPvBgyZBEObo8KBPw2MQmdWh+ztWIEt
        7RZjUqmPP6PCcyOvzyvSgOC1UV9WwFh37mRc+4halj3YUndZ
X-Google-Smtp-Source: ABdhPJxQWiMF5hhNnlmcGcPjirBvBWo3QMc5mLxUHrNzczChFwXxfTMdBa3z+KDIG9Ly8dHMGltuWtoKVX3GmRE2pSoGKqZaQ+Gp
MIME-Version: 1.0
X-Received: by 2002:a6b:7602:: with SMTP id g2mr16215397iom.37.1640983445917;
 Fri, 31 Dec 2021 12:44:05 -0800 (PST)
Date:   Fri, 31 Dec 2021 12:44:05 -0800
In-Reply-To: <Yc9odypVqqB2uMm/@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000060560805d4773ba0@google.com>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Write in usb_hcd_poll_rh_status
 (2)
From:   syzbot <syzbot+3ae6a2b06f131ab9849f@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, dvyukov@google.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+3ae6a2b06f131ab9849f@syzkaller.appspotmail.com

Tested on:

commit:         eec4df26 Merge tag 's390-5.16-6' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
kernel config:  https://syzkaller.appspot.com/x/.config?x=1a86c22260afac2f
dashboard link: https://syzkaller.appspot.com/bug?extid=3ae6a2b06f131ab9849f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=148e8e35b00000

Note: testing is done by a robot and is best-effort only.
