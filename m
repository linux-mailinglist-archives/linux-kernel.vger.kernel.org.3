Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B75A512ADF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 07:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbiD1F0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 01:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiD1F0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 01:26:39 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A00F22B2C
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 22:23:24 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id x13-20020a0566022c4d00b0065491fa5614so3809805iov.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 22:23:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=bm23MXbMzdThqZ1F077AT/Z/gr+FTIvmlXivxB5424E=;
        b=H9OcX6rUJ41yaSJZC0d/2F1gSPtLnT3CR1o2FioUetBEGlQewW781krvxxkXVISS16
         yUS+LB7AJYJfzfALqNLES1fqGuILUwHs4SL3NgNrkrIaRUepGqrjRhegDO/z/3XjNMfx
         9PTAqFJZCeqtb/ET9S6D4Xc4pqtenZRO83ubS+fzLkl31gP7QuFeEezd6e4e+XfaJHWm
         lHvbGSSTF9mE8otjWxgE5NML/TN1GocxNyQF266CRs0z1JWIx97z+JNGK0TWIESEEKIv
         3FFOP/VJCm1PvoT/0/fmRe5R2kUqxW/fPUtm/eFP823CRCYprQg6Qdxdp6yLvaimPb2u
         n+mA==
X-Gm-Message-State: AOAM5312rbOR0KokZk0w81o5YTlO/3IZGehQbLdCcwZsSzRF6D0P3aR3
        B1arXdXVTLY5s5stop0qEhvN12OFh2ruvZyG7lf1NH/EYsTE
X-Google-Smtp-Source: ABdhPJxGGPvScdSkXuIH+e1B1XoCqv3aYDtbq5KVm8tjAQWdifCATaRYv6usd2VOoprDnriONEXdr2z6DH3qm8dlelOF6wJmAEXS
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1233:b0:657:b1d2:c31a with SMTP id
 z19-20020a056602123300b00657b1d2c31amr3088114iot.35.1651123403490; Wed, 27
 Apr 2022 22:23:23 -0700 (PDT)
Date:   Wed, 27 Apr 2022 22:23:23 -0700
In-Reply-To: <20220427234836.3637-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f20e5105ddb01f09@google.com>
Subject: Re: [syzbot] general protection fault in btrfs_stop_all_workers
From:   syzbot <syzbot+a2c720e0f056114ea7c6@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+a2c720e0f056114ea7c6@syzkaller.appspotmail.com

Tested on:

commit:         088fb7ef Add linux-next specific files for 20220426
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/
kernel config:  https://syzkaller.appspot.com/x/.config?x=f49713d2574602b3
dashboard link: https://syzkaller.appspot.com/bug?extid=a2c720e0f056114ea7c6
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11537ee2f00000

Note: testing is done by a robot and is best-effort only.
