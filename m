Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390275270D7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 13:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbiENLkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 07:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbiENLkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 07:40:14 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FEF13D50
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 04:40:12 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id q12-20020a0566022f0c00b0065af7776ee7so6623438iow.17
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 04:40:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=tyXZJZh4UYHJVfVmZGxNnSbUIJkAshWJ1F9kA8aW0M0=;
        b=kuEvzFLN68IFGEBhbpShx/QyhSdrtllUECpSPeFLPyYyKZjSl8GcAD0cKpF518Tg+S
         Poz95MIjwanm0ZZ0ksBVra5yVybWRD+hOTh1ed1ITZnmNG5lifdXV0hSy3B4IDFIBkUx
         N+BmA8o1CJL0WMA39tL3HsWUHHrlyAo/WDRw6tTFJ6UKyUP9zYk29v14H59ozVRrxzRd
         EShUs42FBkzRpEY+x7N4sl1FxkZWjo4XpElGrOmGyDS4usqsnRCCvBo0s0LRQ5/sUhik
         xZrBBUQHCf//5OZEboyFbCPYs4zLVyTNGhYJuVpRsLrDQd5biGovf0TbI/7rFeAprJnl
         fKIg==
X-Gm-Message-State: AOAM530b7PF3+c+kSjxOOyItDGcoVxpQ/m1avUyCo0d3k9YTNLQH6MEf
        Bh43kW3Ok10RhK1ulSykAHzTFyoeRwlz/0iwzInAfQnTXy/D
X-Google-Smtp-Source: ABdhPJyepYGIyDxe2jpilOgVOcUFBD7b6zywiZxgwYO34aUKuiBM3UTMklEb/qjVb/rLVKR+2Iquyfr6xyENZOO/CNgmpHtSwv19
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3d2:b0:65d:c151:f29f with SMTP id
 g18-20020a05660203d200b0065dc151f29fmr4231052iov.28.1652528411979; Sat, 14
 May 2022 04:40:11 -0700 (PDT)
Date:   Sat, 14 May 2022 04:40:11 -0700
In-Reply-To: <20220514110016.1193-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fa340405def74011@google.com>
Subject: Re: [syzbot] INFO: task hung in hci_dev_do_open (2)
From:   syzbot <syzbot+e68a3899a8927b14f863@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+e68a3899a8927b14f863@syzkaller.appspotmail.com

Tested on:

commit:         38a288f5 Add linux-next specific files for 20220506
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/
kernel config:  https://syzkaller.appspot.com/x/.config?x=6f4fbf50aa82985b
dashboard link: https://syzkaller.appspot.com/bug?extid=e68a3899a8927b14f863
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10eefe69f00000

Note: testing is done by a robot and is best-effort only.
