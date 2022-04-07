Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918324F7D1A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 12:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244494AbiDGKjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 06:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244784AbiDGKhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 06:37:47 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5391B74F0
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 03:35:07 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id x1-20020a056e020f0100b002c98fce9c13so3562296ilj.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 03:35:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=zrfjJ9AqnJS4u7tsoccOffIN2MqZ0+E316J+0XXCUng=;
        b=zTnIVedeO+UmObZ30GGuy+tEIz9RsKo9vSRU+QQ+pOVDfXiA1pkjXmoWFHhtOKmq3O
         7OA6+Xo8Mqak/sQy346uhFkiZLTo68ANlZ/gc90EMkT/YHHQokPpB8aTdvugxLeysZ5R
         hE1TYrfHal39Q7/J094EfRnplCeUbe/T8F/TQuny3BBcqxvFRZ0fV2yuPnKadN+XGwdI
         zKJApYMcRSb6wCJaZadQdCvIlsWjFjE0loNYWRt84pWpeg6B5kiOQeXZK3UbCTV5D9NY
         nhY91s8apKinE9C8hlTEy0vR34M8RbTn2qd4779q7yL0D2L5a5Fzmd+0rdxN5f9XHngi
         ig7A==
X-Gm-Message-State: AOAM530NyhieoaAR//b7ETr1MpA+ru2WUk9qZ6P2CaaAaaIcoQmVr/bt
        SkLyh1hwd8uVhL544MwKJMvJHcdagqiPRYMDDXkfcs1qM687
X-Google-Smtp-Source: ABdhPJxDx9+uaE82iP59rk7ZoD2MwPcPKnzXnxD4oLawj1Bh2H+JZ5VfVyFI0MGCNQvxkkeMMC74gxCihBR3S1lBC9+Omsyb/Va6
MIME-Version: 1.0
X-Received: by 2002:a6b:be03:0:b0:64c:edbb:6b95 with SMTP id
 o3-20020a6bbe03000000b0064cedbb6b95mr6094090iof.46.1649327707023; Thu, 07 Apr
 2022 03:35:07 -0700 (PDT)
Date:   Thu, 07 Apr 2022 03:35:07 -0700
In-Reply-To: <20220407102312.5923-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000186c3e05dc0e083d@google.com>
Subject: Re: [syzbot] INFO: task hung in nbd_add_socket (2)
From:   syzbot <syzbot+cbb4b1ebc70d0c5a8c29@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+cbb4b1ebc70d0c5a8c29@syzkaller.appspotmail.com

Tested on:

commit:         3e732ebf Merge tag 'for_linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
kernel config:  https://syzkaller.appspot.com/x/.config?x=a7f265af816d9f4d
dashboard link: https://syzkaller.appspot.com/bug?extid=cbb4b1ebc70d0c5a8c29
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=155e3dc3700000

Note: testing is done by a robot and is best-effort only.
