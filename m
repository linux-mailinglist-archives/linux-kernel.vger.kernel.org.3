Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA5F481C8C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 14:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235880AbhL3NdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 08:33:17 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:46807 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbhL3NdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 08:33:15 -0500
Received: by mail-io1-f72.google.com with SMTP id e2-20020a6bb502000000b00601c16cb405so10994988iof.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 05:33:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=3yJ3X0BiJyv0kz2MWYXA2X/7Iy5TYPDdnQ01QGsY6PU=;
        b=ZUzyogOEVCBS7sTG7j5XcnrdJJ+upFdk/wHCz4bN/I76eZ2vmk3z8YakoLAgPIZc/d
         oVzwidui1SGqHtVB5a98hQh4TghEzlLV79iVYNtAwx0xkkaa8ZS70J9RO/MJq0PoQFOp
         Sg8T3qlHQMszZjwyEh+x2ljxwTIX0t8+eDlD5ddmGTqQgvb8PbMXZRoEI72d2bpUwLkI
         QKotiacCF2BDMKMQRJ0f53tFw60dL/7OJL2J5FxuH9HAvCngvoFBy0sceIe7IVrTi4YH
         BtNZybENt0v/MI7sGL4qza4yPZtnef8+OZxi1Jqod5uc8FiMo1/S+G/NHzljekY0VYzF
         o66A==
X-Gm-Message-State: AOAM531IdDx/VcYCmPQw4djRhVsh0HUOYGcy7ndC2SFQjx5hoUCD92JA
        YppIfOyYrkAbchkwN4z4a2eeU8j+GzRcjskx4tI/PTJa7eJW
X-Google-Smtp-Source: ABdhPJyYOgbsNKZKuabNPhUswR2qkpMvmq0/m7c0Yaw4iZ5MWbMrsMwdIpM4xE7cBjsgD+qxmm9FLy7sX6Ei3apJkJsW6wIGwywp
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16cb:: with SMTP id 11mr14695084ilx.59.1640871194900;
 Thu, 30 Dec 2021 05:33:14 -0800 (PST)
Date:   Thu, 30 Dec 2021 05:33:14 -0800
In-Reply-To: <cb0cbd54-2b26-1c10-eb30-3b97870904d9@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b1bc5305d45d184c@google.com>
Subject: Re: [syzbot] WARNING in atp_close (3)
From:   syzbot <syzbot+b88c5eae27386b252bbd@syzkaller.appspotmail.com>
To:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, paskripkin@gmail.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+b88c5eae27386b252bbd@syzkaller.appspotmail.com

Tested on:

commit:         eec4df26 Merge tag 's390-5.16-6' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=123612d4aeafb54e
dashboard link: https://syzkaller.appspot.com/bug?extid=b88c5eae27386b252bbd
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1217f2fbb00000

Note: testing is done by a robot and is best-effort only.
