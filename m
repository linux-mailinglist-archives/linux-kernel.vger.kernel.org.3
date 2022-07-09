Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108AC56C860
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 11:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiGIJbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 05:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiGIJbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 05:31:10 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B28743E4C
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 02:31:09 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id t2-20020a6b0902000000b006753087a104so484299ioi.18
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 02:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Ob2Pbk8KuwATFeYrC+OWlYeuZ3a9PdwkEqjfU/dxNs0=;
        b=gMkkIrhIQQauuOBCv9ArQH3xb8aXbUKhb7O6LvAL9FJxADsZOx2cRmuxMFbOITWkdd
         oaldGloijVrapoXJoTYUySBio0YrDKkOXNKQEvoXuwvTBzKkbxcaRr1qOL5k5ElPp4LV
         tHDYKiUDKI6UBkmD4rm8RG/enAIeRgTJumvtN5KEoi1+67hSOoVvXsK0FX8gEjXxODxH
         cha7oFlJlXtVv4wI6I+GqZNOfgyh7H267QNpzPtrclRgHmvuGsA1qSsqH0Pq5EqEkQWT
         6s99fRv7W6CjEjKe9tdjyXBaSgFI7yWegUE7tbWg/vtrRSBZwpzqzX6TY55R40ZKEUkF
         zMSg==
X-Gm-Message-State: AJIora9qIqFnZE4StJof9NczBjA7Fl9r9UPjqKNE2H2dbAwvhSUZ6c5k
        vWZ+YkSax9e5SIBcPkcqBJN4APix06r4W+BxSF6fsSk7S3ST
X-Google-Smtp-Source: AGRyM1sMctwb7aDR/OgvrfcUCeE79uZ1MaWErWW1wdqbitJCKZqtDWn/wh5oGN/QNoQ7NwSUagnehRckCCDrhZin0PI9e+lNNQWu
MIME-Version: 1.0
X-Received: by 2002:a05:6638:448b:b0:339:e4c4:1cca with SMTP id
 bv11-20020a056638448b00b00339e4c41ccamr4575400jab.132.1657359068453; Sat, 09
 Jul 2022 02:31:08 -0700 (PDT)
Date:   Sat, 09 Jul 2022 02:31:08 -0700
In-Reply-To: <20220709074319.2322-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008a610405e35bfabe@google.com>
Subject: Re: [syzbot] INFO: rcu detected stall in dummy_timer (4)
From:   syzbot <syzbot+879882be5b42e60d4d98@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+879882be5b42e60d4d98@syzkaller.appspotmail.com

Tested on:

commit:         c1084b6c Merge tag 'soc-fixes-5.19-2' of git://git.ker..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12e3bc00080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f3bf7765b1ebd721
dashboard link: https://syzkaller.appspot.com/bug?extid=879882be5b42e60d4d98
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1159227c080000

Note: testing is done by a robot and is best-effort only.
