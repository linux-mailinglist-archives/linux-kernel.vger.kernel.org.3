Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEE458D1A1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 03:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244799AbiHIBDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 21:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbiHIBDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 21:03:13 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCDD1CB32
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 18:03:12 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id s5-20020a056e02216500b002dde8b02f62so7668914ilv.15
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 18:03:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=GNZ/WEEcU/yigVdW+3TGwb/mwTJDxOKNs/b3Za4ZRoA=;
        b=6qLM53rVboIBA/U1sN0Mgc3rmfdLuQ0cUov0m3b/GiTnIS54EfqgBuFTDLCcraJKcq
         7i4Rm8qtj5WkY6FyCu6NtOjndw4yrJvGqWpe/16D3Rtjvn8fONhsf4CWKQiNbcGNzh+w
         QZN61vVgMpFM7eVnyAly/YNsoRz0XMzj3l5TB7gkftoj0bQmxQJyexO9cqaJ8vaVwNcn
         G+sq5w0nUVM0gDOOuDalerZitOrHpoMCHZNHeosCI6jLY+MoUV9Zu7jbIjair+cKwnZg
         SZ2JGPYnsZpQDcewoIoZ/cJTd1ooKPbRU+WSJShSCoeeqYI0yM5N0ccLxKqy2/OoOnOJ
         IboA==
X-Gm-Message-State: ACgBeo2N+d4o52LDcwflCS+tWtkjoS+8BxMHMYVAH/d1QP9sYtWHrpFI
        RSLTfUq9gFH4mKkKGk1jZvEQbvyI3rORHtEhoMY9l7Ya8pZ/
X-Google-Smtp-Source: AA6agR6lGbKCkVCen8Pq3kkuCbC5xZX2EPvMb7eVfPMPn6uzv8lo6hvhu7Y45JT6EF5zqg7q5d51CW4/YS7lsfDIhtjjf7enXY9G
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3cc:b0:678:eb57:5eb with SMTP id
 g12-20020a05660203cc00b00678eb5705ebmr7999553iov.125.1660006992163; Mon, 08
 Aug 2022 18:03:12 -0700 (PDT)
Date:   Mon, 08 Aug 2022 18:03:12 -0700
In-Reply-To: <20220808133219.2248-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000017bd2d05e5c47f10@google.com>
Subject: Re: [syzbot] possible deadlock in ext4_xattr_get
From:   syzbot <syzbot+62120febbd1ee3c3c860@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+62120febbd1ee3c3c860@syzkaller.appspotmail.com

Tested on:

commit:         cb71b93c Add linux-next specific files for 20220628
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12afd10e080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=badbc1adb2d582eb
dashboard link: https://syzkaller.appspot.com/bug?extid=62120febbd1ee3c3c860
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=104ed896080000

Note: testing is done by a robot and is best-effort only.
