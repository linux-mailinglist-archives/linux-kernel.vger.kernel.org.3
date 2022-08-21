Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56A559B327
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 12:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbiHUKeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 06:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiHUKeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 06:34:17 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0392219025
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 03:34:17 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id l20-20020a056e02067400b002dfa7256498so6479768ilt.4
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 03:34:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=a4Hwz8ljb6oGrMssC7uVIpYuKmilC5qrCNAPlVvxhVU=;
        b=tmg/c7P0nIjcK3F9ywHZ1WI89GGDcAsCWX28/VkV/MtsUL/VEnIOBwGgJRowvDjA8J
         37JHWcWnI87iMliKVnBq0lkHwUbyLXGpxnfs6owDWkf5CHgy4rZV5Q4kSSEZhYm3BCaw
         7ID89/rvXQTRuMz26+IOXzwxlU3yK2t3VT9XK/5CfRq0PrJ3qyFdB8c3EOxsNPPI3QUK
         65eNFFH9FAwM65pzpATxPB9EtKcFl+0EkOf252QE15Zj3pEXDiQ5qe7eOjV1PuKmSZLN
         SjSFrWPLi9F9FD4NGN3OHikXa4XWc9cIY5Ps1g6DjEjKRqi3uusuadG04FhPI7YTCgg3
         Xtpw==
X-Gm-Message-State: ACgBeo1lopDwGmLt8dYHavuy9eEv6YE5QNU4H5UyEXE2Kn0PeJ/vIeDO
        N6Mys4T2vPcB6SIpqLWAQGzQQYQ/9Yr9E2WlGad3nVzG9rh4
X-Google-Smtp-Source: AA6agR5NWDAccdDB8AA3BAyTooLTSMJQwOchkoXU8SeEM+fsi6JSWGEuzUlnrfLT8VVAPDS+0SiWWIkQfElwif6dzCnpanmJIeLW
MIME-Version: 1.0
X-Received: by 2002:a5e:8f09:0:b0:688:6150:55b2 with SMTP id
 c9-20020a5e8f09000000b00688615055b2mr6450063iok.83.1661078056373; Sun, 21 Aug
 2022 03:34:16 -0700 (PDT)
Date:   Sun, 21 Aug 2022 03:34:16 -0700
In-Reply-To: <20220821023626.1810-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007e932105e6bddf95@google.com>
Subject: Re: [syzbot] possible deadlock in jbd2_journal_lock_updates
From:   syzbot <syzbot+79e6bbabf3ce17357969@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+79e6bbabf3ce17357969@syzkaller.appspotmail.com

Tested on:

commit:         ca688bff Add linux-next specific files for 20220808
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16cbacad080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4c20e006003cdecb
dashboard link: https://syzkaller.appspot.com/bug?extid=79e6bbabf3ce17357969
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=145dc1f3080000

Note: testing is done by a robot and is best-effort only.
