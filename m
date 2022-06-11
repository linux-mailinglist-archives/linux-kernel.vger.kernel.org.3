Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF98A54721A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 06:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346769AbiFKExK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 00:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236616AbiFKExI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 00:53:08 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D75CB2C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 21:53:08 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id j18-20020a056e02219200b002d3aff22b4cso762046ila.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 21:53:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=5BVF3R9ZpskfttzoBFPBkmEaU/6aBPz16Q31u+QXpkI=;
        b=aquOmho7adLKVIwGn6vVnMnofv4WuiipqPEeCg6QV1TZEdw21SLaPXOyDIQ4wunT3V
         UT8YhS2eXoGpg7OXzvofY9dLJv1xKtlYJlRdgf69yif5Zk2AkDyZiMr8g9a4wOy8Hjvd
         9+BSSUjxDAvXQWPJUcQE+ZdUq3Q8CARgBIvtmiq9gET5XqElLYv5TTNuX9x9iAvV3J/A
         ODxxIQK8mpkYi8fibpxKgmYo/0KxrKcHIWy2iOq03AIzO8hMkiC+grMMV/BOQgtSjuCR
         a/MbLuRizwbvtGO+uzUXlx3qQp2Ykjg3Vml9CUNCf6SKPVcPb5EN+45e+h+cEEF1Z9oO
         FyOw==
X-Gm-Message-State: AOAM5323oJHpLZ3a0GhDyYxHoJzmwSqiEDlOY0XKASWkI9NfqcImo8/G
        1ATHzvG3x2qXYtgzXpk5p1KxE6lVzc0OcGLd51Clnen96Efa
X-Google-Smtp-Source: ABdhPJz/JVHvn3OyXnbiWnz4nN2I7tk8/iuJ/0n/WIgUzela16tJLKt69VxKUpevIJ7C69Rnv+GMV+XU/A/XwTh8GaJGQ3h7CoT0
MIME-Version: 1.0
X-Received: by 2002:a05:6602:27cc:b0:5f0:876e:126b with SMTP id
 l12-20020a05660227cc00b005f0876e126bmr23545953ios.129.1654923187667; Fri, 10
 Jun 2022 21:53:07 -0700 (PDT)
Date:   Fri, 10 Jun 2022 21:53:07 -0700
In-Reply-To: <20220611043411.1727-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bb466905e124d4c7@google.com>
Subject: Re: [syzbot] WARNING in ext4_dirty_folio
From:   syzbot <syzbot+ecab51a4a5b9f26eeaa1@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+ecab51a4a5b9f26eeaa1@syzkaller.appspotmail.com

Tested on:

commit:         cf67838c selftests net: fix bpf build error
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16db1cd7f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc5a30a131480a80
dashboard link: https://syzkaller.appspot.com/bug?extid=ecab51a4a5b9f26eeaa1
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=113aa46bf00000

Note: testing is done by a robot and is best-effort only.
