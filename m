Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D20714849E0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 22:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbiADVaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 16:30:11 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:53887 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbiADVaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 16:30:08 -0500
Received: by mail-il1-f197.google.com with SMTP id x8-20020a92dc48000000b002b2abc6e1cbso20324231ilq.20
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 13:30:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=e6I0sXk0inEAmUtslAEVQcGILPxuytb3N8HHWOakOdw=;
        b=sPIdxIi/F47ZA3ihetOxybZqxoXU41/+nTwtQoTyRoWsVpxKYkPSYXqn3qDHPrg7+9
         bH/31d4I2sLnTuWg1T89NlP67YZiU7HEuFsbdN5SjtwhIAcmZOQaLFem0tsmdzMbh1fV
         pnW0goEdZVHCCi2iwIgsbjRmikUmoEZVEYu2YPlsRwUv2wIejWeppdSTSRX95kkJpvwF
         4qC70k1flNvSWP7DIzX91pBzhR7BqbphpdQYkEeNsdAGXsuqrpqIgG6ChabLnOWHCwDh
         IqwdldTPAxakIbB9pXWxYWAmXFjbG38ODOEmNBAGrjHdh/QfaDfoFHo+RWnFS9Yj+/t5
         a9GA==
X-Gm-Message-State: AOAM533o6H2lJsm1u6AnPz5gkj9yPCEB9/pIhXhdvhS3DsrJTcm3teeI
        /Yl3kZFbfNxgmAlgOtftLBFSYezBvbb1qVXw4nbKu5OAmbv9
X-Google-Smtp-Source: ABdhPJxHxHS62rmxnySIB7LL5Hkxm0+ir1wzDfJwCxZ28ZsFukFgZ860i+kkpdeJ7KV3ozFNrZMdmc6jxoOkzia9Rlykuj55yTwN
MIME-Version: 1.0
X-Received: by 2002:a02:b603:: with SMTP id h3mr24957080jam.233.1641331808274;
 Tue, 04 Jan 2022 13:30:08 -0800 (PST)
Date:   Tue, 04 Jan 2022 13:30:08 -0800
In-Reply-To: <61d4b9354cf9b_4679220874@john.notmuch>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000064109905d4c8577b@google.com>
Subject: Re: [syzbot] KASAN: vmalloc-out-of-bounds Read in bpf_prog_put
From:   syzbot <syzbot+bb73e71cf4b8fd376a4f@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, hawk@kernel.org,
        jakub@cloudflare.com, john.fastabend@gmail.com, kafai@fb.com,
        kpsingh@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
        lmb@cloudflare.com, netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+bb73e71cf4b8fd376a4f@syzkaller.appspotmail.com

Tested on:

commit:         e63a0234 Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       bpf-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=29c60dfdc879c48e
dashboard link: https://syzkaller.appspot.com/bug?extid=bb73e71cf4b8fd376a4f
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13c1d0adb00000

Note: testing is done by a robot and is best-effort only.
