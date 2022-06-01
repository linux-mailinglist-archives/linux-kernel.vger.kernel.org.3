Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F1153AA95
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 17:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355916AbiFAP6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 11:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352622AbiFAP6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 11:58:09 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809024CD51
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 08:58:07 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id b11-20020a92340b000000b002d3dbbc7b15so870155ila.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 08:58:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=/bHD/FuAjdY2ao8m12sbxeU2qcCCHETq+g1NgUkJaNQ=;
        b=oGBUkYetDR1TVeTLqoVp94aoe2xKtrCLCDpj6asVpuKjGs/ONFjzzGfo9+seY1imFD
         3FNT7SbOM3RkNiuwSA5cCn5LA7itMg5cW2LMh9AqrsgkEtBUT2ISuD491Zl8yYfVpvds
         gYbBgKRn4FGOxq1M0FEzEWhKarFBjO6VqX35/0e4o1ON9R3lRqeZxH1vUdMsm5NeviZf
         FF6GB2YlM2OUGrmPyyN6tCdfV/E2p87ND9hX9GiJ5rSUG5P4oYIIkjCJ25AbzenQyFRk
         wU0YTF1WzGyDtF1o5Uz4Qf+uTk3EJBYtbcvOxPX2nIm1iW3jz3C5dJ0lEuhrL1D+DT0C
         8T+w==
X-Gm-Message-State: AOAM530IJAmaDEhNm5UJL708hTo9OH3vDs4TAQbD4JeEaF/mnfvaKfby
        NI6E2vwdM5vGu4fMQCG/gR3Q7HyyaTIZs+p4Ni8rLASodkVV
X-Google-Smtp-Source: ABdhPJxGwjcJDqDfdqzmiTi8eQ7MujZOMvTBnwf+hUYjUTjZZIST4yDzfuznUJVhsY5oim7jxHK+8j/fXdr4hS1PDUtWKSuY7urg
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3052:b0:317:79e1:8b7f with SMTP id
 u18-20020a056638305200b0031779e18b7fmr301825jak.239.1654099086907; Wed, 01
 Jun 2022 08:58:06 -0700 (PDT)
Date:   Wed, 01 Jun 2022 08:58:06 -0700
In-Reply-To: <20220601140527.4708-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007f9d0005e064f4df@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in snd_rawmidi_transmit
From:   syzbot <syzbot+39e3268af9968f153591@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+39e3268af9968f153591@syzkaller.appspotmail.com

Tested on:

commit:         2a5699b0 Merge tag 'leds-5.19-rc1' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=f915857c44e13980
dashboard link: https://syzkaller.appspot.com/bug?extid=39e3268af9968f153591
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1578ed47f00000

Note: testing is done by a robot and is best-effort only.
