Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A78259B675
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 23:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiHUVkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 17:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbiHUVkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 17:40:11 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19A91EAC8
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 14:40:10 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id a4-20020a056e0208a400b002e4621942dfso7188921ilt.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 14:40:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=kow/SkyWGXjXGWl6s/0v1U2Y6HaQXujf1AsVhEPbsdc=;
        b=JlWiMV2nDOJr9521SRPtckQ/Mulwb3RHGWKGmUvIOHBU4ZcAf5qlZnKGWAdmi0Fqc8
         iBUuQ74I3KtQ2kuqcP4LyXu5jOJGOPX9Cybdbkou1998cYKi0/OruF0WZKGTkFdBbwSb
         Dau50wMxjmf5ftPucXnxLDeQYzNd3SwpNrcRNerqAfytjwYFu9h/FSr8z2XWSCzoFjAZ
         NzQVOLAeV1vgKBcjslnN39D7/tpJYpK72dhOblBa0L5JfX0wJRUBHpn4fC2ETg0ZYfec
         7GIzud71ZDwVOyUYmR6SuvknD4fcGviipyBIFAF8QrDRwE+gqCrKtGODAXWSPF5OwYHl
         uZpg==
X-Gm-Message-State: ACgBeo1L4VpHpRlgncx7RZl7aKUbtaomDl49AGNjFzNF4J8yyNXvpKre
        jGemrS3mwsztDGw1ZR3vlIZN/9wVeYiDaEqLfHRDR0hVae64
X-Google-Smtp-Source: AA6agR7zCz/DiWGpqPVMqEafgWNdubjS5aDSok9nvMO8odWsZxoEX+4wpI9T+XTMUWmPn8XJ0lKjYtDbksQ+9pT17mBhZ9TbS+Pg
MIME-Version: 1.0
X-Received: by 2002:a02:a711:0:b0:349:db96:7708 with SMTP id
 k17-20020a02a711000000b00349db967708mr840223jam.36.1661118010130; Sun, 21 Aug
 2022 14:40:10 -0700 (PDT)
Date:   Sun, 21 Aug 2022 14:40:10 -0700
In-Reply-To: <20220821123026.2119-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ec884905e6c72cd5@google.com>
Subject: Re: [syzbot] general protection fault in binder_alloc_new_buf
From:   syzbot <syzbot+f7dc54e5be28950ac459@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+f7dc54e5be28950ac459@syzkaller.appspotmail.com

Tested on:

commit:         8755ae45 Add linux-next specific files for 20220819
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12153aa5080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ead6107a3bbe3c62
dashboard link: https://syzkaller.appspot.com/bug?extid=f7dc54e5be28950ac459
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17da1a3d080000

Note: testing is done by a robot and is best-effort only.
