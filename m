Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8582854E6C1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 18:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237613AbiFPQQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 12:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234913AbiFPQQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:16:08 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D162DAA0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 09:16:08 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id b11-20020a92340b000000b002d3dbbc7b15so1111554ila.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 09:16:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=oWnjpWJQCWY+S/E/agUEvcTBnBsQ+e7DZvG/gt38KI8=;
        b=ugOjNCUZX3mU7GZUD2iUtqjD6rdJMQdx5XZLw98MbbbZi6CwSisP97GTY1mN6fJwau
         AKCr6GA3VJLSeqJSZMdoUGYdHdIFLo5PVm36qRBb5rR1zrMQ2K99rbsyL/oZ6PlERv/z
         8cQ8qztofXgukdewGHQL3hrjoe680/wTxIkQ6D30m5KXVfvUuPPyKeWxzSTB+bNDJPn0
         4k4YN52jNjdKcQuJw0BTJx52H/zmKEqX3AaPeRiLr3c+MoSoBBsDnk8M7f8mP3bn7pcN
         c5yYDrOceOJ2DY1bLNIMJGkueHMFWIT6Kc1YQ/MI/noBG1x4SC1w+ov2deWrzehQoPHB
         lcvg==
X-Gm-Message-State: AJIora/mFs5dnZosjp+U9+MrWqXbRvhqNB+3285s4AlNeiNTBLe9RZsu
        1zvHMYVlMweJPlf4DRCr6/I3FeDQl127ak8reNWsdTuBGtrC
X-Google-Smtp-Source: AGRyM1vV0N/tKLraOOPR9S+/i6TgAicdwoR1XKueqQldhy7cDxNeyKTJUFJfcoezuGLHHorG1+4tYg5Ic9AB1mJ7RCUizi/DHLIY
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:792:b0:2d7:ae5d:e2fd with SMTP id
 q18-20020a056e02079200b002d7ae5de2fdmr3303260ils.315.1655396167642; Thu, 16
 Jun 2022 09:16:07 -0700 (PDT)
Date:   Thu, 16 Jun 2022 09:16:07 -0700
In-Reply-To: <20220616132136.2669-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000088f98505e192f46e@google.com>
Subject: Re: [syzbot] WARNING: ODEBUG bug in route4_destroy
From:   syzbot <syzbot+2e3efb5eb71cb5075ba7@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+2e3efb5eb71cb5075ba7@syzkaller.appspotmail.com

Tested on:

commit:         018ab4fa netfs: fix up netfs_inode_init() docbook comm..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10c31fbff00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f21890d74080ef72
dashboard link: https://syzkaller.appspot.com/bug?extid=2e3efb5eb71cb5075ba7
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1627e7a0080000

Note: testing is done by a robot and is best-effort only.
