Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63521573252
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 11:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235196AbiGMJTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 05:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbiGMJTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:19:19 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE9E65D40
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 02:19:18 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id s3-20020a5eaa03000000b0067b8e40a536so4166590ioe.17
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 02:19:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=beK/RyAk6JMkokDhacR9sWsAak3KfcE5cJn8YM9YfXo=;
        b=THUD/M/DkJ8qRRZV3pKQJ5wQVMQSJKCich5Us6AwjMXqGBCXYHwSvE5aiTduxsW4Ei
         ElZ74a8Tt5+dbYF40qCDnLtdNobmVZQPVk7sZ6tuWDM4V9fEOq5cjqiTcX9Gwl7m3sPA
         cIiuGiYteJO0vwT1xDWYVcVb11XLx9N4GbUskFfUD1640vsU4LFypY3kfWLxxuApLRuS
         iwn3OHSdDoE0gzCugWJqsEEpHrIoMi2NM6p2H96BUQZ0HNf9Uu3+naPC0UYQXqwGMUFa
         KS5y07bwriOmSi6l+X/EC1/GBW5R+CowSH2OIi8+8qXFzhg7+BZopzhj7P4T89Jb4p9d
         dCgQ==
X-Gm-Message-State: AJIora8y/t9Bao8fCZxUMpDeJKK0usEZqiUUsJ20BLeir2a5YUzydSqc
        GoRKTUMXlwvxTbb/f84vNA7xxN93fg+b7F0DbxUrBpPSWCxY
X-Google-Smtp-Source: AGRyM1tGKk8L7CaPoHPZN3L32agR0DF5b8G/3cjRJ3OTHH6uwupEEMGc5Zzm463FDp7p6zPKyV8fHNejR4x+ih82L8fDnCC6iM8z
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1412:b0:33f:7cd8:6a79 with SMTP id
 k18-20020a056638141200b0033f7cd86a79mr1282583jad.119.1657703957555; Wed, 13
 Jul 2022 02:19:17 -0700 (PDT)
Date:   Wed, 13 Jul 2022 02:19:17 -0700
In-Reply-To: <000000000000f2b07b05d5dc87cc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008870ab05e3ac4783@google.com>
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
