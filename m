Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4C14E696F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 20:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353330AbiCXTqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 15:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353267AbiCXTpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 15:45:51 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8274A38BFC
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 12:44:15 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id o17-20020a92c691000000b002c2c04aebe7so3380152ilg.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 12:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=0y3xyJU9KpgMz1igevVEvpwA8jK8DVLay4wlNnV5yQo=;
        b=raSmmfB3zMxIDjSsW37B2a/tmrBt/Tyk+G6Fa8XYjxN4o20kBbCSdlPoxYP9WVY0sz
         tZKrWOezItGrqS221h8Y163Y5cm+hAZBNtD5iRs9zmIJRCrL54UyJXzN5+H8bDJ3MBfv
         B7jL7ESa0q7fER1XODds9va7YaqBSq3UXdYpkKghXUSpmEe/wgkHebVugvUzi5pbvreN
         VtfhLYwI93G3GMcYDnKrrdaH6c14a17vw3yVpto2jo0XJgRXxpGk6EQF+hxaR2MX8Fml
         tQjcdNXKW4f38bxGh78rv/2z6gT6LkfRwfC4g+3Or//ySWMDZ2Of491iL5M8WlqiqoOf
         Wu2Q==
X-Gm-Message-State: AOAM532ttBo0e+kAjyxoJCHZnCdhWYHFQtt9zeeUbqy3UdOsFCAnohwh
        mbiqVI76tnQ3rr+BEb3RT4MGrzut3LtCFag47Up15U6sm2N3
X-Google-Smtp-Source: ABdhPJxKNlf65kZLBnDRa4mkFMuTOqSR+nfBdZtpkRQxcnvZhHSD0FXdnXU2NPf2U/DNv5QCRJWf9hkzn+xtGOGB2XdYjfmz0aCb
MIME-Version: 1.0
X-Received: by 2002:a6b:14a:0:b0:649:a974:9042 with SMTP id
 71-20020a6b014a000000b00649a9749042mr3578558iob.81.1648151054912; Thu, 24 Mar
 2022 12:44:14 -0700 (PDT)
Date:   Thu, 24 Mar 2022 12:44:14 -0700
In-Reply-To: <CAMZfGtVzUZmz7UObNfEgbxue32_2rivajTbiwZQhGkGhDzLthA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002a12c105dafc12e0@google.com>
Subject: Re: [syzbot] general protection fault in list_lru_add
From:   syzbot <syzbot+f8c45ccc7d5d45fc5965@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, dvyukov@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        songmuchun@bytedance.com, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org
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

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file mm/list_lru.c
Hunk #1 succeeded at 76 with fuzz 2 (offset 9 lines).
Hunk #2 FAILED at 76.
1 out of 2 hunks FAILED



Tested on:

commit:         5abc1e37 mm: list_lru: allocate list_lru_one only when..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
dashboard link: https://syzkaller.appspot.com/bug?extid=f8c45ccc7d5d45fc5965
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=164cecb3700000

