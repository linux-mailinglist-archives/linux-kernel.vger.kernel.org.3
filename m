Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7911957CD8F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 16:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbiGUO0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 10:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiGUO0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 10:26:10 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CC6C47
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 07:26:09 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id f11-20020a056e02168b00b002dc8abbf7f9so1059489ila.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 07:26:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ySmgDatIxHP0HfC+pD98YmKL2oLcCWPSXtuWLyjzQZQ=;
        b=ayJC4clLwSTnrDnTbMIyXYIYFAvAMBvTgjl927Lf2WKdGeJGM86p1Vbnu/CbGfQzYb
         2WQz0WcJNLhHmpDxHLE5fbZ3QFxEH8RXDiR7Hf/P4iSMrvXgX2HID35WXH7QA1dnw9+f
         A58LD1R5c4H/wEBdMlbi2t1sSMkbM8hj0sC0+mtT0BgAh0p+XtFIYB3Lc04EN/Fq7JU+
         dmtgenmz7aKpxBKK4mEbix23vIbEITdXbyh+oLXAX6G1xg4s17y1vjAZ7caZ4a8n5gIJ
         Q76KQBVP6/v1xvjCMCIAuCd1TBo4U90I7oLR56E6RKc/QMPiInKX3aAVEoRVXGocOhva
         PwzQ==
X-Gm-Message-State: AJIora9WUvwucfKV6FUFMjHAQRusEkjLGp8yOX+RcXMQJ9cZMUPRrGLt
        zSDnpCNuNJthBaFCYpbRGevihEFY7Hwpi6CQhtaH5nN7ZOiO
X-Google-Smtp-Source: AGRyM1tNHHZdZzSS/FxQNtl9rTuN1nEqYLIS0vzPB8rCRbcXw2yD5dZkTYoUumxXgwXMUNx0eFlVz+vmIQzS93ZbMZBMgw8hjIZG
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2189:b0:2dd:14a1:8c86 with SMTP id
 j9-20020a056e02218900b002dd14a18c86mr1090588ila.210.1658413569063; Thu, 21
 Jul 2022 07:26:09 -0700 (PDT)
Date:   Thu, 21 Jul 2022 07:26:09 -0700
In-Reply-To: <YtlbkmVGJyhO4kR6@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000acc0e905e4517fa0@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in usb_udc_uevent
From:   syzbot <syzbot+b0de012ceb1e2a97891b@syzkaller.appspotmail.com>
To:     andriy.shevchenko@linux.intel.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, rogerq@ti.com,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com,
        zhengdejin5@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
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
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=1124f6d6080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=badbc1adb2d582eb
dashboard link: https://syzkaller.appspot.com/bug?extid=b0de012ceb1e2a97891b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=177cc2ba080000

Note: testing is done by a robot and is best-effort only.
