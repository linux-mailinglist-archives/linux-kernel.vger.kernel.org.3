Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B014CC737
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 21:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236358AbiCCUn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 15:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236334AbiCCUnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 15:43:53 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC59EDF496
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 12:43:07 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id y6-20020a929506000000b002beffccab3bso4217519ilh.22
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 12:43:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=lCbnp0c+ARU7aCR1dzzMJYL5adEdTpl2eSYsjAMtki8=;
        b=qSUhWTxG5RHmzZAMyVwJnD+HoSx97E+QMKXedPvIgtraZz4o1qVRC86tFocPpOdwVb
         eMND93ZS13KjO8/dNhHdJry4s+pk+pfUcWkC425Gq/C2x/CvXvGebsXGAbQFvuMd6kKy
         ZgFqoFfrhblkNW9LeeuPItgFCcpo62ukaMrXXCHq267aCLui1vVcpKd3SuyTHRSqaAYk
         50Nl8F07EXj8Hag7r/hrR339HBv8+1p94HBbYnlodH8A4WQw9a0UMusjVdDJpNMeRmxt
         TYsvLTRTc79LwUWJRsIJOpi9iee9Tlyv6PA8pX55NCpMoZ9PR/jHOTWYmdDHsk5Vq1wX
         aLZQ==
X-Gm-Message-State: AOAM533xajYS48a7Yo6s5mkv87F/+5rFkUvaoco9JkMn4SuSlXZiErDE
        yXIEEWOXKn9dMOo98G7TDZMEslq+43A57pTjBN+pRXAyBRn5
X-Google-Smtp-Source: ABdhPJy0TdlkldIFbiSBr/Tp2J55fnwCTVN6aaQG/cQB9mSzw3hRWui/L5X6P7Xev64bFa/YddO8iqEITqPegxNLMKuO4T7RI0yX
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154d:b0:2bc:84c0:b255 with SMTP id
 j13-20020a056e02154d00b002bc84c0b255mr33769254ilu.87.1646340186916; Thu, 03
 Mar 2022 12:43:06 -0800 (PST)
Date:   Thu, 03 Mar 2022 12:43:06 -0800
In-Reply-To: <YiElaWLdXT+m/RJM@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000054cc905d95672fa@google.com>
Subject: Re: [syzbot] WARNING in usbtmc_ioctl/usb_submit_urb
From:   syzbot <syzbot+a48e3d1a875240cab5de@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
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

Reported-and-tested-by: syzbot+a48e3d1a875240cab5de@syzkaller.appspotmail.com

Tested on:

commit:         754e0b0e Linux 5.17-rc4
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ v5.17-rc4
kernel config:  https://syzkaller.appspot.com/x/.config?x=f4cd52967afc7901
dashboard link: https://syzkaller.appspot.com/bug?extid=a48e3d1a875240cab5de
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=140dcc16700000

Note: testing is done by a robot and is best-effort only.
