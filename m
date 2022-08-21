Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C633D59B669
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 23:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbiHUVRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 17:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiHUVRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 17:17:19 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995FB12A99
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 14:17:18 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id k9-20020a056e021a8900b002e5bd940e96so7141007ilv.13
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 14:17:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=F//joGg1aI9i66rMvqGljQWFh667OVDtGhtvzcMWkUQ=;
        b=cdCgWdwtfX352CZGu3wl/Wdz6HfSscUWx7yDajELNRs1mE2U7UYLmOe4ki6axdmryC
         a2/8W8hKoprXtoXNJY88pXaevaigUTRPVdlKu/C/VIvceKn0lGqkWcmzhaPAslQohheW
         4RzwEx2m0jv7V2h8Ynmsv2ZpvDyQAC5425VwaDi78OU2CDTyMpVlu673MSRRvSy9//dI
         SeBJYEKKu2qlReaY5w6Tf65wZN62DtZtKmBdZxUgwLowR4h9JGRcsmkKyDIPqwr6Y14M
         RrIt8tiP3oNr9TPQSs1cRETIX0AcELVhMowq6lBAg16AVVNLNlzd1tDqHUNauLzVlN+7
         bE8w==
X-Gm-Message-State: ACgBeo1L/Qe3yFRySki3iNlC7Wndl0u8ohCLicNbKpstJJtj5AvDCuWA
        a9kh+J+rxNVdsKGfw4Z3m5k6HRsvcHLLEVfaKsxmhz6pfFvx
X-Google-Smtp-Source: AA6agR5VPm04BxzCxEy5FUDpyIwy9L86V15RVRoVFfo06bVzEuEb6e00mJJQWerFzdbAB1t9i0VlxZW56U5hZNDQ+oEM5CkXFk0u
MIME-Version: 1.0
X-Received: by 2002:a05:6638:210d:b0:343:17cb:60a7 with SMTP id
 n13-20020a056638210d00b0034317cb60a7mr7938667jaj.292.1661116637922; Sun, 21
 Aug 2022 14:17:17 -0700 (PDT)
Date:   Sun, 21 Aug 2022 14:17:17 -0700
In-Reply-To: <20220821121435.2055-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000224cdc05e6c6dbe0@google.com>
Subject: Re: [syzbot] general protection fault in binder_alloc_print_pages
From:   syzbot <syzbot+a75ebe0452711c9e56d9@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+a75ebe0452711c9e56d9@syzkaller.appspotmail.com

Tested on:

commit:         95d10484 Add linux-next specific files for 20220817
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15570865080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2f5fa747986be53a
dashboard link: https://syzkaller.appspot.com/bug?extid=a75ebe0452711c9e56d9
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=153db6eb080000

Note: testing is done by a robot and is best-effort only.
