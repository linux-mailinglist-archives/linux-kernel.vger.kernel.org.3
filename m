Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9A74D0EDC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 05:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237691AbiCHEwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 23:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbiCHEwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 23:52:06 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5175D33A01
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 20:51:10 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id o17-20020a92c691000000b002c2c04aebe7so11743604ilg.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 20:51:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=uiEnvrCJO9ahx3KjvytyRBPbLTaFX8Hx3K+SLJ16Csc=;
        b=I/6KtEBxTFMe+q2e59cztVm3sa40VIw90Bwjz7hpYeR5xuG4cFoGEUZygJ7ihq2oWU
         pSWWv1KIlagt362JrnRFOB0/eO8weUcoEhNp+ns/ek69kH/W4C0BTC8TqdUWx3SPp+AN
         FjtHZ3wvzFHLX2YASR4FRz7TrrfVMYJDXirVfjVAq3tz1gPdKgl9WEir+BSH8YtqnMho
         az/6DiQTjwiCPePYU80/B8RNh6+up1dvYio7gYbaRKER4s7f2MIawWnhiFDSU82i87kx
         EpxQRDgoBa8yHmq2jOu8APFoy2UsBzJwe40U97zyWWmn/mAdRETBWGuMBOg0eS0w+Rha
         b2hw==
X-Gm-Message-State: AOAM530EoKowDp4hQvaAaWP4RiHS20nDiz2wjTHhhw7cpGZeqzoPo5zd
        XVM1/g5pQ9VVtGezi7dw+q+lbILdHWUqe7ZoA76r/5xyiLLv
X-Google-Smtp-Source: ABdhPJy4yEr09F5ipqfpdWFc+mUL+o4PBJhUCKpWE7/ZHU18qkT14hHwwkq0R1JMdFrqzLXvp6R1hRAOvq2bLJxPuL/iYs2opext
MIME-Version: 1.0
X-Received: by 2002:a92:6d02:0:b0:2c6:e1:79b with SMTP id i2-20020a926d02000000b002c600e1079bmr14430503ilc.67.1646715069632;
 Mon, 07 Mar 2022 20:51:09 -0800 (PST)
Date:   Mon, 07 Mar 2022 20:51:09 -0800
In-Reply-To: <20220308043407.3440-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c5961605d9adba2c@google.com>
Subject: Re: [syzbot] WARNING in mcba_usb_probe/usb_submit_urb
From:   syzbot <syzbot+3bc1dce0cc0052d60fde@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

Reported-and-tested-by: syzbot+3bc1dce0cc0052d60fde@syzkaller.appspotmail.com

Tested on:

commit:         ea4424be Merge tag 'mtd/fixes-for-5.17-rc8' of git://g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=aba0ab2928a512c2
dashboard link: https://syzkaller.appspot.com/bug?extid=3bc1dce0cc0052d60fde
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1527dff6700000

Note: testing is done by a robot and is best-effort only.
