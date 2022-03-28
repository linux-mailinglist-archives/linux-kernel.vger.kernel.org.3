Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675A34E8EF8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 09:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236389AbiC1Ha5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 03:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234268AbiC1Haz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 03:30:55 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC09427C6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 00:29:12 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id k5-20020a056e02134500b002c9af0334e2so999025ilr.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 00:29:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=KF6RRSv0UEz8tSzbeuXx0815Teuk0m5QkpVJdIXOy1A=;
        b=05s3lSvNDoUCoSVHrOqmntYgAbZtGRyu0L3C4bx/Xme46godiPT1Rmbhn7nM2mdB/3
         dXGQf1E+Z4hj8HbS7TFB4cvTI7ifna+Ky2Um04nuvuJ1+tzl2AXSPrhPDlDGw0PUprHJ
         UHmADiGlaGvs/bUOheyCWGXpsSVlhVnbi5VZUnNpT8VvQdvd6/mlbGpmNfc3TKhepnpM
         ztnOdX8rgwrnAhkmdEtrORKZWHBo1v3g7F1gsX+d7p7/o1ygYIMvwv3BKZ0YlaAxHhL2
         F3s4StnE/kaBExxrIQ1FL9zynMGYxwwoh6MGIPqDUVhqLNNZ54LXJirV/p65ZewSqqsL
         GsMg==
X-Gm-Message-State: AOAM531pkHcsJVdgN+/iAuCZTHxNH1O5tiPRflTTKc3HyEw2MqnYAl/W
        5xkv/yhH1TNldRIwpu4cB5vrYU+MWQcJEShZqMOk1G68kb2F
X-Google-Smtp-Source: ABdhPJylgre9J6aJ68nKejMHlxOmxK4+mEFWQQBbyeS+ASnoUYOMmCmdSz/22WytKSqAWnOGc3TqFAKHkQbHRRqzDsr0ElUtrNTs
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4089:b0:319:b60c:3c3d with SMTP id
 m9-20020a056638408900b00319b60c3c3dmr12553389jam.120.1648452551957; Mon, 28
 Mar 2022 00:29:11 -0700 (PDT)
Date:   Mon, 28 Mar 2022 00:29:11 -0700
In-Reply-To: <12985729.uLZWGnKmhe@leap>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c9dfe005db4244a9@google.com>
Subject: Re: [syzbot] memory leak in blk_mq_init_tags
From:   syzbot <syzbot+f08c77040fa163a75a46@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, fmdefrancesco@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
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

Reported-and-tested-by: syzbot+f08c77040fa163a75a46@syzkaller.appspotmail.com

Tested on:

commit:         ae085d7f mm: kfence: fix missing objcg housekeeping fo..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=6583b67d32c256f1
dashboard link: https://syzkaller.appspot.com/bug?extid=f08c77040fa163a75a46
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1461d105700000

Note: testing is done by a robot and is best-effort only.
