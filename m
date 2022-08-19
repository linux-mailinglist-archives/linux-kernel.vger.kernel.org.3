Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCF8599DF5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 17:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349470AbiHSPFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 11:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349407AbiHSPFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 11:05:17 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B3AF4920
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 08:05:16 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id a4-20020a056e0208a400b002e4621942dfso3384173ilt.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 08:05:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=SB1rvUT0GIStyO6xNulBpW7rUFyJLHN3TWI/XnQOCdk=;
        b=CJTwj44LuhJETE3dbVHbGRFUS466i+V9kVag7L9+TzKsQ+TSMB/jgWKyeTY5W3mHwj
         0Ha+I6aQGKOOdwi++LE7tqbfBTxOiyPw29Gex1ezRm98+8A+P3Vbf+DGghQ0dkXg/CyN
         QxLx4ZakiTTyl9XVx4hIDKcPApZEPYhFfH1i1mvvTzHNWc0NEemVdWLkP20XHHJPTh6h
         4uyyug7DNr/hFboIx5+uC28ai95E5JB6vSg4KVGwXF7h3KDI8Njgbc3GCZuwpv1EIzm7
         mFdxqN0/Myu2RSdQJNMRxZvWTtibDrqHHn4T4A9XhR20YlIQTcW7doz3NWuzf09cQfXv
         B9lg==
X-Gm-Message-State: ACgBeo1scncYvK7bCTEB7gi2trnVfclw9oG6Y/ZrGfeWeNLK4pEYWurU
        yrXBElTyVdCmgmOkU3of63lI4L0/8g/ezeAXmirXw5ObBjkh
X-Google-Smtp-Source: AA6agR7782cCe/m6ZcJC2boqbaDxqbt9J9uWSpC4I5dR/DE3NVrHAOrtpmYJl//WpBDotETuTgxAbUImAlhHEzjQkZdTJa+Diydq
MIME-Version: 1.0
X-Received: by 2002:a6b:7412:0:b0:67d:1da6:b498 with SMTP id
 s18-20020a6b7412000000b0067d1da6b498mr3546822iog.14.1660921515285; Fri, 19
 Aug 2022 08:05:15 -0700 (PDT)
Date:   Fri, 19 Aug 2022 08:05:15 -0700
In-Reply-To: <20220819104005.1357-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eb202c05e6996c20@google.com>
Subject: Re: [syzbot] INFO: rcu detected stall in watchdog
From:   syzbot <syzbot+0bab26cf3949891fb534@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+0bab26cf3949891fb534@syzkaller.appspotmail.com

Tested on:

commit:         7ebfc85e Merge tag 'net-6.0-rc1' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=104caf0d080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=924833c12349a8c0
dashboard link: https://syzkaller.appspot.com/bug?extid=0bab26cf3949891fb534
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12cbc6eb080000

Note: testing is done by a robot and is best-effort only.
