Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A52958E0E7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 22:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344361AbiHIUSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 16:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238960AbiHIUSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 16:18:15 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D032210AD
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 13:18:14 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id l20-20020a056e02067400b002dfa7256498so7904993ilt.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 13:18:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=0fQ5cLj/V6ojyehMRs1rc+JPv7f1RQRm1S9oltmm0a4=;
        b=CAnkWdriUQWlWfX9qmP+INrMh8XfYGaq2QttS7iq8nkXNjz0CIY/gA8MAIF37H8Ph8
         4A/h4q3Mf8JUo27pODuLuPsqm1GHNfR8LBctK+8MHl8fm/hau7uU5PVSNgF6bnBxQoKQ
         pVyXWBGZN1sdm2zpdLpNyon/aqaE78lJ/YgJVrik61pGQ/kJGDrm6BDacfqphQuhGhxt
         lNQWnmfxjkGxPhKw4W4nlHlg5dz9hTwa8MnZrU8ljstECjWFcit9qPDcm1H/ulaDtihZ
         2nsEttdLT5fXGaHF6CibhAnuHw9Rlvk++x4Bl729xO+0QP+LUUdKWo3zYhHomW6okQFe
         f82g==
X-Gm-Message-State: ACgBeo246g1t/ZnHjkEyWv1NFiBhOP8SSHAIql9mB5zdHNtREDQDJxd6
        hf59xluLgreeN9seOgjP2BVSsh1RsZPuXgQORgpzwDWpK7qJ
X-Google-Smtp-Source: AA6agR62RGyMeHvC6gMSoR3J/v57szWupOSRpNDYJof1ZyT8NbMB/Kzje6X/eiJ41/zvYhEecfbNs+mauqOzF3KomawcMSRkSFw4
MIME-Version: 1.0
X-Received: by 2002:a6b:2a46:0:b0:684:5fc3:5f21 with SMTP id
 q67-20020a6b2a46000000b006845fc35f21mr6858821ioq.154.1660076294218; Tue, 09
 Aug 2022 13:18:14 -0700 (PDT)
Date:   Tue, 09 Aug 2022 13:18:14 -0700
In-Reply-To: <20220809112941.2449-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d12aa605e5d4a1e1@google.com>
Subject: Re: [syzbot] WARNING in hrtimer_init
From:   syzbot <syzbot+fd406bb2745861bd67e8@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+fd406bb2745861bd67e8@syzkaller.appspotmail.com

Tested on:

commit:         200e340f Merge tag 'pull-work.dcache' of git://git.ker..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=149a1d9e080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b664fba5e66c4bf
dashboard link: https://syzkaller.appspot.com/bug?extid=fd406bb2745861bd67e8
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=146fe4c6080000

Note: testing is done by a robot and is best-effort only.
