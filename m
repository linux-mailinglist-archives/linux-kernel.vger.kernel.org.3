Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69266536E01
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 19:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239298AbiE1Rza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 13:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236088AbiE1RzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 13:55:24 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62AED120B2
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 10:55:23 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id a12-20020a92c54c000000b002d2f39932e8so4029437ilj.19
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 10:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=8fXjU/ZbiGyVhFFAYJKqBjQvQpcxyuo7di2DSV4UV84=;
        b=Nh4Znj961WwB1f/sX98XRKMCqfRLQTuVKmsMxpwELcZI6/rfuUhCgxUwrEhHu4Sio8
         3QIq+1GOWKDJnmmAk3YDMYkRm/wIQGDmsHzfg+kCO5qqnK5f5tuTe7Vgs1ZoxYSFDrA0
         FaETMWMEiguHr+JC3wcv+8tFkd6k1cfBFnLxgeQGxnEAitRLNP1lQSP44Ln1JBYOnwL3
         eGeiSWOQ4a9kme9RMMTpDxACVcfr9zsygZa/fbNp7ZNJAOl9pOGSKOegZnh3hIpplvSu
         yVueWGfueiK2QXmwrH1xjDkXORnzpzN2j5GKkbPfL/sKrcnXiuN22yL641vMVR2DajrW
         O39A==
X-Gm-Message-State: AOAM532exI75NsWy+16H2MIhOzlT9gfgvtrKGKDJy4mstI5z6iW+SBoc
        Yh79DvvZX8xRrvJrqzGlNzVsZ4/5U1AHM2A/E0WxeImWD9v3
X-Google-Smtp-Source: ABdhPJxO7aUCkjM0UfdDnQmD0Nmu7o0bFfpzSg9h0WdtoBHyB4e3jjNpAPbow6+7PDw+VkBvkbHA+vS0vQakdK4WHNKEg4bcKpQ0
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3002:b0:32d:acc7:4a7a with SMTP id
 r2-20020a056638300200b0032dacc74a7amr25577537jak.14.1653760522347; Sat, 28
 May 2022 10:55:22 -0700 (PDT)
Date:   Sat, 28 May 2022 10:55:22 -0700
In-Reply-To: <YpJaiGRcRjDzRxQC@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007a6b3605e01620c8@google.com>
Subject: Re: [syzbot] WARNING in driver_unregister
From:   syzbot <syzbot+02b16343704b3af1667e@syzkaller.appspotmail.com>
To:     andreyknvl@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
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

Reported-and-tested-by: syzbot+02b16343704b3af1667e@syzkaller.appspotmail.com

Tested on:

commit:         97fa5887 USB: new quirk for Dell Gen 2 devices
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=d7b232ec3adf5c8d
dashboard link: https://syzkaller.appspot.com/bug?extid=02b16343704b3af1667e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10f44625f00000

Note: testing is done by a robot and is best-effort only.
