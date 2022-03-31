Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B904ED12A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 03:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352223AbiCaBGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 21:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343946AbiCaBF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 21:05:58 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223CE13D45
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 18:04:12 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id o17-20020a92c691000000b002c2c04aebe7so12418863ilg.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 18:04:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=fR3ceJxR0EpnoFlnx4o/ydku61CbdG3l1dIaszhWt6E=;
        b=xhwNQvdIkZ+cW5+57FJVw9vF7nXDNlptyGFVMlle3qtw5EtifvBECqZUYq0kBlEtrF
         0PA7U74cu7e3nBhNX+v2f1SnpSVnLRcCe5nhvOs4Ti38owhHwK9TMNMPZqTTH0ue32C8
         njESulBjRO7Ol/s9OdKKFDPDo9HtM5SAmaQMdU76+M6mPngOhZ8SFdHtINJ7VLgRakPz
         NpK+KqivGsYERvxOFKj7DcIuMa0hpkFxVdKBVsIE8zXJzxYanar0881F7hMnwptlee7f
         WgVqU9QWqytwQx1Tu3Y1y6e6JsTEoNjpZg9stVEZQQWsw4HlAEn//q8C5vPNkcGz1woF
         jsHg==
X-Gm-Message-State: AOAM533bWvAEiYzLpGsPksqs8cclKZyvUgm9aP8CVgGuuP9WWApTDNpK
        gFotxdj7h72zkaluLM/dkzd9L+3kpOhJu2nVczXSrKMVR4Lv
X-Google-Smtp-Source: ABdhPJweug8GF4GuFOFiRS5cqt1c1S8Zz5P8V+cAFrpG0xb5/uakf8yvmFv8IjvFeDnZZJJErmtkUkUoyIcOYKG9OS9po4XKtxWb
MIME-Version: 1.0
X-Received: by 2002:a05:6638:14c6:b0:319:e02c:1fc2 with SMTP id
 l6-20020a05663814c600b00319e02c1fc2mr1560048jak.44.1648688651492; Wed, 30 Mar
 2022 18:04:11 -0700 (PDT)
Date:   Wed, 30 Mar 2022 18:04:11 -0700
In-Reply-To: <20220331003321.4592-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006ae3f105db793d92@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in em28xx_init_extension (2)
From:   syzbot <syzbot+99d6c66dbbc484f50e1c@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+99d6c66dbbc484f50e1c@syzkaller.appspotmail.com

Tested on:

commit:         52d543b5 Merge tag 'for-linus-5.17-1' of https://githu..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
kernel config:  https://syzkaller.appspot.com/x/.config?x=7094767cefc58fb9
dashboard link: https://syzkaller.appspot.com/bug?extid=99d6c66dbbc484f50e1c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10453cd7700000

Note: testing is done by a robot and is best-effort only.
