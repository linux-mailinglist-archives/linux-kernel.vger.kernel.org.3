Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE975761DC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 14:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbiGOMiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 08:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiGOMiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 08:38:16 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1319A67C8D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 05:38:14 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id f18-20020a5d8592000000b0067289239d1dso2237231ioj.22
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 05:38:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=khqFBmqEAHpFQYuBHi2SX2CNm508COBBJmlEOAearDE=;
        b=WWeXnmEnD2kkDTGpV8iA1E12bIh/T8pnuJHfrmZFYnSWyIV7fFSOMwjdAbM1WYr/CZ
         DqBGbbtDuaaRR+T4uGrRRHIeN9II7Z9B4YKaWW4tVOvaze3SQGeCaBxKVqP5u1dqzfYD
         cD3c+pkXf5TrHZy6dioOSCngXH1zHvQCU3W4fAV2/3iw/wGfgMXARpDwMZOFwEQobsw9
         Gnb5aMHyptHkk3dU1t9/Hlw99I5Wn32mfOwvUDGKTPCZqA7Z39raO2t/i5sqbosAsg09
         73WK4jMwdOko6E1sBLkXzzYCP37Q41jVhCBaoZrhZdtKQxMoxF3vO+Iaf71YsJv0Tzkd
         b06g==
X-Gm-Message-State: AJIora+yhV2qsvjh3B5RjPFS80EKl4HSBqQYf4bHtu+DeWzXA79ieikA
        SE39FG8xr1M+VSuchPy1WmrMuHSSIVr2aZofrWTYIKv9+r80
X-Google-Smtp-Source: AGRyM1vpALlJYAKsFuwrOOMlAw93sK4RYZc2yAWyVJUE5+u/4Zs8G9SXXqCsgljQ0lvleWjkr6NGKF/IvavSVbXUm8orvQWjjgEE
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2f03:b0:678:9c7c:97a5 with SMTP id
 q3-20020a0566022f0300b006789c7c97a5mr6910075iow.32.1657888693448; Fri, 15 Jul
 2022 05:38:13 -0700 (PDT)
Date:   Fri, 15 Jul 2022 05:38:13 -0700
In-Reply-To: <20220715122619.1231-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a6758405e3d74a5a@google.com>
Subject: Re: [syzbot] INFO: trying to register non-static key in ieee80211_do_stop
From:   syzbot <syzbot+eceab52db7c4b961e9d6@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
SYZFATAL: executor failed NUM times: failed to create temp dir: mkdir ./syzkaller-testdir3ADDR: read-only file system

2022/07/15 12:37:03 SYZFATAL: executor failed 11 times: failed to create temp dir: mkdir ./syzkaller-testdir3040842611: read-only file system


Tested on:

commit:         b11e5f6a net: sunhme: output link status with a single..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=159f23b4080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa95f12403a2e0d2
dashboard link: https://syzkaller.appspot.com/bug?extid=eceab52db7c4b961e9d6
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12cc29b4080000

