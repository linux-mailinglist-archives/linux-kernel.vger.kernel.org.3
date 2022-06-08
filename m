Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480B0542691
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbiFHFnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 01:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbiFHFm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 01:42:56 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF71E140E6
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 20:15:09 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id i18-20020a926d12000000b002d1b13b896cso14958332ilc.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 20:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=my0rk8z/GOJ43WqWCVtp9xPE8Ztlbnwblm3qHdmpM54=;
        b=ijLulpDjAor87aRDj08/eH8fj0MMruq2G1e0tKKtnJ4YR5zMExdwvbCndXgt0AX+0A
         v4avNz6QRSYC8D05s5pDVYf7a/ISjsEH3ISxDOyEuokIfTdxrpPqJ7YIRlmT3NHg5HdD
         gDdswniUpzd1jzSjhv6l1iacYNTA06TQNpaG0xC2gRdTnQKIMbRs6OZqdrhEqPS10Yll
         C7v3CwDqw9SopKIh+xrFxqmg6DXXKTTXlOzc5b63jjuC6jDIBI1RghQcBr0wG0EHl+Z/
         117ev+Uj/avwmhh8iJK+AEctYgnkCE22Vyi4uhBek0VRmfq3MTy4GS7jzCq8hsMq04J3
         VsUA==
X-Gm-Message-State: AOAM530/S2yRB3UwL0S9LH9EUYNuFvJO1UnH3+AU7IDz114kffJtA9IP
        zgC/JvtSXfXlFKjPCsV5myXOpbJw2XdSjXG4w7CFQ+J292cI
X-Google-Smtp-Source: ABdhPJyDAHTZEqVZpAdPEsRA1tWIDLDO1YkbVcpsVw8DKrB6ladOIZSYZjLdMQ+C1zhzwGLq/5AjZkFGwdHA1V+LelZ+/7mstGCC
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca8:b0:2d4:455:88aa with SMTP id
 x8-20020a056e021ca800b002d4045588aamr14561882ill.303.1654658109343; Tue, 07
 Jun 2022 20:15:09 -0700 (PDT)
Date:   Tue, 07 Jun 2022 20:15:09 -0700
In-Reply-To: <CACGkMEus=RMMcDk+sM8X14=AtFjK+-3p_Lo=O6tfv9H=0wXENw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d5113205e0e71c8f@google.com>
Subject: Re: [syzbot] INFO: task hung in add_early_randomness (2)
From:   syzbot <syzbot+5b59d6d459306a556f54@syzkaller.appspotmail.com>
To:     herbert@gondor.apana.org.au, jasowang@redhat.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@dominikbrodowski.net, mpm@selenic.com, mst@redhat.com,
        syzkaller-bugs@googlegroups.com, xuanzhuo@linux.alibaba.com,
        yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+5b59d6d459306a556f54@syzkaller.appspotmail.com

Tested on:

commit:         bd8bb9ae vdpa: ifcvf: set pci driver data in probe
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d4cbb773055caee
dashboard link: https://syzkaller.appspot.com/bug?extid=5b59d6d459306a556f54
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1731eaf7f00000

Note: testing is done by a robot and is best-effort only.
