Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C721595B1A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 14:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbiHPMBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 08:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235494AbiHPMAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:00:46 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0957B7A7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 04:46:07 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id u5-20020a6b4905000000b00681e48dbd92so5838735iob.21
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 04:46:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=wzeIiQ9mwpwIUmhJcR2Ov1nD29260pv02saoYmpgAuA=;
        b=hjXqP879ja2+CPkwfkfb2OMCBk3I0Oi/i7F4TvGdDbfDSO6Zael3m7wBNxOyh4I118
         6tICOPQJR7KTICUUdiVRw6KF3EQafECjPx+tZ9fYwmyuFzb711KiB/FwGTTljj018Un0
         H7YZEukQhkyAG3u1cxqSvROFFN6jIDap6KjqKSx8corQpZ4NFbHur8D6+rAH1HTo6HxC
         zCvEpf24ML9e/YPK4vTkPRvdcDsl8cfg3QlDPi0CNz/gbcDBBGJlLpeSOuPaXaPwpAfN
         jN3m/HSC/bRv5dWVcRi4POyphURPaHR6SJsImfOIA1zTQdSkGUyHEJMapsOZTjRQaKsH
         U0DQ==
X-Gm-Message-State: ACgBeo0HOSJ9YpBQQ0AhuXGGpAcBuJplfU7icrsqtDSzpqj8Iod8kRGD
        mpabVfzkCykCFYAkJQYlr7ThNFJyddPeDgmDjyAlcUlAciEu
X-Google-Smtp-Source: AA6agR6GqZD8Afq8+hbY6Jp+6jHd6Izx19F8tkgWrJu85pzdN253VEWOHg5iQIQ2PMoshJbmGSJGBD2Xptt1AghWUhdlTYUj9yQR
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8a:b0:2de:aa0d:b99e with SMTP id
 h10-20020a056e021d8a00b002deaa0db99emr9383562ila.138.1660650366959; Tue, 16
 Aug 2022 04:46:06 -0700 (PDT)
Date:   Tue, 16 Aug 2022 04:46:06 -0700
In-Reply-To: <20220816112228.1024-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003809f605e65a4b5f@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in send_packet
From:   syzbot <syzbot+f1a69784f6efe748c3bf@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
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

Reported-and-tested-by: syzbot+f1a69784f6efe748c3bf@syzkaller.appspotmail.com

Tested on:

commit:         568035b0 Linux 6.0-rc1
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1552c1f3080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e706e91b2a433db
dashboard link: https://syzkaller.appspot.com/bug?extid=f1a69784f6efe748c3bf
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1452c1f3080000

Note: testing is done by a robot and is best-effort only.
