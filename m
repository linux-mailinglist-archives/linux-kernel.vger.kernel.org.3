Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B2A585CE7
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 04:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbiGaCVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 22:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiGaCVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 22:21:12 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B2111C16
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 19:21:11 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id o5-20020a056e02102500b002ddcc65029cso4501909ilj.8
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 19:21:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=zo5fJoYQixEXYBbCGndUPC/ArvAVBHlw1k2WroOMkwM=;
        b=4tLIBCsF+2p2ovBu2hsZ8AYSk/wYRXdN2aWELcSd5bMnM+hIIOKCKcb5ORogLgEkyE
         IeOQRa6gIUO0FWrTek7ztOjb3+BweQIBhckxOqgN/Uol5RWateLEdmPvSNMPxio3ZIB5
         sjkpC9q70p3Qq5XTdsvsI/4VZtnP93fBfK5aew4N0pn7jBwRtT85pnmu8Yo35BoE9D9h
         Q7wgVYSzN15X2F+Tz+fSWnA7EZ28I8vBmcrRL9G1Kbwjcd4BHs5gvbO+j+CIktl4Onhb
         y56Rqubsbk7CX6VeZsomo9AMpnxMtwoFQkAUBlapXNDvafQDs+jW/6oo275XvtDYIlVk
         xaCQ==
X-Gm-Message-State: AJIora9kb9QyFMwzQJnIOhiLTrMEC12LsNw/jwqPZIBGIz9/qiLK2JnB
        4hAGGci91DHZ2e2a0ksm2cQt/y6omWVbg7X9FzcnwHgthLxq
X-Google-Smtp-Source: AGRyM1vN87uoyVwxFW+oI/Up+ogSIJvwrDGrd7IY1Z5wRg18UdGYq1l6SI9Twd6VZpQCDAObOrDybKGKohwQUIBB385cHFtYGV9u
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2410:b0:33f:8518:659b with SMTP id
 z16-20020a056638241000b0033f8518659bmr3672140jat.253.1659234070386; Sat, 30
 Jul 2022 19:21:10 -0700 (PDT)
Date:   Sat, 30 Jul 2022 19:21:10 -0700
In-Reply-To: <20220731020212.1439-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005d5df405e5108919@google.com>
Subject: Re: [syzbot] INFO: rcu detected stall in net_tx_action
From:   syzbot <syzbot+3ba0493d523d007b3819@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+3ba0493d523d007b3819@syzkaller.appspotmail.com

Tested on:

commit:         f80e2148 hrtimer: Unbreak hrtimer_force_reprogram()
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15be83da080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=31eef52c6517a0c2
dashboard link: https://syzkaller.appspot.com/bug?extid=3ba0493d523d007b3819
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=155655de080000

Note: testing is done by a robot and is best-effort only.
