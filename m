Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A23F596E35
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 14:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239369AbiHQMKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 08:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233455AbiHQMKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:10:15 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6F115A16
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:10:15 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id n13-20020a056e02140d00b002dfa5464967so8826297ilo.19
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:10:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=9RCPk6bHeIJNcLh7t7Hvg5FuXBLxs9hY4mf2SXV6Tk0=;
        b=PvcmJxEtAPfY2lp1/i/A+6b+rJg5oYvIa65QXkC1fpPjlxi/ILxMW/qUMMU0WstglD
         SYHwGfSphqBpvRZosE2eaUW2rRr7HkRg3s0mXk4Kvn1K0gHR1GrhDvQd/lGhRNq1clRG
         7U4wmjCjxRmERpHwKHeUq0T7hcM4w0d8gbRPxn2Oigqn8b3tuMpzw3id2nN4rnzIdqr/
         0jSwB6eZppWy1BcEXVmiDrqMrPYg6x4L9/CERLkEVeGW6ACYnzhO8fFA5THaaosyQIPQ
         7aXEOtq8wmUAKSSDIA0S+yd+k/a6j9F2BlkSIt9+sumQqbbwVR5SHnCFpRj4Fd0sdxOW
         M1Ug==
X-Gm-Message-State: ACgBeo07GV92Asld5fXFcrcGeDXBdr3T4JhmYMjL5iIifU1L+y1NZ2CE
        AZ5Sj+VaOTnPkcCUo9DRs4M0bf+hiYiibFvXg6neL2L+xNXo
X-Google-Smtp-Source: AA6agR4ZKyxynIrwCz6/C9YKjfJIOJLXNzTUSQWUhUWUCimKjF8bGk8vtpnTYj7w73LpizLIN271FXpdrzfZRpHjGH0cYTfrKusV
MIME-Version: 1.0
X-Received: by 2002:a05:6638:14ca:b0:346:a62f:cc9f with SMTP id
 l10-20020a05663814ca00b00346a62fcc9fmr3970427jak.163.1660738214534; Wed, 17
 Aug 2022 05:10:14 -0700 (PDT)
Date:   Wed, 17 Aug 2022 05:10:14 -0700
In-Reply-To: <20220817113126.1210-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000057a3a805e66ebf28@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in mgmt_pending_remove
From:   syzbot <syzbot+915a8416bf15895b8e07@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+915a8416bf15895b8e07@syzkaller.appspotmail.com

Tested on:

commit:         40b4ac88 net: lan966x: fix checking for return value o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=176cb1a5080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=924833c12349a8c0
dashboard link: https://syzkaller.appspot.com/bug?extid=915a8416bf15895b8e07
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16d052cb080000

Note: testing is done by a robot and is best-effort only.
