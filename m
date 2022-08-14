Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B701592038
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 16:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237876AbiHNOo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 10:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbiHNOoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 10:44:23 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DB113D0D
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 07:44:22 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id o9-20020a056e0214c900b002dc29c288bfso3635722ilk.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 07:44:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=DUOlGHFKYm23M52E2VgfQ/av+kQLUB31UR5vkDkAjMs=;
        b=2++Zj0q1Rh+oDpNjWlda8TUq7iP/qSRxuLNQhQ+hjAMRvEr38bPuexJZEz3rMzmHT8
         Fn/lfP5CjP6+Q3AzOfLSnDMakhaZrXKHBu/y/33g5pEkK4tB+hfzzd27du5DEenuiy2n
         fCxEX4ccseSauDwI4sPgeKDardfiF9/+0iIuQKY6norL0+cIwtMsszxxOqXDnM1JqOhK
         314E5Lwj5LYyAg1jZaVTU8/1Xthy+V1kMR+iC6kWujS1fe3t2A93rMNOa03qVttRcK2u
         i10E6x200IHtkXMqwKwBNXPYLlZP5B5MwLxyu/jerdVLpQfOr87bG7HNqUaI8fsvq2ql
         E35Q==
X-Gm-Message-State: ACgBeo2E4m8jg3Nkvj3G3/u71EpcRnwR2SSNtFAJaAQpJi8MH8kc9dsA
        NFH3D4of41kvEpl/BuhNnLqbZ+sQoi2q+dKsgyl9fYrH6iRo
X-Google-Smtp-Source: AA6agR7HCnfcP6fvaCLIy6dsMmYee5atb5duxM32NdS3L+q84F4YWhH6Pm/nfOy/Ij0iRPGnbw+L7urjDf2Xnm950CBZfw3qbSyq
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:194b:b0:2df:a382:1a4e with SMTP id
 x11-20020a056e02194b00b002dfa3821a4emr5574963ilu.115.1660488261949; Sun, 14
 Aug 2022 07:44:21 -0700 (PDT)
Date:   Sun, 14 Aug 2022 07:44:21 -0700
In-Reply-To: <20220814124525.904-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000001dffa05e6348db4@google.com>
Subject: Re: [syzbot] WARNING in tls_strp_done
From:   syzbot <syzbot+abd45eb849b05194b1b6@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+abd45eb849b05194b1b6@syzkaller.appspotmail.com

Tested on:

commit:         7ebfc85e Merge tag 'net-6.0-rc1' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=131b1a0d080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=924833c12349a8c0
dashboard link: https://syzkaller.appspot.com/bug?extid=abd45eb849b05194b1b6
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=103a3e2d080000

Note: testing is done by a robot and is best-effort only.
