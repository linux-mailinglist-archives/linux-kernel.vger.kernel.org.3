Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449B457C962
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 12:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbiGUKwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 06:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiGUKwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 06:52:16 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDFE8052C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 03:52:15 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id q15-20020a056e0220ef00b002dcf06b188fso811007ilv.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 03:52:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=5GuxVnz0rbM5EyhUHnn6ht8XDNnckbo4+H3Vu7I05fI=;
        b=wgkeH5k/8/0nXx9rGrxDwQ4e9ioHjgUJicL+X5m9tuEZ3dRh7XEeEOdzNpj5TQSd6f
         PwoD/sX4ZZqxYGP+HWUkp7TWytDWlH5035a5gL3nDo1NiiQAkSJof+RsW8Sea8CmvjBZ
         hshrTGvSAHe3oBCMy2jPFXgAdgV0sbGESPjgfETiLb2uOlMJTRwzZrYy3zcWU6HhbDjX
         BnYzl4x1mteIBspjy/0XsdEAdXLG0onrOw2TlBxo9sSoxYWw9M+/ydLv63vSin6zBWam
         +cTzbqAVjQtmF31aD9WqljYtgCZSexuiSCYZLpr+LmIe/EbFzV81qbb3CC3fxYGFF39q
         B6PQ==
X-Gm-Message-State: AJIora9nGWXOTA46gvaW1eGSDDx/0djTcLwkPpCF0wTC+ocfvJ7d9Y5Z
        WCeUv5ph9FccpZA5+/Dp1Gs3v0L3NNdfPFfD+pbCPbkEYaGr
X-Google-Smtp-Source: AGRyM1vgtpP2367GmH1SsauIwaHUyWS9Kmfk74u3fo4Esu7cPqWD73ex/hwrEDS4puaY2NPOTYZSD07OQ6ybJQLviUBdfQwCSpSN
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2dd2:b0:67c:522:6fac with SMTP id
 l18-20020a0566022dd200b0067c05226facmr10062629iow.116.1658400734442; Thu, 21
 Jul 2022 03:52:14 -0700 (PDT)
Date:   Thu, 21 Jul 2022 03:52:14 -0700
In-Reply-To: <20220721103453.1845-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000abfe7a05e44e823a@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in usb_udc_uevent
From:   syzbot <syzbot+b0de012ceb1e2a97891b@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+b0de012ceb1e2a97891b@syzkaller.appspotmail.com

Tested on:

commit:         cb71b93c Add linux-next specific files for 20220628
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=172e6f06080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=badbc1adb2d582eb
dashboard link: https://syzkaller.appspot.com/bug?extid=b0de012ceb1e2a97891b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11860454080000

Note: testing is done by a robot and is best-effort only.
