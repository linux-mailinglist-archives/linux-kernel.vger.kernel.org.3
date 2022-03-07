Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E4D4CFC9A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 12:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236311AbiCGLXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 06:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239193AbiCGLWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 06:22:25 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F982F02C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 02:48:09 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id l6-20020a056e020dc600b002c627a43bc4so3570366ilj.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 02:48:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=mgKhk7NgAb2oDXlFXPWe8Xc07sODDmNpvRz0YdTXBeo=;
        b=XOeHpFelOAJHiv2pRrqVQd4r8wZI5AKrTQXgUPSeTKwDrH8obndGbeZpEePcHXt5qE
         aQcXwZLcwniz0hHS1kcxAJvrcTrzbQIVewpIxwfuWcO7tidEx+vuDaIMaKPA523HT4aJ
         9JsWglfqMSE+hylRL6F/l+WMvpgEZTfzWRxVgt9ILQvGx+C5dbS59CMK1J5JXf+rCNsP
         FQeV6J7QrvnEDLTYo9fQo+ORyN26olumHbpJM+x+5Vr18rnL6iDfUCKUqlM6NQYRMBvc
         VV7X1P1RkJ0HOOSThtPKzP4tngZtha0WcuNcpQiqq33BLekQzqIcRDw99ixBT4xWpHl8
         m0Cg==
X-Gm-Message-State: AOAM530AqdBu75eTnxWSQih2/Fz6WF1xIYXw47k6lJbX2wiJtfv3NYu1
        Lp3KniPUBI8IXMteTvLpxfW8+JcVf0J8q87y+5J+tCV1dzef
X-Google-Smtp-Source: ABdhPJxoDUXiC7ecC99uyPVAsH4t+KASmXgoR4dfVGmxx07TXt3q7cBI8JX4Mw5ixuMrvIbQcPDEeLW6QbVovebXLWgUizCFqq+9
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18cd:b0:2c2:f50c:278 with SMTP id
 s13-20020a056e0218cd00b002c2f50c0278mr10549727ilu.1.1646650089268; Mon, 07
 Mar 2022 02:48:09 -0800 (PST)
Date:   Mon, 07 Mar 2022 02:48:09 -0800
In-Reply-To: <20220307103434.3310-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a3ec7605d99e99dd@google.com>
Subject: Re: [syzbot] possible deadlock in snd_timer_interrupt (2)
From:   syzbot <syzbot+1ee0910eca9c94f71f25@syzkaller.appspotmail.com>
To:     alsa-devel@alsa-project.org, hdanton@sina.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tiwai@suse.com, tiwai@suse.de
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

Reported-and-tested-by: syzbot+1ee0910eca9c94f71f25@syzkaller.appspotmail.com

Tested on:

commit:         38f80f42 MAINTAINERS: Remove dead patchwork link
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e9585407e09f75f
dashboard link: https://syzkaller.appspot.com/bug?extid=1ee0910eca9c94f71f25
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16c1baa1700000

Note: testing is done by a robot and is best-effort only.
