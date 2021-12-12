Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE83471765
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 01:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbhLLA3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 19:29:16 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:34513 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhLLA3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 19:29:15 -0500
Received: by mail-il1-f199.google.com with SMTP id h10-20020a056e021b8a00b002a3f246adeaso12887953ili.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Dec 2021 16:29:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=nDG4SEwejxlIh6+HWy4XvDA2HuM5COpv4vJgPsHPavo=;
        b=ZFtCNsvlsjw6LSWDwPq+VGfelLniBuI9gNDQ8jenMJAmHRikU9NZGdJjn263X6s6Ai
         dmPTZuGPOzKR6CYh6hIZ9EIh0rdid7rPXBASGjgmrYsxq9QCuOjyHWa2UOvp6ho6HFJ7
         FVUnZBF5hf1j7dveIkBjDL6FwGK70WMjsKPoWkdIr2hgXllrdIGPWRt1ZByp5IgrfoT5
         7PKSLJn9Ui3181t5MUdq4vlI+9xH99K+4sPHfRq4XhdcEWSgGB+4r30VVG/cH3mr25C6
         d26heZBw3pIHdReYKGidT7tENPN5tSmUiLreO50IBk3LWPdDwhH9du9IQGKl2Xi4Stse
         VZPg==
X-Gm-Message-State: AOAM531CBFYH0NsqyHrg4fBi1fv++8WRZ6W8xcSVtg94ZrdqNJq5ZXkq
        et0SvAG1rtg/rnFgbC1DEZ5j8pwCrSAI/1kaAWty+fC5HO2g
X-Google-Smtp-Source: ABdhPJwzHakTYI1Wa9BYeGT4aejJxGYvhT9EdlMdrBDi7DNg035WzF6pyQvv8kDTCOTdf6YuX6qFjYtFrL2Zt2gyHUsIpsas+q7d
MIME-Version: 1.0
X-Received: by 2002:a05:6638:dd5:: with SMTP id m21mr24924006jaj.44.1639268953978;
 Sat, 11 Dec 2021 16:29:13 -0800 (PST)
Date:   Sat, 11 Dec 2021 16:29:13 -0800
In-Reply-To: <00000000000047627e05b17a6ec9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b17d0105d2e80b47@google.com>
Subject: Re: [syzbot] general protection fault in scsi_queue_rq
From:   syzbot <syzbot+0796b72dc61f223d8cc5@syzkaller.appspotmail.com>
To:     anmol.karan123@gmail.com, capitolscan@capitolsecuritypr.com,
        hare@suse.de, hch@lst.de, jejb@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, syzkaller-bugs@googlegroups.com,
        tadeusz.struk@linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 20aaef52eb08f1d987d46ad26edb8f142f74d83a
Author: Tadeusz Struk <tadeusz.struk@linaro.org>
Date:   Wed Nov 3 17:06:58 2021 +0000

    scsi: scsi_ioctl: Validate command size

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11db6f3ab00000
start commit:   ec681c53f8d2 Merge tag 'net-5.15-rc6' of git://git.kernel...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=bab9d35f204746a7
dashboard link: https://syzkaller.appspot.com/bug?extid=0796b72dc61f223d8cc5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1279df24b00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15a855f4b00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: scsi: scsi_ioctl: Validate command size

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
