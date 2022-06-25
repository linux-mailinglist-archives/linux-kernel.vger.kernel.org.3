Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97BB655A5EF
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 03:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbiFYBxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 21:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiFYBxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 21:53:10 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD00822BC0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 18:53:09 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id 3-20020a056e0220c300b002d3d7ebdfdeso2590687ilq.16
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 18:53:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=GtGyCwocl0Yp8tVlP9BXhAQlgSd3iI9ATo+V/AeC5gg=;
        b=H+lmSJoWq/Im5O63kahSOV1DcJ1aR4wH0Q01pZQsi89UpzZviN3EJvhuJvr8AoYmES
         pjf2u0hFnydlL71XnT5eD3cFLfY2XdGg2PzCedt/HqTBvkr76LLCAjqnXONIE2TK2IAj
         f7ixJKONjQfR3ZtO1HVJVvnjbMevJ5EBYDC9AGhHkpiwEdWfaR78MdchNEMT6xVP0It6
         MSiIxITSI00uzBB2FI46gGyqvrVJTzGgAKqniU/0Yb5XlaSjpBjONsNtBGDVGu4ZepfT
         D0S8lF+YadcYdIQCPbrePpc+yAn7UHfUy5NvQbC7VqsEVIkWIXtYPbxqqF9qWdVFv/YA
         dYmQ==
X-Gm-Message-State: AJIora+yd86BfHbLK5wSrWT5dkRgz8cvfmMS9XoPGJbNEqLPcOTSHhjs
        xqbkuNCISWUVKsp5C+PyKfXrWAnWogJ51eq3sw31L4sJ3LAk
X-Google-Smtp-Source: AGRyM1vCuOH7osTjkET3EpP/lgx/hPHI2xJ7gxMA1L9hrWwn/2kKC25W0hxATcCxtgqi9R1x5QR2B1ZAFGmjLZt1TwAN96O05JX6
MIME-Version: 1.0
X-Received: by 2002:a05:6638:16c2:b0:332:3901:d8b7 with SMTP id
 g2-20020a05663816c200b003323901d8b7mr1235438jat.73.1656121989315; Fri, 24 Jun
 2022 18:53:09 -0700 (PDT)
Date:   Fri, 24 Jun 2022 18:53:09 -0700
In-Reply-To: <20220624230752.745-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e0c4ce05e23bf2bc@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in free_netdev (3)
From:   syzbot <syzbot+b75c138e9286ac742647@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+b75c138e9286ac742647@syzkaller.appspotmail.com

Tested on:

commit:         b4a028c4 ipv4: ping: fix bind address validity check
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15fe514bf00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=70e1a4d352a3c6ae
dashboard link: https://syzkaller.appspot.com/bug?extid=b75c138e9286ac742647
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=175c6e37f00000

Note: testing is done by a robot and is best-effort only.
