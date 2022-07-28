Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F7C58438D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 17:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbiG1PuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 11:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiG1PuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 11:50:10 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95A92642
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 08:50:09 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id k11-20020a92c24b000000b002dd46b47e01so1397037ilo.14
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 08:50:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=h9dKTPCnNry06qps4eymbd89NnvSJWefjx7WIqIa/x4=;
        b=PJW/bxUDy1a/6KIvj3dBM6UQ5m1UUz1Dp2q4Bab2aBJe+UhfGk+YhbgzOGd5j+S5OX
         K21qlIm0Iu2IMnwOdfR8lmvukmICOB/DfbbzOu5HmPI4Rs0NMKvvtyfrK9GSE/NrUi1g
         6qy4BxKx6xXXFOZZP+iXxx+o5v9g6KgPxh/xFLt4phjaW8koS7rjluDZUoY9JBT5cL2g
         8uGz+qnmhDBIVE2D+Opf1sCZ5BaXMn3/GxFsQ9OdgX6lXT6Fe7oAFuk45o7r7khFdRrq
         PhAmsJox3erFhmYF3cjs7QTwgwvdVAtEIyVZXODTCuKsHvnsTEEgybj7Az+3GZsRanEq
         ri0Q==
X-Gm-Message-State: AJIora9l+quwDuWxTwxy6WIz608/MqNRcCRY5ANc91CRO8wmOAvWddZ6
        GW+LJt5Zl7IE/dlqZBovl4CaCmy8AXgRFDBwxxC0WqU2Ofng
X-Google-Smtp-Source: AGRyM1sxc8Mt8MIzkh7Woic2/J2uzAfzsfdWw6ekwztoCwEAMIwi1HQogRQ9b8JBFGmR+aubHnysr5+saF4eDdmjVlNmy2aipFJv
MIME-Version: 1.0
X-Received: by 2002:a02:c9c4:0:b0:33f:4f44:11bd with SMTP id
 c4-20020a02c9c4000000b0033f4f4411bdmr10905577jap.240.1659023409218; Thu, 28
 Jul 2022 08:50:09 -0700 (PDT)
Date:   Thu, 28 Jul 2022 08:50:09 -0700
In-Reply-To: <182456e25c7.cd7fb4c79569.3198675383666226894@siddh.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fb0ea205e4df7c67@google.com>
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

commit:         16007670 kernel/watch_queue: Make pipe NULL while clea..
git tree:       https://github.com/siddhpant/linux.git post_one_notification
console output: https://syzkaller.appspot.com/x/log.txt?x=11a6eade080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=95c061eee05f8e15
dashboard link: https://syzkaller.appspot.com/bug?extid=c70d87ac1d001f29a058
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
