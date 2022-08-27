Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B7C5A3331
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 02:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345086AbiH0AnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 20:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiH0AnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 20:43:12 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AE3EA32C
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 17:43:11 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id a4-20020a056e0208a400b002e4621942dfso2264655ilt.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 17:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=5VgFJFqVUbfRFk9PtEy9IurC1DutixQZSf9EEzwuapc=;
        b=Ua8olQdos62YpSZJeoeQUMRXcM94/WRO2Vo/wdorU7PR+No32xVXfTml3Wru3oCEPU
         qYTqqIx4hJbk7oZyMbvy3IkRLoIG8ILlaAC4nMKKJYbx450OxEZdrWc4QGqfSikMHqJt
         MkC89F83DsWphazBSxjTsolz7mYI3vIrB815Jp3bi2xcnBjBnL88RZC2VD+55YrnzCaC
         CYXXqDBvsmiZSoo8Ehw66ezLo/QLoGunxwX0F322CaDd7AjP/WB+0JNsFhb+Ez7ehdz1
         o/fPMzFtfrW6lCodCsi+zD8BKcfLqtViCVYpuF/5ti/nBamtW7CeYr2Ur6k+NwTanojQ
         wKsg==
X-Gm-Message-State: ACgBeo18dIpOoKaiFpnoki0PHKxh9cdUHGbNSksyg3aTvDc5xE8RC6vU
        /S4MZiDQ/+MsEgrnGjTIPnx44MLBH9D0RzUTumEsNzVFs/Q7
X-Google-Smtp-Source: AA6agR5gyel94u7ZSg/7DOVFa8RerTJ3SdfxrQVuo/AEUAlK0sC6xpB8RZi8xtZAoQcpyfywbZ0FVpR31pCH7jEuVjULtGcxU0oz
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:158a:b0:2d3:f198:9f39 with SMTP id
 m10-20020a056e02158a00b002d3f1989f39mr5448623ilu.206.1661560990957; Fri, 26
 Aug 2022 17:43:10 -0700 (PDT)
Date:   Fri, 26 Aug 2022 17:43:10 -0700
In-Reply-To: <20220827002401.2552-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a3878b05e72e50c1@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in __kernfs_remove
From:   syzbot <syzbot+8bee3285b9e190f1509e@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+8bee3285b9e190f1509e@syzkaller.appspotmail.com

Tested on:

commit:         68a00424 Add linux-next specific files for 20220824
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14297dad080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=591008a24ae652d0
dashboard link: https://syzkaller.appspot.com/bug?extid=8bee3285b9e190f1509e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13cc5157080000

Note: testing is done by a robot and is best-effort only.
