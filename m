Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4194DE162
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 19:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240237AbiCRSxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 14:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiCRSx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 14:53:28 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31C2304AEB
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 11:52:07 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id m17-20020a923f11000000b002c10e8f4c44so5303862ila.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 11:52:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=/4mPg3CJhiYczFxDFNRkAaBcypBHoPLTRaLTCzvtw/I=;
        b=HLcXK9zp4lAdzIx7GoJrVspbNWRRBukkCJC618R1jMJSwlmWPQJTlhT6HzRjcOTzND
         0kHiovbnyrT2Aa6MaScXDSOq5XCwPEFfsys/ib8VbsnvY1cXB5L09B9QPelKLyZ+kqhJ
         Nbe4a6ow95Qy9aEH4qqyD4EP6TrtsfbYdR7U4dQaXTGHx4BNtfrtmDMshn6rgDpJKmL3
         b1trAiK5kc3BdWZvelZRI+f6eyNpNMx8PuF4wADn6j/G2qD9eMkiJcNZrG96q6qS+ZB0
         +C+ZhTfe2TXXL3Mk4H5PYPcWVOSzd0E2TCUj4wyqBQZCegRwnKdQaGrVfyE6aUvtKi2O
         T7LQ==
X-Gm-Message-State: AOAM530mYWw3RS9ZJDDuKc0tLyao8qQLmgngHkcuCAKeJ+fKnvjvgjlF
        oOErhbC9DQeY07W4jwMWgTNHkm1FXHWMhnt5ribEMHcmOgct
X-Google-Smtp-Source: ABdhPJzU9Nigo5iCFfFbdXki7fcEbns1SuethIp2/0qBuen2s1zpDHhbiRu8WCIp2/WUkX0sFNX0ri5+1Qx8xXz5axsuhcCuyK+7
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1746:b0:2c7:f247:b378 with SMTP id
 y6-20020a056e02174600b002c7f247b378mr3302331ill.298.1647629527149; Fri, 18
 Mar 2022 11:52:07 -0700 (PDT)
Date:   Fri, 18 Mar 2022 11:52:07 -0700
In-Reply-To: <YjTJRQb9eMXdsHOE@debian>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aff2c805da82a426@google.com>
Subject: Re: [syzbot] WARNING: kobject bug in erofs_unregister_sysfs
From:   syzbot <syzbot+f05ba4652c0471416eaf@syzkaller.appspotmail.com>
To:     chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        xiang@kernel.org
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

Reported-and-tested-by: syzbot+f05ba4652c0471416eaf@syzkaller.appspotmail.com

Tested on:

commit:         a1108dcd erofs: rename ctime to mtime
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev
kernel config:  https://syzkaller.appspot.com/x/.config?x=442f8ac61e60a75e
dashboard link: https://syzkaller.appspot.com/bug?extid=f05ba4652c0471416eaf
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
