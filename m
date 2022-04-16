Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2015033E0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiDPC3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 22:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiDPC3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 22:29:52 -0400
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4004013FBB
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 19:27:22 -0700 (PDT)
Received: by mail-pj1-f72.google.com with SMTP id oo16-20020a17090b1c9000b001c6d21e8c04so3386285pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 19:27:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=8WNW6xnn5WEdwMXXGl1X4Ei9BJ1HBZW0NfGnSnzGVrg=;
        b=btbJ7ghzw/3XQGMvSNPtPHfSHpN5M9Pd6qCnpe1Fs8MmR0wG4uiouTRuhXvSlU9jPR
         DrZbxQaCeLjIQNzAGdiMizOTH25T9L+bZ9ZXEEIMBcfAKUD1dG74sPGTbsuOioGU/397
         gZ8SxvnTV8WSPAWBqwr8Ggp8+UyPlB++ahQ4lGryMVn8x4NQiATC4sG8pGf2s/viCPuw
         PDM5iq1iDlS8ZssJo2MXcGmmHD6rXylRUHSyTEi/f7UEvboPbmb9wEoFroJqLQRl4tEJ
         srcL5xj5ip2trA3XRReTRwOm5BhhT5gY7duGcxmJjlOxaeGzrlgROo+/OQoOQv7AuMwx
         xrYA==
X-Gm-Message-State: AOAM533L8bAbGxRlNJpxXLmLN82t/Mv75uwmh7UDRHTyof5Eg/H1C3yg
        bAHQ9VBooZqY7Ubb0v5U/AjZs7nd86wuxQDQtabwHxrGzRFW
X-Google-Smtp-Source: ABdhPJxU8xVrbxVLJm6ZtxISjYbhf8cF/m4bWgxr8XQeEFHMGolZo6xy3PrzbfX8OsTl4ZoQYrTmnoRjpkblAe5GIYJk2iCrNI6N
MIME-Version: 1.0
X-Received: by 2002:a5e:c00f:0:b0:64c:7199:468e with SMTP id
 u15-20020a5ec00f000000b0064c7199468emr521514iol.161.1650069971675; Fri, 15
 Apr 2022 17:46:11 -0700 (PDT)
Date:   Fri, 15 Apr 2022 17:46:11 -0700
In-Reply-To: <20220415234011.1489-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000842d0b05dcbadae4@google.com>
Subject: Re: [syzbot] possible deadlock in blkcg_deactivate_policy
From:   syzbot <syzbot+b9e4c31d0a1efb34cb03@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+b9e4c31d0a1efb34cb03@syzkaller.appspotmail.com

Tested on:

commit:         b9b4c79e Merge tag 'sound-5.18-rc3' of git://git.kerne..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
kernel config:  https://syzkaller.appspot.com/x/.config?x=eb177500e563582f
dashboard link: https://syzkaller.appspot.com/bug?extid=b9e4c31d0a1efb34cb03
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11b965c0f00000

Note: testing is done by a robot and is best-effort only.
