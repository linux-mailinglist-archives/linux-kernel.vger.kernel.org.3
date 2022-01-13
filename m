Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673B848DE01
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 20:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237831AbiAMTEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 14:04:09 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:47854 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbiAMTEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 14:04:08 -0500
Received: by mail-il1-f200.google.com with SMTP id g14-20020a056e021e0e00b002a26cb56bd4so4525876ila.14
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 11:04:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=YnXlPLzLOeSu5XTDUNqCJDVyX7wesve914JTiyKl2c4=;
        b=WNiHKvlB3MuRnRJ22a/rzo/cUeLyWqRTHmWxb2TbIS3SHSNNbuTcvM5biNXV017OTh
         5kmvOKk7TzZdKkM2nphUTopIWJ+utGjUGd74/PNJlWhHu89RL1pKrzsKxMNXSi0ZASzo
         2QTSEFv7wx1EDwFRj9NlZJr5rGCiX+dMUgDfW/ctBpr5aUcfGvvH+VGsRMC7G6Nt2gsN
         7d5wzfCQbnQxRKpz8k4/hrfzF4+iQq/wMgJFOLFRmOOzekE1jro7T5GW4ZI2egQPVSxO
         iRfMh6VCQI0SU5a861Eovw1xtx4a6cVHQZNthV8XpwHf+qFWCxlV5TMzUJ/gKfsZ/BVS
         zkpA==
X-Gm-Message-State: AOAM532VMOk3oPPXAcR+REcCdfwds5ZSuziOY/N8jxU6brunijg3JCt/
        /ZOr5E8031h4CcTTBbxuOvzSPkANLxereztkPBoCv7WGX6iX
X-Google-Smtp-Source: ABdhPJwzwAgBJut9x8nUk1XqzpsbqJ8B/iN04mKahNLszI9mA7kZUC437wbqHYrvmU0vdte769zywTMaAUDIiNFjNKyGoNX0UYW1
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2d08:: with SMTP id c8mr2857216iow.199.1642100647552;
 Thu, 13 Jan 2022 11:04:07 -0800 (PST)
Date:   Thu, 13 Jan 2022 11:04:07 -0800
In-Reply-To: <00000000000086205205b0fff8b2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c86f9d05d57b594d@google.com>
Subject: Re: [syzbot] general protection fault in ieee80211_chanctx_num_assigned
From:   syzbot <syzbot+00ce7332120071df39b1@syzkaller.appspotmail.com>
To:     arunkumar@space-mep.com, davem@davemloft.net,
        johannes.berg@intel.com, johannes@sipsolutions.net,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        phind.uet@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 563fbefed46ae4c1f70cffb8eb54c02df480b2c2
Author: Nguyen Dinh Phi <phind.uet@gmail.com>
Date:   Wed Oct 27 17:37:22 2021 +0000

    cfg80211: call cfg80211_stop_ap when switch from P2P_GO type

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16afe84bb00000
start commit:   7f75285ca572 Merge tag 'for-5.12/dm-fixes-3' of git://git...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=b5591c832f889fd9
dashboard link: https://syzkaller.appspot.com/bug?extid=00ce7332120071df39b1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1393cbf9d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1238ba29d00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: cfg80211: call cfg80211_stop_ap when switch from P2P_GO type

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
