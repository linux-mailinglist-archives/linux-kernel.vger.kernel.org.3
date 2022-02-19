Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771DD4BC6FA
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 09:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241658AbiBSIc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 03:32:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239001AbiBSIc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 03:32:27 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE4966F9A
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 00:32:07 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id n20-20020a6bed14000000b0060faa0aefd3so5998618iog.20
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 00:32:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=igoAkr62uwBqt6MdzVON7HsNoLqGN8q1W1weZlEhX9A=;
        b=mxOYrNzFsuiLSed5nbI2RoX9dZF2tQlHtMDlZWZBOOvjCyhymsB1sEa1ROAryy+uJo
         LAIPTqD1Sd4oDIK3DMIXVsWmBnscdRbVFbMABU+5ylUWW80dfe8ZAraXjQ5z+A8a4/MH
         6hJsX9pRfDuTZQH29LsOm7LypqytLYquDznWgZN2nz2w+3I57+g4UNjERhfeUQsKcA3X
         qQcgy40p5O6nTjWdc085VZHWUOq0iw9JUVNZH/cg45NsmxHYeSebZBvrqaQqHgNkap63
         eU9pqHTChYSt8MpP69a7oUFGn86PqlY9JYOtQqpnjkB7VOUSjnNoVi0nQ8HjoyPOPwnJ
         CQaQ==
X-Gm-Message-State: AOAM532KYeZ/Gb/eMkE0+pzpywqm4jk6Kg3GFuJVqILstfK3K1iw2j4L
        JiFVW+CEeVI5kHMa43hzLWbkRjWBkwKkCEUoLo8M511UOMik
X-Google-Smtp-Source: ABdhPJz0eiTh8/Kq1/brq+WpX7IwYm+Ys3u2m+LYdHtUPupV0Y45g17HdUKtGcVyGIc1mVNIfWK4MbxwvFfxmwk80Odum08VUY2H
MIME-Version: 1.0
X-Received: by 2002:a02:51c5:0:b0:314:4f44:7159 with SMTP id
 s188-20020a0251c5000000b003144f447159mr7491372jaa.29.1645259526928; Sat, 19
 Feb 2022 00:32:06 -0800 (PST)
Date:   Sat, 19 Feb 2022 00:32:06 -0800
In-Reply-To: <20220219081631.592-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aa811605d85ad5c4@google.com>
Subject: Re: [syzbot] INFO: task hung in vhost_work_dev_flush
From:   syzbot <syzbot+0abd373e2e50d704db87@syzkaller.appspotmail.com>
To:     hdanton@sina.com, jasowang@redhat.com,
        linux-kernel@vger.kernel.org, mst@redhat.com,
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

Reported-and-tested-by: syzbot+0abd373e2e50d704db87@syzkaller.appspotmail.com

Tested on:

commit:         e6251ab4 Merge tag 'nfs-for-5.17-2' of git://git.linux..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
kernel config:  https://syzkaller.appspot.com/x/.config?x=266de9da75c71a45
dashboard link: https://syzkaller.appspot.com/bug?extid=0abd373e2e50d704db87
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16139f0e700000

Note: testing is done by a robot and is best-effort only.
