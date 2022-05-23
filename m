Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713255306DA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 02:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbiEWA1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 20:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiEWA1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 20:27:10 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5682F3A0
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 17:27:08 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id b13-20020a92670d000000b002d1a5d6b795so1200009ilc.16
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 17:27:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=6AUZk0FmgHvNN9nGJR2UtaRpnmC+2FUe10fEWzV7zU0=;
        b=uVaJ0h8sPJtJpaWvxLEAetBH5inqFxxPrjXtz6g/NJd6X463RkwLqwRwAgwqRphKQx
         BulwhJ/3YlZ4pFKFmb/ncG+ymp35IB9pXhxr6YKsAIbt+dluDEDnO/gBouWx4ZIA3uv2
         UJ/UnyTvHk3hR9r9kwc9QGHallLxVrw/8lVDksKeujjnr7kC+wbSEMCDck9lwBmwMd8J
         37fX8y5JsMJgxqjOMWcouGfQXto9X0A+Z+wpqSqhfDkNedfbpT5fBbSRyVY/s6Sqf37z
         10EHFmqxNwcodpTxzyBY4KYORewSsx0DKrI6AcdUNzzv0AnjF+apTpv/FBuYKQTs13oL
         TDdA==
X-Gm-Message-State: AOAM530O9UmvuXZ0Cgui7TGwA79ZMqVRzGQ7o9w4FamjauwzBaAi7VRN
        GB/99nm2UOpuKpEGaOtljMrzZjGV2eEcdJh9gmlxp0s/+nZ8
X-Google-Smtp-Source: ABdhPJw84ULVYg6LrnJ0//uRQWKtRtwcmoRfWdqdjr2fWwhEN6IqN5JJ+T9kN30lCVmgxoGo97rMAbICtm/AN21t2F9KnavmAsZZ
MIME-Version: 1.0
X-Received: by 2002:a05:6638:339f:b0:32e:d7d:54bc with SMTP id
 h31-20020a056638339f00b0032e0d7d54bcmr9795391jav.260.1653265627276; Sun, 22
 May 2022 17:27:07 -0700 (PDT)
Date:   Sun, 22 May 2022 17:27:07 -0700
In-Reply-To: <20220523000922.2997-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006ee89505dfa2e633@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in corrupted (4)
From:   syzbot <syzbot+48135e34de22e3a82c99@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+48135e34de22e3a82c99@syzkaller.appspotmail.com

Tested on:

commit:         4b0986a3 Linux 5.18
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=facb2be252153c68
dashboard link: https://syzkaller.appspot.com/bug?extid=48135e34de22e3a82c99
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
