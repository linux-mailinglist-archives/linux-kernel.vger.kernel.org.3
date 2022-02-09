Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8CED4AEB8D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 08:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbiBIHzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 02:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbiBIHzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 02:55:09 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B52C0613CA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 23:55:13 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id n13-20020a056602340d00b006361f2312deso1254543ioz.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 23:55:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=UtEHDx2/SDtUWhjFiOkqioSqjTgEfgWZaCkVNfs3Q+A=;
        b=JvrGdVPA0YYt3K+BNTIYURUf8ZBIHWGnzBjRG0LXnO6U4XSoO3WRsL0v9ZAO4BhJxx
         ojfhzn4hw/nioa8sPmAuaXoK5RJz8vwBjWrB+ppwTv2WLjug43zj5EWr7tQXy1WMhM7a
         f/SztByPxEntYKfbTjoAAEqGXyBkqC0Yo0eMg+hk7LW7cxJFougOIij9hMpcRZxX5RUG
         U0vlSYyMlmdn1b5OMm4X0IKtnJ6CIEQiVAGwva2M6TfmCp6/w9qofyGWwZ4cmxQ0TgmS
         nB0u2rArFORSSZJ0LlYl5Utwkkpdua2MpkC7qQoOHgI2BRFOWjjxEQdZf8cPVjmU2GX9
         MJdg==
X-Gm-Message-State: AOAM531VuK13inC0UKSBoYjLqn+m0yAjpNvG5D0D+0oNS0dl6scFRU3T
        eLOTh2KdLGfnSdqBfPMZfUuJdg0nYaDQglVms6i69x/9+Vfe
X-Google-Smtp-Source: ABdhPJxTiND/YMKyiFm0ggyZBFIDxDVQgbKIe1A0qrUTf80Goj1N/PGkmq+Kz1wBKQu3w76vPZ0n7I1tPyBPOGq6MC80jWI0Lvfz
MIME-Version: 1.0
X-Received: by 2002:a92:3f0f:: with SMTP id m15mr520244ila.112.1644393313139;
 Tue, 08 Feb 2022 23:55:13 -0800 (PST)
Date:   Tue, 08 Feb 2022 23:55:13 -0800
In-Reply-To: <20220209074137.linx5qyi43hkclss@riteshh-domain>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004d049f05d7912725@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in jbd2_journal_wait_updates
From:   syzbot <syzbot+afa2ca5171d93e44b348@syzkaller.appspotmail.com>
To:     jack@suse.com, jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, riteshh@linux.ibm.com,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
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

Reported-and-tested-by: syzbot+afa2ca5171d93e44b348@syzkaller.appspotmail.com

Tested on:

commit:         54ccc072 jbd2: Remove CONFIG_JBD2_DEBUG to update t_ma..
git tree:       https://github.com/riteshharjani/linux.git jbd2-kill-t-handle-lock-t2
kernel config:  https://syzkaller.appspot.com/x/.config?x=266de9da75c71a45
dashboard link: https://syzkaller.appspot.com/bug?extid=afa2ca5171d93e44b348
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: testing is done by a robot and is best-effort only.
