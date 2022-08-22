Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B23D59C407
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 18:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236966AbiHVQXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 12:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236961AbiHVQXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 12:23:16 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D421A1DA
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 09:23:12 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id z30-20020a05660217de00b00688bd42dc1dso5877961iox.15
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 09:23:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=WkKZ5NODq/Qymdy1tEZzofeSuiOIi9pswPpZMiFn/38=;
        b=PHuSHsNwUBng5flhRtyCgjcfSjY7M161Q+g0mHIRPol9NWQR5svd1mHb9b9uJwpXHk
         OabvRS9iCfG316Lyyh/5L3kz+H1Ziuul0/Ics7mtZNxyMg7ptny69Lgy+SwbYF5bdV/R
         JIoQLiWPR6lZADM+DeawdFg7z4hfUMLmyqe+maol1z56RkVuNgC+iA8Abd1WbKuHle50
         1b0pGkKnWT2XY72vYftSPSNYAyx1D0d8Ap4TTNk6nuHmfP930lFZvDIA3mRJ3+MseRhH
         4cHT/APDO36R9ey3UUwxo061cRO5IhBN4dvI6WpgCG8belGdIQNWOev7ZAIC4/naCwff
         njDA==
X-Gm-Message-State: ACgBeo36mW5SQ12m4e+PulRo9nmdrbh4M+z4NthG3gs77eXtdLXRn9Kg
        vjg3nbhXYNYkV4z3vFP4itgWLzioxXe0fBkHnwvRtysRnRlN
X-Google-Smtp-Source: AA6agR5hxkMoScoyFrXGJPc8cBZJhzujPur3+AOv0D6Bw2fqc99JQx50+BG7985kdQ+w40VR8ouNdtDdOoO+toD4LvEG5FZ+G7Nx
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c26:b0:2e9:9acc:911 with SMTP id
 m6-20020a056e021c2600b002e99acc0911mr4028748ilh.131.1661185392232; Mon, 22
 Aug 2022 09:23:12 -0700 (PDT)
Date:   Mon, 22 Aug 2022 09:23:12 -0700
In-Reply-To: <1959174.1661183147@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000035d93c05e6d6dd39@google.com>
Subject: Re: [syzbot] WARNING: bad unlock balance in rxrpc_do_sendmsg
From:   syzbot <syzbot+7f0483225d0c94cb3441@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dhowells@redhat.com, kuba@kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        marc.dionne@auristor.com, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+7f0483225d0c94cb3441@syzkaller.appspotmail.com

Tested on:

commit:         f1e941db nfc: pn533: Fix use-after-free bugs caused by..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1550e4f3080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=930fc801ca92783a
dashboard link: https://syzkaller.appspot.com/bug?extid=7f0483225d0c94cb3441
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1518592d080000

Note: testing is done by a robot and is best-effort only.
