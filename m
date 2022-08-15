Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F32593DCF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 22:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347955AbiHOUbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 16:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347505AbiHOUZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 16:25:53 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F0B9C514
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 12:03:22 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id f17-20020a6bdd11000000b00684f4e874b5so4638231ioc.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 12:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=SMyJSBc//ldugq2wK4ymFhOfMcuivZanqF/HXPMVlz0=;
        b=zsvCxYPJGu/PtwKfBZWqdp8wwczGcVMVTqUvH9Gdtk+EVvfrIacVH1NfaXLQdDeD9I
         8/5f7s2u18oiqoqSdjb0fQwY+gqt2jEXB8CG9zqcwgVaFIe2YyzruaiNMTQOc3vIXdcn
         lZufgYVw6yHVc8itTqW1L7hA5yUHJ63gPDihieqZ0+acsfC39qAp3bnYypJKbkTk3rPw
         Y5Ua+72jEvH2TzzI4iY2yfbItc9VbM9G5cELyQIEd30R2LMOrsBG+E/ts5AyBFnoAEb2
         q+aTShamWA2pC2co9VPV0N5aPLTjqyiW1ZTlUllmbJln4oIRacT7MP8wHSC3Yo3Uvrwb
         IVdw==
X-Gm-Message-State: ACgBeo1pk9BeRphFb1xRoBxOAIhWYUjOPc7m4ORqexIkvEAJpg6nQPK4
        azoKebymK/b4bkEwbeBma1D4/snJsIyO7VdMtFWcLAoZhbhN
X-Google-Smtp-Source: AA6agR6O9hjLRRcGo7EYtsJrIz0tiwEQGCaRsZcH6nx4qdnDZdwYNquDrQuT/O6a0R40I4P0w7uCC2Qjgu/wjdWTBTn4fX4vYNmt
MIME-Version: 1.0
X-Received: by 2002:a02:aa92:0:b0:343:6007:1e12 with SMTP id
 u18-20020a02aa92000000b0034360071e12mr7190295jai.62.1660590188637; Mon, 15
 Aug 2022 12:03:08 -0700 (PDT)
Date:   Mon, 15 Aug 2022 12:03:08 -0700
In-Reply-To: <20220815180801.GA3126580@roeck-us.net>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004fb42805e64c48eb@google.com>
Subject: Re: [syzbot] usb-testing boot error: general protection fault in __tty_alloc_driver
From:   syzbot <syzbot+2c35c4d66094ddfe198e@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux@roeck-us.net, syzkaller-bugs@googlegroups.com
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

Reported-and-tested-by: syzbot+2c35c4d66094ddfe198e@syzkaller.appspotmail.com

Tested on:

commit:         fc4d146e virtio_net: Revert "virtio_net: set the defau..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=3cb39b084894e9a5
dashboard link: https://syzkaller.appspot.com/bug?extid=2c35c4d66094ddfe198e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
