Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4260B4BE7C7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377646AbiBUOZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 09:25:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234903AbiBUOZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 09:25:30 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2D71EC70
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 06:25:08 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id a19-20020a924453000000b002c224a576edso2814062ilm.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 06:25:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=1G4UTq2o6P+a746sTP+dVfls+sUJpDYN5P8Qcj9N0Fw=;
        b=zy0QPgn1BOirntICOnRKM1/+vQ4FlgCqNWnLsS5hHFIzCkGZadvGUT4VmAxEF7J/iV
         2jmNkCRZj6ZkoMVLHssiyOukAznn6NXRuR3ORzGCWbz375onIin9y0/CyTxoAESrZ4As
         S9p1RIW9yno7cwrXe2DLVdLwBaV/zWAU2E65Ahs8HEuLMj9s2BvKPBVw9WBKb2SP4zdi
         SUaG0vFsjL1BgT71W9QMYcvk46wS/BhLz4L0R6f6MzsDcaq0k5yhwA6cCwnLYN+/0Fda
         Cotro6ewKuhp9xcB+xdLN3EwUOFutPgNWVgxeydlaDpi8kp+J7uAkJrXGQc7wOKWf8Zz
         8FQA==
X-Gm-Message-State: AOAM5317gozq6oOZ24vmd5VRjyO9s8fTxtka/adsz5v04N3bmCOiG3uF
        A0zqRFOMzxC6m9/kGK9y2C2iqQvV//R5bPymrFkMT7gUGgBr
X-Google-Smtp-Source: ABdhPJzNsYGk158e5e070uwwiQblmpJR36IBOvzT5M746XeMrwbnfnCwt2Ij175fwa4je3uPCfVMOyoDjAZwmvmIP4VvqwCvkCg2
MIME-Version: 1.0
X-Received: by 2002:a02:c8ce:0:b0:309:bc07:302f with SMTP id
 q14-20020a02c8ce000000b00309bc07302fmr14872524jao.305.1645453507419; Mon, 21
 Feb 2022 06:25:07 -0800 (PST)
Date:   Mon, 21 Feb 2022 06:25:07 -0800
In-Reply-To: <CAGxU2F4f0Gx=-4g-r3QHFPsn0WwSW3HyT+MRKj4=TTWp9R+WYw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cde22e05d887fff4@google.com>
Subject: Re: [syzbot] kernel BUG in vhost_get_vq_desc
From:   syzbot <syzbot+3140b17cb44a7b174008@syzkaller.appspotmail.com>
To:     hdanton@sina.com, jasowang@redhat.com,
        linux-kernel@vger.kernel.org, mst@redhat.com, sgarzare@redhat.com,
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

Reported-and-tested-by: syzbot+3140b17cb44a7b174008@syzkaller.appspotmail.com

Tested on:

commit:         f71077a4 Merge tag 'mmc-v5.17-rc1-2' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
kernel config:  https://syzkaller.appspot.com/x/.config?x=a78b064590b9f912
dashboard link: https://syzkaller.appspot.com/bug?extid=3140b17cb44a7b174008
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=123f7296700000

Note: testing is done by a robot and is best-effort only.
