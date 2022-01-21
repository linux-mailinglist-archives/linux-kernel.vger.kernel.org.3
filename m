Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B894957EB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 02:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377963AbiAUBsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 20:48:09 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:54907 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244589AbiAUBsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 20:48:06 -0500
Received: by mail-io1-f72.google.com with SMTP id z130-20020a6bc988000000b006058a1dd100so5150164iof.21
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 17:48:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=DanrII7rs7VHR9x2Ad6ztSAzc5bhObpiObDh8wKC9WU=;
        b=PXLgpfiFqRQAvDohP7r0W1FlIkOnG2+Cwb49+gvFexpPAtjXZ+zuN2CwPl7Hq9PrU1
         czGNsk49Oe3upfh1m0/xzD5CuG88dQOtabZ/zFJui0EQGy0fo1+F80YPKBMR3BRP+QP/
         bB2yyeVHyen8aETijTaB6XnEKMrj16vKCmwvyFN+hxx4kMPiZ6lufSJ38vbhLXoMYOel
         wZWkGf1gHiy2sv+ukzeGpUXtRVroB/2ASK1gUqAJyOdj870kVSNI05vw9znoT02RZxV1
         RZGZNghceibLIZ8UJoWthEH6gRUOKIv0KOryW0oxPqYZXmv2ZGf2ROQkZXxeFoXxvN3B
         01Ag==
X-Gm-Message-State: AOAM531F8xjZqQu0teNyZkDnShEoObgt5WYXJdtd1gQTUTiQggLym16a
        DzjwLyzK2wJa74IVza9FGrbqpGmeX5Arv9ON648rbIBC2gQe
X-Google-Smtp-Source: ABdhPJwo+j/up45k23KzgrwwJOdQRYqe4wZFCj5sSOh1hefXEP0mn76QeYRFAhQgeYfh1ABeRjuYCNLoAcbb47n7Nx1OAC7WHPRo
MIME-Version: 1.0
X-Received: by 2002:a02:2207:: with SMTP id o7mr751312jao.99.1642729686278;
 Thu, 20 Jan 2022 17:48:06 -0800 (PST)
Date:   Thu, 20 Jan 2022 17:48:06 -0800
In-Reply-To: <000000000000bbdd0405d120c155@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000069ab4805d60dcf4c@google.com>
Subject: Re: [syzbot] KASAN: vmalloc-out-of-bounds Write in imageblit (2)
From:   syzbot <syzbot+14b0e8f3fd1612e35350@syzkaller.appspotmail.com>
To:     bugs-a21@moonlit-rail.com, deller@gmx.de,
        dri-devel@lists.freedesktop.org, javierm@redhat.com,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        maxime@cerno.tech, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 0499f419b76f94ede08304aad5851144813ac55c
Author: Javier Martinez Canillas <javierm@redhat.com>
Date:   Mon Jan 10 09:56:25 2022 +0000

    video: vga16fb: Only probe for EGA and VGA 16 color graphic cards

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14c71e37b00000
start commit:   7fc5253f5a13 Add linux-next specific files for 20220120
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16c71e37b00000
console output: https://syzkaller.appspot.com/x/log.txt?x=12c71e37b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=94e8da4df9ab6319
dashboard link: https://syzkaller.appspot.com/bug?extid=14b0e8f3fd1612e35350
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=155dde3db00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=125298e0700000

Reported-by: syzbot+14b0e8f3fd1612e35350@syzkaller.appspotmail.com
Fixes: 0499f419b76f ("video: vga16fb: Only probe for EGA and VGA 16 color graphic cards")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
