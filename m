Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E88854AF13
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 13:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356181AbiFNLJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 07:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242215AbiFNLJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 07:09:15 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB396477
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 04:09:14 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id g8-20020a92cda8000000b002d15f63967eso6330706ild.21
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 04:09:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=TBHkuaKBYnos9tQCfAk/b3JzDTJF6ct74HVIaUNxla4=;
        b=2PzN4w0jP75ptrLUj6bp7Snfx/xAN3361tgGS1eMAZpYvF/oZDVYN8Ro7CL5mk5eyI
         O0X+Aj0dWEuWUMhoyjTaXSJuxyxIkJsMyrTcladxTL4IYr2lGjhG6xIp3vqBxf9BtKEA
         szGDN3CJUFsSICKvVMsFTspwZB2ett6QpiW2PB8bwI4XKE5oeEKp9abGaU/333c4X6OL
         tA1ZxNmEryPhMolqDD6IyXkbai4VO+IR89GeuKCu2MPPgAFiMhCNkSS6vYTg7D7Wst7K
         gN8EE5F/AG0LNDHnFT7lypDH4Y4qegFDhTUYOBNr9kebHzkTmVtpiOyvQCQf7li2VArv
         L8Mw==
X-Gm-Message-State: AOAM5334I6Bg+Ovyn3RjrQgq/lmOCXVT/fbcHJKYKNINceJwUzGPXPm4
        VU20q2qGqbaJLnYipWOkvposDJGHB0DgWuZWOIi8g+HgRhMB
X-Google-Smtp-Source: ABdhPJxV827ndBOAbT2AnKtw11TOeQZ+nVDVcvel0gp2zsyH1vIGHzR0u266q3wPZaZpQGy0UKuyp8x7Kmx28St6GhKfkbSLchek
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1313:b0:331:f465:3a with SMTP id
 r19-20020a056638131300b00331f465003amr2370367jad.59.1655204953556; Tue, 14
 Jun 2022 04:09:13 -0700 (PDT)
Date:   Tue, 14 Jun 2022 04:09:13 -0700
In-Reply-To: <20220614105010.1897-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000498dfb05e1666f2f@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in __vma_adjust
From:   syzbot <syzbot+68771c0e74f7bb7804e5@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+68771c0e74f7bb7804e5@syzkaller.appspotmail.com

Tested on:

commit:         6d0c8068 Add linux-next specific files for 20220610
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=113754dff00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a30d6e3e814e5931
dashboard link: https://syzkaller.appspot.com/bug?extid=68771c0e74f7bb7804e5
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11e906dff00000

Note: testing is done by a robot and is best-effort only.
