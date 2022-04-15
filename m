Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE76502128
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 06:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349334AbiDOEGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 00:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349326AbiDOEGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 00:06:34 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D04AAC89
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 21:04:07 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id h10-20020a05660224ca00b0064c77aa4477so4188775ioe.17
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 21:04:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=GOM/u/LjYywzIfgQEbQmUfvSEjGD9tJ5Gw1F0/rgW7U=;
        b=aT7k6dw/1vWAbO4dMKQgXEaDfPGKR4CRk7S4lJ1oPbb4xKQWe2+3twdK4QYwOOaIdZ
         GqwvauFu+AHBNJXOQGBiOGRgoI+6IP44VW/YkmMX6Lr9ZGN2nrBrlrQfV42ncgDmnaUD
         7mly0x4Hrt8qlBqz6bhwnW0RSxQW4rBUq5Aulqnq+OqFXEhvFJMoLNIDj9GHGcRfpnjM
         YNbp+FmtG4cJclxn7yAe9hb/EMRXWC9JD3oxtPtsbzP9XVoEKNbtz1vB8VpfIAoW1TRx
         l49b3bVYypkDgk+n68dUtIt6qXmu89ueMGYLDyO5nMPMe4ZFE0DPGXTIKRWlLT6BG4hg
         eB/w==
X-Gm-Message-State: AOAM5318ZxE1LE1vczS5mxC9sq4RSssIUqgWvv1SYC8sYUquGrzovzEO
        78LIz3uhpqiHavfNoQ5fPDbFOwNG4Yoz/e44cdh2RuY0LTeg
X-Google-Smtp-Source: ABdhPJw43wBjC+s6gCr8+BHHrKq5QX38deICyV9LuvBjQTDqr8QEpp3b9kxO6bRNBDo5jzXDiHROM8noDKB/FBRT5WnYRAELj7O0
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3c5:b0:64c:727d:6e95 with SMTP id
 g5-20020a05660203c500b0064c727d6e95mr2731705iov.118.1649995447343; Thu, 14
 Apr 2022 21:04:07 -0700 (PDT)
Date:   Thu, 14 Apr 2022 21:04:07 -0700
In-Reply-To: <c122ba3e-ef7b-0f70-1972-1bae0ddff651@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000851e4705dca980e9@google.com>
Subject: Re: [syzbot] kernel BUG in commit_creds
From:   syzbot <syzbot+60c52ca98513a8760a91@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, ebiederm@xmission.com,
        io-uring@vger.kernel.org, legion@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

Reported-and-tested-by: syzbot+60c52ca98513a8760a91@syzkaller.appspotmail.com

Tested on:

commit:         70152140 io_uring: abort file assignment prior to assi..
git tree:       git://git.kernel.dk/linux-block io_uring-5.18
kernel config:  https://syzkaller.appspot.com/x/.config?x=eb177500e563582f
dashboard link: https://syzkaller.appspot.com/bug?extid=60c52ca98513a8760a91
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
