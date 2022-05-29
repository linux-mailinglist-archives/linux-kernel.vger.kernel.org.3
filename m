Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB4B537079
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 11:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiE2J6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 05:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiE2J6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 05:58:16 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5857CB40
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 02:58:15 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id q15-20020a056e0220ef00b002d15dcd2750so6249270ilv.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 02:58:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=NXHQeiJ7R4PPma2lCPY4/Gcxe0k+LjThmEjwi9h42ks=;
        b=wgzEUEyywWAXR5rxIBkbFvz5DDac77ZZl2cz07eGE2R/sWi0hlvxMwyQJSw6bvfpya
         ziNCV0PUvxLufBmlXjQg4imbDa/uKI7K4scUwm2a9K2zDUN6QW44H7frmw8H5GWjpPW6
         mCO2qTzEKsRzLF4aE6a6oi9Ke7vEdVtw0Hhsidm4i2f1sjxGVAAXDzlhwGrN9evXpeBY
         wakwepsUFm1GZsXj5kbKEYdVGiHTxIJBclSwjamnsEneyG/XNgPNXNM3/THyqYBWuTfD
         Aw570W6nLBeMtdE+Z9GZe7lb18DFj5rvvo5o+gSmXRGBb+RXRWuXEr/GND9fThH/P7Ei
         gi9Q==
X-Gm-Message-State: AOAM533zwNlJtF/b5ocD+j6EdRc+Ai0oAJBZXJUldM9R3cKQQsZN7krH
        JcnmcgQx4ImVmNgw+e8crnaV5cSZKyqae9ju3f2lxu1v8A1Y
X-Google-Smtp-Source: ABdhPJwgUebHs401swtS4x7DN6b8mbp1Pn2fXg+JgYrI7XyliCpJl8/21a5J7UT0RlJqzaphhxcI2mXn2JLybVfY6Mg5lH1vfCbG
MIME-Version: 1.0
X-Received: by 2002:a05:6638:240d:b0:32e:80af:6a25 with SMTP id
 z13-20020a056638240d00b0032e80af6a25mr27546250jat.233.1653818294662; Sun, 29
 May 2022 02:58:14 -0700 (PDT)
Date:   Sun, 29 May 2022 02:58:14 -0700
In-Reply-To: <20220529093522.4155-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f9fb9b05e023937c@google.com>
Subject: Re: [syzbot] INFO: task hung in hci_dev_close_sync
From:   syzbot <syzbot+c56f6371c48cad0420f9@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+c56f6371c48cad0420f9@syzkaller.appspotmail.com

Tested on:

commit:         9d004b2f Merge tag 'cxl-for-5.19' of git://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=d5ef46f0e355ceff
dashboard link: https://syzkaller.appspot.com/bug?extid=c56f6371c48cad0420f9
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15816d23f00000

Note: testing is done by a robot and is best-effort only.
