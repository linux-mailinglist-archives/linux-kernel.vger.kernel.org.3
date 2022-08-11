Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E633B58FD56
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 15:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235496AbiHKNYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 09:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234066AbiHKNYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 09:24:10 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE70816A5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 06:24:10 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id u5-20020a6b4905000000b00681e48dbd92so9716989iob.21
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 06:24:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=Tz3EySJ3G4jRxpLoZxF4SZXo5koC2ppG85L8I0jq3G4=;
        b=BeW4UG3gz9TmSnZ4cyJX+ar5RmyXR33hfjwCTn5ChkIQ8pNNJGaxNdn1h7Na8+XZcP
         T7tefsGzJhrdx6uvImJhzwHpEGgSy0X8pEEy6RN7KNCjwLmObzpPVFJ2M8YmJ041XB2g
         YEfVIn0snVg6a4sMZe4TYWZgX1hyZw5haS4KryMSCihxikt4qXh2+Y0eaKGLYNFhUvgX
         ExEezNX+uE/jEaOaVJ3Gu5eSXPTAxEMFYZc+QJ0F47ZIQtXGMcaG5bxLyX5HoSd6OzQD
         GL5cNrN8fILsmjx8lbiqbHAdYME0TpPeQzq3abm6oc4uKZrBTfI5YXCWYIPaQFkKBvQa
         K05Q==
X-Gm-Message-State: ACgBeo3gdyNIOyd9+clJB1efsN/yQCqczPGCYgVwLQr19rNeKpD0YetR
        ZptB0oxgjQr5lkfape1t5vZOCydl6mTWdCXlGF2gXc+6/d9w
X-Google-Smtp-Source: AA6agR4PDNFIDZLUnFtMh84ZcSt77qOF1CqKiM3wLwJu8aFeKZT5JwMjvuUcAAP5JcTadc3KZp6KSptfobmmcywosSmL5Q/fzrXJ
MIME-Version: 1.0
X-Received: by 2002:a05:6602:13c8:b0:669:c3de:776f with SMTP id
 o8-20020a05660213c800b00669c3de776fmr12529611iov.124.1660224249853; Thu, 11
 Aug 2022 06:24:09 -0700 (PDT)
Date:   Thu, 11 Aug 2022 06:24:09 -0700
In-Reply-To: <20220811103620.2807-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a9029805e5f71478@google.com>
Subject: Re: [syzbot] INFO: task hung in __generic_file_fsync (3)
From:   syzbot <syzbot+ed920a72fd23eb735158@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+ed920a72fd23eb735158@syzkaller.appspotmail.com

Tested on:

commit:         200e340f Merge tag 'pull-work.dcache' of git://git.ker..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16422f53080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a3f4d6985d3164cd
dashboard link: https://syzkaller.appspot.com/bug?extid=ed920a72fd23eb735158
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16273ac3080000

Note: testing is done by a robot and is best-effort only.
