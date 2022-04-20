Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35DB1507DC0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 02:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241613AbiDTAt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 20:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235020AbiDTAtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 20:49:55 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3218A20F76
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 17:47:11 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id ay41-20020a5d9da9000000b00653e75506b8so204713iob.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 17:47:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=itiZKxg/sm35zMamOv3v2DNVdOgk5OTxIJt0tf+BnPo=;
        b=PrKu0XGPLM3qIxfmg5n8nhZZIuFkJBcy0WT2hL91P1hBcz9I2WIodXF3mOjjJeqz3V
         Otu1XfyrJqgZh9fy3ombqzk/539WoP0dP4vzQWWaNXL5PKofy6xwoBZR+D31fz1pcFM1
         mFjK+SWp6jpE0zjs8OygpYOmZSbcBNMBh64q3tFHxwKf08y8i7UDPByTpIIaMXeZtAqQ
         EUnL309/snaP55wh2Um66SZhgqXzO9Ua+HTzSjS1GSnGS5V5gd045/tt+CnbJ/uCjisG
         wj1r+WU6dqveXIx/FcoIb0i5ueaD5dQaRObS4spguoZxVdau8E2TQSznZNUyOoAkNufh
         isTg==
X-Gm-Message-State: AOAM530rdIuvKUjKuvb9HaP9GDfXop+W9kGfgr9v8Y7fk7XJyMjTe6SP
        kpPSM8y2/EPsJWspH2jxW2G3sl6D9ZuwDlLYOOr+BRb2yWJn
X-Google-Smtp-Source: ABdhPJzvi/Gv315g78j+Ewo11j2Ob9tECSFV/H2W8teoBhxQEd5+dQ28+ImUx/K/2fhhuBA6BlYySCt7vc9P/kYTcleKlU3E02x5
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c46:b0:653:879e:4490 with SMTP id
 x6-20020a0566022c4600b00653879e4490mr7793256iov.130.1650415630559; Tue, 19
 Apr 2022 17:47:10 -0700 (PDT)
Date:   Tue, 19 Apr 2022 17:47:10 -0700
In-Reply-To: <20220420002839.2160-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000642ea805dd0b554d@google.com>
Subject: Re: [syzbot] INFO: rcu detected stall in sys_setxattr (2)
From:   syzbot <syzbot+10a16d1c43580983f6a2@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+10a16d1c43580983f6a2@syzkaller.appspotmail.com

Tested on:

commit:         b2d229d4 Linux 5.18-rc3
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
kernel config:  https://syzkaller.appspot.com/x/.config?x=34d641b059469a42
dashboard link: https://syzkaller.appspot.com/bug?extid=10a16d1c43580983f6a2
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14302ff0f00000

Note: testing is done by a robot and is best-effort only.
