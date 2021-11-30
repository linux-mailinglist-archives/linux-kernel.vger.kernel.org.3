Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB34463B93
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238080AbhK3QWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:22:33 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:36760 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238952AbhK3QWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:22:30 -0500
Received: by mail-io1-f72.google.com with SMTP id w16-20020a5d8a10000000b005e241c13c7bso24071158iod.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:19:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=82PcJsGJmWA9J7EfSsaBo8R7BvPCcHNRldX54MbqtUk=;
        b=vYD7Ww6iN4go3eBRU0s9d+NOc90Qa/oFWz1Y3v7xlwlXCSin0A3rYwD3RClErvc1jA
         y0wnEIpuTiKYCDeFWf1EqrGnaafLaHlcNF1xS8VDGNOX4DrmgMZUepYvQEX/gi83iIaq
         feFE+nr/5It0HBg5iIGyYG8zVDOXeN767zKgG3X3hLQS4nw0qoxYTsIdz75VxY7Wu5TX
         ZZuvvzVoXAfQVAhUMv6aRSKvJXqPcxymAOCoQiAud+eiCusm9Z6m29Gi/I0iOZyXQqg6
         m8lOSncVYoMoGJFbZL6OFmMTpeD3IJjoWypJrm+P2oLqdc70BsoGVMQuRJ1nYCXU0HXA
         F3oQ==
X-Gm-Message-State: AOAM531juVvfEjFxd9vGeBfjQbH+8JKKk2CqXfKAZhiO0KN886IOKIc/
        03CNgZmCTOSQ5z3imVTCfZKYTF4hPRf0iRldi1pfmUgv10Vs
X-Google-Smtp-Source: ABdhPJyxuzWxbXXQxXt/uLUyAQu5gmBfd3on9w/gXZzhkfqblOPzJkm/nRXJfXP2GwX0YVZSMLpgNz44tT0MMcAsVMq1dotg6xoH
MIME-Version: 1.0
X-Received: by 2002:a92:d8cf:: with SMTP id l15mr1635ilo.59.1638289150573;
 Tue, 30 Nov 2021 08:19:10 -0800 (PST)
Date:   Tue, 30 Nov 2021 08:19:10 -0800
In-Reply-To: <000000000000f5964705b7d47d8c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dc091705d203eac6@google.com>
Subject: Re: [syzbot] INFO: trying to register non-static key in l2cap_sock_teardown_cb
From:   syzbot <syzbot+a41dfef1d2e04910eb2e@syzkaller.appspotmail.com>
To:     a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        bobo.shaobowang@huawei.com, davem@davemloft.net, hdanton@sina.com,
        johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        luiz.von.dentz@intel.com, marcel@holtmann.org,
        mareklindner@neomailbox.ch, miklos@szeredi.hu, mszeredi@redhat.com,
        netdev@vger.kernel.org, sw@simonwunderlich.de,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 1bff51ea59a9afb67d2dd78518ab0582a54a472c
Author: Wang ShaoBo <bobo.shaobowang@huawei.com>
Date:   Wed Sep 1 00:35:37 2021 +0000

    Bluetooth: fix use-after-free error in lock_sock_nested()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=134c881eb00000
start commit:   73b7a6047971 net: dsa: bcm_sf2: support BCM4908's integrat..
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ce34124da4c882b
dashboard link: https://syzkaller.appspot.com/bug?extid=a41dfef1d2e04910eb2e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=166ee4cf500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1337172f500000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Bluetooth: fix use-after-free error in lock_sock_nested()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
