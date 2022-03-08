Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C670A4D1B8D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347750AbiCHPVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347728AbiCHPVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:21:07 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C314D9F1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 07:20:10 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id s14-20020a0566022bce00b00645e9bc9773so2764964iov.20
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 07:20:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=t0VNOU7RRwjb3H7s1WRSl1+Azc/DP7e41yedGLIzhXo=;
        b=D/g3rVWU1KI3BKNZYsTti8kzxI6zVfsZQ7aRNvZ75GsBZfzyQ2vlWxNlnk+z1ELozM
         rBLSMuw7IKepl8oE9Aid75Gq8N1YaQAJ6+wLICYkBK5h5UcAtRunFrnbAcnZbzK2HaR0
         wEbxTtnFRtNZkhGjtnfWqEBNa8gIr4iRTZlOTuaPUOVdbSiFiRstNMCe1eQuAZCO+Vpg
         nPrWtS5HU8q+Qo+Di3v6siYAzc6wZLO9Y6tpW9KC2iDCuVNLrdCHivmGb7AyZqQ/vtD0
         v24hEBrcHD1QiU6bj1aDuyGD/hGiO0nHri3yDwj5zNP5I7vPylHBqbu+oXVXyjkhaLfV
         LcYw==
X-Gm-Message-State: AOAM532ZgIpWRyNm7LlhLbIogJztb3ptxBC1WB9yf60Krs/tq7BC7sIS
        bvc0Jeb+3jBYE+Z6Xx/aSs4fL7vx9cFWym7tk4YGvyE8CV9R
X-Google-Smtp-Source: ABdhPJxIN1KmDqfCPfbxTpbcL1P976T5kld5TWrV6qwp59ZVvVUSFZWeL+pWItJl4jnlnqyijl4xmXUrp4AFu7GyO3ZtQUl40q2Q
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c04:b0:2be:4c61:20f4 with SMTP id
 l4-20020a056e021c0400b002be4c6120f4mr15914234ilh.245.1646752809820; Tue, 08
 Mar 2022 07:20:09 -0800 (PST)
Date:   Tue, 08 Mar 2022 07:20:09 -0800
In-Reply-To: <20220308150836.3680-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000043292605d9b684bf@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in cdc_ncm_tx_fixup
From:   syzbot <syzbot+5ec3d1378e31c88d87f4@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
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

Reported-and-tested-by: syzbot+5ec3d1378e31c88d87f4@syzkaller.appspotmail.com

Tested on:

commit:         ea4424be Merge tag 'mtd/fixes-for-5.17-rc8' of git://g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
kernel config:  https://syzkaller.appspot.com/x/.config?x=442f8ac61e60a75e
dashboard link: https://syzkaller.appspot.com/bug?extid=5ec3d1378e31c88d87f4
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=129f209a700000

Note: testing is done by a robot and is best-effort only.
