Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2D1598C43
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 21:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345187AbiHRS7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 14:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242087AbiHRS7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 14:59:15 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06B2BFE82
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 11:59:14 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id w7-20020a5d9607000000b0067c6030dfb8so1363788iol.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 11:59:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=zks3cyVxGDQrYuKcAHllSYdeYCBN0k10SgDcxH3TjaQ=;
        b=3D7J0k15R7PJGyN2rOxmCbhNnpXFAlLNkRAdcJx93KlW9cCvBdPssdnKbbPC04a/lP
         9pJP2+2s6XTAf2d/s9MhpxDkMqS07NSTCkh96gsas3VFSjpx2tqDF8JNHQuK123QxBxi
         +8NyPubA1aaXY0OGrkC3NUboBmSNpVUMRVRtPwBEk+ehEF+It+nhIryXMzJMuiLIoiEq
         M0cWEzQRWwWNwLoKq4lSZ36AoUffaRCw/1SLvG93zpxqaGGmBpdS3BIlbJyjegUm3+Y5
         pHngMf2Y/3yGPJ7ov4edwg9vTYU7RTJ+usjfuRNvt8t0LwsmIknLUO8ymlIKDspXauev
         pynQ==
X-Gm-Message-State: ACgBeo3kKdbxZXAxZkF28m0vzzE9yOHCWFmP2uycIwiPEnI98PEmohLG
        JHXIqtlrPlqrboq4xqmg9jJsFyGMS25UmqAaZERCn23fEXOf
X-Google-Smtp-Source: AA6agR6vXmA56nN8PSnxixLJ0iOxv0aj2ynYmmA+9emcqggi6xd9NfGsouTe/+Lh/ta3jhl4wHjqgShfhf3YrLO/d5bRq742f/jD
MIME-Version: 1.0
X-Received: by 2002:a6b:b802:0:b0:67b:de15:c1fb with SMTP id
 i2-20020a6bb802000000b0067bde15c1fbmr1939100iof.215.1660849154242; Thu, 18
 Aug 2022 11:59:14 -0700 (PDT)
Date:   Thu, 18 Aug 2022 11:59:14 -0700
In-Reply-To: <20220818105159.1280-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dd3ef305e6889368@google.com>
Subject: Re: [syzbot] WARNING in __cancel_work
From:   syzbot <syzbot+10e37d0d88cbc2ea19e4@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+10e37d0d88cbc2ea19e4@syzkaller.appspotmail.com

Tested on:

commit:         7ebfc85e Merge tag 'net-6.0-rc1' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10a4ed2d080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=20bc0b329895d963
dashboard link: https://syzkaller.appspot.com/bug?extid=10e37d0d88cbc2ea19e4
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17b69fc3080000

Note: testing is done by a robot and is best-effort only.
