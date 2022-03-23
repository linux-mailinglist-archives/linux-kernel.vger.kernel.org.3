Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C13E4E4A2F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 01:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240973AbiCWAtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 20:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbiCWAtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 20:49:36 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B641EEE3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 17:48:07 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id f5-20020a6be805000000b00649b9faf257so12550ioh.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 17:48:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=MG5Y8xILdnFlJljeDRhJEgQB6FlTo+9PoQNjAE5QtFg=;
        b=p477F3aHpIM07oAWFsxc0TWa3tvg5MHvy2eKkKNdoHiJqeNBm6Wc/4+SXFa4jPQvXQ
         1szyRJIGQKE0v2nztp5hMUE86LPzjayOeD6nBYmdiYqMqRTCBvlEeXVn9W3vS8VFaxq2
         4gNNSPYA7ojExSd2C2uLOALY5jQVF/cHtlGZ9kxcUzO/ITaJTqcdLPDavYcsF7Zydl4q
         HVqoYDDX5D89QqgWhKnb8YpFJ8DJhlxPDWvNbTQfWWxbOnlyGvQytgp93u/gv071s5IN
         f9S7iZwc7QEZMkv+osvRxyQHxBU2uosVO6u79BwOB5XqrOj9osSXFJ0OZ4AAYWFjRxy4
         6PlA==
X-Gm-Message-State: AOAM532SYOZRylFKdZAdm0VggiXdsnxzQZY9ipnJ6m4soi8/3s06qSNv
        4CnXuDsPqHj4FEjxMwH7C4FIRl/PVtPuxolESLNPrNQIJKqG
X-Google-Smtp-Source: ABdhPJzptHHQrN8r1mX3409unrkLHPcL2SBen3Iw3BjiPGI4qJqSBSa7xKT6pKtQAVfZwGv1L/fSJM4YvdlQx/82p0qPPCGBE8T6
MIME-Version: 1.0
X-Received: by 2002:a05:6638:22e:b0:321:675d:aa77 with SMTP id
 f14-20020a056638022e00b00321675daa77mr1273076jaq.152.1647996487309; Tue, 22
 Mar 2022 17:48:07 -0700 (PDT)
Date:   Tue, 22 Mar 2022 17:48:07 -0700
In-Reply-To: <8bcf2234-983e-171f-90dd-ff0c07412b46@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000379f1d05dad8157a@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in add_wait_queue
From:   syzbot <syzbot+950cee6d91e62329be2c@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk,
        gregkh@linuxfoundation.org, io-uring@vger.kernel.org,
        jirislaby@kernel.org, linux-kernel@vger.kernel.org,
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

Reported-and-tested-by: syzbot+950cee6d91e62329be2c@syzkaller.appspotmail.com

Tested on:

commit:         7d58de1a io_uring: don't recycle provided buffer if pu..
git tree:       git://git.kernel.dk/linux-block for-5.18/io_uring
kernel config:  https://syzkaller.appspot.com/x/.config?x=3172c0bf8614827
dashboard link: https://syzkaller.appspot.com/bug?extid=950cee6d91e62329be2c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
