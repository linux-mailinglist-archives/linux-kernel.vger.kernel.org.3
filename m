Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7922B52B2A8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 08:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiERGpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 02:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbiERGpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 02:45:09 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35174DE338
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 23:45:08 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id x3-20020a056e021bc300b002d13f8bad89so738562ilv.18
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 23:45:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=bbNknpHMvvRBOmWc8Xg3T+LYindwAK7z0wniwQ/gaIk=;
        b=Czh9u47BpXuE+Mge9zyNWkQ5Zy1BqRj/bUPw3GlfqUJNVkgZbI1jKJXwgk2GIzMG2D
         CpDj3Vsx4g+llho6Mygq/uL+8sG8faIinCqmZfFMSoL7f9a1t1tcV2+AzPXU35WzGsIk
         HChWgQf+Tfk3mA48D/YtgHx1/StW6g8eFaDRVZbBGTOcPPBjqU/TX5C837g9my2D81lE
         suZwlWX2bDNaemUowT5BUliFCs0pWKMFJglsI9moYOtiHPWREZWFarLNriTBKZkqggZv
         NXVP/GgetzzURm5M8rPDBidBCEMacKrwzNxsiyv6CvFfvdAUjWMwkKlAf3/XP26hG7LX
         G3Lw==
X-Gm-Message-State: AOAM531Xgae4+1D8rV+mNvJxnlaO6gzXvi/WB3/ZK+oJ9QlQwmV0Qndx
        fjDG9hXlLdIUaWjmNm/Irjbsnp14+Gp8VhbR2Ko5PX2btA3X
X-Google-Smtp-Source: ABdhPJx/0yH3kyKaF/QZJcNSwH2Q3v9poWe68iePLJnroqJoqiM3lg/+Ivn7R++RLGMwx4HPQb03JnaMFcFY3BVcNv/q30v9cauc
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3711:b0:32b:ca0b:8a32 with SMTP id
 k17-20020a056638371100b0032bca0b8a32mr14405686jav.267.1652856307625; Tue, 17
 May 2022 23:45:07 -0700 (PDT)
Date:   Tue, 17 May 2022 23:45:07 -0700
In-Reply-To: <YoSRPP1n26hmDuzn@zeniv-ca.linux.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000014b2d605df43994d@google.com>
Subject: Re: [syzbot] WARNING in mntput_no_expire (3)
From:   syzbot <syzbot+5b1e53987f858500ec00@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
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

Reported-and-tested-by: syzbot+5b1e53987f858500ec00@syzkaller.appspotmail.com

Tested on:

commit:         a9171431 percpu_ref_init(): clean ->percpu_count_ref o..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git proposed-fix
kernel config:  https://syzkaller.appspot.com/x/.config?x=79caa0035f59d385
dashboard link: https://syzkaller.appspot.com/bug?extid=5b1e53987f858500ec00
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
