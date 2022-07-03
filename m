Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB0556459C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 09:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbiGCHkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 03:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiGCHkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 03:40:09 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156BD6439
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 00:40:08 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id bw12-20020a056602398c00b00675895c2e24so4022398iob.19
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 00:40:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=s141Ejx+6ZmOtqXtjOpL3vVUTBxzEz8uulAeMjK6AGc=;
        b=pwpXIoXfQARFtd1V8RPUNR0N4DeQ0v+6WUkdlUjkQPu1i0IjJrLSZq9N1/AZGMPjXM
         9/MAF13kl9924N8LKqksfafLW/PltnbzU9CAAhBpc2DObHdbogVkZmQI5qNDDWSwrs0y
         dIr+5GG4Ia1lzjxZ9A1Bv58ctUU5p25xruR2blfRsIkjpq1pT9K5V75LidlAlTkxe9rF
         8G/8akRKWDa0dDdIVv7HsputVjKqSpyzO7zopM55wk96L6eOz9NEjYRi4aaFfq3HZ12S
         VIZn/aNrh3UwnPSEpeRVMybWuo02nXmI7LX+V1a7Fc3euCE5dvQpRQ+PysOUk05bpEmq
         qSNw==
X-Gm-Message-State: AJIora+uiNP20v17D9mTAzOt/ObtOkTj2+EGV1i1iWkDnGdDhbYHJFn6
        mZ+mASS2NJJMrr8K6FeShDDQbFKMaVJimRtSIGSYG4WqkQOE
X-Google-Smtp-Source: AGRyM1v/I9EKoHFgLMZe1dvCIx1N/hZGkCJj3V9CKabsXzOSKkM+5rnaxP1FMXSeBmw/sNNmshGkv9ZggRLMTZe7TM3N07IzVWEK
MIME-Version: 1.0
X-Received: by 2002:a92:d946:0:b0:2d8:e271:79c2 with SMTP id
 l6-20020a92d946000000b002d8e27179c2mr13509151ilq.240.1656834007488; Sun, 03
 Jul 2022 00:40:07 -0700 (PDT)
Date:   Sun, 03 Jul 2022 00:40:07 -0700
In-Reply-To: <20220703070714.1237-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000077dcfd05e2e1baab@google.com>
Subject: Re: [syzbot] possible deadlock in mnt_want_write (2)
From:   syzbot <syzbot+b42fe626038981fb7bfa@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+b42fe626038981fb7bfa@syzkaller.appspotmail.com

Tested on:

commit:         08986606 Merge tag 'libnvdimm-fixes-5.19-rc5' of git:/..
git tree:       http://kernel.source.codeaurora.cn/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1479f7fff00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=75c9ff14e1db87c0
dashboard link: https://syzkaller.appspot.com/bug?extid=b42fe626038981fb7bfa
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11e05fd4080000

Note: testing is done by a robot and is best-effort only.
