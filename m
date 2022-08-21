Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C3F59B352
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 13:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiHULbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 07:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiHULbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 07:31:15 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015CF2654D
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 04:31:15 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id q10-20020a056e020c2a00b002dedb497c7fso6537819ilg.16
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 04:31:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=K0dtPPveIUhljS+m02PNzwfOPhGk9uEu12ddowdN54E=;
        b=c+pq1ZHrJgC/j/hIpgEaqBUVcvvGty/efZ3yq2UTC96G96A+rBkqVc6q8JVcQmCDI4
         DXBQqzok7rgcC2Zvvh3piwKvx78Y3i360czRx/t7tZL0G07Hc0mrpx4IEompDLPwMeCi
         tCxh6IpP2+xPSBI2CGLKB8zKE9uQepTvjpxk2SUbXxVKQ2AQo+UCHqZUel6+bj3SdmoL
         qH0bEq4nbTgrQqkvptw+Gp1CKej3UyEzp1UQJkVTcc85vzg4WQcI5C972g0Ogt7RgSVQ
         XDZ/rAiZfpXMn2H8zRBmFgSkQEb6iPONEVHghs6SC+SUUNbj4gfJjA2OV2SSCJ5TEER9
         8Ung==
X-Gm-Message-State: ACgBeo30nn+RZMRlGP1lEFxn/IGKmlo12HLxyVepGs41pBbczMlXyQWZ
        FqFMOgaaUdJdl6ZW/zY0VmttW5xw3o1/Tl9CqZRDdxunzbWZ
X-Google-Smtp-Source: AA6agR64ifgzArmCmqG7R+Hj3GrLzf5B030PXh+D1owlOIUf8TVPsvUWr8erSJzprfuAHNARgqhKAawKvI+iQ06DJKngKyJvcAe1
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1487:b0:2df:193b:3b77 with SMTP id
 n7-20020a056e02148700b002df193b3b77mr7661161ilk.304.1661081474401; Sun, 21
 Aug 2022 04:31:14 -0700 (PDT)
Date:   Sun, 21 Aug 2022 04:31:14 -0700
In-Reply-To: <20220821104952.1932-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000398ec005e6beabdf@google.com>
Subject: Re: [syzbot] possible deadlock in rds_tcp_reset_callbacks
From:   syzbot <syzbot+78c55c7bc6f66e53dce2@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+78c55c7bc6f66e53dce2@syzkaller.appspotmail.com

Tested on:

commit:         8755ae45 Add linux-next specific files for 20220819
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10ebe2d3080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ead6107a3bbe3c62
dashboard link: https://syzkaller.appspot.com/bug?extid=78c55c7bc6f66e53dce2
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12b61785080000

Note: testing is done by a robot and is best-effort only.
