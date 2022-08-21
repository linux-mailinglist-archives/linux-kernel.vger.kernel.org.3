Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB6E59B32F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 13:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiHULIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 07:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiHULIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 07:08:15 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44B1F2D
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 04:08:13 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id n13-20020a056e02140d00b002dfa5464967so6428411ilo.19
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 04:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=fltaNMKt2+22E8y3r6VHjG+0AEE0+JQww0vhwiR7T5k=;
        b=cKVFUesYZ4OhxPY07Q9sOuUVPawiCzGAt9jmA/5J+7EJi2BHkw1cGgUefsXm90+wEb
         2b2JVVQSL8DTsfqjmLuD31qfIBsUGoy45IrbzJgIcmK2rXohzCY6CsQdMH99TNjp2A2n
         r+36jIaUOgr0hOcKynJZGTbvyv6CmK/7nOltXOQXpfec0zsDFCiDvyCX28B7iEXmUNH2
         2cG52eE07eBQuZeR24M/k85GhzccWM3Tcu6QSCJ12Ey4N21zz+N2FDvJMbz595ftjrj2
         xkFFhbmTcLEFbsXcUY8WXqyy8oxZ7NFcFjJDPSWTiIL6ZpGoWyVJ6bfgNHrRACLI3C/A
         Sj4Q==
X-Gm-Message-State: ACgBeo2KP9SzzIJ6hBNokUUtLPxeVurmJZ+6Gn43cs24H4uQbVv2RgZw
        8CXPoC4tEOnT0/ErWvy0NEa46EfighjVLdxDLYWcKo66RHM8
X-Google-Smtp-Source: AA6agR4MLdnEFOXrMdbuKX/AyhsGmAefaq+1NG4/k7peTWb2pugVPvzUVEMKhkr6rNJwca6dWBCzWey0RPuvyBWugg92yTNDjzsP
MIME-Version: 1.0
X-Received: by 2002:a92:c908:0:b0:2e9:549d:2e7b with SMTP id
 t8-20020a92c908000000b002e9549d2e7bmr4086768ilp.143.1661080092978; Sun, 21
 Aug 2022 04:08:12 -0700 (PDT)
Date:   Sun, 21 Aug 2022 04:08:12 -0700
In-Reply-To: <20220821101652.1872-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e2b58805e6be580b@google.com>
Subject: Re: [syzbot] KASAN: vmalloc-out-of-bounds Read in kvm_put_kvm
From:   syzbot <syzbot+ee478a0237db20ef61f1@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+ee478a0237db20ef61f1@syzkaller.appspotmail.com

Tested on:

commit:         7ebfc85e Merge tag 'net-6.0-rc1' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12379b85080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=924833c12349a8c0
dashboard link: https://syzkaller.appspot.com/bug?extid=ee478a0237db20ef61f1
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13d2c57b080000

Note: testing is done by a robot and is best-effort only.
