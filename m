Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3022758E97A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 11:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbiHJJVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 05:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbiHJJVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 05:21:17 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8394B6B168
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 02:21:16 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id b4-20020a92c564000000b002df416e18a7so10100842ilj.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 02:21:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=beK/RyAk6JMkokDhacR9sWsAak3KfcE5cJn8YM9YfXo=;
        b=CoK/T89im2JphSwafpe+E0XpJPBOJ86NRcuRGT+yn+oOPcpzYzoCPIgxvASH1+GWrC
         l7Lwl8qe3UoxLil1l4uy0ztqzZmhdE/s1zs/6DAfkKVv77U+yAPSx6Yr6+gF0cW9bQJH
         hUDCU2BH5HCUE+iGuYatNP51+gXWqOWJYjPc21adThTAlGElIrsxYIE7NorbAZWtQFZs
         zBKKYQuvMtz8NNHY3j/HRvt/dgA4VvcCPrtug2Yfi4ck0NKvbm/mxQuT9cASNW5i59fU
         WhqLkl+P6rxRKt+Q2MfdK4Txm+anaHVIly6I2sGtL17IJyMkeC4VrvRqwHF/ymPgL5V4
         n4JQ==
X-Gm-Message-State: ACgBeo3VKDeyAj0fYsY5DNqLKL7ZbeD+bLnvizUtMCM3dR608qwio4aj
        HcU/Qyg7BSdtn2NtYf9k9jcYsPy9iHVJmVnEJHv+uGSnhPY7
X-Google-Smtp-Source: AA6agR6ue90cOnN3b6APDtHTxxyZV2Ri32eZNHueoSS0CsGnxVIUIlx6F7PHmVBLe5nS869MW/sVtQ8z8zKRyRqMpful94vI3koA
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3721:b0:343:47cc:848d with SMTP id
 k33-20020a056638372100b0034347cc848dmr150268jav.84.1660123275927; Wed, 10 Aug
 2022 02:21:15 -0700 (PDT)
Date:   Wed, 10 Aug 2022 02:21:15 -0700
In-Reply-To: <000000000000f2b07b05d5dc87cc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000025251905e5df9239@google.com>
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
