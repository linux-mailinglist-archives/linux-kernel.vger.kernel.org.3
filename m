Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146A258E08D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 22:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235769AbiHIUC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 16:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346298AbiHIUBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 16:01:09 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F06CF9
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 13:01:08 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id n13-20020a056e02140d00b002dfa5464967so7842726ilo.19
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 13:01:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=lUD5K1OaKXZ+uIyIJbpNGwhrosahtoeyYFURN2v4TZk=;
        b=c8KL63IyP812iYPFxiimwSdkLs/+/5eWnhn3TKjXPVLo5GwtnfC/I99uxZ3iOLfOyk
         LGbY9qflYuIibEvE36/yaVaLHzkV9OIKr954K2O5jwLzstTAG73IsZj8c+6cZkd49oUV
         KRAmxgZd3HTtJMsdktwblaulc4MmowV4eJL34RYWAETIt7F2OKmJdnhUvsxvR0M+wXbG
         ccV2KYcgOVd35vEG8jhWr2nd9x7c4FPbvuvKj6MQ7YqmNXVAb5QqcPF4vV61BtJzOvqA
         wVi5L7f7VvrJ73ei33xwQrD+reTp14f3t7fKTrlNjps4w6SHmbQKHhh+JcwjIujMu1uu
         25tw==
X-Gm-Message-State: ACgBeo30Glz+a0ALs0+BecCm7e/rfnA9cn7srgtyycKoWtpnPzeeSsxE
        CFJmkffiIuCJ3RkeVo78JJo77dIjW517dxBKXdE+ARFxze62
X-Google-Smtp-Source: AA6agR6n58/o7pKgAaqATtwzUJsoBbzrcET1Z/GWo1Rby+nPb4jgIIXcO7lcmAk6ESpnFU5dkYO4p96EPmp30/dWFS9jw2nOlhTg
MIME-Version: 1.0
X-Received: by 2002:a5d:9b99:0:b0:680:360:8703 with SMTP id
 r25-20020a5d9b99000000b0068003608703mr9559963iom.72.1660075268055; Tue, 09
 Aug 2022 13:01:08 -0700 (PDT)
Date:   Tue, 09 Aug 2022 13:01:08 -0700
In-Reply-To: <20220809111035.2393-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a7290705e5d46441@google.com>
Subject: Re: [syzbot] possible deadlock in ext4_bmap
From:   syzbot <syzbot+9543479984ae9e576000@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+9543479984ae9e576000@syzkaller.appspotmail.com

Tested on:

commit:         ca688bff Add linux-next specific files for 20220808
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=147eb8be080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4c20e006003cdecb
dashboard link: https://syzkaller.appspot.com/bug?extid=9543479984ae9e576000
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17ee2476080000

Note: testing is done by a robot and is best-effort only.
