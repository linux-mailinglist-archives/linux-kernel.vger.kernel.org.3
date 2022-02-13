Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342194B3BCE
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 15:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbiBMO3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 09:29:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiBMO3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 09:29:16 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D37A5F27C
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 06:29:09 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id p16-20020a927410000000b002be8797ac0bso9533277ilc.7
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 06:29:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Dv9Zi+PX8etQ+L08jB/rCP1HZFg1/MknHt1yKnbgbN0=;
        b=O5gETIaJQ2+hBZe70+n/MahgunIwHCFUONmzhjKYJeGZKxyzWKx63jpVhotc/FIv4P
         +T1yza0Vx8juJbjHrTFpu0CaUl9b61gSd2oqRiweSFM+iMt+dSnD1qaD1PSMoDMHG6X6
         T32WmtBUpCetqM7RwT+bVs44sLIz0As3/RM8a8mAg6FhlZ7oLvc5FqZ5fnf8uelKAATr
         rZgA6vu52HPjvyRkEg8bOBCxXm5s3QKo0aAuE8JQWDaY04xEPkLphgtVbb0jD3s3jDtU
         AJwq2EE5bFlQmsi7VtvlFWHf0dY9zD6b1aaxkdjLtU31LrJf0n2jD0Bz9BuiNoHNgbTg
         8gJA==
X-Gm-Message-State: AOAM531eOZ5ODOx/jd1C3X177yGNb552lhuW+XvEUSiE9CVG/ZyzuyAY
        rP9tXKqCTCFh36GjrnjPGsSx+e1+wwIETkGqCfFdTR9MA005
X-Google-Smtp-Source: ABdhPJzzEhKco3w4LZcBUiyVqndZPZxC89klYJbKjD3vKb7taOsTe8y7FmnS78bfkXqXi0vqAP2QZTmIwBGOZLSaxzCUnUfMv4Gh
MIME-Version: 1.0
X-Received: by 2002:a05:6638:13d1:: with SMTP id i17mr5796558jaj.182.1644762548816;
 Sun, 13 Feb 2022 06:29:08 -0800 (PST)
Date:   Sun, 13 Feb 2022 06:29:08 -0800
In-Reply-To: <20220213103641.1247-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000764f1f05d7e71f64@google.com>
Subject: Re: [syzbot] INFO: task hung in usb_get_descriptor
From:   syzbot <syzbot+31ae6d17d115e980fd14@syzkaller.appspotmail.com>
To:     brouer@redhat.com, gregkh@linuxfoundation.org, hdanton@sina.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        skhan@linuxfoundation.org, stern@rowland.harvard.edu,
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

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+31ae6d17d115e980fd14@syzkaller.appspotmail.com

Tested on:

commit:         b81b1829 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d94e196c4f68081d
dashboard link: https://syzkaller.appspot.com/bug?extid=31ae6d17d115e980fd14
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: testing is done by a robot and is best-effort only.
