Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CF7502115
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 05:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349179AbiDODzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 23:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347119AbiDODzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 23:55:35 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC679F6D1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 20:53:08 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id v14-20020a056e020f8e00b002caa6a5d918so4167679ilo.15
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 20:53:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=U6CTm5B28M4afqEsb8LPbBd2WBwUyyQSnNk1TL0GxsY=;
        b=5w08xXGbLixslCGJw5SsqUUXsIMzEG4+EeX+ijq+A+o4nnoV72MIf0Qkmp+kmNabGV
         Ocl+TH/h2iTnQhev3P9OYTfkf6HGzbJr+dDhf6EQ6nRKxWMt6pPyxwIRg6VdsmjsTXgM
         MZdhhiPuqOZOXYBZ8rBciuhd5ExS0v4PbZTl1SOLsc/qnYFwMQoZvzI7AfBDGHiG5UXs
         /RlT3jjNFYqEFJKom/oWOHsDaSEy5gWwicakcyKWT52ZC8UGRhpyK2gW78Fp2CbwXEpk
         sDit7oQG0te/7o/9Nu8SIAJzh/i0A2N6aOOMM4+sgp5vZLxutMmghHYTiC38w2g6AObA
         wH3w==
X-Gm-Message-State: AOAM532HiZIYfREEfgACK6fJPyfFsScYTqMnwpHMqRGCneWYz1OFGfQM
        ENtrYkYlALANi+AKU9HMA+fs/xPamhH+kRZQiiLMogK95V5U
X-Google-Smtp-Source: ABdhPJyOMibi3Uo2BHXwnwVuCuZurLC7/1DxJGVZT13swTyDcxeFOyh3vUIWCljjNMRqJH0bk9xYR5ywHUhENm/znfnIr+8adPN3
MIME-Version: 1.0
X-Received: by 2002:a6b:1495:0:b0:645:b115:611c with SMTP id
 143-20020a6b1495000000b00645b115611cmr2564723iou.199.1649994787553; Thu, 14
 Apr 2022 20:53:07 -0700 (PDT)
Date:   Thu, 14 Apr 2022 20:53:07 -0700
In-Reply-To: <CAAZOf26b5bOV76F3hcv-p_BuGQm6BO_qNXXB9astHk5NfPTnKA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000031879e05dca9594a@google.com>
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
patch:          https://syzkaller.appspot.com/x/patch.diff?x=151cb868f00000

Note: testing is done by a robot and is best-effort only.
