Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A492B52D222
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 14:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237708AbiESMLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 08:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237711AbiESMLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 08:11:12 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94630F43
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 05:11:08 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id k7-20020a92c247000000b002d1515398cfso2886761ilo.19
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 05:11:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=FjGU4Gpefvz5yhdYVCK75yk5wKDjHVj74Cx0nLOOa9c=;
        b=df5c5FInrIi5yTlF4TK9mttWgZBULo5vFPGYDbFI5NGGrbWsIlYwenuKMqDE6J6TGd
         xInYXuBprLWExsUnN0vSGRaeBrBK60RcBNfImnjRULzQg24KE5iFod9rItvG3WwpuPbw
         XflnLRrgL3GG6xwiBD3kafzXqh6FHYB0iUlcjAfGHiRkcEXakRahF8lY79UhMzToHasf
         I++gRwS3aE4bAMFZPpqZ0JkJujhnq9DydHVZBacRUWMuh3fEUO5//VQOXUl0saC44ZaL
         i6FcJOUOhzuDc3PeXExGSiUM6UcqdnCkQQdefTgeoHgZU6H0VkJFdS1oIIzExh+PZ4Lq
         YW8w==
X-Gm-Message-State: AOAM5321HtoRHcZzDP1yG5B46VbnBflsHUnx8WgqQRbO2a6qOISWm5HL
        zZK/zHaqk1QB9o3z8YvfHg2Idar9pNuNBHQ0xZ+9caLxMjDg
X-Google-Smtp-Source: ABdhPJxylCdyNDgh6PAdw+Y6eDtteQFN0wAD5KeZFzk/JyD6ou8r03lQqOAL7crHRYTQAQC24WXve6JFwCMAD0pHpsAzz5Eypkig
MIME-Version: 1.0
X-Received: by 2002:a5e:d807:0:b0:65e:892:e0a3 with SMTP id
 l7-20020a5ed807000000b0065e0892e0a3mr2286594iok.214.1652962267899; Thu, 19
 May 2022 05:11:07 -0700 (PDT)
Date:   Thu, 19 May 2022 05:11:07 -0700
In-Reply-To: <20220519115146.2526-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ce317005df5c44f2@google.com>
Subject: Re: [syzbot] possible deadlock in rds_wake_sk_sleep (4)
From:   syzbot <syzbot+dcd73ff9291e6d34b3ab@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+dcd73ff9291e6d34b3ab@syzkaller.appspotmail.com

Tested on:

commit:         1e1b28b9 Add linux-next specific files for 20220513
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/
kernel config:  https://syzkaller.appspot.com/x/.config?x=c31703627c33e76e
dashboard link: https://syzkaller.appspot.com/bug?extid=dcd73ff9291e6d34b3ab
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10bcfcd9f00000

Note: testing is done by a robot and is best-effort only.
