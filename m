Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E38599E22
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 17:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349671AbiHSPWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 11:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349657AbiHSPWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 11:22:16 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8408FF235
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 08:22:14 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id a4-20020a056e0208a400b002e4621942dfso3416483ilt.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 08:22:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=uRVtT8QpSN/EYjTquNnKl0o/Oh6F4fnkqC7Jmic6a3M=;
        b=5EpI4bC0W1Jy6BMaHEtnSfTZlIfOmyL8DSFtOhe73P3+Asj7xOW/kOE8XhG6UPYE5k
         ssJyhA4BkuUqiTRLDrJlp9fcBh09jIK67Z3758KX4Y7JvNebA4FQwAv7iI+MF/hZqp55
         /X7L2q+enIhqwp4+BSXg803AZoWhAoEgd/E4nHY6mYT8pM3tatDy9z03TO5JF3EBCI8k
         g63jAXN1HaL2tzSisatXVSUXZ12X1GuTsYLloAoFp2l1B/xS/G/gUnusL4dzFX7mS3Fw
         qokdG/Bwc+7GsUOzC5FSNxtSFMNy/u01HIpsxL6wGA/aWdeHw8A2W3gUrjjudBWWjYub
         3fgg==
X-Gm-Message-State: ACgBeo22DvqcRfLhFJBf5RZn3fiO0oj1NpkikcYVYKFiP/6LLJJcdrzT
        EcNFYv5y5QI/drIb7X41tMEjayRL66KYB0TBUY/YJRlYgqDJ
X-Google-Smtp-Source: AA6agR60UOhUkqbcEHqXSuYVXBWYdvhrMtJdvvHvgEgDepURFjddGRHQoov6tgNCBYpUbprHspeiXRf6FVvktRo1K5BSlc8hQwVT
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1402:b0:346:8903:f54 with SMTP id
 k2-20020a056638140200b0034689030f54mr3593467jad.243.1660922534003; Fri, 19
 Aug 2022 08:22:14 -0700 (PDT)
Date:   Fri, 19 Aug 2022 08:22:13 -0700
In-Reply-To: <20220819105110.1412-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a38cca05e699a9e3@google.com>
Subject: Re: [syzbot] general protection fault in release_udmabuf
From:   syzbot <syzbot+c80e9ef5d8bb45894db0@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+c80e9ef5d8bb45894db0@syzkaller.appspotmail.com

Tested on:

commit:         7ebfc85e Merge tag 'net-6.0-rc1' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15378a47080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=924833c12349a8c0
dashboard link: https://syzkaller.appspot.com/bug?extid=c80e9ef5d8bb45894db0
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14e079e3080000

Note: testing is done by a robot and is best-effort only.
