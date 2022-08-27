Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2A75A33DC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 04:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345468AbiH0ClP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 22:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345467AbiH0ClN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 22:41:13 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4070D95688
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 19:41:12 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id k9-20020a056e021a8900b002e5bd940e96so2375875ilv.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 19:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=Vw8IRDZzaCEOWyI088Lz4BLtWDCY7UD8gRx7VzqlV74=;
        b=L+MTZHoy83PiQwdpB7qopTAsR8XtRpF2EYwihh79kh7RKUYIIbwyZ24PUUBz2XoF/r
         0h+o6cj1WX54fw/i5RSfqs6SsPkWbTEKLA8jPDGLCtg4vqPkHvXvJThA4Xw6iY7ftUWv
         xPq2IOq4or2Neme1RHq8SmTA0u0cY+Jt2JIHW0KTYmDaSdvDae7tejRk6cNmIJEip0sm
         T+eNa0HlCyexmuFAe6ssWpwrlm2ehXuwmM5APfnJYNe+0CtUAawbjbFKlLqGoMblzyc9
         6A81ix1ZF9b2Dpy2iDkTitmyycn4LVehUjJ2mGiTZfbLiUlO7I6jaDyDlYfN9ECJbqX1
         gi3g==
X-Gm-Message-State: ACgBeo0oTLBBvieY915atxq7Jr8a6sz00QFyV4QcQK8NR5ZM+NUTjXmY
        L9aRwD+vp4R3UT+44h9i0k3qmJZRnaCCz921EhnC02SViMGt
X-Google-Smtp-Source: AA6agR7NNzxQxWWkSf6WLqL34liHZ3AcFt0N9RNnmYPYbNDuFi0OVrUqUIwNNw8F+oUuT1aiH6fprcP9fKgZayLtbF/fKYdmIEa3
MIME-Version: 1.0
X-Received: by 2002:a05:6638:dd1:b0:349:dee3:4b1e with SMTP id
 m17-20020a0566380dd100b00349dee34b1emr5227057jaj.56.1661568071381; Fri, 26
 Aug 2022 19:41:11 -0700 (PDT)
Date:   Fri, 26 Aug 2022 19:41:11 -0700
In-Reply-To: <20220827023941.2613-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aa392d05e72ff61e@google.com>
Subject: Re: [syzbot] BUG: corrupted list in efivar_entry_remove
From:   syzbot <syzbot+1902c359bfcaf39c46f2@syzkaller.appspotmail.com>
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

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git on commit 680fb5b009e8: failed to run ["git" "checkout" "680fb5b009e8"]: exit status 1
error: pathspec '680fb5b009e8' did not match any file(s) known to git



Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 680fb5b009e8
dashboard link: https://syzkaller.appspot.com/bug?extid=1902c359bfcaf39c46f2
compiler:       
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15835ae7080000

