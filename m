Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A713253C8DE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 12:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243815AbiFCKlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 06:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiFCKlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 06:41:09 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FCF3BBFB
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 03:41:09 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id j5-20020a922005000000b002d1c2659644so5495684ile.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 03:41:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=iiL2DpVjWYYskDbf949NfLbw3PKJhXR4nhN3vqxyn2Y=;
        b=jHjlunyDeQ5e+KGmG+pSsxyW4QCnqb8zUzeFy0SL1F3asKzESwEcFIClikmN0L1co2
         AFqscJ/2jUWL7rp8C7GFVuZfuquT9x392ywYD51MqtIN6CW/8W9bV+nHSOhFkdqgdLFA
         WgsH5NuX1OsDbEqn2890TsK5D4OS1Uumq7vT57qRWJmdjpnG4Cmkp3+6VMoyZ3XMckvi
         vwCljiAZypWwbVSWW1Lf50YWYxRF2sx3BM1KlO0OpXWBuV/IK5qSNjYJhXS3H8zA+cbt
         yFITu7Y347f1JtWw51E1g7UqYLIT3SXc8O7mcozQpn75Fsix7vRnlquvPfMl3UGF2647
         yNkg==
X-Gm-Message-State: AOAM5330zIolDzCp/ZhVAseb0VB9z6IEt3IW9hHDOvqxoKhISmIY4M7q
        Ykeaw3bKN0r6o6uMwxryi7g4onpU4p1jEKY7MNBT4bQHe1HF
X-Google-Smtp-Source: ABdhPJy53MzWla3EMoNfbty6SufVuCzUnMa+Tb2Pkwo5O8uY30T+KSbBS//eyKAr+gSjZYV4/NQ0HX6PnF+k8oOMesE9igkEjXJ4
MIME-Version: 1.0
X-Received: by 2002:a05:6638:240e:b0:32e:d495:e439 with SMTP id
 z14-20020a056638240e00b0032ed495e439mr5486146jat.59.1654252868912; Fri, 03
 Jun 2022 03:41:08 -0700 (PDT)
Date:   Fri, 03 Jun 2022 03:41:08 -0700
In-Reply-To: <20220603074439.5255-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009ecba705e088c2ee@google.com>
Subject: Re: [syzbot] general protection fault in __device_attach
From:   syzbot <syzbot+dd3c97de244683533381@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+dd3c97de244683533381@syzkaller.appspotmail.com

Tested on:

commit:         d1dc8776 assoc_array: Fix BUG_ON during garbage collect
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=c51cd24814bb5665
dashboard link: https://syzkaller.appspot.com/bug?extid=dd3c97de244683533381
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1244e933f00000

Note: testing is done by a robot and is best-effort only.
