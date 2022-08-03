Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6820E5886A7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 06:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbiHCExM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 00:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbiHCExI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 00:53:08 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F233457233
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 21:53:07 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id f5-20020a056e020b4500b002df180f0997so909619ilu.21
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 21:53:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=bT3YULCXKnZc8y+zrRqHabIVdyfiW1cYQ26ZuMNbOJs=;
        b=zhXu5Pd7wJObR6H3CGL0xNOTg0Cdizy1d0IUaTTnGj4vJ+w414icCMx8HekfW4q+qg
         vYu1av/oFbPt9JydWrdyvtlfPy6IzcNFzdnq1FwtNd4ZbCEmTXYMhBJaFRVgbPek9V+o
         MqDf8Fd2xvSVumaOH3CfEB5i0CbrXfqySATMtpSeqMHxv2SSRTV369aMlSmugV+du+PN
         GC9xwgcLi0o0ZdA5sIGiQpW9G6ksDFgME4StGAHsvSQDVFgLhGHuwlYU4nNgFLylPDa/
         W4vqjUB0IlgnoWTH2GdCiMG/AQPM8YNlVUMjw/a9RI3jxeLHMpC3hLR8afu72OYsz7Pb
         SXUg==
X-Gm-Message-State: ACgBeo39KAJfBprICj0u+z+nlkOJTCYqwdzH8/q6DrAFm8RKsLZYvM6y
        4gjdeCgMSbtDzYqcVwYn6WW1/c14ydnQU7HZOPiJLyfVBOaK
X-Google-Smtp-Source: AA6agR7jwtRilJZsNtewGloH//4KZJ9mP2xale2iRjqRKkPPjGUhtEgBUTn8zZV8ELRAlwrLu5JX7a79CQDtjoxVI7nP7gNXowEy
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:190b:b0:2de:ba7d:40a9 with SMTP id
 w11-20020a056e02190b00b002deba7d40a9mr4550902ilu.52.1659502387164; Tue, 02
 Aug 2022 21:53:07 -0700 (PDT)
Date:   Tue, 02 Aug 2022 21:53:07 -0700
In-Reply-To: <CAJfpeguS6Ta9LcGU0A_JkfvPWZup_Ndg+tpvpbzXJuWPNZwGgw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004a9f7b05e54f0213@google.com>
Subject: Re: [syzbot] memory leak in cap_inode_getsecurity
From:   syzbot <syzbot+942d5390db2d9624ced8@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
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

Reported-and-tested-by: syzbot+942d5390db2d9624ced8@syzkaller.appspotmail.com

Tested on:

commit:         e2b54210 Merge tag 'flexible-array-transformations-UAP..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12c050a2080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5367bd9b8d9fa72
dashboard link: https://syzkaller.appspot.com/bug?extid=942d5390db2d9624ced8
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17a74536080000

Note: testing is done by a robot and is best-effort only.
