Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA8D536E67
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 22:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiE1UkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 16:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiE1UkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 16:40:20 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA445AA5A
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 13:40:17 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id x13-20020a0566022c4d00b0065491fa5614so4428560iov.9
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 13:40:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=bS6+g7fgBiFwD1ekT/9uQrMvAnNI5lC4ABT63K0ShAw=;
        b=yjE+v17WlBKTD3NhuAXp6hv6qzi0e0jv8z5QjVyDwUcE6NlLo9CNaBjTgzpa36aW7S
         MbJuDUkueOxPq+XrPoBG3QHU44gALvAXgadQSmkhn2HHWPh8v3d8y93Mj9Py5Xad//F1
         7JYsBTfzqQ2SIF33uMY0KwBG9+710pQ0Kw51xcLTwq1YwiDTQB1uMAavw2MnR3f40d5u
         AElEQv6LnYI4q8dqvGTdiC5iVt/IBJfv5yy6MMKh9WbvApe5/swfB65L6qENS1Ljh0DZ
         iCCXNLlekJlsKHacuOH1hOvBEOFBC5WOEPmN2JHKpRIfiD+qyFjp0L7WTBtiNM239QY7
         djWg==
X-Gm-Message-State: AOAM530btldXNIeHX3VgnXz4A1P2amMfWFKBB9wmUYuKBmDQ/GMlZ3E7
        YiKmKwCyxo9C4K09UYk366xefyjh9NurgRpUOIEPJ5PVi6bd
X-Google-Smtp-Source: ABdhPJx+nYBaU8bsqJqVCu9UPQAsPEejq1TMd4ejR6FWyB+2XbrCSX8ah/4visCPxVeFhXXQ0rkVkpoKInc5YTZIuj8KYuf/VAmw
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2513:b0:32e:5298:8264 with SMTP id
 v19-20020a056638251300b0032e52988264mr25780252jat.178.1653770417161; Sat, 28
 May 2022 13:40:17 -0700 (PDT)
Date:   Sat, 28 May 2022 13:40:17 -0700
In-Reply-To: <YpKEoBORZLtXG/y9@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000414e8805e0186e9d@google.com>
Subject: Re: [syzbot] WARNING in driver_unregister
From:   syzbot <syzbot+02b16343704b3af1667e@syzkaller.appspotmail.com>
To:     andreyknvl@gmail.com, gregkh@linuxfoundation.org,
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

Reported-and-tested-by: syzbot+02b16343704b3af1667e@syzkaller.appspotmail.com

Tested on:

commit:         97fa5887 USB: new quirk for Dell Gen 2 devices
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=d7b232ec3adf5c8d
dashboard link: https://syzkaller.appspot.com/bug?extid=02b16343704b3af1667e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=103c91e3f00000

Note: testing is done by a robot and is best-effort only.
