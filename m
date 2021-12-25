Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6514C47F344
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 13:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbhLYMuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 07:50:13 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:55827 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbhLYMuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 07:50:12 -0500
Received: by mail-io1-f70.google.com with SMTP id n80-20020a6b8b53000000b00601ac7398c3so5505068iod.22
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 04:50:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=K7DoHqQyUKYH6kM5CoCCZ8d62sX+ZNfxmcKAZL086u4=;
        b=saSO5AenVK4up6K6PwM2IeXlJpXVdPE4x+L6i6cpkc1wR/3QiAMtt61ehsM9JE5Rej
         kscPk5wLXbxynEHCmGERL//f7uZoG7UbXK7A7piyLzouKA/NkyfqupglSp021Hm7NEx/
         3u188orS9SjQWUO8nUD/dM+Pi3Q37MGoe/bEzP0tlc8OkAWTWOkIreiHFDpUx6NGHmpE
         qqX1OZGFcK27kFiVCc1vPSisDlapzpu8QzWx+D8GQ5h/P/IffV/KRPlcULAvt3tz+yd8
         CURpHURDSAE+NR2B9dYxMZU7/y7h4TNM8teBFItNsSGZBL1Da+eIGD0n6vZ4fnA1MAM7
         rtlA==
X-Gm-Message-State: AOAM531a5Y07VRVw5MaqEO+XTnRDJC7L4u6dQSbg5QMWewATStSXQ4c8
        M8AHXZLjBZT5Cw9T9VzGSNJGo3TIh+kNx1dTv8F+knzGDw5B
X-Google-Smtp-Source: ABdhPJy5PDspTJMagDfHp14bMVi76UBGIN5RbNJ/1oSC22Keff9HSu/r48paBE+yZ3eKQHCm7uzSYC0UxYQ3zl8VgB5n58Tvu2ji
MIME-Version: 1.0
X-Received: by 2002:a05:6638:370c:: with SMTP id k12mr4658592jav.25.1640436611701;
 Sat, 25 Dec 2021 04:50:11 -0800 (PST)
Date:   Sat, 25 Dec 2021 04:50:11 -0800
In-Reply-To: <0c5a424c-4089-9623-9276-9e9473191deb@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000845fd505d3f7e966@google.com>
Subject: Re: [syzbot] WARNING in __i2c_transfer (2)
From:   syzbot <syzbot+e417648b303855b91d8a@syzkaller.appspotmail.com>
To:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        paskripkin@gmail.com, syzkaller-bugs@googlegroups.com,
        wsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+e417648b303855b91d8a@syzkaller.appspotmail.com

Tested on:

commit:         b927dfc6 Merge tag 'for-linus' of git://git.armlinux.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=c2cc5ccf0f9979ca
dashboard link: https://syzkaller.appspot.com/bug?extid=e417648b303855b91d8a
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386
patch:          https://syzkaller.appspot.com/x/patch.diff?x=128718fdb00000

Note: testing is done by a robot and is best-effort only.
