Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2D3596D95
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 13:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiHQLgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 07:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiHQLgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 07:36:09 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F73B5F135
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 04:36:09 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id o9-20020a056e0214c900b002dc29c288bfso8858850ilk.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 04:36:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=jmnwb+YPCDrZ2zilqeE/MgjVc7NfQNGZEFAWn2JRNus=;
        b=7jsP/NQAd0XbMAEN+nUNF80ZqVZB4f1B2tnLp5h3ZdHc2wce8U5aC2tYZnOLJmck+f
         3/F4YjLpl0HP3hISht5H/PM69pPGLgMrX/MohdGQn0uWUeG8UQlAdFukSp6REflOhQiy
         lH4WwiYD1oH89LcJKLlpj9nbu9jbJjqE59LiykLkvKmrC0NzzLVzlqrw8jhGBOKPVZJO
         P6xDl9Gg461+NYTdMGiVWKV0FC3pHMd2gJluUFdbdpOfqTUwxWlNmTde2FtZXCArB+JB
         4Aw1sn0fDJ/gztx4T47XhUX6pIU4FVwE0a65dP9cDKhYv+nKNffDN8NhwhtRGSTfbg6k
         qZyQ==
X-Gm-Message-State: ACgBeo215171JxxEz0eHNysRqzMpS/n2NG+lnrAOfdgnQqgRwVqhcExs
        XPYtIAbmTnjkHIgRbGAQF0kX8zSMZboqDCd1MUGPd+WuRYa+
X-Google-Smtp-Source: AA6agR63IZULemH8A8apm/mofE6Lbt5ZAxDoadTOxnM/+sma2227P4dKCVfv35OLjA4+VmA4rSGGZNPKzZL/e0Htk+v4NJ9DSnv2
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b83:b0:2e5:b254:69e5 with SMTP id
 h3-20020a056e021b8300b002e5b25469e5mr6981417ili.292.1660736168598; Wed, 17
 Aug 2022 04:36:08 -0700 (PDT)
Date:   Wed, 17 Aug 2022 04:36:08 -0700
In-Reply-To: <20220817110315.1095-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000065234105e66e4531@google.com>
Subject: Re: [syzbot] general protection fault in hci_uart_tty_ioctl
From:   syzbot <syzbot+c19afa60d78984711078@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+c19afa60d78984711078@syzkaller.appspotmail.com

Tested on:

commit:         7ebfc85e Merge tag 'net-6.0-rc1' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12c9b867080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=924833c12349a8c0
dashboard link: https://syzkaller.appspot.com/bug?extid=c19afa60d78984711078
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10a6c1f3080000

Note: testing is done by a robot and is best-effort only.
