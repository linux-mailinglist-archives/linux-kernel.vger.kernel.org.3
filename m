Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423C257F2B8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 05:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbiGXC6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 22:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiGXC6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 22:58:14 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B418813F8C
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 19:58:13 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id t3-20020a5d81c3000000b0067bcd25f108so3172308iol.4
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 19:58:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=muOCySf8YxPRJQpwuAf9Z3i6yFH/QGSM5zXTsfkeSa0=;
        b=UNENgm6nQ/5IEADGqzXzHgW77fRETSrixO2Xz2GN5cX4AID21hCrx0iD7jbPpOs4R8
         R8hhbj6tkajKEVCmlHv3iOwLcaUEhqLaydzIrXAHYQb5H13TJ+hYiM4DweDjOs5WvZuR
         WfQYS/OzxMdF9HzedDWTL6E7WOsa2IqK9azFx3N0qvfXFNVDAPTiCGQP4iOnVisZA6sS
         rNEE6RI8QTSoK36Fx+6hxC+lBsROh2azTOViJEB4lsgEO+sztk9ig7fndduu5AOI8lig
         EcCF34JVqHa8+sw4tzMHob/N0Ux3ccKFYm4dkSTBY/S4BxTPAPzXTXJqDIWBsX4DcQcg
         HNBg==
X-Gm-Message-State: AJIora9oBgvl0vXDYWTRVVKfPtV3IZFszc0Wvkgs6SMPUL7JpaPfsb/s
        sF84dRRjshLRJJtZoZ9/PgFxVetwd2XzwapIIhiSOzNSnBtc
X-Google-Smtp-Source: AGRyM1sMVMx0ZChrRCxOictlj+ge6GtfhbQq8JD9YGpo8R2Fn+F6YAVeOq6o0a+7eujbHlfchj5ALCc1Zw6IOQw5V4A/RqFXN+pG
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4394:b0:33f:3e15:ef88 with SMTP id
 bo20-20020a056638439400b0033f3e15ef88mr2693173jab.248.1658631493091; Sat, 23
 Jul 2022 19:58:13 -0700 (PDT)
Date:   Sat, 23 Jul 2022 19:58:13 -0700
In-Reply-To: <20220724003356.2425-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f587d605e4843cbc@google.com>
Subject: Re: [syzbot] INFO: task hung in __input_unregister_device (4)
From:   syzbot <syzbot+deb6abc36aad4008f407@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+deb6abc36aad4008f407@syzkaller.appspotmail.com

Tested on:

commit:         a175eca0 Merge tag 'drm-fixes-2022-07-01' of git://ano..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=140f65aa080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=833001d0819ddbc9
dashboard link: https://syzkaller.appspot.com/bug?extid=deb6abc36aad4008f407
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13115bd6080000

Note: testing is done by a robot and is best-effort only.
