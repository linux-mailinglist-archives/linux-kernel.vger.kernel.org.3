Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A511457F2CA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 06:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiGXEBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 00:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiGXEBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 00:01:15 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF54DCE22
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 21:01:13 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id a26-20020a6b661a000000b0067be5b57f45so3195822ioc.16
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 21:01:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=uiSef85sbzNzSxFDZMDAnpVD09PJlwSE8afzRsP7STM=;
        b=6CVQTbuAR3x2qNNQ3bR9agbPEXsfPr7wFJaB2GGHDQFYmlXUL3bJPNybCfMddCdYmB
         pg+dphqc84xK2ICUbxI3h4RWdAGYwaeW04VqQE+hGXB7gPk3i4yWKpOoe0vsoSDplgaD
         wsf7aWDQM2CB02kGXtesPwcwKkKRXsqZT+3dPJdsxCY6jFLwkqJf+GOT/o343z5ee6Ng
         89Zjo/jc7S4DjJzTQnqDUEvrtylLQ1/qUwaWJG5tWlD+ZD9iEq8Ckj6PYohzRcoMzhmx
         GZwqjTkCvuGb9gAf2LCcSIWc7dCbNjw2hrY838f0qKpPzbbLyQkbslqUmbRBnThFITNQ
         k2bQ==
X-Gm-Message-State: AJIora8KDMRmTbnsnKcw+2IoXJyyfydeqF1CsIe2MizDvrUr9baPxclA
        QOTtz+METnu2A+UMoWgcM3RTytIETd016tgaABmxbpRc0x9r
X-Google-Smtp-Source: AGRyM1sh21V80mILNdGD3LAVAthcX5SqWgp9wgMX/KlxJR54IdhfGvmANEJQ9C3dSwog4T63WGs0mjj7FcbetxCPzG4KL4tFH1qb
MIME-Version: 1.0
X-Received: by 2002:a05:6638:d92:b0:341:4d9a:7d52 with SMTP id
 l18-20020a0566380d9200b003414d9a7d52mr2871505jaj.28.1658635273297; Sat, 23
 Jul 2022 21:01:13 -0700 (PDT)
Date:   Sat, 23 Jul 2022 21:01:13 -0700
In-Reply-To: <1822e4b6e21.562f3a5d626157.1197655428248513205@siddh.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000046e89e05e4851ee1@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in post_one_notification
From:   syzbot <syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com>
To:     christophe.jaillet@wanadoo.fr, code@siddh.me, dhowells@redhat.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com

Tested on:

commit:         fa4c07d9 kernel/watch_queue: Make pipe NULL while clea..
git tree:       https://github.com/siddhpant/linux.git post_one_notification
console output: https://syzkaller.appspot.com/x/log.txt?x=17f5cf52080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=95c061eee05f8e15
dashboard link: https://syzkaller.appspot.com/bug?extid=c70d87ac1d001f29a058
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
