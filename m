Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E555858B0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 07:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbiG3FLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 01:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiG3FLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 01:11:09 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E6B4B0CE
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 22:11:09 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id d12-20020a056e02214c00b002dd143bee38so3847712ilv.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 22:11:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=5HpK76YVB+zmO7doqKwpnhkQmOVXp2DRm0ubO49YkKw=;
        b=a9Pcf6rZdOV26flBl6Xdc32EL2TTuXoU6Hd4+vJXReqCQvruiAWPEdlDcimZxED4rS
         M5XdlYpghQkKygyYeJDazsCr2hZWBpWy8lP0Cg2RsP0nLBZX7oyoM3ZVojsLeCRIODHs
         ZIo/mMFbwBGeS9/te+HXpx3s0oYK0vwtCMSFvceYoqd5glRx+AR1uQlDEqiSbUUPzTxr
         hwdeiVYHdLN7FglFKqRGWDHDqXzaxmDK1R6Wj6HrSHltUWCrGoVBa4smtFOSjK+Sq3+h
         tOnMJzYZuIxQyFlP7SfMb9+/OrTbHWfBfCCrjjddIhKEcbR17S2AFJuSdxBvGXBr0zxl
         sclw==
X-Gm-Message-State: ACgBeo2ERbO/5lLrzFipLpEGt9LjX83XUodFhoL4SBhJvI5VG9mXyONL
        Om3ICQzwRJg5+fTrLGyFTJr/Dfh+02h1eEPR5MbT1KIT8j4f
X-Google-Smtp-Source: AA6agR6R54Txy7xLBpHZnyfR16sYmDrRAwlYEmsY4epbfmm/3cHqU7aprDitnHgJaFFMEovYH4XRJBlCCn7ZS40QuVgdBQ0JirX9
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:174d:b0:2de:5a82:eaa9 with SMTP id
 y13-20020a056e02174d00b002de5a82eaa9mr247161ill.241.1659157868514; Fri, 29
 Jul 2022 22:11:08 -0700 (PDT)
Date:   Fri, 29 Jul 2022 22:11:08 -0700
In-Reply-To: <20220730013945.1056-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000061158a05e4fecb7d@google.com>
Subject: Re: [syzbot] possible deadlock in throtl_pending_timer_fn
From:   syzbot <syzbot+934ebb67352c8a490bf3@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+934ebb67352c8a490bf3@syzkaller.appspotmail.com

Tested on:

commit:         cb71b93c Add linux-next specific files for 20220628
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=128a6b41080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=badbc1adb2d582eb
dashboard link: https://syzkaller.appspot.com/bug?extid=934ebb67352c8a490bf3
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=147e67aa080000

Note: testing is done by a robot and is best-effort only.
