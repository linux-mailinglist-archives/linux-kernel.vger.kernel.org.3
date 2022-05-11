Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4877D523A7D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 18:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344883AbiEKQk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 12:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiEKQkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 12:40:22 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7B0209B6B
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 09:40:21 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id q12-20020a0566022f0c00b0065af7776ee7so1462865iow.17
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 09:40:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Zd7VaJ+t20Ip39Sfs4fMNAc8bfbYqGcyc9hWSuHpp9U=;
        b=aS1CpStOb4Q6iycC1kXhp9RgolujBG7lF9JKv33wqbyPAcWH9dhn/JFms2reYqhGue
         Fv8DxPew6gOXMwLvddLZ1itUXPj2Y+r05SOf7BZbRZKSC69huxaJcMdzmr43XXAJCS/B
         HH2UkKPrm14MNFiCoG1kXWptIXEy911EmOz2dEm3QtFkmociGDFm6PT9xSMi8YqZdGtO
         zI7LwAD1dZux8b1zCwxCeY1CbQW+d7ImzLmt4lq04tT/D+ZldSd0ZmHSlFhCsSQOz7vD
         PPfjxmQTNxqEErtmawci4HUNWcxgheyaaWLtpXnaBDzvQA4c48sdjqZnqUytat2Anlc3
         8Yng==
X-Gm-Message-State: AOAM532jBn3757z545uHi5m96Tmr0yY7dczXrq8VTBx3UpuVOi0uVJ1E
        /JnasiZ9lBE79qY0Eq/1JA99F/gCzzIyLpbEfVXglGZO9z4J
X-Google-Smtp-Source: ABdhPJxpDKFr2qFtoKE0bFOelRySco0CrSfRQHwnpEEtvMC60H+c4vbp8d0h4MoPp5WG8UlxLu/OtRDgBXAPie4D3JazSj1FTMRE
MIME-Version: 1.0
X-Received: by 2002:a6b:2c46:0:b0:65a:4d2f:53 with SMTP id s67-20020a6b2c46000000b0065a4d2f0053mr11130775ios.149.1652287221059;
 Wed, 11 May 2022 09:40:21 -0700 (PDT)
Date:   Wed, 11 May 2022 09:40:21 -0700
In-Reply-To: <0000000000009962dc05d7a6b27f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e0d41905debf1844@google.com>
Subject: Re: [syzbot] WARNING in mroute_clean_tables
From:   syzbot <syzbot+a7c030a05218db921de5@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dsahern@kernel.org, erdnetdev@gmail.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        yoshfuji@linux-ipv6.org
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
ipmr,ip6mr: acquire RTNL before calling ip[6]mr_free_table()
But I can't find it in any tested tree for more than 90 days.
Is it a correct commit? Please update it by replying:
#syz fix: exact-commit-title
Until then the bug is still considered open and
new crashes with the same signature are ignored.
