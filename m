Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1402D46576A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 21:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245666AbhLAUx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 15:53:56 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:38729 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239840AbhLAUx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 15:53:29 -0500
Received: by mail-il1-f200.google.com with SMTP id b4-20020a92c564000000b002a252da46e2so18625369ilj.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 12:50:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=X/WRQR8STDSXJRhWuJ7l+MpIYKViU5igfD9Z/w6cwnE=;
        b=j9wgHTapoh45rzjCUdSPfb3T1/M5VtA0Ni5dUBzzxJG6tI06Ct+9Ee3+NGeU6NYqtZ
         0qm9bw+iqn1M7dUA4W7LqaPHvdPCaXlcuM5QO7dKw+hGCH6K7JROD56edC7DYp6RuUYH
         Q69sin7vmjZBUDuJOxtpZhs8nLL2x/kS5/M56JBPfHMaPhlBXbTl0nFmOA4Bu4JDWeYQ
         hUM61w3VR4MOjFhuyJ3Y/l5gXUatdWmbUhm36+V1skUx88c7o4zFuRqSpQISnvZzukVF
         G6+CF2aeXxU5gGmKe67Itgo83CD8L0xmBKOTOrLgytl8LgL9CzLOv2/bD1s40H3Sb7Pq
         6Irg==
X-Gm-Message-State: AOAM5317QpDc4idW2Tb8O8pxRSW96XzdxA9xfQLbn4TMiztgLG9hpSCT
        2v0WHRTh+YGEQMnZErKlCUP33i1Uvl0myPo1piWwSjdKj1AY
X-Google-Smtp-Source: ABdhPJxwnTjayukxQsPm7f3vzoFuy8C1JldbQMohbfblKSqInY3rP+nF24H24uBktfOukSFRQgYKFbRtf7c4JSZgMRbBhRziF+lR
MIME-Version: 1.0
X-Received: by 2002:a92:d291:: with SMTP id p17mr1253204ilp.154.1638391807990;
 Wed, 01 Dec 2021 12:50:07 -0800 (PST)
Date:   Wed, 01 Dec 2021 12:50:07 -0800
In-Reply-To: <00000000000069924b05c8cc3b84@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b7e3ee05d21bd19d@google.com>
Subject: Re: [syzbot] WARNING in trc_read_check_handler
From:   syzbot <syzbot+fe9d8c955bd1d0f02dc1@syzkaller.appspotmail.com>
To:     bigeasy@linutronix.de, jgross@suse.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
        mingo@kernel.org, namit@vmware.com, netdev@vger.kernel.org,
        paulmck@kernel.org, peterz@infradead.org, rcu@vger.kernel.org,
        rdunlap@infradead.org, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 96017bf9039763a2e02dcc6adaa18592cd73a39d
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Wed Jul 28 17:53:41 2021 +0000

    rcu-tasks: Simplify trc_read_check_handler() atomic operations

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1281d89db00000
start commit:   5319255b8df9 selftests/bpf: Skip verifier tests that fail ..
git tree:       bpf-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=9290a409049988d4
dashboard link: https://syzkaller.appspot.com/bug?extid=fe9d8c955bd1d0f02dc1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14990477300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=105ebd84b00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: rcu-tasks: Simplify trc_read_check_handler() atomic operations

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
