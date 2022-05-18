Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6687B52B603
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 11:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbiERJP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233901AbiERJPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:15:24 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04969FD4
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 02:15:23 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id h19-20020a056e021d9300b002d11f6f002bso921890ila.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 02:15:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=beK/RyAk6JMkokDhacR9sWsAak3KfcE5cJn8YM9YfXo=;
        b=QCRtTVMkXGzkI3P+9tHELEikLWD/Ee6WoE3v54pNzlwlGyNePBk2u7IcmjgqN+DGgD
         CizfosNQ2wBPSMdE7r7mJ3aZrhsFzf7b6EGY8VTXaWKZwboQJucXEmg0Hu0tWf+TV9Ko
         mEg0d2EpZuTLN9GKmr6PEVg0zKqI+Oalj3o9qGJn5Rr78aaT1+ayx2MC/WGv851riVt6
         ureVBxxUhxXxUUBMh8omsb0ZU3T1ixHFGrzNS6TKY/POYIRdl4ZXxa5Lqi5GxIyGGcES
         ewQBQm9S6sM8mVwwffPoQYKp0iW/WU0RHevkya8rN9S6+20oHaTGt2YFwc+r3HSpxuSv
         7jHg==
X-Gm-Message-State: AOAM531ETk2XABDfhLPXCLY3xBPpDUsixuGPK80CHUqsqo+kXARtVgYF
        ouAt4TvRAaQkrQorD6EKMwgwwLjkIZ+2AhWOdr5xi04wAB7s
X-Google-Smtp-Source: ABdhPJwt3FmoutrzsR+CsxDMxj/k4tujVOEsXNvPIF709dM07yn4rtyCh7r50mBFGtbTVUq1qQySxrLJcDlVhEYCEjc/cJ/YcyS+
MIME-Version: 1.0
X-Received: by 2002:a05:6638:411d:b0:32b:7465:fee2 with SMTP id
 ay29-20020a056638411d00b0032b7465fee2mr15097962jab.318.1652865322948; Wed, 18
 May 2022 02:15:22 -0700 (PDT)
Date:   Wed, 18 May 2022 02:15:22 -0700
In-Reply-To: <000000000000f2b07b05d5dc87cc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006f9dbc05df45b23b@google.com>
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
