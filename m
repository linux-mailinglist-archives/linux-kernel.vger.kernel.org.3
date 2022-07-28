Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56DA158378D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 05:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbiG1DeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 23:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbiG1DeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 23:34:15 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8848D5A3D1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 20:34:14 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id z1-20020a6b6501000000b0067c6495c03dso186776iob.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 20:34:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=MNz55KaaGxLrlaqs1U3qM+7ivKwtanb88ZyuIDPI5Mo=;
        b=fJOblq6jW4330MDeCZeBI90Egfzys86BaagXuzP6udGoYICi53kX+MDRUzm9rqzjT1
         072qzx7Pz7xg0/hgIjihVqbN3Abp7oONu8W0/p1XkvhM5XUOJTKqEBv8fD81xcp1r7Dc
         NxNioNj/D2L9AwMKIsz6wMpiBBT1W+JdWNN7ekfgXQide9h6tNDwXzFDX25vBWUjcM2/
         Gwerfej8dcblyc1SCHFQyR58Xw+49Mx5ew/J6HVVWBMdBCEN2z5zRl468/PWW7IOFQU9
         QZRYIT7uOFso9q0Blh7gSXhPN+IP8fR1gAmR6cQ+JwO5OshHIMzw+LpZ7L5PUKY10sQB
         SROg==
X-Gm-Message-State: AJIora+nSafguUf7u5PSAaWyArOXl+QSWxrNVRUrIX2d+/ftR4STL9ct
        1jfOOXrpCWhA9Vko8yHA3+GgIW09n/2TiPpvsWeq56V2v0ry
X-Google-Smtp-Source: AGRyM1u7ngBipM/bsbjwlGBGsx6Kdyeri/FeEmxIk8pNogVIQ9MyEKu/P4gFHS8RL0AVTUoUFPBIfFOM/UNx1GeFevZ0dmdMj1Ta
MIME-Version: 1.0
X-Received: by 2002:a05:6602:168d:b0:67c:44c3:9ba5 with SMTP id
 s13-20020a056602168d00b0067c44c39ba5mr8952708iow.190.1658979253272; Wed, 27
 Jul 2022 20:34:13 -0700 (PDT)
Date:   Wed, 27 Jul 2022 20:34:13 -0700
In-Reply-To: <20220728031520.554-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000014c7ad05e4d535fc@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in __post_watch_notification
From:   syzbot <syzbot+03d7b43290037d1f87ca@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+03d7b43290037d1f87ca@syzkaller.appspotmail.com

Tested on:

commit:         e0dccc3b Linux 5.19-rc8
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=145fb2c2080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cfd2f9ae77f1f719
dashboard link: https://syzkaller.appspot.com/bug?extid=03d7b43290037d1f87ca
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=124486de080000

Note: testing is done by a robot and is best-effort only.
