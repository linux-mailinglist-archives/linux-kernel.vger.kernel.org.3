Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E2B57EF3C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 15:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbiGWNmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 09:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGWNmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 09:42:12 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5ABD65D9
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 06:42:09 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id i9-20020a056e021b0900b002dd12dfd5b6so4378186ilv.16
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 06:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=f7HYHx9fnFqWx0fVQu8neY0gvnObCgN2cJwzVmyarl4=;
        b=hY7cjkUAvSypfs7GMs9dCePgN6kY70ZTE4nCFLqv6jv3T7WGmLtPjiL3aMwAPHa1Pm
         nz8YvE1eDU1yYkAO3OHGG/EY+nV/7b9K82vyPeCERzM5XNm2iKjJ7hKxJg5xLm2QEmJN
         ITx8ELSPZ6A+4k+13gahrLUzwSZyrw1e3NruBSf81Zl8MXJRPSF3N0I88lqoSyu2XCRj
         VRIblM99jE0R/DMfmzYgXDllY/A1U176dhZhC3eMDMOAaz9LvnO2GNDs6ZHeuWKlzaVT
         scuF4ihePnk+FeJ7gV8uhhaL3kGfFYo4xSFdhZdxQXQH8mk1Fl+mfSXDcG6ktf3aUw6+
         Seow==
X-Gm-Message-State: AJIora9tAhd1fZjKaOwQy9c84VasXi1coVGBG8dD9K6PUqFf8EZ7CfKZ
        JcI2U66BSA2eUQ8SYn4p5oPWNs5pHwybUn4cLlftWQnlE7U1
X-Google-Smtp-Source: AGRyM1uCI/EYxhqk/qAHognYhHpxDLHaBiohr+z/M3MqwgmS6RLj84xrqGVKU5NBq4XfYHW53tXAnv29/aHiZqzwuLkODA8/0Y90
MIME-Version: 1.0
X-Received: by 2002:a05:6638:15ca:b0:33f:594a:52ba with SMTP id
 i10-20020a05663815ca00b0033f594a52bamr1764126jat.217.1658583728995; Sat, 23
 Jul 2022 06:42:08 -0700 (PDT)
Date:   Sat, 23 Jul 2022 06:42:08 -0700
In-Reply-To: <1822b3971d7.6eb03239234291.5206322384521184060@siddh.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ff41ec05e4791d37@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in post_one_notification
From:   syzbot <syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com>
To:     christophe.jaillet@wanadoo.fr, code@siddh.me, dhowells@redhat.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com

Tested on:

commit:         778e6ace kernel/watch_queue: Make pipe NULL while clea..
git tree:       https://github.com/siddhpant/linux.git post_one_notification
console output: https://syzkaller.appspot.com/x/log.txt?x=13049d52080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=95c061eee05f8e15
dashboard link: https://syzkaller.appspot.com/bug?extid=c70d87ac1d001f29a058
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
