Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130C659FD17
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 16:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237701AbiHXOUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 10:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238463AbiHXOUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 10:20:15 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAE265F8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 07:20:14 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id x7-20020a056e021ca700b002ea01be6018so3967530ill.18
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 07:20:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=rZtrk0HP2tziIl8gfTDQtUr1nJmW8X6DR7NwgCcyZhA=;
        b=2We7TfhGE2KH4htW5Zp1mLc04pvrp3yN2StdFm+nFXKcL5KDhnIZaG1plK+Ay3pxJ5
         Bz0pfgsbNl/NkIKD9NlPhikUrl9x9tT+p3jmxplPSC9d36B1PlDSkegVQL9uOLCVXB9H
         Km6fJHZBz60e6m4Nfr6iAwXpZlLUlM5hlakF9aPjwX71WTxEB2wlenuhaOVt3wHxXSN4
         uxtiD3tOyXk8kC/kJdMZMU0HYjsCaxWqIyEwoHddKv0ZOyuaQGX5WDpByExbPGQM43pT
         7Jzqit5w7mP+vzx+kUBCDKG6DmbHWHy04SWx1YkFfL7l7lqY5XEPuuDtqEyHGTFVvhmk
         ErUQ==
X-Gm-Message-State: ACgBeo0yWvJBhsLL0HSSHQbK4hxxActuMz5tVCFAiOfjCQ7IWg/SZLLS
        KyF17auKuSi6nSvjsyQeteVHIOI8MUxTyICoWq39Yuq85bSo
X-Google-Smtp-Source: AA6agR7thrK+df2sbX3PCoO0TROu3P+YrW44olm31e2KIpETP5QsIzIEKa/Mjgqhh3jAmDv+Awd7fZYdQaKmrSZ8nBLu/8F+OhUM
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1691:b0:349:d047:3943 with SMTP id
 f17-20020a056638169100b00349d0473943mr8064889jat.201.1661350813807; Wed, 24
 Aug 2022 07:20:13 -0700 (PDT)
Date:   Wed, 24 Aug 2022 07:20:13 -0700
In-Reply-To: <20220824120207.2433-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001abba405e6fd6146@google.com>
Subject: Re: [syzbot] INFO: trying to register non-static key in __access_remote_vm
From:   syzbot <syzbot+d011b5a27f77c61c6345@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d011b5a27f77c61c6345@syzkaller.appspotmail.com

Tested on:

commit:         8755ae45 Add linux-next specific files for 20220819
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1340610b080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ead6107a3bbe3c62
dashboard link: https://syzkaller.appspot.com/bug?extid=d011b5a27f77c61c6345
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1286ee0b080000

Note: testing is done by a robot and is best-effort only.
