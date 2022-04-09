Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82B94FA60E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 10:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240526AbiDIImR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 04:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238963AbiDIImQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 04:42:16 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D850915A29
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 01:40:09 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id u10-20020a5ec00a000000b00648e5804d5bso7119284iol.12
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 01:40:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=/bp4t45uO/UCmdMLVdMnZLdvzrBnqeP3SYAoylwRLZw=;
        b=w7Fg+Ic8+HGZVnJ9vidc+CQ+qcNceEdPpVFyufsVeBGAehkU+l9ZOoOlQGqRCk9HHa
         h17rAZhZXE3u2AOvHVxX29+vLFCMNRKS0BX+AboyZvgvdsqQia3FpIo+rtMfPKQnBYRC
         +UJQAVtnhO+60/EwQv2zH9eF9LB9FmLxFmexA2EPjL7NO46R/UBEd3TI1wN22jtmVE0j
         /zCqKKxR9O6gw03EKtSVl7LydDMDBpchTfbyFBM1Toz0XJo9eN+ieeHJqqp2K3FX0pzj
         CSzqbHpFWcx8OHkHM64Gb3hEB5AhFJGM5kVdtCifUi+4ziuwW53fVmZ0aZA+eFo16QtL
         ZX6w==
X-Gm-Message-State: AOAM531KeJQqLty3nr5NF2GBDKh5KnCxBPbAGLMrZcUGptJYcaGeRmm+
        Y5kzOTv2+XQSLpqerLkGCC0lqqkZiqdpNUtDfM9MtuCAsTyd
X-Google-Smtp-Source: ABdhPJzB6NiIE7KBeN2Oe8GaKT0m96EIF/Jc3tq+liSM/KmPVddhh3Dnq+nJRuq2czTw/4Inb1Br7SmGvpipzV8FgXLpqa2tPv0w
MIME-Version: 1.0
X-Received: by 2002:a05:6638:22c5:b0:321:32af:3191 with SMTP id
 j5-20020a05663822c500b0032132af3191mr11229623jat.116.1649493609172; Sat, 09
 Apr 2022 01:40:09 -0700 (PDT)
Date:   Sat, 09 Apr 2022 01:40:09 -0700
In-Reply-To: <CAAZOf24aXhyYd1pv0J63+2oLJ7K=yFFTXm_sE022-spCMMz6QQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a2518505dc34a817@google.com>
Subject: Re: [syzbot] KMSAN: uninit-value in ax88179_led_setting
From:   syzbot <syzbot+d3dbdf31fbe9d8f5f311@syzkaller.appspotmail.com>
To:     arnd@arndb.de, dan.carpenter@oracle.com, davem@davemloft.net,
        glider@google.com, jackychou@asix.com.tw, jannh@google.com,
        jgg@ziepe.ca, k.kahurani@gmail.com, kbuild-all@lists.01.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, lkp@intel.com, netdev@vger.kernel.org,
        pabeni@redhat.com, paskripkin@gmail.com, phil@philpotter.co.uk,
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

Reported-and-tested-by: syzbot+d3dbdf31fbe9d8f5f311@syzkaller.appspotmail.com

Tested on:

commit:         33d9269e Revert "kernel: kmsan: don't instrument stack..
git tree:       https://github.com/google/kmsan.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=d830111cc3be873
dashboard link: https://syzkaller.appspot.com/bug?extid=d3dbdf31fbe9d8f5f311
compiler:       clang version 14.0.0 (/usr/local/google/src/llvm-git-monorepo 2b554920f11c8b763cd9ed9003f4e19b919b8e1f), GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1130ceb7700000

Note: testing is done by a robot and is best-effort only.
