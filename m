Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010465084A7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 11:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377106AbiDTJRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 05:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355436AbiDTJRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 05:17:04 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672CD1CFF4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 02:14:19 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id k2-20020a0566022a4200b00654c0f121a9so809857iov.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 02:14:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=beK/RyAk6JMkokDhacR9sWsAak3KfcE5cJn8YM9YfXo=;
        b=JjucaE61zrksF4GTKdJhJoEhKZb8j+g8nQu0w08/fRInPUXH9dB5JODlAX4QwqgeWG
         6X1B6qv1gVFBRK4MroiC4cfHDmOAmb4UeMmHpTQvO41raQmDfdUT/SEC8F86fZjVxVbA
         aapEh9xCwC6RJQiYHSi7oAb+j47laVW150bel3nSysZzfNpFqUn/95fuR0H8E9GFO1G3
         ZNvNlJ2d4qEuZrAgZ9wkt9eSlnDrwijr56WMJS0XDYBaWYvP2reQGwqKBRuqoHhF+LdD
         V9K1oIBWdvfh0sqqoG0HB3lM3pTvs/q4cviHKmlVLjc1h/BZ6f3LxhUs4bzCSYS17oMT
         34nA==
X-Gm-Message-State: AOAM531RF2yzWSJupp214Xt5C2xiotCQP+sYeod1esHTNkPhqmjnZxnR
        vz4D6PMq+UuLhKRZBVy/H3vkwWk1JhB3gAJIzJn49V1m6D7a
X-Google-Smtp-Source: ABdhPJxlMZ0hRpDFaI0jdEI5Dnpg1mQUJshrHXx7KMk2sDcBb3gUQC1o+mc4qbU6FItlTkLngt806p8qF7TlTQp4DWyA7rAQ1odu
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3281:b0:648:d45d:22e with SMTP id
 d1-20020a056602328100b00648d45d022emr8220771ioz.7.1650446058846; Wed, 20 Apr
 2022 02:14:18 -0700 (PDT)
Date:   Wed, 20 Apr 2022 02:14:18 -0700
In-Reply-To: <000000000000f2b07b05d5dc87cc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000f008905dd126b03@google.com>
Subject: Re: [syzbot] general protection fault in fscache_free_cookie
From:   syzbot <syzbot+5b129e8586277719bab3@syzkaller.appspotmail.com>
To:     dhowells@redhat.com, linux-cachefs-bounces@redhat.com,
        linux-cachefs@redhat.com, linux-kernel@vger.kernel.org,
        mudongliangabcd@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
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
