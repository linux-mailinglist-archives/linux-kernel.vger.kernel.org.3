Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916484E4A1E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 01:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240947AbiCWAij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 20:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbiCWAii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 20:38:38 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7D251E40
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 17:37:10 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id z9-20020a92d189000000b002c830ac1ad3so3542213ilz.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 17:37:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=94hmLNLc4Qa65xhXJkCqKMKovw/2rdLlaroN12E6w9I=;
        b=wirsnL2FOSEUhjunxZ2If900Zw9kJrcYokcTqK7HupfQfI68vvcqBHmj0TnXWgY/7Z
         naDTNLDwmcKeWWcTXjdIbeVU4d7h/HLkMifplB1GsQVHP09ITmx6SLntGRlisIrSTJD4
         Pe7QcvGaUoV6rBIv+Qdv+mrq5U/VgunLhdykySIEytioXhf1iW7vnBc6zHpgc6DolNJv
         3T3+XcE8kKMr7kE5+epdz69C6wmG3XLituR2Bqr2fqo7PMs7vbeO2qNXCctqOYVXBu6n
         rRRjQ89tVv7Uu3kF6QssI4cERyouFDJ/kEVcUaOufj0UevdhJLhDBmR/lyKRl6V4loJk
         QE2A==
X-Gm-Message-State: AOAM533clv38e/EcDQgxDR88yfNz2vH3xBjRND7AyAlvMfiOYGlx8tUI
        NRDaJkmsGS6pj8UIAug5mbtWWJum//GqWG2lrXIlKGpY1vi1
X-Google-Smtp-Source: ABdhPJxgGzn9M+W85C5QQyqaGER567i8Ni0Wh0pm/fQ8jNr/jrNrGVKqaTeS0VR6UsigXFb6xbZUilrXBgVl1VfFlwPUIINOPwZx
MIME-Version: 1.0
X-Received: by 2002:a6b:b806:0:b0:646:1c7b:bb01 with SMTP id
 i6-20020a6bb806000000b006461c7bbb01mr13365275iof.105.1647995829453; Tue, 22
 Mar 2022 17:37:09 -0700 (PDT)
Date:   Tue, 22 Mar 2022 17:37:09 -0700
In-Reply-To: <20220323000702.3445-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000018dde05dad7ee2e@google.com>
Subject: Re: [syzbot] BUG: sleeping function called from invalid context in blk_release_queue
From:   syzbot <syzbot+bbea00057d3d55c4889b@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

Reported-and-tested-by: syzbot+bbea00057d3d55c4889b@syzkaller.appspotmail.com

Tested on:

commit:         f9006d92 Add linux-next specific files for 20220321
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/
kernel config:  https://syzkaller.appspot.com/x/.config?x=949ef165e81e8114
dashboard link: https://syzkaller.appspot.com/bug?extid=bbea00057d3d55c4889b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13d673db700000

Note: testing is done by a robot and is best-effort only.
