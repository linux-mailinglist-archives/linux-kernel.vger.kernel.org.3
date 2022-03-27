Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60AC4E8751
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 12:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbiC0LA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 07:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiC0LA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 07:00:56 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF89B26560
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 03:59:16 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id h10-20020a05660224ca00b0064c77aa4477so75454ioe.17
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 03:59:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=JHGXyOygk/7q4MtXArnUOUFIWvMGw5cJdsungG4an+I=;
        b=1JEncpwfPqNUApqbM+MlIQA3/IlZuEgQtIj+mcOYPfRvNhGIDJVNEArgjbR+9ywH20
         zLul3+N0Daum/NLkHSr8f336e5zYUuJURy78UdHL2RbJz+xStDiRuLePvFURtTy+xgh7
         K2uzQzzv5WQzx8feGQWBDuhqRFxPMANwxTmHXmhZ2J6EVmZEdbeQO1xYpjUO2vJReo6v
         wr8xQ92tgKXvPsxNZ5Bi4ISGKn5mPZ56C657OevF6WVQU7bRVwTRpfPTsyoaSntQixAH
         bB2QXjWm1vvP06/xZ5KYtozx6Q8c8LM+vNTTqkHvwXhj8oZEOKYZ5N6fqDOlhaabWIW0
         FfDQ==
X-Gm-Message-State: AOAM532SWFqgs2DD1WX+Ad0Mvjigi9F4VCnyntCtUHlBqtXaSyhkeB9k
        FABbYRKrAirnU8BJq20w3z64autpKkeOJp+xBuJK0rhpVqpm
X-Google-Smtp-Source: ABdhPJxh5lnmgI4/Hz0Yc7PjlUITBlstrgP8S6r2VwMjfC8Zx9NPBMLARVUzwMwHE6lqUQbGhWr8KNIVXXrH9Cxw+E+eQTzU6XcD
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1caa:b0:2c8:811f:56ba with SMTP id
 x10-20020a056e021caa00b002c8811f56bamr3202440ill.90.1648378756053; Sun, 27
 Mar 2022 03:59:16 -0700 (PDT)
Date:   Sun, 27 Mar 2022 03:59:16 -0700
In-Reply-To: <20220327092631.4171-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000035bee505db3116b7@google.com>
Subject: Re: [syzbot] INFO: rcu detected stall in __hrtimer_run_queues
From:   syzbot <syzbot+de9526ade17c659d8336@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
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

Reported-and-tested-by: syzbot+de9526ade17c659d8336@syzkaller.appspotmail.com

Tested on:

commit:         f0228146 Merge tag 'trace-v5.18-1' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=abe260d3ec31020f
dashboard link: https://syzkaller.appspot.com/bug?extid=de9526ade17c659d8336
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
