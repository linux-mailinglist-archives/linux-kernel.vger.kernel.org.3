Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7104E669E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 17:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346626AbiCXQH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 12:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243557AbiCXQHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 12:07:44 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87391035
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 09:06:09 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id u10-20020a5ec00a000000b00648e5804d5bso3366794iol.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 09:06:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=FbzRbiu5vJCDRMtVtSTdRIE8gG5etNsd6nvcljrLMyY=;
        b=QKcFHkyH6yt+2MAflFDip0qsfVSl4wR25li2Kcux98DQaaSvqetu8dPMo2o+WJtcGY
         mEn2rs2IRWmSwC3DPQPzV4Jh1Vhn7AZAysAt6/Zh+s/axr0HPubFdDMKpbmuFxpWOzta
         ypaQt6Ejbo1vlHuktLJJVPehcq88xGeZJb33UoNUVEZBmIcxQ0NlTnsjfcyUMpRMcha0
         sY+xXdbA/MMZGdyogkSa25CDwcI/PydKpw3UPkagUGIL4N5CJfy3lYzxe5pZrpi2b1Bl
         bXo0xJEhN++q8lWBGcRXDs3OvrUZeuZltLQ7CAPff1yJPTJweobM3MA2Xeu36DFwG2wz
         rk4Q==
X-Gm-Message-State: AOAM531pExU8s3zj0hwmM5giz9Z02SRpMYWU+kYbZiZbdot8qrQQjigt
        9UDfDBuGzUaKzRsfV9fY1fwP2l6AvEENqXEJ0zb9LZZqS2Rk
X-Google-Smtp-Source: ABdhPJxZkWsrdCGt6DrEiMHFZWjgkikINkI3G4vtYbV6h142DwTtAkEg7dOMGUx2joKmKnqq/26KBBrRRcz3b843x8qnBKCCPJWi
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2ac3:b0:649:1357:44b8 with SMTP id
 m3-20020a0566022ac300b00649135744b8mr3140855iov.159.1648137969221; Thu, 24
 Mar 2022 09:06:09 -0700 (PDT)
Date:   Thu, 24 Mar 2022 09:06:09 -0700
In-Reply-To: <20220324133429.3841-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000032471505daf90696@google.com>
Subject: Re: [syzbot] INFO: task can't die in vmci_qp_broker_detach
From:   syzbot <syzbot+6e07eb10996f8ea7a825@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+6e07eb10996f8ea7a825@syzkaller.appspotmail.com

Tested on:

commit:         6b1f86f8 Merge tag 'folio-5.18b' of git://git.infradea..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
kernel config:  https://syzkaller.appspot.com/x/.config?x=bc982714c733be2b
dashboard link: https://syzkaller.appspot.com/bug?extid=6e07eb10996f8ea7a825
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15b451db700000

Note: testing is done by a robot and is best-effort only.
