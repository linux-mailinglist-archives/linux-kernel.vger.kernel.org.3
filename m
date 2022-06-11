Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCD3547187
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 05:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349737AbiFKDLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 23:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348522AbiFKDLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 23:11:19 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC10313F9A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 20:11:17 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id x5-20020a923005000000b002d1a91c4d13so623366ile.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 20:11:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=wi2T6qnf2xGB9lZBchu0cNh++1EBQpnh7cQrvF4dfH8=;
        b=x7Yj8mIDGhSBkP0YuyA889TInTlK6QMn9iN+5RcHu82bhD6fdwJvhUldB4jVt6EW+W
         Vmkci9yWdwrA15EHCppwn7tozJaIjdpqAmXn7BIaapuuairypGlASWr+KmBE8no1YkwB
         AkhAK+MT4Furn37i73o0MsQJ2piExC9/sLq3A/519ZikxLb+T1Im1O1a1+Z4t6syZ0LD
         0Ud/c34O3dImkAqDUKmrm2zAhbZq6UOtx9/ZAU9PRz8kfO9MAqYWPRZcol4/WwB1gq5g
         ESkN8MSB79Xooi5HldBSWvyZcRC8+LqoQaX476Jip0yXJy0WLiZ6KMbpZCJBCOSNXgBz
         U2iA==
X-Gm-Message-State: AOAM532G7e8qCvPplE1BToxfD/Lx3wICm+fkYVwcB6T5NHM4WJttdH9j
        KrIeHwr+T6EKRnksbWj8eCfmN6YS2V4WHq9DsLClvCg4Qkky
X-Google-Smtp-Source: ABdhPJxtGWCj1GJk2358E6GS/ysApBmorYwZ0IYw4HDPwAyIcrMiZcBJI7WyohRC6HBj9pYy3Vns2mFzuqhgug8M5HTtTpL8W3yg
MIME-Version: 1.0
X-Received: by 2002:a02:b804:0:b0:32d:fc36:b397 with SMTP id
 o4-20020a02b804000000b0032dfc36b397mr26868548jam.271.1654917077110; Fri, 10
 Jun 2022 20:11:17 -0700 (PDT)
Date:   Fri, 10 Jun 2022 20:11:17 -0700
In-Reply-To: <20220611025247.1620-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000083961c05e1236868@google.com>
Subject: Re: [syzbot] BUG: sleeping function called from invalid context in
 corrupted (2)
From:   syzbot <syzbot+efe1afd49d981d281ae4@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+efe1afd49d981d281ae4@syzkaller.appspotmail.com

Tested on:

commit:         03c312cc Add linux-next specific files for 20220608
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16e6c28bf00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a0a0f5184fb46b
dashboard link: https://syzkaller.appspot.com/bug?extid=efe1afd49d981d281ae4
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11367c2ff00000

Note: testing is done by a robot and is best-effort only.
