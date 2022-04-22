Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E810950B7F5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447750AbiDVNNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234118AbiDVNNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:13:04 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3DE22BF7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 06:10:11 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id k2-20020a0566022a4200b00654c0f121a9so5380403iov.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 06:10:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=RMrxfkxhED/k+onCuiWjc6y9Gxw24l3qWHTwIY1akbI=;
        b=bA/xTG6YZOFYlOmLJUuposisHWMF8j1SCTCuLWGL/JLTkgZtnuEZvF50ro0WmsgPjr
         b77OSFVN2MyEWMoi9mMUPEcXtNTw2pkq0m9CfyYpVC5MdNYuzvonALESzAMF60GufVoQ
         PdLTvasEk5EIwB+8B6HV6rIpxrhFtk0ZqqNySs8/Rn9kNonHIMbW7OWL7wYRb0L+8Pl0
         WCSjE/k0wziCQ+KQUyVv5aEi6gQSf1ZW/uJN/zc70WOn14m+O6HVAGLfKybYYGJpx1xt
         kgdxIVlc35o0CH/W6O5B+n+wkkOJEFGgjLlTHdThKDp7KZ2qpYKvTwagG0XEMh1eQoS8
         7eRg==
X-Gm-Message-State: AOAM533Ozzy+qYebrETOXVy0Qmml0EXEgzqR1b3o9FP/N80yiVDCjwFP
        Gc2XSHHaAbVBouV9SP+bYQyj7icb3xqXF2rswVQqozdToqY0
X-Google-Smtp-Source: ABdhPJyeaqqI7JHo9FAL401hlQu8WtxIW+9yMSfrIfTTsaFHRPrqpc2jS1eX6kxLqpTxIbluC5uTU+HTakE56AivA9mn5OJ4katY
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:e11:b0:2cc:3377:416 with SMTP id
 a17-20020a056e020e1100b002cc33770416mr1843031ilk.308.1650633010715; Fri, 22
 Apr 2022 06:10:10 -0700 (PDT)
Date:   Fri, 22 Apr 2022 06:10:10 -0700
In-Reply-To: <20220422125227.2853-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004223fc05dd3df2d0@google.com>
Subject: Re: [syzbot] kernel BUG in __filemap_get_folio
From:   syzbot <syzbot+cf4cf13056f85dec2c40@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
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

commit:         559089e0 vmalloc: replace VM_NO_HUGE_VMAP with VM_ALLO..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
kernel config:  https://syzkaller.appspot.com/x/.config?x=dd7c9a79dfcfa205
dashboard link: https://syzkaller.appspot.com/bug?extid=cf4cf13056f85dec2c40
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1670e278f00000

Note: testing is done by a robot and is best-effort only.
