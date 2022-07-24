Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2CB57F536
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 15:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbiGXN1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 09:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiGXN1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 09:27:13 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F0B11C0F
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 06:27:12 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id l17-20020a056e02067100b002dc8a10b55eso5694412ilt.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 06:27:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=1OtCs4tBRDhs9/PfenuS07eTKFYGPd02xNCaqa46XUQ=;
        b=d5FVfojfmlLMfwHA8iqVAKUEwU14dUYi9l0gYR53RQRxZoGv+CE0J3a2Hs3LVuQNK2
         eL0CNTAUNTYxznB6lyRYruEEcqWu2GNaLm7eoHLl46HBVQKPdNt5PLoUdG+q70OAjJW4
         qRpu0cHtMkbxwZqNZWxQh9RmGC6/lR1rRc8c/CM3koYZ+ANjFUeogy/9x3fn+zHTQHAA
         9zJR3bQo66zP/EscpIj2uMeU9dCsqA+fcrzebMBnXef+lwh2NyuGzZMvrcr7z5gPOOMA
         BZW8zXCuDXA+TjX9Q/Qm4iKRPl39n5/SU1q5B/Z9uRVMtlzmXK0QZjn4GeI05AamiQS0
         Il/A==
X-Gm-Message-State: AJIora+1F74M9+WwARUtEf2Zd/S5y4b29FvfICI9zhVCLDsfmWjFblPu
        0Q0SJfQ4Caw1ahQBPchfjZIW6Tn7eI0Dc+G26qL87ku2wYcm
X-Google-Smtp-Source: AGRyM1urrbP6vE+R8yGNoQznJkjyIBCM2GKV7Zhd+I8se5caWMw67cvKcc0cSWgPBT5HcL4UPDWOl8SOWAdNB+FviTOmEX1/SX5Z
MIME-Version: 1.0
X-Received: by 2002:a6b:6911:0:b0:67b:f03b:74c1 with SMTP id
 e17-20020a6b6911000000b0067bf03b74c1mr2699546ioc.58.1658669232183; Sun, 24
 Jul 2022 06:27:12 -0700 (PDT)
Date:   Sun, 24 Jul 2022 06:27:12 -0700
In-Reply-To: <20220724125520.2680-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000625ed505e48d067f@google.com>
Subject: Re: [syzbot] WARNING in p9_client_destroy
From:   syzbot <syzbot+5e28cdb7ebd0f2389ca4@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

./include/net/9p/client.h:128:13: error: duplicate member 'reqs'
net/9p/client.c:288:19: error: passing argument 1 of 'idr_alloc' from incompatible pointer type [-Werror=incompatible-pointer-types]
net/9p/client.c:291:19: error: passing argument 1 of 'idr_alloc' from incompatible pointer type [-Werror=incompatible-pointer-types]
net/9p/client.c:336:17: error: passing argument 1 of 'idr_find' from incompatible pointer type [-Werror=incompatible-pointer-types]
net/9p/client.c:370:13: error: passing argument 1 of 'idr_remove' from incompatible pointer type [-Werror=incompatible-pointer-types]
net/9p/client.c:407:21: error: passing argument 1 of 'idr_get_next' from incompatible pointer type [-Werror=incompatible-pointer-types]
net/9p/client.c:1024:11: error: passing argument 1 of 'idr_init' from incompatible pointer type [-Werror=incompatible-pointer-types]


Tested on:

commit:         cb71b93c Add linux-next specific files for 20220628
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
dashboard link: https://syzkaller.appspot.com/bug?extid=5e28cdb7ebd0f2389ca4
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10707be6080000

