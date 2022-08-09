Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C931258E132
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 22:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236861AbiHIUgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 16:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234285AbiHIUgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 16:36:11 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66805FD22
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 13:36:08 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id i12-20020a056e021d0c00b002df2d676974so9227492ila.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 13:36:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=Pg56kAYpQfG56aZiuYp7YP/gqknD1IM9tckOCxj0xcQ=;
        b=oJ2lFQCAFirHTGRfZWrHBVJtSjarwsmnX3br9+R9c+WjsSJSdCAY5fjYhSLBWxUpzt
         kbU/vWB12tW+7GrNpf1RQj29UoKya+LnK+XbplBfVN+qHIrR7IvTPgafc74VYfxpld6N
         715NtKR9raoTFbCgstY5yrbqw5sGr5eqwuMyTnnMpQvvtEJDRMYydcEJCf3TGCve7xWv
         tUXzbPGra989Xx8V0CWm/7MAXPRJ0oo7eqPvjxfLMIRv536QYb6flRvFAsTETbkeQqZK
         tDV/ShvGw86cSR5NSHWFzJkvU14gFGg53sq2dHQMZRBQYrk3mISaOhSsXMb+oFRfNhcY
         zC0Q==
X-Gm-Message-State: ACgBeo09OM/jXUoM1NrZtruTI/FQYP3dnR8XK39VEt8p7tjaAP1h+VnN
        +doSBg8Sg3YiPCQevK1Vv0QLtmisgDBOQj4I0j+ZiXvItzW/
X-Google-Smtp-Source: AA6agR6PH1Ps9ZjWUANlwj1Lw7WNbFBJEqH2QjBf59vYRVkjhyrk8ZWnzmcpuKDNv+4ULjUHdNLSWsuMbJs2C/Bo5/KwWvSnVz9t
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2147:b0:2de:f6e3:d970 with SMTP id
 d7-20020a056e02214700b002def6e3d970mr11183980ilv.163.1660077367653; Tue, 09
 Aug 2022 13:36:07 -0700 (PDT)
Date:   Tue, 09 Aug 2022 13:36:07 -0700
In-Reply-To: <20220809115352.2505-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cc7ce805e5d4e158@google.com>
Subject: Re: [syzbot] WARNING in blk_mq_release
From:   syzbot <syzbot+31c9594f6e43b9289b25@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+31c9594f6e43b9289b25@syzkaller.appspotmail.com

Tested on:

commit:         200e340f Merge tag 'pull-work.dcache' of git://git.ker..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11dbd371080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a3f4d6985d3164cd
dashboard link: https://syzkaller.appspot.com/bug?extid=31c9594f6e43b9289b25
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14835cd1080000

Note: testing is done by a robot and is best-effort only.
