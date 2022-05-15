Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93EA3527904
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 20:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237980AbiEOSGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 14:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiEOSGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 14:06:18 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B3D63E7
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 11:06:17 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id l8-20020a056e021aa800b002cf778c63caso6687276ilv.10
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 11:06:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=oPGQxfIwbb9QsQbrJvf8Wi53xwv1p8oC92azXf2cBpE=;
        b=ZVqmiC9bJiu4Nj+hcbKbKfl8qLLxVsaIovHOJ4k9egF5PiJ8AQGlCTwMF4KHq31ZxW
         8q/Tv/+ZausopABqVZLzjpZXe+ooSjQCPlq53dzwY4B7vesW0/wKKqZlywpk9NnZSAA+
         LsgJp0B8FsuOuM71U17HwimRI2MhtmHLItM1fZXOjAlpxx4RpIUYp+K8E+6ge5BFe5n2
         fjIlXpU0BJtsMm9jxVhDaqtjxpJFC1lAcrSQDxsqnnQuz7IhTx3ersmT6yUvlJybfuuS
         K+Sg7LSM+7rhPax/CHNt2tjmHUCYKv5QjDlRdXhd101vUzonqUnI5cLYGQHFPes0Yulu
         yBew==
X-Gm-Message-State: AOAM531vb/Dypw/Seii8G0MesJdJ3/odCDHcL8f3t/w5vNkNFWuKTrnh
        D9qILGXHAfiwpCAaKy/4U6tNUaDu+AAb51mPfCZ7BMU178hy
X-Google-Smtp-Source: ABdhPJxD3ycjJsSa5v55IdSjv/TrHXKD0tEnHw6gL+FulOK3q2CBC9dHIAgVaOCcnI21lSPIaBaG5tDuhzkpvxwmAIGsNudsVNaG
MIME-Version: 1.0
X-Received: by 2002:a05:6638:22c1:b0:32b:8e38:bff4 with SMTP id
 j1-20020a05663822c100b0032b8e38bff4mr7184895jat.151.1652637975100; Sun, 15
 May 2022 11:06:15 -0700 (PDT)
Date:   Sun, 15 May 2022 11:06:15 -0700
In-Reply-To: <556cb5e5-bfb8-9a2f-054e-e5c8c488a578@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000072c21d05df10c303@google.com>
Subject: Re: [syzbot] WARNING: still has locks held in io_ring_submit_lock
From:   syzbot <syzbot+987d7bb19195ae45208c@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, f.fainelli@gmail.com,
        io-uring@vger.kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, olteanv@gmail.com,
        syzkaller-bugs@googlegroups.com, xiam0nd.tong@gmail.com
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

Reported-and-tested-by: syzbot+987d7bb19195ae45208c@syzkaller.appspotmail.com

Tested on:

commit:         3782ad72 Merge branch 'for-5.19/io_uring' into for-next
git tree:       git://git.kernel.dk/linux-block.git for-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=7b4d7b33ae78f4c2
dashboard link: https://syzkaller.appspot.com/bug?extid=987d7bb19195ae45208c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
