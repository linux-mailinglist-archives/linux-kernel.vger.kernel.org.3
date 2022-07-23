Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7EED57EFC4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 16:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238288AbiGWOjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 10:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238452AbiGWOjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 10:39:14 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA5315A1A
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 07:39:13 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id c14-20020a056e020bce00b002dd1cb7ce4dso2923645ilu.22
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 07:39:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=iiJ9q/IhJM4GZC/IZGK4lpPpea/vBzanjxDRvbBYUcs=;
        b=HnYQSh1tOf6dWvJ8XorK1cWh7rvvZ+vE/027DxbveST81qQCf3PdjIQR3IEvq+W/fJ
         BaWomrPeNf7GCgB560q2kOuwkYr/vpiQ1A4SYEbDjXT++3kdvvUR27aoYjeJHc7iQJfK
         9MfvF6Y3a48B8DQcl4bs08KILIVPHjfNz85CVgSQYh6hDoOGIbf9alzc+UO/T98h4SWl
         5ba1IsWi/fqzg9oWBa3qKLUub+vpVe4T+W2/CBNMD8mITL4kcZ7NbAjaIf38r6fm0Nd8
         vbEqh0EXRIfQC9chVEEQTglZUUT85bC3z3OI8TJoPbFae2I30CWh8DXFAE3M/kkDbMTh
         n9UA==
X-Gm-Message-State: AJIora9Z39l3s+uIqLnsBMR1qSvMZ84diEV4iaUEdbowGZXQ+ESKd6N2
        DE6VbcF447nEC92mg5SfDXfSugrwUW3F+ozh/FBKwtcGgumL
X-Google-Smtp-Source: AGRyM1taDDCQcUyRo7MBM1NrUg2fD+i1YBlVB3WV4pC0B1mBPapFN//TimwiqEu8Qs1BqCgtwsjuysJdUEuqToYYcBVN3AdN83DF
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1a08:b0:33f:4b10:1958 with SMTP id
 cd8-20020a0566381a0800b0033f4b101958mr1904951jab.220.1658587152490; Sat, 23
 Jul 2022 07:39:12 -0700 (PDT)
Date:   Sat, 23 Jul 2022 07:39:12 -0700
In-Reply-To: <20220723142031.2316-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000dac0205e479ea39@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in post_one_notification
From:   syzbot <syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com

Tested on:

commit:         551acdc3 Merge tag 'net-5.17-final' of git://git.kerne..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=133a814a080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e006319d4b3bc11a
dashboard link: https://syzkaller.appspot.com/bug?extid=c70d87ac1d001f29a058
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13b8c83c080000

Note: testing is done by a robot and is best-effort only.
