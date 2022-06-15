Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2C654C772
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346496AbiFOL0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245180AbiFOL0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 07:26:16 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D62424B3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 04:26:14 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id r76-20020a6b2b4f000000b00669b75529e5so5878218ior.16
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 04:26:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=UQxnSfg6TnSWZ3zBWqt7rNLBJHB5jX+VpfQyusZRyF8=;
        b=XhEve5TPe2CBaMEodJDJiRkuOvZlDWDwVY0VQ8t9z2IPkcuqPYkf0enozWM5lFIWGX
         hDm+BnjAUolnaHtcIIjZ4RKf/IOYjwWTrnnd02/DlKGpc8nFAHyeupbTNjsuHHrUJ1QC
         jOYul2rsh31K52lHJ8R2HkF79IfBOkJuWjcdnybnQVJpEkNukl8olN7Lu5jSbsnWeaSZ
         Ob2wpM4hmqyfs2l3c3iZuaQq2qMn55bXftuHlXhCRbCcTCaTezs+HxeDkPAGxxqwpFG0
         HR3N/RHHXNwJp4tsQ3S0jVo9OKfw8MnsoN963xmcrjR7jjSkhp+m6dsVUN50jduCuHnI
         sbKg==
X-Gm-Message-State: AOAM531r3mEmNMK+hCN0HOCh0j8g+gizJe76RxGhtNh2Kyq47aPuexmE
        nRRQ6y5Pq839nyGyHHTA8fUZWqNX98kh2dniachE4EK/BpER
X-Google-Smtp-Source: ABdhPJwA+MJi5znPE1tARF3RLbEwqkL373x8wpbWUJZc/xke8lJBbjvJqa8zAccC/x8N7AD9rqAbIaV9RPgFHXkw0ro+E5G/tf3I
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1606:b0:669:cb4a:dae7 with SMTP id
 x6-20020a056602160600b00669cb4adae7mr4770949iow.116.1655292374339; Wed, 15
 Jun 2022 04:26:14 -0700 (PDT)
Date:   Wed, 15 Jun 2022 04:26:14 -0700
In-Reply-To: <20220615110916.2060-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f8d63505e17ac9ca@google.com>
Subject: Re: [syzbot] possible deadlock in j1939_sk_errqueue
From:   syzbot <syzbot+ee1cd780f69483a8616b@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+ee1cd780f69483a8616b@syzkaller.appspotmail.com

Tested on:

commit:         24625f7d Merge tag 'for-linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17d77f10080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=70e1a4d352a3c6ae
dashboard link: https://syzkaller.appspot.com/bug?extid=ee1cd780f69483a8616b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10b51fbff00000

Note: testing is done by a robot and is best-effort only.
