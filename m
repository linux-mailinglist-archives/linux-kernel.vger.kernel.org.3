Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5235543CA5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 21:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbiFHTQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 15:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234646AbiFHTQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 15:16:25 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC4549F2E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 12:16:22 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id v1-20020a922e01000000b002d40b2f60e5so11211961ile.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 12:16:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Zd7VaJ+t20Ip39Sfs4fMNAc8bfbYqGcyc9hWSuHpp9U=;
        b=Qkr2uT2GlJcBUtnF2ukqyfKKpbsRfhTckhZkgWc7J2RfbNUi/G5EANxo5sfeSyDvzi
         3MpFUfQlvHCXslCFmxV670ZSEmf1Eepnt/2pWwHZhnyot5EGuVRlfciWfz+KqfIIhlVw
         +HXS554bobsBPY+FPpbMLHSZoEuqIUi9F//RMeY0QEjqgogX9JESoYi/rHv5NAj84D1E
         QvNLKc324/TjnIzbhPe4qJvqQQcf0W7KMP4Xiig/4juk6uZHpPYSnaJenx/dbotwFFWM
         9tjX/fxygYnQNEu8ee7MeUnb+Xj3BxwPwZlb4fBe5y/lQEt9QjEr+CeMTmkolQeHopG5
         jq6Q==
X-Gm-Message-State: AOAM532NIW8ZCOF9h5bcD0c64WxpgxIfsbPTuLVkOQ40LW3q7SAToqXe
        uAZL4x+Oy58ZEEKHAPz2GOjoEDwQKmVNnbnU1K0gz/kBQ1sB
X-Google-Smtp-Source: ABdhPJy0UBXD5u8aWdBLoB3V1Aplx2c/xnxS4MzYAvEgDjQyzbYMEbEVHsASiYiBFtBhWSQ6nWTs6GmjnjgMjJLm7tFgBzEoUm21
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4705:b0:331:7c49:7048 with SMTP id
 cs5-20020a056638470500b003317c497048mr14416586jab.182.1654715781780; Wed, 08
 Jun 2022 12:16:21 -0700 (PDT)
Date:   Wed, 08 Jun 2022 12:16:21 -0700
In-Reply-To: <0000000000009962dc05d7a6b27f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006097c505e0f48aa2@google.com>
Subject: Re: [syzbot] WARNING in mroute_clean_tables
From:   syzbot <syzbot+a7c030a05218db921de5@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dsahern@kernel.org, erdnetdev@gmail.com,
        eric.dumazet@gmail.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
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
