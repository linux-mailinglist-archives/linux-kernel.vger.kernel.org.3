Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E0E565165
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbiGDJyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbiGDJyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:54:17 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB966DEC4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 02:54:14 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id f18-20020a056e020c7200b002d949d97ed9so3942646ilj.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 02:54:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=sVvRetvU66viZg03zt42J481swUWQOVgkFgrLPfYY/8=;
        b=5l7NfdVElle49DmkWlAIZ30THv/zEiBPD7v+ZyFkEZMsOXLgMolnH0nCzBbH0wU0Wu
         3sFX00z/pMcRPJFqESN6jC/cXAVdOr4jU9Ev3drwQZq3ktSHSce5FA2ELg05w4gPKF4O
         Svi2cogF0WE/ud730N4xJXKKNT+HN6S4r6aXC3f34a8tAvdnLiK3P4Yw+SA2akf2MpEc
         LQ+7iuN+PVeE+PlBsd0ZRLCynl7Fl9yFo/7t0qYAqFOZ3ryPeGXANpXj8D+p+wFXdyRR
         pO89sLCGCgdp2s3ERa+sv+bY4E8EB1jsJXBiTgC25kmmmtWgabtwefu+F5cOjwxGGhmn
         /2JA==
X-Gm-Message-State: AJIora/+Zh/6Mnd4fWO5Eej0SYFrIVY6kLsi/9b56XPYTGj8KfF9+1Fi
        24tD1+twbf17In47D5V+CrpBaxeY9iCmEj1FfSn1KuKceJ8P
X-Google-Smtp-Source: AGRyM1uVAx2t8fSOR2KLN2tAOPiUaRp3izLzYWRdEEBPt99xhRwEmPj9yiT6KWURtcER3vu/Lsr21nC1ku8Hk8QVAofPc1lwnppx
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3689:b0:675:49c2:504e with SMTP id
 bf9-20020a056602368900b0067549c2504emr15029553iob.201.1656928454096; Mon, 04
 Jul 2022 02:54:14 -0700 (PDT)
Date:   Mon, 04 Jul 2022 02:54:14 -0700
In-Reply-To: <000000000000b960c00594598949@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ecc7e905e2f7b764@google.com>
Subject: Re: KASAN: use-after-free Read in tc_chain_fill_node
From:   syzbot <syzbot+5f229e48cccc804062c0@syzkaller.appspotmail.com>
To:     davem@davemloft.net, gregkh@linuxfoundation.org, jiri@mellanox.com,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        stable-commits@vger.kernel.org, stable@vger.kernel.org,
        syzkaller-lts-bugs@googlegroups.com, vladbu@mellanox.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bug is marked as fixed by commit:
net: core: netlink: add helper refcount dec and lock function
net: sched: add helper function to take reference to Qdisc
net: sched: extend Qdisc with rcu
net: sched: rename qdisc_destroy() to qdisc_put()
net: sched: use Qdisc rcu API instead of relying on rtnl lock
But I can't find it in any tested tree for more than 90 days.
Is it a correct commit? Please update it by replying:
#syz fix: exact-commit-title
Until then the bug is still considered open and
new crashes with the same signature are ignored.
