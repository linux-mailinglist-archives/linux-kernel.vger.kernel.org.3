Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074E04A6EB4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 11:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245354AbiBBK3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 05:29:10 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:42721 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235035AbiBBK3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 05:29:08 -0500
Received: by mail-io1-f69.google.com with SMTP id n13-20020a056602340d00b006361f2312deso944699ioz.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 02:29:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=nEulIPpIJ+MIKD14q/kortqxkpNWNggKXQtSolinqdw=;
        b=sVHm3THoF6wMphY65wYzY/4I72/H3P1lO492HnOUTH9RtiTW2I5kuEPermHTxiZJ5c
         uHBO2Rcs2KM0Tnp7og2NpIVopCpXnyYfkY3hKsao+hnOVS/436o1onSyp1KrqKuNdq6F
         Vsas1WMpLJp8qcRHULu6Lq2idppjHFUejIC723uM0BHOaXryXiAASw7vhrhLSf9rfFW5
         X6rkJBGYbYFd+N6r03mxBWoqJrlNi62XmxfMQ7/gxNu0EqfVzwxCr/nL83Knn6J1Bvcq
         9lgKLrZOmo0RwmTOnC0P9sx84i5ZzLvpN/Il6SWj+aaEUMIKhcAgZ3pytPuKiKnVAPXy
         Z5CA==
X-Gm-Message-State: AOAM532zuxoBpbzxztCtOPSTEH9Jp2YmDTm19j82RMhMEmGW7Ahq4o51
        LxNUTt3jjBVl+ixini7FFtkXqBg77X7S7o54knwIPYWBsPGX
X-Google-Smtp-Source: ABdhPJzkYKK7JWamarEhzKL/vOzo/telIDI1MWTjw59pYJDk7c8XLo1kA18YrsLryANpisSQxWWE+eViXhx+8NgcJcbf+FdgRNEC
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c23:: with SMTP id m3mr16967384ilh.258.1643797748172;
 Wed, 02 Feb 2022 02:29:08 -0800 (PST)
Date:   Wed, 02 Feb 2022 02:29:08 -0800
In-Reply-To: <eb631eb1-b7e1-bfb5-0027-1577445ce39a@iogearbox.net>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dccb0305d7067cae@google.com>
Subject: Re: [syzbot] possible deadlock in ___neigh_create
From:   syzbot <syzbot+5239d0e1778a500d477a@syzkaller.appspotmail.com>
To:     daniel@iogearbox.net, davem@davemloft.net, dsahern@kernel.org,
        edumazet@google.com, john.fastabend@gmail.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        roopa@nvidia.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+5239d0e1778a500d477a@syzkaller.appspotmail.com

Tested on:

commit:         4b48392c net, neigh: Do not trigger immediate probes o..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/dborkman/bpf.git pr/neigh-probe
kernel config:  https://syzkaller.appspot.com/x/.config?x=5044676c290190f2
dashboard link: https://syzkaller.appspot.com/bug?extid=5239d0e1778a500d477a
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: testing is done by a robot and is best-effort only.
