Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CC44E5BC1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 00:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345467AbiCWXSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 19:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345465AbiCWXSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 19:18:45 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F67090CDC
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 16:17:15 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id x16-20020a6bfe10000000b006409f03e39eso2009930ioh.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 16:17:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=clW1tH3ZC7Lm0X7T/4WUZGOowaN8nMkUH4EAKd7mMwA=;
        b=cAVshD8mCTiijJoG/DI7/H1QRzC48kdJuViYWURHFfgDQlJbvPHqAdmbncS2Vkq8tK
         NKMOF9bZ174TnJAdCAsLZoKDxOrDcgPUcbY6+8Uu5S/6U+dCKFZlQ/c2auisVzhQiQ/L
         8VB48VrSNtme+S38C8P7/qvUejYHdU2nk+vOmuSZBPfJaFhQJXDxzUUbRF29LstbvswF
         HxQaMz568LeLbAI7YyTwyYQuHnBS6ygrhnlcJH4Sv+qx7hv7ngXe3mngK3xA4LpT4Yo6
         A0SjeWirUWib7ZRlmIPhV7RWY+70vj3Ye/LRbO1rvkkl+eQxfh/nTHehfm1J494J0Z2w
         ASZA==
X-Gm-Message-State: AOAM533YTBurBWAWdq+8KjbPlpTdmV9IuWJWLlZQjMWuIEtsk/NA1HdC
        Beg/s3WH+UmKwERMf+o4T2IhAmO6ENQD3A1g5wz+IeVK4qdQ
X-Google-Smtp-Source: ABdhPJx5oe25ghsA451wnyS8jAONpeOgSsVTFqm8sKVCgTUeGUlgGdMSvN/eNIS6+5zzG5XyESpkqmR7/ui7OT1nLeHmmeEH+AaQ
MIME-Version: 1.0
X-Received: by 2002:a5d:860d:0:b0:649:be05:7b0b with SMTP id
 f13-20020a5d860d000000b00649be057b0bmr1283401iol.22.1648077434896; Wed, 23
 Mar 2022 16:17:14 -0700 (PDT)
Date:   Wed, 23 Mar 2022 16:17:14 -0700
In-Reply-To: <442f565c-b68c-9359-60d1-dd61213d3233@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000011c72405daeaee81@google.com>
Subject: Re: [syzbot] INFO: task hung in io_wq_put_and_exit (3)
From:   syzbot <syzbot+adb05ed2853417be49ce@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+adb05ed2853417be49ce@syzkaller.appspotmail.com

Tested on:

commit:         8a3e8ee5 io_uring: add flag for disabling provided buf..
git tree:       git://git.kernel.dk/linux-block for-5.18/io_uring
kernel config:  https://syzkaller.appspot.com/x/.config?x=3172c0bf8614827
dashboard link: https://syzkaller.appspot.com/bug?extid=adb05ed2853417be49ce
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
