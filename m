Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB22A59FFFA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 19:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbiHXRDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 13:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbiHXRDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 13:03:13 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EEEB863
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 10:03:13 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id i14-20020a5d934e000000b006892db5bcd4so9794467ioo.22
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 10:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=oZ+DHQ0CMVDWXNZAlzh+DfPqGzcC6u8ivHvdHW+me7g=;
        b=FmHlJn7eoprjrG+KQNiP68zFdpDisLA/Gb/Y+IjtzWgBzsgLC2PDLu35dLY2mNPFC8
         8QTNojUFjg8PDzzd4FaRSY8W3bqwGvJFQPUWMoxNQNquP9WziYTU3zW6VLpayiekeoTT
         noGw+sbvRdJAjRF1IWFn06s6exvzKbAfbDmDTwJX5c9LnW5PdYnGTmoCblrTmNrfRKNP
         0omTEW8sE70G9mRWgFhsr+jgDiTh0wBFDHFFmnnsyb0yD3L0anoCbnz+R4BfWMrv1aVm
         iGEWZDqs3n5P/60lLL/6tLSuB+JmS5GfaJCNHnxWZnL4gGkbBO00Pnwk4UhqdtLlqFrM
         kMBg==
X-Gm-Message-State: ACgBeo1rxbPOjeZocNwqkvrUgWw/UMNT+6Qep0TnH3NNg+ekRyC3w3QT
        Ne5UYUdWW4UlSHWzapA2VUEBgbdLm2WCUAgIpTJFBctM33KQ
X-Google-Smtp-Source: AA6agR6vyJWdAuYzi0pLXzPnRgYPAqb/gA62FAnF3htuF3d5ng597wWhnGycZ5qam3lmx7y6A1OtM5wKByxJr8VOktLR8YTXVcwr
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19cc:b0:2e5:e7bd:2187 with SMTP id
 r12-20020a056e0219cc00b002e5e7bd2187mr2448845ill.289.1661360592497; Wed, 24
 Aug 2022 10:03:12 -0700 (PDT)
Date:   Wed, 24 Aug 2022 10:03:12 -0700
In-Reply-To: <20220824163739.722115-1-code@siddh.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f5b27805e6ffa78c@google.com>
Subject: Re: [syzbot] memory leak in ntfs_init_fs_context
From:   syzbot <syzbot+9d67170b20e8f94351c8@syzkaller.appspotmail.com>
To:     code@siddh.me, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+9d67170b20e8f94351c8@syzkaller.appspotmail.com

Tested on:

commit:         c40e8341 Merge tag 'cgroup-for-6.0-rc2-fixes' of git:/..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=11e16ca3080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b1831d905b683446
dashboard link: https://syzkaller.appspot.com/bug?extid=9d67170b20e8f94351c8
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1503a42b080000

Note: testing is done by a robot and is best-effort only.
