Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5664054E12B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 14:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376281AbiFPM4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 08:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiFPM4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 08:56:10 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882713AA74
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 05:56:09 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id r76-20020a6b2b4f000000b00669b75529e5so836104ior.16
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 05:56:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=7dgrW0/sl3GQ3uXBraF50K7X7RRrejAyzeBz0ig+N+s=;
        b=weFdrhgCgjYdUr5Rtj6otkDUOFegdqXAiGJPCSL8nVBoN2Nd/4tqZGf6A5m/Qmm8Ef
         dz05YJpv5HlUR7J502hdd9OHEBQR9VXLyZwXBwLb+lbEOGEKYql1uaoS89CAw2n+C0aK
         8PfBAwI2VOecul2vZNP3SAuX9TcEkt3C0nxxVXkkLbUNePqduLLKVDM5UEfB4Xf5jD5w
         Vu6afyKvJyGjvlC3iuCx+/2/HQD7ymZqpd8hi38TasxKiGvTkosMWUGwB6JD9mZQ5pmv
         VpBumXCyRN2erWgIu+LzsL3qfkCVAC3pn8UqXpmsKnBgl8dgMKXIS7Mu0Cj0Zjm/E7el
         Ib5w==
X-Gm-Message-State: AJIora/wlXmsSvnj7Z1oqrfwJyX9dozIKFb1n3bYZDMndSpUQAq37MPf
        0JDJPFbEVGzfC08x2CyfhRtq+DPey3hHw7pgGxpN2FXxlQRN
X-Google-Smtp-Source: AGRyM1tBqEDRakt56/+n2G6Ca2qbmxEqzONnDCAolQpXrx30minSxKuF54OnAn+bFI1rhGxyrsTF1sf45gtGP4uK3gN5UMsgplev
MIME-Version: 1.0
X-Received: by 2002:a05:6638:f0d:b0:331:e337:f4e4 with SMTP id
 h13-20020a0566380f0d00b00331e337f4e4mr2657302jas.249.1655384168913; Thu, 16
 Jun 2022 05:56:08 -0700 (PDT)
Date:   Thu, 16 Jun 2022 05:56:08 -0700
In-Reply-To: <20220616123726.2597-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005ae29605e1902945@google.com>
Subject: Re: [syzbot] WARNING: ODEBUG bug in route4_destroy
From:   syzbot <syzbot+2e3efb5eb71cb5075ba7@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+2e3efb5eb71cb5075ba7@syzkaller.appspotmail.com

Tested on:

commit:         018ab4fa netfs: fix up netfs_inode_init() docbook comm..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=167212c3f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f21890d74080ef72
dashboard link: https://syzkaller.appspot.com/bug?extid=2e3efb5eb71cb5075ba7
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15b2f608080000

Note: testing is done by a robot and is best-effort only.
