Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0E7563605
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 16:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbiGAOnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 10:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbiGAOmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 10:42:52 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4743B02F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 07:42:09 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id k10-20020a056e021a8a00b002dacb91b6ebso1316108ilv.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 07:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=FEqrsxktskGLC6Y2f5tNmNMN9el6VXi0VNJpvJnw5Ps=;
        b=ip4vi/WoZhQNHzHNTC0CNlKSn784hL3CeU3kqR2oAbd2wc31pZnD3dvZGpcm3JUP+w
         /6ltgv2bHPHlcF1zU6G39bkGMYWwAIjU2iSEYSIv4VtP2fk8sBMKVpNljoXSCToSS4a+
         JFwoptJN5PkC4QFDNSGzMbxGEe367DslqBowjoUwNUR4p0EQ65x7B2kOtcxPTtRQuCax
         JU03Jk9Vl1eMN3WJ0O9gU1XgXyBE/ZLvQFCWFdeAEM0r9wj6rSTSXEc54ec9OBPm9tiV
         d2h77lCL8JSVLVALWbf4wUqyEaTRnx3h0zLOMw7biNbEp2aYC282xrz3/0cQRt4MrZJO
         DKzg==
X-Gm-Message-State: AJIora9LPUJwyO1QlCtHc1HKFe5iuM5qe67nsMW4lLmt9Fk93jcutIBt
        kozsrtfov+T/hOgaKMMxsibNa4v6Tc0yAeIY2dO2iPzIWAru
X-Google-Smtp-Source: AGRyM1vp1F+nBnMUcpFZoSL8KRsC2g7ciX+UeeZyoYlqUUenher2n5QjjgDp9anloGpuhV/5D/0nYMI5cqHwXsJlMWTV+WAoKKJn
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2191:b0:33e:9c94:69ed with SMTP id
 s17-20020a056638219100b0033e9c9469edmr2402866jaj.80.1656686529226; Fri, 01
 Jul 2022 07:42:09 -0700 (PDT)
Date:   Fri, 01 Jul 2022 07:42:09 -0700
In-Reply-To: <20220701071434.1226-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000142f6305e2bf64fd@google.com>
Subject: Re: [syzbot] WARNING in sk_stream_kill_queues (8)
From:   syzbot <syzbot+a0e6f8738b58f7654417@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+a0e6f8738b58f7654417@syzkaller.appspotmail.com

Tested on:

commit:         aab35c3d Add linux-next specific files for 20220627
git tree:       http://kernel.source.codeaurora.cn/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10deb7e0080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6a874f114a1e4a6b
dashboard link: https://syzkaller.appspot.com/bug?extid=a0e6f8738b58f7654417
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1450de24080000

Note: testing is done by a robot and is best-effort only.
