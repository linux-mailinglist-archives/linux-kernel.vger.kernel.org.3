Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4B1465C48
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 03:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354991AbhLBCqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 21:46:35 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:39682 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348543AbhLBCqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 21:46:34 -0500
Received: by mail-io1-f69.google.com with SMTP id m6-20020a0566022e8600b005ec18906edaso31176934iow.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 18:43:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=861cFVE9yMdYZPPo4IwcsubtwbX+fHJmIXiFQWVSCVs=;
        b=Oanvorey3lb8T7aBPekxO43ux1ZxA7k/J4s5XFSoamOAVdgWQFIArp+QvsMpdCB44k
         g5QwxnG0jpb+f1ARkfDFxTXBaDWaUtMubwMT3YK+A9KXkllnXBhuoJB/J8+H2dDZD9OH
         Q9NiZJ9BCDykz+k/MqdGQNTzvPnYGPAzQ+X/Co/LdJLsSy4HYxjYdSedL9rWBZozBDms
         BvyWpCOvnXQ5VxNokUEcUoq/4gEh72rIeKrJF0qihnXgLQ4/lb/3NgRKAK712rLx++Ds
         X9+IrEbXUyjo+rZzYLypqns3dYh4NE9qd5KJT4bEk0UaHHnlh/ZMqHPplkNt3+yEA8yy
         zaKg==
X-Gm-Message-State: AOAM5306BXYUimwbRHy0/XTXn7A+Ww8JayetDlZ74XkuUMIjFDngxLFV
        tg3o02lGkUltLN931xtt5CmX8JapLlgFCm/5w7CS/OJxkzQ5
X-Google-Smtp-Source: ABdhPJxVfkKZsgfrINxKH5d4qFILdmhdRAQ0bMdMTA9hk0hIyISa2bFgV0QjyA1RbVRq73PcuziBvpRfxBy8TZQoJiHDDvP1WQUE
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b84:: with SMTP id h4mr13487031ili.215.1638412992699;
 Wed, 01 Dec 2021 18:43:12 -0800 (PST)
Date:   Wed, 01 Dec 2021 18:43:12 -0800
In-Reply-To: <000000000000a9ed6205c67e08c6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006ce3ce05d220c008@google.com>
Subject: Re: [syzbot] INFO: task hung in set_current_rng
From:   syzbot <syzbot+681da20be7291be15dca@syzkaller.appspotmail.com>
To:     colin.king@canonical.com, f.fangjian@huawei.com,
        herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvivier@redhat.com, mpm@selenic.com,
        mst@redhat.com, syzkaller-bugs@googlegroups.com,
        tangzihao1@hisilicon.com, yuehaibing@huawei.com,
        zhangshaokun@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 2bb31abdbe55742c89f4dc0cc26fcbc8467364f6
Author: Laurent Vivier <lvivier@redhat.com>
Date:   Thu Oct 28 10:11:09 2021 +0000

    hwrng: virtio - don't wait on cleanup

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=171ad129b00000
start commit:   3dbdb38e2869 Merge branch 'for-5.14' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=1700b0b2b41cd52c
dashboard link: https://syzkaller.appspot.com/bug?extid=681da20be7291be15dca
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15a472e4300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c51a28300000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: hwrng: virtio - don't wait on cleanup

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
