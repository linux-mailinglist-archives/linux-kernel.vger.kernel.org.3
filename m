Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661CD54C473
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 11:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347068AbiFOJRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 05:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238107AbiFOJRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 05:17:17 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7573F304
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 02:17:15 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id h4-20020a056602008400b0066a011ac3d6so3623523iob.14
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 02:17:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=beK/RyAk6JMkokDhacR9sWsAak3KfcE5cJn8YM9YfXo=;
        b=xbImlg6nAsVyJkuPKnOuXzNKCQCdzAMUenJJ8SONdINKpm1osdF0IJcj6/e02PocY/
         XLZgrVT8AMNGyVL/11uJqybu2wK/ARSRBpmDF2iTSYt0BJXyPQO62KDlA0+nK5fj9vQn
         Y4fpf2TVkrRZbqnv5X6Z8YjWeWMY4xAXylL7RXCyP69hXPg1zSNbqgc6E9noHR8/tXoQ
         tPSgUulFqcBaFUUWZljgD0r0ZkOribla2+9TRAXLFcZkKHcr7KWQgDFF7cDG465xla9D
         swgEV42xR2YCABmQaT3I2wJPCO8qVGf5SmRgtbPNy6qan+SzVWE734z8xCgWQT18bwvY
         9O2w==
X-Gm-Message-State: AOAM5315y/hlL3LryCegCz/okGEZosWqMjMhghuEId5LenUQc7ErP88x
        hFQVEZnwG1oj9K4vRvBHzzLSsHRgJ4RXBG71QJorB1ILgq0F
X-Google-Smtp-Source: ABdhPJxovQRz/hp/ytkhe13B3x5BwOLmalwzoxbSro+i1hOF1Xj9TTkUXxckE9He5j28lM3HzlW6ZqzdpqsF82VHdVWOems7/s1a
MIME-Version: 1.0
X-Received: by 2002:a05:6638:218b:b0:331:aec6:9bf9 with SMTP id
 s11-20020a056638218b00b00331aec69bf9mr5141953jaj.100.1655284634978; Wed, 15
 Jun 2022 02:17:14 -0700 (PDT)
Date:   Wed, 15 Jun 2022 02:17:14 -0700
In-Reply-To: <000000000000f2b07b05d5dc87cc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ab916f05e178fcf8@google.com>
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
