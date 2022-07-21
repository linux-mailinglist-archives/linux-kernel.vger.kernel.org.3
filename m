Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B66D57CB15
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 15:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbiGUNBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 09:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbiGUNBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 09:01:14 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566E4643F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:01:12 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id i9-20020a056e021b0900b002dd12dfd5b6so946037ilv.16
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:01:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=TXZ8s4gYj+O/XzowImoSAN7Iznpvsn1zqktzz5m4FiQ=;
        b=QG5BPcGykbpdPbR6W1j/6MbjfEDJNgr4uE+lhytxuLxlnR0I0fiq18H+W42rJ4a8XL
         lmxJTb7p2ztlfFWV/GWmHiIS5h+ahnJBkHWocTZ7b90l6qPU1PLrmZCiiQ9jH1Ol/9As
         NHiwka6DbOEWnCka2lEz55gZMTbxv1jcXwzgnfHsNScBVpOYAbo9tw8JUXW4ISU2U8di
         n63tJY4sXLsOQtKr7hW3S6BugbStGTM4ATUWB3rivU5aQLWlOCpHDtvbOzcM/Llc2MnG
         V/HVSa0ui2W8oPCfLnFsJH+LIpYvpt4BbmZgclWAu/bD/NU01ENKNKfEUvhSbYuE4ULs
         5WIA==
X-Gm-Message-State: AJIora8J3imIpJ4Z+BPviXzXLJdge2htFscPUPHwRVyIe5V+IPguZoUF
        +2BSTLEiWQSBuCsgHRzAd1WR+8/YlFVNQi4qZ+Z28sviaTQF
X-Google-Smtp-Source: AGRyM1v/lZOkqMP6B1u2hC5D5OvCgPshec5AbI/cxJC7t5fg5PoYyZ3AG7XBMuLKdxfHOgsAgyl1J2FhUjMLQe9xNbbyrE1Aj8bG
MIME-Version: 1.0
X-Received: by 2002:a92:c549:0:b0:2dc:949f:5514 with SMTP id
 a9-20020a92c549000000b002dc949f5514mr20249492ilj.301.1658408471460; Thu, 21
 Jul 2022 06:01:11 -0700 (PDT)
Date:   Thu, 21 Jul 2022 06:01:11 -0700
In-Reply-To: <20220721123306.1968-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d5829205e4504f34@google.com>
Subject: Re: [syzbot] WARNING: still has locks held in tls_rx_reader_lock
From:   syzbot <syzbot+16e72110feb2b653ef27@syzkaller.appspotmail.com>
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

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+16e72110feb2b653ef27@syzkaller.appspotmail.com

Tested on:

commit:         e22c8879 Merge branch '100GbE' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17c4ab8c080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c46ba1483fd8356
dashboard link: https://syzkaller.appspot.com/bug?extid=16e72110feb2b653ef27
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1410d6c2080000

Note: testing is done by a robot and is best-effort only.
