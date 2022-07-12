Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55918571C50
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbiGLOXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiGLOXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:23:10 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FE457260
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:23:09 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id s3-20020a5eaa03000000b0067b8e40a536so2919886ioe.17
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:23:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=09dRBx96IZbwQPCZA7lE8SyIExCEKrqd7v5GHQxLxoo=;
        b=oVFTB1d+CxSkV07ijlJFjreBJmLqwLoYsCWzi9twJBb3Vb3wFOg+ko/DfwaeDmn6e5
         U/Y3ulU7i5yG+aqI5AJnQFpv1IJAhr9VqBQVqBt59DP5Qrm1ZaEMEEqsuvaXaonFwQLe
         jDuyy5qGCzojR/tg2u6gq+QmqNS2qtEhQD7GN39HNx4vJBjPjfqpr/cDa82LdMGGkEJ/
         C6a1cDWRqqHxEsmrMzYTqddf5NgJFv2UurR13sE9c93Jr51c/GlCERAPJ70ZXokbBGLG
         SfeD0Uc2pZqATWc9W+twmUcEu2f7vFOPFbjlsPfFoj6EpOImHN7Pok8kCFXn/nCy0k6D
         fpmw==
X-Gm-Message-State: AJIora/SfEK5B6WxtBPOQsDNX9I9FvnDMONagY+wu4+YQNzB6TKVYGvn
        SHy+at9c9BGenkHpGnKfds14FdlKjcOmYOjNxycwfG5rKT8v
X-Google-Smtp-Source: AGRyM1ssjn5o8vsqT9xXSMiK9O6FEVEbYvg+hB44LPkdEuBGAB9ZymPkruZNPcO3m/BzDL4DEFY2CdlHelfHwAu9qXf0o3IKbCgL
MIME-Version: 1.0
X-Received: by 2002:a02:1981:0:b0:33f:82f:cc41 with SMTP id
 b123-20020a021981000000b0033f082fcc41mr12489416jab.44.1657635789318; Tue, 12
 Jul 2022 07:23:09 -0700 (PDT)
Date:   Tue, 12 Jul 2022 07:23:09 -0700
In-Reply-To: <20220712105156.2701-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000063ad9a05e39c68b6@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in kill_fasync
From:   syzbot <syzbot+382c8824777dca2812fe@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+382c8824777dca2812fe@syzkaller.appspotmail.com

Tested on:

commit:         cb71b93c Add linux-next specific files for 20220628
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1573452c080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=695e91d821f66ab5
dashboard link: https://syzkaller.appspot.com/bug?extid=382c8824777dca2812fe
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11bdab34080000

Note: testing is done by a robot and is best-effort only.
