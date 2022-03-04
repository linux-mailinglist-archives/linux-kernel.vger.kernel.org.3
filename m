Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9284CD406
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 13:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237658AbiCDMJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 07:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbiCDMJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 07:09:55 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586262980B
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 04:09:08 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id v10-20020a92c80a000000b002c281af4ddfso5350788iln.21
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 04:09:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ZLQ+l6U3cC3xcyZ26dmva83Rjla9btl+5WyQj7ZwMUQ=;
        b=x07u51M28BHhafBIckCN+044KbfXYi5yxetJeuVmLj0jI1Ifc0dh/vZksn73ygjJdx
         UzLhiO+HIl0eAWb2VptH8I4wLB0TKRV39PCy8FCknz/tJRgkFs7eS9HOGBrJyoRXir2h
         R2Y3ZsXqfJp5M8WtTAA2sTAup8t0BTzZMd01QZBWyLc3RN6hTs+3w2Act027P6SYgsSr
         kXkI6bKnL3KZcRNWQupgjD74s5fpFJgm8vJ2iJimPmbecEXh324XjfGwAE8hkHjfVSpk
         WL4Qg5oD5/EWsxWWLXlRCUZYhCsD/3EDnFR0Lmwb+AJAeu0VZwtOnvOHpsffbz73+WXH
         oYCg==
X-Gm-Message-State: AOAM532HihUEpJek1dUdcffwxYcs11aMcVYU9VsAwtmyUKThQluoC0YZ
        ckUOexNn2cPXh9VNC+DCJjbnaWEFIeAKEHcIhGB192v+Bmyp
X-Google-Smtp-Source: ABdhPJzTtUgWNdrJB42fkiOFuPQZ9wPjXcRLvuJiYwlAZuwlxR2NYIaEMoOGsQAnk3FD4ovrLTnL00mlm28BFC5D8h0pBTHV1nNt
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1487:b0:2c2:e41d:f72b with SMTP id
 n7-20020a056e02148700b002c2e41df72bmr23414746ilk.61.1646395747743; Fri, 04
 Mar 2022 04:09:07 -0800 (PST)
Date:   Fri, 04 Mar 2022 04:09:07 -0800
In-Reply-To: <20220304114907.2733-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b43dde05d96361a0@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in btrfs_scan_one_device (2)
From:   syzbot <syzbot+82650a4e0ed38f218363@syzkaller.appspotmail.com>
To:     anand.jain@oracle.com, dsterba@suse.com, hdanton@sina.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
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

Reported-and-tested-by: syzbot+82650a4e0ed38f218363@syzkaller.appspotmail.com

Tested on:

commit:         2293be58 Merge tag 'trace-v5.17-rc4' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
kernel config:  https://syzkaller.appspot.com/x/.config?x=5f28851401b410e5
dashboard link: https://syzkaller.appspot.com/bug?extid=82650a4e0ed38f218363
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1723b521700000

Note: testing is done by a robot and is best-effort only.
