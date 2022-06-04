Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF1453D674
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 12:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235076AbiFDKoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 06:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbiFDKoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 06:44:08 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04844ECF9
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 03:44:07 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id u8-20020a056e021a4800b002d3a5419d1bso8064929ilv.12
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 03:44:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Pb+NhBmE5Npow1DGAGKUfbYGPUdSzBEwQpAUOHLnXkc=;
        b=bKkFhUkfLS7Gx0vl2oYEQoismqDUDmpO/pssR3ZbbyaTKKnIWwoRWpnRGgHjJ2vx9y
         KGKfhJ9cOsAGZuWhm+lIdbODHBCqc05neZB7sovuIJGjt/ajTjvDzFtSYmvjRJFoHtov
         j2y12gSqeLlWHjB8kBSoIHyfYc0WXAK3vaCWMDFXKKk1os9FQySAQkUtbifBLn1gmwK6
         V4f3giic8ebJTALAzfnkV42OPInX5TQuqltsORjNrnW4ZxiGVCPZg2RZBK5u4ABedQZD
         XKbFrCaAvc7mn7tNEx5luJhcQbo/lRmyMAFGZ2JvXXLpHXIOXV1vciZUd49AHpLV9cSP
         lCGw==
X-Gm-Message-State: AOAM5325DQEPzXMph3p6/Ftdv76cOATQvyUSyGbvvZqEWJpiFXyUQRcz
        t1lVuEO9LoGGemTX+4Y0TQdmrlbM+Pb7j5vXK9H5xLi8vG8U
X-Google-Smtp-Source: ABdhPJw7pZUHicYPaaOzk3dkGyS1mP6GYTRquBHQ03xiEzaVJkxpH0Hi8sALoDLWqCeqjQgZOoQlrRp+KDObtK59MTMueBHv+VkC
MIME-Version: 1.0
X-Received: by 2002:a92:de0d:0:b0:2cd:6d7b:e12f with SMTP id
 x13-20020a92de0d000000b002cd6d7be12fmr8113963ilm.179.1654339447106; Sat, 04
 Jun 2022 03:44:07 -0700 (PDT)
Date:   Sat, 04 Jun 2022 03:44:07 -0700
In-Reply-To: <20220604082520.5635-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000015855305e09ceb23@google.com>
Subject: Re: [syzbot] possible deadlock in j1939_sk_queue_drop_all
From:   syzbot <syzbot+3bd970a1887812621b4c@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+3bd970a1887812621b4c@syzkaller.appspotmail.com

Tested on:

commit:         50fd82b3 Merge tag 'docs-5.19-2' of git://git.lwn.net/..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc5a30a131480a80
dashboard link: https://syzkaller.appspot.com/bug?extid=3bd970a1887812621b4c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1785e693f00000

Note: testing is done by a robot and is best-effort only.
