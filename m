Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F9B4DEA1E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 19:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243921AbiCSSdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 14:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243914AbiCSSd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 14:33:29 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F7F2986E5
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 11:32:07 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id w28-20020a05660205dc00b00645d3cdb0f7so7401233iox.10
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 11:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=IZtuSSe7h4ygjSJ8KqApgw4dc4sgkX0YCgrh7z/0rTY=;
        b=2TvJk7jg3sEDkk9gjibTuDm8WR+50rqMHEzyTkmSmZHr88xfqslrplIxGCJJZhvQMS
         2fD8tb4/4rL0o+WbAYhvzRkNsg1zuDrMVPeonoQLNPTqi+ucqo3KHBa5RLRi47Vksihd
         TS1lVPW26TH1oW04Z3KeCZfyKkfSvd1cVrDwjQnYNgHZR1xA9lCWlLfTklJBcnBJ2PnZ
         6bt7B4EHhJVOt5PXaNZQ5FSLbOEJHOHaSf3TumUR74e5NmVZjbMPkmCXd+9bEFZdeKEL
         ZFMtdUzuILGdhdDkXrGsWY4r1vFFaH4vSgpmsLtWvQ6GbAjVEmT40o/EAcf7aAim/SaI
         85QA==
X-Gm-Message-State: AOAM53315IHc/d3xEqWjWUCfJKZjpjn93ilyzsRH8uMObhEqssTH6APS
        xdqvQdUdAwGOlfvTW/G7iUhW+PK31JyYJ6RNTfGZFfBOjGwQ
X-Google-Smtp-Source: ABdhPJz+S/WggbwwTQF2cGT56obUcB+F64Vr0b60Mm58ZevgA41kJhUpY+YFb6eHnCWtztmTdjo8L5wOPZ8aKhUCSJusjifjz6bK
MIME-Version: 1.0
X-Received: by 2002:a05:6638:490f:b0:317:d121:a93a with SMTP id
 cx15-20020a056638490f00b00317d121a93amr6918348jab.35.1647714727210; Sat, 19
 Mar 2022 11:32:07 -0700 (PDT)
Date:   Sat, 19 Mar 2022 11:32:07 -0700
In-Reply-To: <57fc3806-86c6-b1b2-4c44-083b1b7afc8b@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000001b61605da967bae@google.com>
Subject: Re: [syzbot] divide error in dbNextAG
From:   syzbot <syzbot+46f5c25af73eb8330eb6@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        paskripkin@gmail.com, shaggy@kernel.org,
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

Reported-and-tested-by: syzbot+46f5c25af73eb8330eb6@syzkaller.appspotmail.com

Tested on:

commit:         34e047aa Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=70f75a89c7a0e6bc
dashboard link: https://syzkaller.appspot.com/bug?extid=46f5c25af73eb8330eb6
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14c2cd33700000

Note: testing is done by a robot and is best-effort only.
