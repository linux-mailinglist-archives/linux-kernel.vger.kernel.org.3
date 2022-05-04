Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1B3519B64
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 11:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347095AbiEDJTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347129AbiEDJSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 05:18:50 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F94117A
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 02:15:15 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id h10-20020a05660224ca00b0064c77aa4477so590337ioe.17
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 02:15:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=beK/RyAk6JMkokDhacR9sWsAak3KfcE5cJn8YM9YfXo=;
        b=I8h5KC2vZfRT0vlHrHyvdAfEpe/wNr0ADyOtwdn1Lo8BwgulHAJp1/eOnd7+/ySp1W
         vnS5c1ljPCy/25L+hzCBIF8ANxTcO281DJDPSho4bqH9HIxPP0Axb319FNobuIwhw+fy
         WreKZvFpuffhKOAKWiV42j3tqBbyiTrcWVPx9CSbOXbhnTQU6blHrOB3ki9eZRb5WCKF
         adkkSc5nYnkX9gvd+F9glD/TPrfOm1lVDCOyeTfBdqpCtkvjpcv91oE3aOmFAXKZwBag
         +LsAxxikRjgi45xdxXggfWS3qbVyT2WytZoIwJ6EpMLRKxZxZ1Sgz5PHv+U/ubWuP5lc
         M1EQ==
X-Gm-Message-State: AOAM532RB513cRiGXmWdraPMJJDdpfc2bugbdeMmODLC1EefXnDwPQXh
        /NWOBG6N5a6u1NiOkGYMhMZJRKWfC50mzp2avMvfAYmCXp51
X-Google-Smtp-Source: ABdhPJxttq7avaGELU4BmNcisd2cCdBbhhtvLjh75B538RWU2YaKgmnsBhCoBcLJkQWt5aBSQ2E1Ter+xblfk0DaPVHIWpD1e0Hv
MIME-Version: 1.0
X-Received: by 2002:a05:6638:164b:b0:323:ac42:8d4b with SMTP id
 a11-20020a056638164b00b00323ac428d4bmr8709404jat.75.1651655714399; Wed, 04
 May 2022 02:15:14 -0700 (PDT)
Date:   Wed, 04 May 2022 02:15:14 -0700
In-Reply-To: <000000000000f2b07b05d5dc87cc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000025ef7405de2c101d@google.com>
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
