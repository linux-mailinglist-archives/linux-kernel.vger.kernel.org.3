Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027DC53D66A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 12:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbiFDK3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 06:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbiFDK3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 06:29:09 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A701517A94
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 03:29:08 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id c7-20020a6bec07000000b0066942b01338so90683ioh.10
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 03:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=wNXC2m/6IoCuykSeYloTIGgg/Di4mRUeB5x9FgRaY1E=;
        b=xNIpxf5yhI/2nukGBLKbXTEnkcf7qq76vYFu66cjSzTO3u5YgNXTdCM2vYHw7qM6j0
         Bxup7tiYnthh0bkfnwJTGIODj4lmsfBM8enVMRZnsdrts7Xxc/Gyk5pE7cplgbsZNl+G
         iKnjkertgSrs6mHuR+1ED9Okt9J9ZJQ3sgmF4M90SMLvggV3fs5cHxMexslJxnohEbDw
         kN6XkxR4O960jYz40w/d4bUvObUo59PPyUxhO9KEg1VbUVYITiqD6ajkQ2T0bVT0kS8t
         VrkcQWBJNhUaU6vaB9soaQE97S9LeOhhs/JbDdif51pZ5JOLNUR7NWacZSul1f8RpUSQ
         P/rg==
X-Gm-Message-State: AOAM533c7nk+VZbBpMBGHrC8lUpg4i+ldE891AMLPZJbNqeO31UXleJo
        Kif62MGkg8MM8AKQ+szhsYySUoTMafj2m2ykw0l0n34oDf5e
X-Google-Smtp-Source: ABdhPJz028rOgk1V8oD10N504F+Au1sdNchit4WLjaBUMrtWitzNPXqDiq+rWxh52w9wKOYRYIKURFmGJe5BYlL9lKEoa8TfmhK0
MIME-Version: 1.0
X-Received: by 2002:a02:852f:0:b0:331:8c7e:691 with SMTP id
 g44-20020a02852f000000b003318c7e0691mr1018029jai.169.1654338548070; Sat, 04
 Jun 2022 03:29:08 -0700 (PDT)
Date:   Sat, 04 Jun 2022 03:29:08 -0700
In-Reply-To: <20220604072852.5532-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007f016405e09cb5ed@google.com>
Subject: Re: [syzbot] kernel BUG in __skb_gso_segment
From:   syzbot <syzbot+7160965e6a93d826048a@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+7160965e6a93d826048a@syzkaller.appspotmail.com

Tested on:

commit:         e9d3f809 net/af_packet: make sure to pull mac header
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=e2c9c27babb4d679
dashboard link: https://syzkaller.appspot.com/bug?extid=7160965e6a93d826048a
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
