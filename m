Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E1A5867DA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 12:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbiHAKyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 06:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiHAKyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 06:54:10 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B07A29803
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 03:54:10 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id d6-20020a056e020be600b002dcc7977592so6414103ilu.17
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 03:54:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=uT5aBsRl4Nxp3sL/bAvhl3ZHDWjlM5D2XO9RDu0Tm/k=;
        b=YsJuGQ1HjHvcv/SWR8xvA4BoJYpWIqxUNoZv9Wkc8FLXcoR1lwX+3DAm0v+ZJlq5uS
         susquQUWulRGRMf7kzhtRlgQacEGR1nqwc3ww/dK1PcqJUiSO4hlnUfz2Kudl+Y3gv4x
         loA+rSpqLcxS0ZZj2pgnf20I8CWDhgWBiOPrqBixNa5owKfUPUJ1N4ibNCzqbe/Eatqs
         wItZq2/AY2HRGEIDQnETOYxCICscrpk/zcO2oa5Je+ePYGdY5mIxxbg6BHuelwXOB68c
         ANLjNUbZL2wuUsHec887tuAVLrjp/AIZaSjAKODjFzxbjeqfs/+uSy5lNrVlidqR3i7/
         KZiw==
X-Gm-Message-State: AJIora8UpfkVRoYENo6Ft5fYLBol7IjTCVLqnRiRizT8Q6aJlBXMsYvl
        a8EvQUivnCXsugSVujNEATgBmAFpI3rMKQc7uQi/UG4YjdUC
X-Google-Smtp-Source: AGRyM1sc+jKVOQZOY0rloIBLTV7xjki64DUXRr/OgOUhnj/tAwgWJmggmVPsA/xcszD5amniINcL0ZnyafEATpLGrMtqDgLojtEJ
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1586:b0:67c:17da:86bf with SMTP id
 e6-20020a056602158600b0067c17da86bfmr5332258iow.15.1659351249428; Mon, 01 Aug
 2022 03:54:09 -0700 (PDT)
Date:   Mon, 01 Aug 2022 03:54:09 -0700
In-Reply-To: <20220801103533.972-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c7a83905e52bd127@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in post_one_notification
From:   syzbot <syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com>
To:     code@siddh.me, hdanton@sina.com, linux-kernel@vger.kernel.org,
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

commit:         3d7cb6b0 Linux 5.19
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=14066d7a080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=70dd99d568a89e0
dashboard link: https://syzkaller.appspot.com/bug?extid=c70d87ac1d001f29a058
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
