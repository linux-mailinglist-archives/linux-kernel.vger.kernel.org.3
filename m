Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12395537073
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 11:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiE2JlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 05:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiE2JlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 05:41:12 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794D5532E5
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 02:41:11 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id m9-20020a056e021c2900b002d13627892eso6180417ilh.20
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 02:41:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=tYRIh4qNHeFY0bfRgHxO1Z+lb7J6POVfjlxkkF/QeLs=;
        b=yALSdERwA50bZJC8k0bFijXikmiLN6lGIpGDvun4Tagikt+7ZjxgEKEKTVf4aGHqH8
         eVejyR2Zpm/feMRlmhDl8eejyZsP93txz1KwdXuYpam2QdZAdI/jrrgra7CnWLh6fz2r
         X61a73KSpDpgasAsoSBVALjBKCafDfUbV7W/RaUuW/jMDWvlpAZ+/PbqNyJThJYAZF7j
         /SJs5HjrlKfGUyvqD8EP7fGcerQVKwbBZ6vMWoeInSiLN9UXN2J8vikVRPZsijnPU6kw
         auPLlM05WbQ7peuARjfTU8gFCMfIwA3jA62o0kVUGMUDjHg9WtAaPvjuPPdbBiFB0h+4
         kV5Q==
X-Gm-Message-State: AOAM530HOKX6bUbrIsYTWn6bHA+BKtIr5wyTT8CyZJK5+rsn4RATLhyF
        Ja/uT9rqUuiM5u2ZQ3Tg/dbmgyaE9yAzZuvboEMeGJUqvgxz
X-Google-Smtp-Source: ABdhPJx4jUZWSvbhZygWKaWH0Y+nlt6B20DSLR+iIXJyRQe9QvEXAozKs/QyABmFBTAw//GPl7QjfRtOAU6OItRM2ODRrJqokr6T
MIME-Version: 1.0
X-Received: by 2002:a92:ca45:0:b0:2d1:b7cf:26a9 with SMTP id
 q5-20020a92ca45000000b002d1b7cf26a9mr15075806ilo.52.1653817270807; Sun, 29
 May 2022 02:41:10 -0700 (PDT)
Date:   Sun, 29 May 2022 02:41:10 -0700
In-Reply-To: <20220529090856.4089-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f3314905e0235636@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in driver_register
From:   syzbot <syzbot+dc7c3ca638e773db07f6@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+dc7c3ca638e773db07f6@syzkaller.appspotmail.com

Tested on:

commit:         d3fde8ff Add linux-next specific files for 20220527
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=ccb8d66fc9489ef
dashboard link: https://syzkaller.appspot.com/bug?extid=dc7c3ca638e773db07f6
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14fdf0ebf00000

Note: testing is done by a robot and is best-effort only.
