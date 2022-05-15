Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750BD52763E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 09:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235945AbiEOHXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 03:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbiEOHXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 03:23:16 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC324DFE3
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 00:23:14 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id a3-20020a92c543000000b002d1108788a1so369220ilj.4
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 00:23:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=dQNDJrcSlSeQiac7rbEEb7iB5P6+L27qAWitqYNvlXk=;
        b=tsUV6iK9T0TJb9b99lkdOFtWBfdyNoUxg+vLBHrvB7vtw8QjOgXlyNcBJSj1fHebHw
         V/Woa/2XY6+zgAkg0ysOTqJVwLuTVIl8Vd5CaAdL2o2UAKOz7e4M8K2z1ei6BpKqGtdq
         Ku591B00QZEuXXlC945rzEPueEeED5SY7TRdUram6lyBarxgVMXxFcPhtARJ5jbtkoSW
         B8hRsQmBIzhHApye0RTNkMtU9lzAOmBFOdAPLJwVtGfY8E9Ys0nID9cJf/dCzFllhyxN
         /P10BTMnHpkXjELlalCfmBOVnXjOm6xqZS1OHZ1Y9iBHVMjzSypLQlteXHRuzSCNJK9/
         NCmw==
X-Gm-Message-State: AOAM53329uW2LK0k5BLpKHgc1h+WNBbyjhuSOOtN/e1KIUGOunnrV9EO
        16L7a5/gviTo0fLZDP87KGDWEryTgxbcS//gXPV3qS1WFGV5
X-Google-Smtp-Source: ABdhPJyOq69nXmeX37CZgjAvoiFiYs9naNVqtYvZqT+ccU8+uxrae5vbCaJftfaBWw0Z268nnlzGVs8lUIu9Z2mUwSbItm+p4Q/U
MIME-Version: 1.0
X-Received: by 2002:a92:4a0a:0:b0:2d0:fdf4:6f45 with SMTP id
 m10-20020a924a0a000000b002d0fdf46f45mr4584046ilf.262.1652599394077; Sun, 15
 May 2022 00:23:14 -0700 (PDT)
Date:   Sun, 15 May 2022 00:23:14 -0700
In-Reply-To: <20220515012731.1529-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d715a005df07c7c2@google.com>
Subject: Re: [syzbot] WARNING in mntput_no_expire (3)
From:   syzbot <syzbot+5b1e53987f858500ec00@syzkaller.appspotmail.com>
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

syzbot tried to test the proposed patch but the build/boot failed:

fs/namespace.c:1302:1: error: expected identifier or '(' before '{' token


Tested on:

commit:         feb9c5e1 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
dashboard link: https://syzkaller.appspot.com/bug?extid=5b1e53987f858500ec00
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13dff259f00000

