Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498EB50620B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 04:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344477AbiDSC1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 22:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242194AbiDSC1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 22:27:52 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA24AE73
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 19:25:11 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id g16-20020a05660203d000b005f7b3b0642eso10786397iov.16
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 19:25:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=L2HlMjbuv8DDmn+bIIQUm0YxArO0essYjE9LzbNI0b4=;
        b=2/h2Cz0SW8y7JZ6L2rDqF52B+MuPyijp4rXz3kf2VnudPtG+Tr+W+UV+oGcGGEtclF
         p+9xEwZRjm1n4ZvE/jwlGVcwTMsN6+MEPt7e+u9pEk7xO9ob4WMEOkgvn/9t4Bd1TIlE
         cZuTuImXJ6qZK4U+e0/Qw0FeI8oCC5bduiZa7rhiw/Cmr4FwbT8/YbIR/Ysiy4PPPZRW
         yx+5bce8uqbQTmwluCRZNkx5hyhob/G4QVlX6EQtFS7Qs+URC7GQe9BdzUHgNrMU3OyX
         i4Mm8WTpJxEuwVHESxMvdByZIOGc+o2O8txfkA0zq/MA8nynols9nk9M4v4C4e9815gL
         Dw4g==
X-Gm-Message-State: AOAM530V6vVkysys7/s1GnPrqAOViuXugvobQKcSeyt+VNweXwUXJupt
        IH6H8kq9Ue0bgQo96SlcW0HloTZYGA2XO4kWgF/9wV/bQ726
X-Google-Smtp-Source: ABdhPJzxYIm/4YCS1NyeJ+EwxUsIOy6SEvBiQ9fyjNj0ySmX8xI1+nQytZNVJ7McSLsWauwzI6ZiGPdvGT6pkms6eGGIHsAE6pkO
MIME-Version: 1.0
X-Received: by 2002:a05:6638:24d0:b0:328:6343:60ff with SMTP id
 y16-20020a05663824d000b00328634360ffmr6505071jat.41.1650335110421; Mon, 18
 Apr 2022 19:25:10 -0700 (PDT)
Date:   Mon, 18 Apr 2022 19:25:10 -0700
In-Reply-To: <20220419021532.1932-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000465d905dcf89693@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in __snd_rawmidi_transmit_peek
From:   syzbot <syzbot+70e777a39907d6d5fd0a@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+70e777a39907d6d5fd0a@syzkaller.appspotmail.com

Tested on:

commit:         a1994480 Merge tag 'hardening-v5.18-rc3' of git://git...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
kernel config:  https://syzkaller.appspot.com/x/.config?x=eb177500e563582f
dashboard link: https://syzkaller.appspot.com/bug?extid=70e777a39907d6d5fd0a
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1096d994f00000

Note: testing is done by a robot and is best-effort only.
