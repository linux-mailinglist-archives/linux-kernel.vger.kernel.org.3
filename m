Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF46A536B7B
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 09:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiE1HxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 03:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiE1HxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 03:53:15 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADE6B13
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 00:53:14 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id l67-20020a6b3e46000000b00660b8c61a31so3919353ioa.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 00:53:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=k12H14fTkAkalc/6+WsNOIirEfbstqXEz7Gz+8J7vBo=;
        b=UyNEwiqlzMjGy2t3TUK2k5b1dPHowjKhgk+RSk9F8vNNWIyrwJ25EjBf6pZfjKp8iL
         Au+uj7R58KtNCjeXaZVV/UK9a+kw+H/xGe6EQVBGoXSB/4FrL8tGBtBp5kzHGnfuhwZ7
         6VYSm1HjB6jIv9BLUfKD+99wfRmnB1zJ6CqxXuv/eNWZXjDa7UrLy05oAJOhvdkNvtBz
         Mzku4jBlfVipU/MU5DjJVRJTHDyVhui2NRkcwZyX2Az5IuXmn7MFFPUfjI3LjLHzOMAG
         JGLmufypEjyAC8lasu9yr/XqfmdkuUtx/hAshw+1sYXbvE+QyDgRaZumezAmdH2FUEPH
         /U6A==
X-Gm-Message-State: AOAM53038HU9+Rrku+Vgj7pAFZyAzm5WZ+AUU0XeB7+hX06Uab8u9Sop
        5aB3FF4a8bbETObZf8GFBJ+U2co+vlJDeXmirLcQS+slLfWU
X-Google-Smtp-Source: ABdhPJzS8ehE/Ax2cl2JoQjhoN+vaRL4D9wedTWlpmvpcddnfmR1U4l5atscQjeeuhzRxTyRpJaPVDcGDP5hA+/T3sPgIebpmW0J
MIME-Version: 1.0
X-Received: by 2002:a05:6638:329b:b0:32e:d7c1:c30 with SMTP id
 f27-20020a056638329b00b0032ed7c10c30mr12944168jav.19.1653724394035; Sat, 28
 May 2022 00:53:14 -0700 (PDT)
Date:   Sat, 28 May 2022 00:53:14 -0700
In-Reply-To: <20220528073417.3900-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000010219805e00db787@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Write in udf_close_lvid
From:   syzbot <syzbot+60864ed35b1073540d57@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+60864ed35b1073540d57@syzkaller.appspotmail.com

Tested on:

commit:         97fa5887 USB: new quirk for Dell Gen 2 devices
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=cacd11c8fed2980d
dashboard link: https://syzkaller.appspot.com/bug?extid=60864ed35b1073540d57
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1373055bf00000

Note: testing is done by a robot and is best-effort only.
