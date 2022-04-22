Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C62E50C0C6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 22:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbiDVUlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 16:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiDVUlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 16:41:53 -0400
Received: from mail-io1-xd48.google.com (mail-io1-xd48.google.com [IPv6:2607:f8b0:4864:20::d48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F55F1F8EF5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 12:40:05 -0700 (PDT)
Received: by mail-io1-xd48.google.com with SMTP id u18-20020a5d8712000000b0064c7a7c497aso5974842iom.18
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 12:40:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=bMZssZ4/5rMn7JFTaYyRiobnst/WdHrTg0VN7pqEdmQ=;
        b=O861KVCFr4TrMODOAUcWXCQn2HF6Mk2Fth0t9iUDihlog5kRB3u74rl0BJzbdWCkf1
         Py/FfKREARx92amy0Esx8T0XpYwiKKfPkNK5olcZWzfoPDHFvWqAVmv6S5imIhDqWp7n
         n2Q3pcyQupBSdhUwIZc24T7oBV3kjVUVyXJkEiJW94eMsNZ4Ll50DjTUua/QOWOGIHUD
         hXMjIqNg2RnpAgWOkO0wmTGYk/7ddw9oBYjxf8h2ebf48f/6qBQ4T+aDmoS2Ct+PSUvY
         QMiZ+RTHYLKvueE95Nu23HEckmtzg8YBr5UXN+13uRLzsyWZ7dMwjbzetUToIAnCiD73
         +/zQ==
X-Gm-Message-State: AOAM530OdyHGMeYKLGpz2mKP55D4CBr2wmcStfHYR6VIfFJ/6kQCJjeI
        Zom1xRZlzZaJ/XzmcypXqhK2hlIXHjAyrei5L7Lzdy509SLj
X-Google-Smtp-Source: ABdhPJzJJl9SIcuNGwTO5H7TFvkYM+As7pFatvBd5/JUgAa7lJHQohxhtSzDJQrAEenqLF5eS/og3Ya09FLcQ411672yYb2SSXei
MIME-Version: 1.0
X-Received: by 2002:a05:6638:40a3:b0:32a:b968:af2f with SMTP id
 m35-20020a05663840a300b0032ab968af2fmr1673108jam.221.1650656051380; Fri, 22
 Apr 2022 12:34:11 -0700 (PDT)
Date:   Fri, 22 Apr 2022 12:34:11 -0700
In-Reply-To: <YmL0L7nhdJTMI9QU@casper.infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000096c5ef05dd434f4c@google.com>
Subject: Re: [syzbot] kernel BUG in __filemap_get_folio
From:   syzbot <syzbot+cf4cf13056f85dec2c40@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, dhowells@redhat.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        vbabka@suse.cz, william.kucharski@oracle.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+cf4cf13056f85dec2c40@syzkaller.appspotmail.com

Tested on:

commit:         91070385 XArray: Disallow sibling entries of nodes
git tree:       git://git.infradead.org/users/willy/xarray.git main
kernel config:  https://syzkaller.appspot.com/x/.config?x=78d87160570beee3
dashboard link: https://syzkaller.appspot.com/bug?extid=cf4cf13056f85dec2c40
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
