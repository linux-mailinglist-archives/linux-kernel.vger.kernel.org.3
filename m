Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E5759B65B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 22:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbiHUUnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 16:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbiHUUnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 16:43:15 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51432E31
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 13:43:14 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id l20-20020a056e02067400b002dfa7256498so7150887ilt.4
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 13:43:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=prnWCsQK2iq59RvJlWzlIX9I4tLStK8xjndJHPnltC0=;
        b=JqHbVw/FWv4PbeNPVI3+TAjuqvPbDzQzM9iZzHuzZ/8jGUgVj2AyMTEjPj4Tfx7NUO
         UhGlngE27O4AWcpFAte2SYpaiprInsAVilAhSk/CoAZVVi8sVX0uhUbDiQy/kKwrSON3
         1gEKwukTWwZTW0T7HEQB9ioJK8ZCet1N5k0VJvc1s0++v7CySklLj75LQBVWsS5zmsBr
         awbJ3kldMcoeirW3FIWKxH/p/LsxwVP2Vk9H7eTl7oooSdTeVFWku5d0bCE59wDhJFux
         M0fcGrmgBxGTsRq/MlzRLcGBMLRhGXgJZNRC3YQmOSsc7CX9bUjL8l9u4d6JGMzBf5p1
         iX3g==
X-Gm-Message-State: ACgBeo0oXJJXBw3qAPf7rz83lx1Y2bZaiwQNGca41PH0Fk809AzZgelp
        yglMGkDn8HyWrTBZsseBT9oLwlara+DowqWavV1GrGmLyok2
X-Google-Smtp-Source: AA6agR4L80pmj6+V2bj8hPc8sySDrS/nfRxzadzyfAOwSE7cmYPGaaaytURLD0VsaMlz5zGKY7O5Z8ezswrjMFIUI2lGekh7syfi
MIME-Version: 1.0
X-Received: by 2002:a05:6638:d05:b0:349:de28:679f with SMTP id
 q5-20020a0566380d0500b00349de28679fmr405866jaj.169.1661114593735; Sun, 21 Aug
 2022 13:43:13 -0700 (PDT)
Date:   Sun, 21 Aug 2022 13:43:13 -0700
In-Reply-To: <20220821113138.1991-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004a7d4005e6c661d7@google.com>
Subject: Re: [syzbot] possible deadlock in kcm_ioctl
From:   syzbot <syzbot+e696806ef96cdd2d87cd@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+e696806ef96cdd2d87cd@syzkaller.appspotmail.com

Tested on:

commit:         95d10484 Add linux-next specific files for 20220817
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16cc63d3080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2f5fa747986be53a
dashboard link: https://syzkaller.appspot.com/bug?extid=e696806ef96cdd2d87cd
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16cac9cb080000

Note: testing is done by a robot and is best-effort only.
