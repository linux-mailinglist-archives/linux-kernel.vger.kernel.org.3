Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79AD512AC7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 07:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242845AbiD1FIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 01:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238161AbiD1FI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 01:08:29 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BCB109F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 22:05:14 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id l15-20020a056e0212ef00b002cd8f1a8cffso1166885iln.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 22:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=NELWs5E3d7hrbPccO9GIG4nHqgSZ2xPQFrfhxPBBI5U=;
        b=v4Tcjoto9y7oySQAON5pGsz6773G9gl9ORA7g8Y0z2Iz/BkPf1/A1WjKLqTSyHkIyF
         7/fArtWP+BSDffB0OGKB21VfAiPcwvjWvvRzZpjrNi7UKeRJF/bu/1WihIwKZ17gYg/e
         bxXNJodSjROEQHsptxl1ylIawzWc7Zq9fjAgZKduTxt3LXmFzH1Uo54CQbQclGSSlmrz
         XySrZfA8L7gPxW0N1ZT3Qshjp0SV56m+BRHki8exoUY3TtV/oSHcY20Q0oIRjdfoO0Pt
         07ouR7SQS4JW8qdVz3srGr8bWjJPTATCR2Zgx+kf80LOebf5RQrlesBqtUYt7jQ/dX/U
         /AzQ==
X-Gm-Message-State: AOAM530OM8pJygUO7r7nV6Ln6T1CvTAQmaw22a8rz/UQXJ3pob96bW1c
        F2tTQAjUP3rxCFyf+s+6LHygJMZPkyra60r0+DTKvQSo6LjC
X-Google-Smtp-Source: ABdhPJwutBsiNFEqI0xG69qDeOD5jbbkDATr8/nzlp6Y/yl8JYFyWZWlDNQ7AKh2cGsfMelBkFyR9D2gvmAcOa80/TTAuD0d6ZIw
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1af:b0:32b:26b6:3a47 with SMTP id
 b15-20020a05663801af00b0032b26b63a47mr1993510jaq.233.1651122313718; Wed, 27
 Apr 2022 22:05:13 -0700 (PDT)
Date:   Wed, 27 Apr 2022 22:05:13 -0700
In-Reply-To: <20220427230210.GA6837@lst.de>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fd713505ddafde13@google.com>
Subject: Re: [syzbot] general protection fault in btrfs_stop_all_workers
From:   syzbot <syzbot+a2c720e0f056114ea7c6@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, hch@lst.de, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, wqu@suse.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+a2c720e0f056114ea7c6@syzkaller.appspotmail.com

Tested on:

commit:         ade4dbbb btrfs: don't call destroy_workqueue on NULL w..
git tree:       git://git.infradead.org/users/hch/misc.git btrfs-workqueue-fix
kernel config:  https://syzkaller.appspot.com/x/.config?x=17dad21e0facb5e6
dashboard link: https://syzkaller.appspot.com/bug?extid=a2c720e0f056114ea7c6
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
