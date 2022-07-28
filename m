Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2A8583BE3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 12:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235685AbiG1KQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 06:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235790AbiG1KQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:16:12 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CF8558C9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 03:16:09 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id n20-20020a6b8b14000000b0067c00777874so333137iod.15
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 03:16:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=KCp1YCFZHiH6faIRaH4KjiEeUrRm+nx9G5bhsYjdz1g=;
        b=hj62i/Th5a+nRzlUIgAoRDQ8IyF/PBVUmzhTZoUT4vGtLqsiTVReTNObkzO9WYjW9h
         EzVUMh9wSMh/YL8NmzJ8zy6zPn0PLUnptRfX+KsYEXcoqVx8R7JqfIoDLsw4IGq6J2HQ
         uAvhtzh0UeG90NR+3jYuBbNV/YzwEy80DO2S92YcYno33+YiBmgA6NYQ36Lg6ZeDZHGe
         xDYtNSDlqdg/keY0IyuKqtCDq7xJO7XF6WlhNVe1I3aw5ogFwmfSWXZinhx/g33RW2Vd
         xK3fnj92iQjsoFLNRaKSdkJiDc1RUzjiaXEsiFyRmgVC6BAC1+9JX73YM1v01xTxBiPY
         gN4g==
X-Gm-Message-State: AJIora/WRRKi3Zo6W3ZXSaAXF+dgXDN63QcCdSg15sFSQ26buOoIQYQW
        xVvrFM24ST8JzeHFEYZH5Zswhk+PQCvlVMJnyP8nr33tzuuF
X-Google-Smtp-Source: AGRyM1u48q3e0UGkFyqH7zIHWquNUOh0sDLLHNKzDA6zCoVuq77wWxjWrJhzYz4Y4tPn7CAj8qb2pRA5wYD/I3MyHSjC3cfgSuke
MIME-Version: 1.0
X-Received: by 2002:a6b:5f0d:0:b0:67b:da10:933e with SMTP id
 t13-20020a6b5f0d000000b0067bda10933emr8949449iob.56.1659003368661; Thu, 28
 Jul 2022 03:16:08 -0700 (PDT)
Date:   Thu, 28 Jul 2022 03:16:08 -0700
In-Reply-To: <20220728095628.903-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000786c1305e4dad233@google.com>
Subject: Re: [syzbot] INFO: rcu detected stall in net_tx_action
From:   syzbot <syzbot+3ba0493d523d007b3819@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+3ba0493d523d007b3819@syzkaller.appspotmail.com

Tested on:

commit:         f80e2148 hrtimer: Unbreak hrtimer_force_reprogram()
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=161c00ca080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=31eef52c6517a0c2
dashboard link: https://syzkaller.appspot.com/bug?extid=3ba0493d523d007b3819
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=111abd26080000

Note: testing is done by a robot and is best-effort only.
