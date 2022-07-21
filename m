Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD9A57D1E0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 18:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbiGUQqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 12:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiGUQqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 12:46:15 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4069E87C00
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 09:46:15 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id z11-20020a05660217cb00b0067c63cf0236so398394iox.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 09:46:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Lh8GUyjZ+95KJHeS6CKqtOSROmHf9AQTkTHT8abyJsc=;
        b=RyByYGjjfqGhWD5nFOw43o8TgUjK5XWVgk+YPKg3j1sxps3L2bOIAanS5Xy9xlkabX
         hNTC62Hr7qkfV7J9Q3V5y5ymPXkoTirsglTzp+TK0yFJXNucB3DLc/MN+CkM+iOIv9Yd
         NXCvbpiYSdtscJCM5wOuGzOKvLr3dzfGfhaEN8XMmmNWo8soa1SkbKhSU4AqIW6TZ+Y5
         b7reGT9qjfiXOMWU2OcIAJvmAgAZB3Ks4Ttb+wvC6oRv98fFQvfPVFt0Jebltdck74Sa
         jOO70Af028ZpPGwpfvF4WGFUy/W+qmhDqw2XPxpRwBFsQQ2ttLsJMcXPre+b3ucTWyVY
         zT6A==
X-Gm-Message-State: AJIora+Ekjh1hevcS2tVCe977Qaq6BaFXE5vTlZdkgRs3uJC245zr5OI
        lvVeUG79y+A5jrlKcpgoFl8K8ofMcXZWoQjcfh9tcOn4yK05
X-Google-Smtp-Source: AGRyM1tFwAXk7LyT0MzJve5L+Ak4wKxJsuHUR2/5Vh+aXLMMJoS9NQE5rRLSOCJWtWCOHmI0NLcVsNngtAqFawxLff6yqHMzgT+5
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:10a:b0:2dd:15af:379a with SMTP id
 t10-20020a056e02010a00b002dd15af379amr1205180ilm.101.1658421974644; Thu, 21
 Jul 2022 09:46:14 -0700 (PDT)
Date:   Thu, 21 Jul 2022 09:46:14 -0700
In-Reply-To: <20220721162656.2033-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000afbe5805e45374a8@google.com>
Subject: Re: [syzbot] INFO: trying to register non-static key in ieee80211_do_stop
From:   syzbot <syzbot+eceab52db7c4b961e9d6@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+eceab52db7c4b961e9d6@syzkaller.appspotmail.com

Tested on:

commit:         e22c8879 Merge branch '100GbE' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=119975d6080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e37e9aaa4c062adb
dashboard link: https://syzkaller.appspot.com/bug?extid=eceab52db7c4b961e9d6
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14583378080000

Note: testing is done by a robot and is best-effort only.
