Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F8350F02E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 07:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237795AbiDZF2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 01:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbiDZF2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 01:28:18 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74105FE2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 22:25:08 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id k2-20020a0566022a4200b00654c0f121a9so12995554iov.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 22:25:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=tgsKMbOiC15FFfOgbeMnUZPqv7EQvB7ObCUGCkrvd6U=;
        b=nQmIE5PwSL3GOgQ41IVBCVp7uLprd7LSosiJkksG3ETGMzzGfzEY6C+eR11/uWaixy
         gyRgjaHIk0lAxKiXGNDHPz9/NAKe//8xbcVTTWnrNRUxT2Eio86thf0BAySL56WQyqki
         kI/MHplHLaHUR5qgfBqL/UEPM3KoPaPn4tcA/+mq4xkUk1WNn8NJzZgtEyE4UVQD+vxc
         7d4aWjp1eu4Ki+b5aTv0JG+kfDrv4ZpZ1brbryeGkx6QpQA7YkyCeUYT5ixPAIt+OVUH
         WnarUwY+C4nY3AhuCdDIzqFqdO0g074ejPrXU9D/dbAcLx+jjF6vbopqQWpmBiNPwGzH
         uBhw==
X-Gm-Message-State: AOAM533kZf03C3bkVOigT5JOu7l8bnc3wGp0uoLEVym4qFPvephUtPVy
        c1LLczKNNCVKC14At4gjQIJFFioVZrK1oQN+pV7FOKdALZkM
X-Google-Smtp-Source: ABdhPJwdFXTufHSVHOix19svb6S9paLA20EomGHktnbLr5uRxImD/RxWppNpcwfVQW0pTxr+Rl2qHZjB4L8sMtugsx2Cs6BszAmb
MIME-Version: 1.0
X-Received: by 2002:a92:ca4f:0:b0:2cc:4571:3cd3 with SMTP id
 q15-20020a92ca4f000000b002cc45713cd3mr8374154ilo.110.1650950707853; Mon, 25
 Apr 2022 22:25:07 -0700 (PDT)
Date:   Mon, 25 Apr 2022 22:25:07 -0700
In-Reply-To: <20220426050846.3267-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007bc02105dd87eab5@google.com>
Subject: Re: [syzbot] WARNING: suspicious RCU usage in hsr_node_get_first
From:   syzbot <syzbot+d4de7030f60c07837e60@syzkaller.appspotmail.com>
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

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d4de7030f60c07837e60@syzkaller.appspotmail.com

Tested on:

commit:         22da5264 Merge tag '5.18-rc3-ksmbd-fixes' of git://git..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
kernel config:  https://syzkaller.appspot.com/x/.config?x=71bf5c8488a4e33a
dashboard link: https://syzkaller.appspot.com/bug?extid=d4de7030f60c07837e60
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1789a8fcf00000

Note: testing is done by a robot and is best-effort only.
