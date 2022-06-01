Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE0153A026
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 11:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350011AbiFAJQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 05:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346234AbiFAJQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 05:16:25 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD738427FC
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 02:16:24 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id y18-20020a927d12000000b002d3dd2a5d53so74312ilc.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 02:16:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=beK/RyAk6JMkokDhacR9sWsAak3KfcE5cJn8YM9YfXo=;
        b=ADG1BH5IIp1tzwiIiHb1Lmw1T9OrRG5bspUOHfm1OBT0reA403W2u7V2R9WKrcDbwW
         aPmaAs36xsx0bDZ7M08kj1McNh/FnMcWfZkBhyEbG9p2Xxw4TZw0bNZm6v0PYC4LPsjo
         Ub1xmKuhaHxjO3Af3HXtzGyXM+N1SYK6YMOwPPZwe4NT2Mgo0YH1j1fWZY83AOktx6eF
         CBJOlnW13cvtzZXjTt67sW0e3sLSKuHgZPVpDD77e8aP2mkKKxPZfoAtnbeNrFhjH5rM
         YBjGZ2mEXWVSxR2DfXfzEoj4zAgZNoCmlUr2NzT7xbs721o87lFN87rnGKEXpEp60eKy
         w9Iw==
X-Gm-Message-State: AOAM532JAhF8MOp3jI/89GpByW7mtfbkPKrRfip9w7qYslNIKTrmpBln
        e2B74w6XV/lnIjHmxvYfM6LA6KmDbYAjWKo0yxqF1MKkT1Ge
X-Google-Smtp-Source: ABdhPJx1LL8AZ73Jqh9VOj9UlGKgQV+jKWbLhyOzcUBGZ0Dtl7G1jyvg+xSnTxpPRL3nAHlkmb8e7vAr7Vj2Yew8Js/X4rb1woHc
MIME-Version: 1.0
X-Received: by 2002:a02:2124:0:b0:32d:beca:e5ab with SMTP id
 e36-20020a022124000000b0032dbecae5abmr33364107jaa.119.1654074982798; Wed, 01
 Jun 2022 02:16:22 -0700 (PDT)
Date:   Wed, 01 Jun 2022 02:16:22 -0700
In-Reply-To: <000000000000f2b07b05d5dc87cc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c81ea805e05f571c@google.com>
Subject: Re: [syzbot] general protection fault in fscache_free_cookie
From:   syzbot <syzbot+5b129e8586277719bab3@syzkaller.appspotmail.com>
To:     dhowells@redhat.com, linux-cachefs-bounces@redhat.com,
        linux-cachefs-owner@redhat.com, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org, mudongliangabcd@gmail.com,
        syzkaller-bugs@googlegroups.com
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
fscache: fix GPF in fscache_free_cookie
But I can't find it in any tested tree for more than 90 days.
Is it a correct commit? Please update it by replying:
#syz fix: exact-commit-title
Until then the bug is still considered open and
new crashes with the same signature are ignored.
