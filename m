Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF62482650
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 03:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbiAACSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 21:18:13 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:39810 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbiAACSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 21:18:11 -0500
Received: by mail-il1-f200.google.com with SMTP id u7-20020a056e02170700b002b54e12bb9eso10239934ill.6
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 18:18:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=DIQTLDv9ByGH2G+h8WUbHGMXxdylDYDKvWCChgkGEAc=;
        b=qK7F0UQhHHY4TQkeBZB7B+0YJtyOqG7WBRI5BBZlaF4Q8sFGDdWc/AMQDBBGzlsYEA
         ULAFNLnsO4ApUcjxbqnZiVtxQX8vnOJyjFd6mFmPcu/ePvOw8KNvYnatejn7KPpHiBPp
         KbMQYsxFUfvUbuK5sUBGQy6KIPed/PDwRy0rAnBkxTvxN6kOC11wjpUe51PfykOR5i6N
         jZ0cBICy6ff40WhSHHQazmORA366F7t11y7Gkkc7fqzMIMMrt6qdrTKIAml/DwXPKqNw
         cup58PTnx4wB7ePc6VGl/+oZgWgC2Q0tvuuZ36cCVjY7192vQWNxsE35+fSmwTZpuw4U
         NXjQ==
X-Gm-Message-State: AOAM5335XGbzPlIUhbpmYVR24qinHjTiwjVDKglvHMgwK2q/3Hy5IdE/
        ZGvvSwtAD2InFJirQFjm/eU0BmzAzzgpYmM3mVzR2IlN8dU/
X-Google-Smtp-Source: ABdhPJz8DDyIt38ujzp6t4/n03OTzAGatimsbFaARzWW3yGBAjvMgdfvw7DT+wglxECjlov6/3jFmbCsJAKynTfsJngemZjJuqnX
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20ce:: with SMTP id 14mr16433369ilq.200.1641003491309;
 Fri, 31 Dec 2021 18:18:11 -0800 (PST)
Date:   Fri, 31 Dec 2021 18:18:11 -0800
In-Reply-To: <000000000000debe1c05a9c39c93@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002cbe9205d47be6d0@google.com>
Subject: Re: [syzbot] WARNING in ipvlan_l3s_unregister
From:   syzbot <syzbot+bb3d7a24f705078b1286@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        fw@strlen.de, harshit.m.mogalapalli@oracle.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, marcelo.leitner@gmail.com,
        mige07@migeof.com, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yajun.deng@linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit f123cffdd8fe8ea6c7fded4b88516a42798797d0
Author: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Date:   Mon Nov 29 17:53:27 2021 +0000

    net: netlink: af_netlink: Prevent empty skb by adding a check on len.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11e95e2bb00000
start commit:   6ba1b005ffc3 Merge tag 'asm-generic-fixes-5.8' of git://gi..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=812bbfcb6ae2cd60
dashboard link: https://syzkaller.appspot.com/bug?extid=bb3d7a24f705078b1286
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=103edc82900000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net: netlink: af_netlink: Prevent empty skb by adding a check on len.

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
