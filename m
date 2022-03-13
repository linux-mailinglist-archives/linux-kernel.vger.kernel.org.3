Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E27A4D7750
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 18:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235194AbiCMRmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 13:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbiCMRmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 13:42:17 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E326E8E1A2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 10:41:09 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id d19-20020a0566022bf300b00645eba5c992so10739038ioy.4
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 10:41:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=LSM3VjxELhJj4+/mnArqOMDnWPb4GDPFt7f+AkdtHz4=;
        b=Zw2XpRQguEivUK4VgYfvk6ZfkeDLwWAWGCnv9koenpYaAR9fq9bAbsSsslkkwTBLf+
         EfF5ngkwNHDDsLKBV0xcmWT/uA/498HPyBSYRGgD0u7oYSUIrky/eTyKB/eBP49IHtH9
         Gr+OTK58bxyvyCuAMzNadT3jcfNZJUKcEhfDo8IIuh3B4Eopk11oDnHmhlpD2xCPW99p
         dNpZI5jPuQj7jc8yBPtufkPbECSl0Moj12pyshZyT1PkeThdp15+4ruP1l2ZM8Qlz06N
         QusXak0UPNwdbpc3TJ4yso4k9RBkpGRmBK/SQoF3h8CoqoGX2RlT1TpLUJa3CDIbh6hd
         ABzg==
X-Gm-Message-State: AOAM5338Wvf/ATeKZSannikjzxImhHTh8HOOmCt5SdvR3PTG2pM9/kWT
        4zwky8ibn3Ej+sw+1Sc7grkkM91eF6qgFyo1PihtR9ckAjm7
X-Google-Smtp-Source: ABdhPJy+VuMRzGzZk2ZJwKxb5f0DmK57Ah9ZX2L0UhW4J+twszZINyFRIWgVWuGEwpzBOJWe8vYgxxMkE6VJcTTdT10x2lqLaPSG
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2402:b0:317:b534:2b8c with SMTP id
 z2-20020a056638240200b00317b5342b8cmr17109176jat.60.1647193269370; Sun, 13
 Mar 2022 10:41:09 -0700 (PDT)
Date:   Sun, 13 Mar 2022 10:41:09 -0700
In-Reply-To: <bc933e26-92f3-cfa6-9500-609c2d1015a2@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b2860905da1d11b5@google.com>
Subject: Re: [syzbot] general protection fault in __pm_runtime_resume (2)
From:   syzbot <syzbot+b9bd12fbed3485a3e51f@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, len.brown@intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        paskripkin@gmail.com, pavel@ucw.cz, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
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

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+b9bd12fbed3485a3e51f@syzkaller.appspotmail.com

Tested on:

commit:         aad611a8 Merge tag 'perf-tools-fixes-for-v5.17-2022-03..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=442f8ac61e60a75e
dashboard link: https://syzkaller.appspot.com/bug?extid=b9bd12fbed3485a3e51f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=105cb5a5700000

Note: testing is done by a robot and is best-effort only.
