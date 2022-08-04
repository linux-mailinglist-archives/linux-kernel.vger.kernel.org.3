Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014B1589AC5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 13:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239513AbiHDLKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 07:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233704AbiHDLKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 07:10:21 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B276F597
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 04:10:20 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id d6-20020a056e020be600b002dcc7977592so11870245ilu.17
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 04:10:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=nU94kHDqKyyobD2ylU+XWg3IoudilPeOz7R9wa3wlH8=;
        b=BFW0Ebfo23BLzqQgNloxmH+lN7HB1MzkInHRaUlVdTrdtJklA7SuQFt+VfveA/y498
         l61l5+mWPJO96jAxYy9Mgof+f2x9fSBMvFT9F6mv6expPx+WF3ScTUuwoeKseIOfz1X1
         AYEWmmAwP2DhxNkIJ8N8H9pEm3LjxVVwtdHYcrIA+0NYvyBtSUBR3e3s4dIiC2wZcUMp
         4v9M9OMUIkoewTboCEZVn48oqjmkEc68SEenX8z0kyDxNg8x0F3XE3KSQW9Wy2Ts2/Ks
         KRaeSf4zCDUozlif6JUYkiZ+yiPd7SH/uPFUW4A0ihVb7amUkD7rvIhsBEI9epZqM3uE
         DcYA==
X-Gm-Message-State: ACgBeo0VH2EnQIZNAcbM44QsChfMEnEUDgiK2P3YHh3FoMBDLOevCPNE
        FFtHRaLT/malSN3pQKoGBir0rjZ0ScEMcd9Pyvy4fnHPGlrL
X-Google-Smtp-Source: AA6agR6zJ0RDbdqXaXGsqZlPdtPopdtEakk0dfE/D/G4PEctqmzlr5RcMtURSqsdPF3DSsqRiOi1R6f87rjTYRDuwZpj1MFWi2Kf
MIME-Version: 1.0
X-Received: by 2002:a92:c246:0:b0:2de:b25b:e75 with SMTP id
 k6-20020a92c246000000b002deb25b0e75mr628863ilo.246.1659611420034; Thu, 04 Aug
 2022 04:10:20 -0700 (PDT)
Date:   Thu, 04 Aug 2022 04:10:20 -0700
In-Reply-To: <20220804105325.1600-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000280dfd05e5686579@google.com>
Subject: Re: [syzbot] INFO: trying to register non-static key in rxe_cleanup_task
From:   syzbot <syzbot+833061116fa28df97f3b@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+833061116fa28df97f3b@syzkaller.appspotmail.com

Tested on:

commit:         cb71b93c Add linux-next specific files for 20220628
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14347bd2080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=badbc1adb2d582eb
dashboard link: https://syzkaller.appspot.com/bug?extid=833061116fa28df97f3b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1471202e080000

Note: testing is done by a robot and is best-effort only.
