Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC03D4E253B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 12:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346769AbiCULbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 07:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238787AbiCULbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 07:31:42 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5CD8CCD7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 04:30:17 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id x6-20020a923006000000b002bea39c3974so7200777ile.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 04:30:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=KzjEr1+hgr7MD8f5jMgWlmnsK+QjCzm3jdhixdqeWiQ=;
        b=DEFUEIBC3mqUz099AsjKzii57/Qil2374XkOs6+rViG8ydll+apJkWXWEcG9WG1PKC
         TuiA569SvTjeytmpHm3JAIWtbzcr2tESza/CvMgWl8vIxmI37qsG9dfpwBLIH3p4d7cK
         9eUpjiWH45f/MbFHPgbrMPNLeWuv1qc8x/Vu7u0JU9woozjDFlUpeKHWC6EVSkbg84cv
         SyY7WtIbmNE9ktwtIHIRykR6k3opBQ+awdQSyaW4UM7f1jHfbIDcM4soS44ejXR6aqoQ
         A9XfPOma+RoSlokzZkCT6uWL4mD0h5ZgmLl3ISiEJxX9pibY1Qx+NH5QDzhE8DWf5xtq
         E1CQ==
X-Gm-Message-State: AOAM532KCtbpkbXJz9Go6dZK1l7kmPNtbEoXO6fPxb6p6dYEF2bMXOhg
        jo6uJijg4118zpsob25AgE3pcGy4eywRzttErLZ3DIOkerbW
X-Google-Smtp-Source: ABdhPJwKgCVVTdt4W9/iVfVl5OsXXuwQJWx3S7OTU2lBM+evmsJ1LsZ4MA3J0y4LZy6mS5L5evR2MgLqTVnR9v0P/DxGJGeAotVP
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:190f:b0:2c6:74aa:cc73 with SMTP id
 w15-20020a056e02190f00b002c674aacc73mr9040021ilu.29.1647862217200; Mon, 21
 Mar 2022 04:30:17 -0700 (PDT)
Date:   Mon, 21 Mar 2022 04:30:17 -0700
In-Reply-To: <1003460.1647861598@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000018652f05dab8d297@google.com>
Subject: Re: [syzbot] KASAN: null-ptr-deref Read in __free_pages
From:   syzbot <syzbot+d55757faa9b80590767b@syzkaller.appspotmail.com>
To:     christophe.jaillet@wanadoo.fr, dhowells@redhat.com,
        fmdefrancesco@gmail.com, linux-kernel@vger.kernel.org,
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

Reported-and-tested-by: syzbot+d55757faa9b80590767b@syzkaller.appspotmail.com

Tested on:

commit:         733021c6 watch_queue: Fix NULL dereference in error cl..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=19ca6f72fd444749
dashboard link: https://syzkaller.appspot.com/bug?extid=d55757faa9b80590767b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
