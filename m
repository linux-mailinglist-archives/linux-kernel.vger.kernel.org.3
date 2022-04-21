Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC4B50AA3D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 22:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384219AbiDUUpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 16:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245040AbiDUUpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 16:45:02 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C14A4D268
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 13:42:11 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id y19-20020a056e02119300b002c2d3ef05bfso3250847ili.18
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 13:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=QTaJFCvihcUmHDlw/ICH6QwXqyikackCR6G4w+KbOPs=;
        b=qeSJ+yLvxVzb4Pp8DxNyRPgldUHn2ovEVZf/46sZmQ83JhQ/jhDRLUlKnZW/aa1td+
         UY0yoyCGPl6ogs8QIXI3wmGiRb6kSRiS2yVw/AxZDXMcs1owvww/iWhDpC0aiW3PcCM5
         +w/knHQuZqnHYk/OwqV0HOlyxCe3xTkeBKWNCytAzzBDY4bzEeqMhnKv/gUztyXlTBCc
         ijTJnnJmyPxENb9ZsIZqFqXh+vCJQbh43qjVuU9qjVYHbpluv47xvkFg2xIoWTT4DvGN
         u0EKKYJj9/jzY7fY9rDtC+YAVvlacNGJBo3mT7x3qEXIOc3j0m4LbP/8Adm++TsFmkSe
         xmsw==
X-Gm-Message-State: AOAM5315ZMMvcQ9hli0y0sASIuuCiXCqH7/4QdIUzyzT9c3LQzvSAxTQ
        lz6ISLzNSebD7nOtuqjvoEDMcr96okUfNVVEbrFA+3/hK6pp
X-Google-Smtp-Source: ABdhPJxeuoyMPdfv0cavfLIcjxEa18/sMT287zLocnJIrQ8M+pc3e5eXNK/A7/Agt+HpAbdAM8QtmHFfrvF1ro0LqjWafQzEoQNJ
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1bc1:b0:2cd:5db6:d9e8 with SMTP id
 x1-20020a056e021bc100b002cd5db6d9e8mr689285ilv.276.1650573730916; Thu, 21 Apr
 2022 13:42:10 -0700 (PDT)
Date:   Thu, 21 Apr 2022 13:42:10 -0700
In-Reply-To: <83061bda-5a91-6123-a006-aaeb5458d5d7@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e8321c05dd30241a@google.com>
Subject: Re: [syzbot] general protection fault in ntfs_update_mftmirr
From:   syzbot <syzbot+c95173762127ad76a824@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com, ntfs3@lists.linux.dev,
        paskripkin@gmail.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+c95173762127ad76a824@syzkaller.appspotmail.com

Tested on:

commit:         b2534357 Merge tag 'xtensa-20220416' of https://github..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=4cdc9619f45633df
dashboard link: https://syzkaller.appspot.com/bug?extid=c95173762127ad76a824
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1778ee1cf00000

Note: testing is done by a robot and is best-effort only.
