Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6C753B7C7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 13:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbiFBL1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 07:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234173AbiFBL1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 07:27:15 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CB32A80FD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 04:27:14 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id y12-20020a5e920c000000b006657a63c653so2534061iop.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 04:27:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=tBPqEXkYJWesIAOs0ogsXVDrcaMGjMtECgfa+1Fisr4=;
        b=t6f0E3ruYlIWkafk8Yl5DQsN3sO9hs/Y+OanPW69A3xHh17afuyxvidFgz5/SBwk0p
         e0WXTP/jjnmd6cPdL5YTO3epKj3wHaMPfAHX9J1rQepr8Up2rI8i7/gynW6uGrsUpMu/
         oDQf/yA5i+ctxX1IauutclVZJaLOMF+IT2xurbMbzHKcgR1WpH7+IJljz3c3cur7jgD6
         FtwN4qUF5yHzfmaSUXTa7CQi6AZ404YVWYfHIhchUbk5XSyL9Ir14eImvFo6OwM6SO7s
         5lbjAHGt/HbeNDtlRa0RLQmTOu06I1Puwhbl+nZxYmVSG2Hteq6wNk2PScG/xBXa0R3d
         eYeA==
X-Gm-Message-State: AOAM5301MKqfGiJCbMSUIEw+AcNmTY9M+fqBmtkZlFdIGRLqurOa6Ask
        aE2IdF+hEKULyb3DXKVcLTkJ8W+ALZj9DvpKRuZrzj7ui7Q9
X-Google-Smtp-Source: ABdhPJw1dvUVLCTqxeceapGHayof/e1ERQj6iNoh8gbQd/yfQFHM+WOLHpC7/KP/qF7NPpYCfDLZkI5kgXAgvPkmSnCCDbXHy8/u
MIME-Version: 1.0
X-Received: by 2002:a05:6638:14ce:b0:330:f182:c463 with SMTP id
 l14-20020a05663814ce00b00330f182c463mr2754415jak.114.1654169233943; Thu, 02
 Jun 2022 04:27:13 -0700 (PDT)
Date:   Thu, 02 Jun 2022 04:27:13 -0700
In-Reply-To: <20220602110759.5027-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000096728005e0754936@google.com>
Subject: Re: [syzbot] INFO: task hung in hci_power_on
From:   syzbot <syzbot+8d7b9ced2a99394b0a50@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+8d7b9ced2a99394b0a50@syzkaller.appspotmail.com

Tested on:

commit:         9d004b2f Merge tag 'cxl-for-5.19' of git://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c367f7c347f1679
dashboard link: https://syzkaller.appspot.com/bug?extid=8d7b9ced2a99394b0a50
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1645eedbf00000

Note: testing is done by a robot and is best-effort only.
