Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE13755DBC8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236698AbiF0LjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 07:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236475AbiF0Lhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 07:37:34 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB21132
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 04:33:12 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id n14-20020a056e021bae00b002d92c91da8aso5534888ili.15
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 04:33:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=r74xeVThUWO/LSsITiSIjgYPJgIfQdHJyOxtqSL9wTk=;
        b=2CvJQpU30PZwf2rU+CKtpWDUGD4PjeZsv9uQvK7gGe5GaHsrBdy8Cp9YXtat5TUOHg
         h0MMdmawJNeCCW8/K2yq4tftmgEhWmdDZ7KPXWixzLPtLzudXq4UgG2IRYTM+MQIfh5M
         J3l46x2MgNC6o2mv7ZZWO3w0scUCuyxGSafGbWNTDzaM3OzYE+wMJ5wRq+K1/kRCHIKn
         xEg2u1vM7MkQFuSuhno3X8Yy2QlrlwemlCexrmufnlRgz9EIGwbnqSDGQcIBdv6Ukyx0
         Hf1UguwhMBCjH9LkLGpfGgzISvC2Bm3DQ6OU4yXLs5WexRqE6e7ezd8ZFUtxTOrGs9OW
         zK1w==
X-Gm-Message-State: AJIora8M0MzIwZzpDg9mA8oE/AeR3akX3aGhYoXw7yLEFUcn63mGFz/J
        aQpfekrhZgsr911fZSpu6KukYxLZwdg/Im6iH453xt8MTVwv
X-Google-Smtp-Source: AGRyM1tsVe0ETMcrRl7sA/aI/qKL3BgLMLs+jKmmH2MHKhwhhdA8r0+XBjLUHyIHxb+4w16oEXyqavGNKbHsFbpvsdPxZyUwt0yH
MIME-Version: 1.0
X-Received: by 2002:a05:6638:5:b0:339:e628:b96c with SMTP id
 z5-20020a056638000500b00339e628b96cmr7782418jao.203.1656329591485; Mon, 27
 Jun 2022 04:33:11 -0700 (PDT)
Date:   Mon, 27 Jun 2022 04:33:11 -0700
In-Reply-To: <20220627104113.933-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ee810005e26c4817@google.com>
Subject: Re: [syzbot] WARNING in binder_alloc_vma_close
From:   syzbot <syzbot+da54fa8d793ca89c741f@syzkaller.appspotmail.com>
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

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+da54fa8d793ca89c741f@syzkaller.appspotmail.com

Tested on:

commit:         08897940 Add linux-next specific files for 20220623
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16ecb94c080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fb185a52c6ad0a8e
dashboard link: https://syzkaller.appspot.com/bug?extid=da54fa8d793ca89c741f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=134bd9e4080000

Note: testing is done by a robot and is best-effort only.
