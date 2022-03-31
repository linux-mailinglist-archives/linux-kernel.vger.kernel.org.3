Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DF94EE15D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 21:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbiCaTIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 15:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239928AbiCaTIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 15:08:02 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD82220FC8
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 12:06:14 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id w28-20020a05660205dc00b00645d3cdb0f7so320093iox.10
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 12:06:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=r/0Q/v7LxnQii6Wat+1eXZLZ1gIDdS2hR5mCVVjGKVU=;
        b=iwCKKCzo/n7DAzb8RvWrbmQoCKd8lG7d9fC3DXS7KKgWKChVX/ATM+clWEoCnUcVgS
         DeSXBAz8dnvQPUsKvstiIxkiDlu+qYlSVaVshwLernFgwaxrf5Bi7fHyVH6doXoCOPII
         cSmWUIYypvAYqDaGnb7+pGiEdHpCQZLT8VNqX6wlSQ3wQ34A2J/ixFrimtBwCWl4xUIk
         oQ+0an7fy9uGP48bDcG2uZxR8BCVQoFxS/DjGD0+RNp+s/qcfz+hooA8Qo+GF/jEc1So
         7XlmKSV843FdbPNTMGpziny2Jrt0eppCyGx6J2chjwsr45EuzgYPJ6wh7jUL/7hoqo2p
         heCw==
X-Gm-Message-State: AOAM531giv0vUjVJJNxJG1mm4vM0BSpBlURYHocHwZE7ARNbVFs+vvG7
        Ca+G63WJwkkY6GPUJLIsF4u1g1/4D3cCnKKgUb/vndG4DJwX
X-Google-Smtp-Source: ABdhPJxhLwKFZ45jya0LVhjew/uXFv5NxVPTM0yGlD2OYJVrGpYWtkpe4WTktB5ooY57V7udWcsSpk1vZJPjYdvTK/6ygZ7oJpx1
MIME-Version: 1.0
X-Received: by 2002:a02:b10f:0:b0:323:9bba:a956 with SMTP id
 r15-20020a02b10f000000b003239bbaa956mr3701828jah.313.1648753574205; Thu, 31
 Mar 2022 12:06:14 -0700 (PDT)
Date:   Thu, 31 Mar 2022 12:06:14 -0700
In-Reply-To: <7f56f140-ecf0-d72b-b891-171a0aaf21ca@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001ce19705db885baa@google.com>
Subject: Re: [syzbot] KASAN: null-ptr-deref Write in io_file_get_normal
From:   syzbot <syzbot+c4b9303500a21750b250@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+c4b9303500a21750b250@syzkaller.appspotmail.com

Tested on:

commit:         9570a845 Merge branch 'for-5.18/io_uring' into for-next
git tree:       git://git.kernel.dk/linux-block for-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=6a82c1abd4cbb9ee
dashboard link: https://syzkaller.appspot.com/bug?extid=c4b9303500a21750b250
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
