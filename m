Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C55956A4A8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 15:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbiGGN5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 09:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235719AbiGGN5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 09:57:07 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D91915FEC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 06:57:07 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id i2-20020a056e021d0200b002d8ff49e7c4so9346839ila.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 06:57:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=jrhvBpI6mqQX1aZ/JxTs5fURHwqXekze4iGJit6D5xc=;
        b=M9IqIeS7IqjNH4O74SZIauUysFz9L4umGl3bM+vVomeYMY3vnmmRntM0qAb1ZEXiFj
         Y1igfk59kvKTlVM8BWduZq6UV4TTfe+qpTmv4mH7GR1rBRqKgzPcjFFiqfpIAJCuNw1y
         H2foWzH9tiL6Krwb9dAT2jpr8n54s44K23z6Rca5WbWMW2E0NUkQqAsmci6auSI4J/+9
         Nvhk+t8H15WJjARM2D0BntP2vxYcQEfVU3WVK0szSP/UPmNAXFYnxxLhplzxfZNd9VsM
         Qxoz6d+bgRmGldpvxc+0/E1o4wtG6IKdrWZIYrVqeA0ZmTPHRENxpzEF1Xf5bpT69ltm
         YScA==
X-Gm-Message-State: AJIora/jWOTpsnLsFMk+4R7g2vUnBTvuPqiTyry9c0mjAm05eZ9rszcm
        lf1ixoPfILBb7W0WfL4M9eIkyCcMJLgVM8mgHFWg+kLx4Wev
X-Google-Smtp-Source: AGRyM1veD1FGX/guWz3LmMbeJxeQj9YYx4l0t8os2QaZH+INKZ0nO6u8jksRJ5byu1i7VngnaiT9PCYRcCRa7HjFNH66pdwpkUSd
MIME-Version: 1.0
X-Received: by 2002:a92:a041:0:b0:2d7:7935:effa with SMTP id
 b1-20020a92a041000000b002d77935effamr26077785ilm.222.1657202226780; Thu, 07
 Jul 2022 06:57:06 -0700 (PDT)
Date:   Thu, 07 Jul 2022 06:57:06 -0700
In-Reply-To: <2041c8d8-e57d-01bf-1378-3ad2c72f69d6@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000c61d405e3377621@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in pty_close
From:   syzbot <syzbot+49950ba66096b1f0209b@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
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

Reported-and-tested-by: syzbot+49950ba66096b1f0209b@syzkaller.appspotmail.com

Tested on:

commit:         f2703d1a io_uring: don't race double poll setting REQ_..
git tree:       https://github.com/isilence/linux.git poll-syz
console output: https://syzkaller.appspot.com/x/log.txt?x=115e9020080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d66f898fdc339ef0
dashboard link: https://syzkaller.appspot.com/bug?extid=49950ba66096b1f0209b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
