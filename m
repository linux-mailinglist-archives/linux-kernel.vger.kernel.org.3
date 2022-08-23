Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3549A59EA1B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiHWRmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234176AbiHWRlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:41:00 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADC6AC25C
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 08:38:16 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id o9-20020a056e0214c900b002dc29c288bfso10692606ilk.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 08:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=jj+DJXwrsYlSJItXjtgoHdex4lZY6RIyfIJzSWY+0OA=;
        b=6oORCh0GJcO61uEvcCtsjPR8yl1NSPf4OYHOfS8957KG/GCbWcpKgrtLCQsWcBg0N1
         JexL5HiHuyY4CGj3IYkgYb4WrJmofVMMbmOLhozGL5T5mD7Ukz6UvSYxLWJjYRx6JCKG
         pz5/tTenlEB8zYxzcJWxbzMHP3dk4xaDTIm8qk/cXWDfUyhOH81NzTuDTCNDD1ZtVDM9
         tfldrMl9hCkq0zqKsxXbwhuDgcG7koRWY35g78Vbrw5DtqjDMSf1K1paDHVoTF2lHKDY
         +VVeR8KSW+rQYAg8DfoV0h4Pg4lZvjbnoqco6z76x436OFLQWzbeRaRt9Y+QYlGD+FpC
         LkRw==
X-Gm-Message-State: ACgBeo2LFwklucVOnzANlAx5F6/Lo42DA1aBUbvOOMALvJmKZKTYXPI7
        UjsWbfLVxMa+grJxqeZGXSnZRbOVec/jEjAs0g151lN/xhd8
X-Google-Smtp-Source: AA6agR6E5kQeZsO1i1vYztRzxIpze53XHYtfM9V0vZY1WanZlXP3pyvAqhiEdhMjqZJTJnrTzmbfrJBk/YwRG3atOe+jou2IskV/
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c07:b0:2e9:221e:9c77 with SMTP id
 l7-20020a056e021c0700b002e9221e9c77mr98428ilh.176.1661269095633; Tue, 23 Aug
 2022 08:38:15 -0700 (PDT)
Date:   Tue, 23 Aug 2022 08:38:15 -0700
In-Reply-To: <20220823152101.165538-1-code@siddh.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000525beb05e6ea5aeb@google.com>
Subject: Re: [syzbot] WARNING in iomap_iter
From:   syzbot <syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com>
To:     code@siddh.me, david@fromorbit.com, djwong@kernel.org,
        fgheet255t@gmail.com, hch@infradead.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        riteshh@linux.ibm.com, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com

Tested on:

commit:         072e5135 Merge tag 'nfs-for-5.20-2' of git://git.linux..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=120a311d080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3f885f57a0f25c38
dashboard link: https://syzkaller.appspot.com/bug?extid=a8e049cd3abd342936b6
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=169d8e5b080000

Note: testing is done by a robot and is best-effort only.
