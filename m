Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B975D4ED962
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 14:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235888AbiCaMLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 08:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235833AbiCaMK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:10:59 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD161427C1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 05:09:11 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id h10-20020a05660224ca00b0064c77aa4477so7907520ioe.17
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 05:09:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=18Mkz+OV0uH/o0z5c+hvbkz/PLf1Z22tYk19vV/U/Xo=;
        b=Vq6LMfHyXRuib6Vs50zP8Bqagbe5MKt2ooaL2lSl6q4EiE3bXm5PU/3qk65aNUYiXL
         eEwasJclz2yelR2ujfu0loHP+0awYZ5LV7XH6Xx4E11PfKmf62gc2ualdHye+4hmWK+o
         1DQoM6qLX4k2HmAJ0qYR134GlInobg7Um5ntRyQvirIX47k4x00dBE4jz0wij7EyvxcN
         qcwgZ30/LnB8J5XYYDrLWeSOTuW1PeROmPREZxg3KzpdOvnekOJmWD6fThz6Hkij3Rfu
         QK94WAZkp2fiw0WxMT+H/75RXnB4E9tXiSMDIU/lVVNGaZu3lJDj4S8Y0p7qJCiEa5RI
         hr9g==
X-Gm-Message-State: AOAM530hGaRZYq9Y6kkMahIXMFYOKgOUhzRNv3UyGMghYmI0okcJ/KGd
        44vig+JPb93Zyct3MnEcC9gWV5bW2odloo2PXWG9EEPimFQv
X-Google-Smtp-Source: ABdhPJwfjfctyb9xR2ToAiKlE3H2I/5ji+1dmKCX6eUc/NV/qz38S5exg5HTq9L0ON8VSg81R8t4wziwA5YVlBUZNJDW+yM/0nnj
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2d90:b0:63d:b41e:e4e4 with SMTP id
 k16-20020a0566022d9000b0063db41ee4e4mr14064269iow.172.1648728550744; Thu, 31
 Mar 2022 05:09:10 -0700 (PDT)
Date:   Thu, 31 Mar 2022 05:09:10 -0700
In-Reply-To: <20220331093522.4712-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000099288705db828735@google.com>
Subject: Re: [syzbot] general protection fault in smc_pnet_add (2)
From:   syzbot <syzbot+03e3e228510223dabd34@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+03e3e228510223dabd34@syzkaller.appspotmail.com

Tested on:

commit:         d82a6c5e net: prestera: acl: make read-only array clie..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/
kernel config:  https://syzkaller.appspot.com/x/.config?x=cce8a73d5200f3c0
dashboard link: https://syzkaller.appspot.com/bug?extid=03e3e228510223dabd34
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17949c87700000

Note: testing is done by a robot and is best-effort only.
