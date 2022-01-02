Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34D9482A85
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 08:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbiABHkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 02:40:08 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:50159 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbiABHkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 02:40:07 -0500
Received: by mail-il1-f199.google.com with SMTP id r12-20020a056e0219cc00b002b52dee3ee1so13317027ill.16
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jan 2022 23:40:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=sAl2BO2TxRwWJvxdVFieuUcsy1nC0RP0z5A1A9EWQ6A=;
        b=6tdqa8yQFcqnoLt0M4mOribPJ8q3ULXyw5L/9nkmRNkoUq6F2984VI2tN9stGfzacH
         zNIhQ4Y/Imxk1uaORjGf5LcX2Wt10qlR7EaLASQFFhXi7Jk6gX079guARa6DKmjbF+Nw
         oV2pJaGGDY8kFIe14iet1wSSIGRZzbkX2IaYgREVdy4l5y2kFqn+l2WTFIeG8ljpA/k9
         Ahf0orhOxdbl4chmh5a7fwfyS6VgYwduUM7i17UPDrD25SbLb3H6UenbexJt05hGCvcX
         t9+6Dt1ZGHCx0Go47Apk6chPkQ2nZL9lrUGqvFH7BYL8x65f83/++u9FMRLEv10G5NXx
         EBKw==
X-Gm-Message-State: AOAM532IlUE4x3bM1IjFJSIEmQ5+86cQGlLFICXWRGNI50eAzybDG1lE
        Pqkc3A+Lf+XVwTVwDTLFTGpo7c52/dNWJFfALt506NDI+Hcn
X-Google-Smtp-Source: ABdhPJwV89qS7g0DWlxyByJ0WsFT0/K9EXaJsW1Cs2VxUfHNeKzIn7K+Yf2kfeQqwPpB3ALgAw1/1sNCrxbotZHQH2SJi+/I/Jtp
MIME-Version: 1.0
X-Received: by 2002:a92:c502:: with SMTP id r2mr18126122ilg.123.1641109206873;
 Sat, 01 Jan 2022 23:40:06 -0800 (PST)
Date:   Sat, 01 Jan 2022 23:40:06 -0800
In-Reply-To: <00000000000084d90105ceb7119b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000503ebc05d4948304@google.com>
Subject: Re: [syzbot] INFO: rcu detected stall in newfstat (2)
From:   syzbot <syzbot+40ef7b5e4067ef581a8c@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        mchehab+huawei@kernel.org, rafael@kernel.org,
        rajatasthana4@gmail.com, sean@mess.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 476db72e521983ecb847e4013b263072bb1110fc
Author: Rajat Asthana <rajatasthana4@gmail.com>
Date:   Wed Aug 18 20:31:10 2021 +0000

    media: mceusb: return without resubmitting URB in case of -EPROTO error.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=155db371b00000
start commit:   519d81956ee2 Linux 5.15-rc6
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=1f7f46d98a0da80e
dashboard link: https://syzkaller.appspot.com/bug?extid=40ef7b5e4067ef581a8c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=165544e8b00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=159822fcb00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: media: mceusb: return without resubmitting URB in case of -EPROTO error.

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
