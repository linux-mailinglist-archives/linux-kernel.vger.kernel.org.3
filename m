Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080444EB5AD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 00:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236569AbiC2WOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 18:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236467AbiC2WNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 18:13:52 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDA5186FAD
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 15:12:09 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id b15-20020a05660214cf00b00648a910b964so13244041iow.19
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 15:12:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=OOoVa+V/irW/x+0wA9yzjLGHzahFLKZsDL8MQwHOdOk=;
        b=ECpWTSmjHRG/MEihJ6B3DN6O8pSFIBCQa+6louhF3Rv+iYBlgi0Q/5Kl2xrOvtOcny
         ND6nMvVrrN9Hm6hQTnqWa7+3sEco4e+APbzC2Kk2k2eLXr3Br4huAticZ3HDW+FC+Uxm
         KJ6QPT5am3mKpcFsTHSHFF1MNTwJQtSdKAc89Na54wlbTyIbnvUXw/UgQI5r53a0dT+Z
         xnfGhM8Os6cIIBJVoaB0SiDm+ZIzf5krKi0PmunhYM5aimyNzZTRc+rTIYdsjhuklzUW
         +d6fAHEa8e0gCx9YQg+UFMhrhlD8tsKViBp4ZaeRTN7z/q3pfPI0gOynxC1edHre2suK
         iHFA==
X-Gm-Message-State: AOAM531LSTPD8K1n2oL0b89T9FGTuSNiFrPEopc6eXcRqiN4ELLVxwa3
        rM8D/XnWOjYw2PZ+T/mA9H/uV7oUYsWYYo2vAKL6O2NQnAoc
X-Google-Smtp-Source: ABdhPJw3pahBeObtq8ZwZuFbJHHaAzDqVoMW2fRmLcGfMwRzoQkSN2/0Mynl0syuHLCkZzBNOgbVxEEbxorg8AC0mn61Oh8R+l2M
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2053:b0:31a:4907:ff65 with SMTP id
 t19-20020a056638205300b0031a4907ff65mr16979897jaj.224.1648591928519; Tue, 29
 Mar 2022 15:12:08 -0700 (PDT)
Date:   Tue, 29 Mar 2022 15:12:08 -0700
In-Reply-To: <419a9bb8-cb68-8add-e7be-275a48b2126d@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000476f2c05db62b851@google.com>
Subject: Re: [syzbot] general protection fault in dma_fence_array_first
From:   syzbot <syzbot+5c943fe38e86d615cac2@syzkaller.appspotmail.com>
To:     christian.koenig@amd.com, daniel.vetter@ffwll.ch,
        dri-devel@lists.freedesktop.org, gustavo@padovan.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, paskripkin@gmail.com,
        sumit.semwal@linaro.org, syzkaller-bugs@googlegroups.com
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

Reported-and-tested-by: syzbot+5c943fe38e86d615cac2@syzkaller.appspotmail.com

Tested on:

commit:         c2528a0c Add linux-next specific files for 20220329
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=88d1370cc1f241e6
dashboard link: https://syzkaller.appspot.com/bug?extid=5c943fe38e86d615cac2
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=128372e7700000

Note: testing is done by a robot and is best-effort only.
