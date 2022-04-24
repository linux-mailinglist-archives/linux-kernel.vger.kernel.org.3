Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB6050CEDD
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 05:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237970AbiDXDYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 23:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235940AbiDXDYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 23:24:08 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DED5AEC8
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 20:21:08 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id u18-20020a5d8712000000b0064c7a7c497aso8720581iom.18
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 20:21:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=6ArGAEZJ6yyaQa9rlHgTgII5cuN0tKZpMgaymdZ+DWE=;
        b=YY9urv2WRdhDLhcMcx85E2p3cq2pXnRUvBLrvF1Mlj36l+CUlxGKTy2ue0AktgcIji
         nV+4rwuJ40zgy3qE6XEHIuXlnwE7HbJHvRLAu1Czgsui08X7aYEY0PJ2RdFDXYewfaS5
         x+uXB+ard0jl8KjCGmaU0HFM11sxtV+LfRl0gv1cE208Y3H7GVMd0PsBuwZAyPeXJmVW
         R6T3Y8OPwHdfb2YmmAJuI2llB9lexV0hR1gM48MS3UHqk2mCgru4VgM+glRB86zzvWbD
         hk2kb0a3sqwCqUGXGZRurUUTW/u41FiUN8aXbPhNgbw1vTDDdGxN5Fgv3s301VSVqmP4
         5PnA==
X-Gm-Message-State: AOAM533WReXsSrxIeHLrCzruJltM/WJpVfjKYMv6gSn0O2I97Ucsuudy
        PYtBzvX1a1MYuskW3x+34qVdp4BWnrjxikKImaF1i3WZz2iV
X-Google-Smtp-Source: ABdhPJyPm89BQLjrpKz9XSb8SJL9YK5Lp7Nmfe6awRPRwtyu0ZU2JQmbgZezH+QX6ZxUuF865f10IY9N+jE0hiJsGIbxdZh0CHBO
MIME-Version: 1.0
X-Received: by 2002:a05:6602:228e:b0:654:a673:2994 with SMTP id
 d14-20020a056602228e00b00654a6732994mr4768202iod.99.1650770467751; Sat, 23
 Apr 2022 20:21:07 -0700 (PDT)
Date:   Sat, 23 Apr 2022 20:21:07 -0700
In-Reply-To: <20220424030445.3134-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000560c8705dd5df304@google.com>
Subject: Re: [syzbot] possible deadlock in snd_pcm_period_elapsed (3)
From:   syzbot <syzbot+669c9abf11a6a011dd09@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+669c9abf11a6a011dd09@syzkaller.appspotmail.com

Tested on:

commit:         45ab9400 Merge tag 'perf-tools-fixes-for-v5.18-2022-04..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
kernel config:  https://syzkaller.appspot.com/x/.config?x=d1843173f299d1e8
dashboard link: https://syzkaller.appspot.com/bug?extid=669c9abf11a6a011dd09
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=129b9652f00000

Note: testing is done by a robot and is best-effort only.
