Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76844E2248
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 09:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345317AbiCUIfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 04:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345329AbiCUIfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 04:35:39 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0CA54BD0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 01:34:06 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id z15-20020a92d6cf000000b002c811796c23so1490242ilp.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 01:34:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=cV92yiiOpOi4XT7qrWpuZxHTA42G2oLn7srnjUjjDSM=;
        b=euB5a2NSQb6f+8oPUvJjJi0PiaOxmb/r14Uoa2b4X3UTA3j0kc1FMmEG13GDdMhRKJ
         /ax7dFCES4RxdPKis6egdeKy5ZTg/eeVcLD02iHT7im3RPo1OF1/ypHeftM7L36U6QLx
         pInAAjHqFl5rMaWCXFx7FVpojlTyVXYsU3J3VqHASnI9NUTPeahf/fn/nGZrHW2t1ua/
         DQmWfGwGCIJ1Vlo+VsDX97/pFlziRF2lJWrQwKiIUHmu2Eo3wmJAtf55G3xfxFiMNXCg
         L63qmoJpT9kE1PSc6jFMWKdHWoV+pi9u3enhOInnAji/YuQlug0POJ75tJcnux3T48uB
         xSLA==
X-Gm-Message-State: AOAM532XLSjC3DAFiZYHIzGsmtN4l4CIOuKlM6TnHnTR3iyGs/wEll2n
        ocYRB1iwaj2RQ1xm7XVJjDYLwTHOWAxzwAkI5/oPg/9xn/qL
X-Google-Smtp-Source: ABdhPJx/I+SN91HOqy6wd+4qsVMV8PSbYg0Go7U1nPFj6qO5Ehngnm7BInSwqZc7LGr/EqmFlQ4cEDDjS7XTgx9+PZ52zVRQG8EU
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3051:b0:317:8a78:7be5 with SMTP id
 u17-20020a056638305100b003178a787be5mr9895967jak.142.1647851645964; Mon, 21
 Mar 2022 01:34:05 -0700 (PDT)
Date:   Mon, 21 Mar 2022 01:34:05 -0700
In-Reply-To: <970502.1647851062@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000015ed05dab65cac@google.com>
Subject: Re: [syzbot] KASAN: null-ptr-deref Read in __free_pages
From:   syzbot <syzbot+d55757faa9b80590767b@syzkaller.appspotmail.com>
To:     christophe.jaillet@wanadoo.fr, dhowells@redhat.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

Reported-and-tested-by: syzbot+d55757faa9b80590767b@syzkaller.appspotmail.com

Tested on:

commit:         6d39b096 watch_queue: Fix NULL dereference in error cl..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=19ca6f72fd444749
dashboard link: https://syzkaller.appspot.com/bug?extid=d55757faa9b80590767b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
