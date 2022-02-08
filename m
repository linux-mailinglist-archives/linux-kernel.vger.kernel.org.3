Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3180D4ADB92
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 15:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378435AbiBHOvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 09:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiBHOvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 09:51:09 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB66C061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 06:51:08 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id y3-20020a920903000000b002be462612d7so3230181ilg.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 06:51:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=gyoR7YM+mgvf6gynog/ilFRl/dnvDf1mCVSF3t4qaro=;
        b=VSZhTp2HK/FEHyD8xEgCZQoftiifol7rmDMtNdsSdt9TZqYUQgie9iSXO8nGFaGsvg
         lhgleqfR6VDD/o7G9VChp++4XX3Sgc1Jr4wUd80ZjGHVf8iqXGstaarghjjjjd6/KzQr
         ENkuYPMi+7EOEEBz3LG//qRI1aqICl66D98xcRjZdRSMCJP7dG6cGUVNfiegIOz35iq6
         AA/7bR9pFJQpzo/fm1rf+xoRv7Xck/VyrZDC/DRQgdVGVtqrbT6/9jf9v3jkG4QWDd0l
         XzFTR0H1It6T1ixw1QgBy+AtMSjHZwEQDuW+9hg38pci20/5tmi2ibm//O+BAa5hVBYP
         f98g==
X-Gm-Message-State: AOAM532sOKn9grfAha5wZ/kgQwEB4DWJpsyPR9Wqq+egDAg/dUYRy1B9
        JVdZWqHOu0GPNQm1p7drI6pvadQwdxSVISRx8wpHUeSy1LXt
X-Google-Smtp-Source: ABdhPJyrUpevVYRtKHnpJMXJjRCIBtEle9LkYgAgiZm93aCVhOQ2Ko/U9yzPvwo4+Gb4ic59T/FQlqCtLdjX1jXFHAD2iLfsIHlG
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1ea:: with SMTP id t10mr2189767jaq.77.1644331867846;
 Tue, 08 Feb 2022 06:51:07 -0800 (PST)
Date:   Tue, 08 Feb 2022 06:51:07 -0800
In-Reply-To: <2114181.C4sosBPzcN@leap>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e03f4e05d782d886@google.com>
Subject: Re: [syzbot] WARNING in component_del
From:   syzbot <syzbot+60df062e1c41940cae0f@syzkaller.appspotmail.com>
To:     dri-devel@lists.freedesktop.org, fmdefrancesco@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
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

Reported-and-tested-by: syzbot+60df062e1c41940cae0f@syzkaller.appspotmail.com

Tested on:

commit:         555f3d7b Merge tag '5.17-rc3-ksmbd-server-fixes' of gi..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=266de9da75c71a45
dashboard link: https://syzkaller.appspot.com/bug?extid=60df062e1c41940cae0f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=111f7428700000

Note: testing is done by a robot and is best-effort only.
