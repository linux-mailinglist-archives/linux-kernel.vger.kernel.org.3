Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16474EDF27
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 18:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240289AbiCaQ4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 12:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240277AbiCaQ4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 12:56:02 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3976A5F8E1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 09:54:15 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id f11-20020a056602070b00b00645d08010fcso67239iox.15
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 09:54:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=lAU3Wth5raowPe6hr9BcwEouOu/KFzD0omZlx82ZzhQ=;
        b=n7e7d5+/UzKA6d+pyU5shAMeRTZ3aqGywwHurmXRXcYHX/0m79e+FwdbEL+2ZucNIY
         L68KSmJjZbaHrPa9GQ8SKuxnnvhzvvnpmbXaX4B9hxcW9KFxOUUaGJV6zHvUPCApBin6
         nwEHS2LRGe/lZZIRAQy7BDvB+cVeMKO4/SZZRypfYWC0zQCJjjtSEBXaIiPyj+wdL/hE
         Z8zquB1g1LRIzhQZVwthiFsR36tVMdFc0aHCRKailuS08W49QuduNq67xCB+lNAMICis
         Oo8CZLuaKLYe58L4VZ1P4vHyjkDoPvhDIfqMg7CRlCm/u5XEe0JKAn0tCRblbEKJOTI/
         fGVA==
X-Gm-Message-State: AOAM533xbkV/lY/9Fxay3bv+j+fRqUGLAyYYOSSYz1InVxNTgCvT8GJ8
        PuQu2a36nYpkCobqlgCHUf9ZXgxZwQzFTJ3X+Oh1xa+U+xJQ
X-Google-Smtp-Source: ABdhPJwmJ9AzvPYeGAfkPFM7NlFTob2+QRp3K6k3IYckOOrGwTagSa4rhrpDwa3c7WBsNsTiOqz5dCc3PpdqYZs8p+YNEMVAidFz
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d81:b0:2ca:47:4364 with SMTP id
 h1-20020a056e021d8100b002ca00474364mr1503158ila.80.1648745654584; Thu, 31 Mar
 2022 09:54:14 -0700 (PDT)
Date:   Thu, 31 Mar 2022 09:54:14 -0700
In-Reply-To: <20220331164358.GA30565@lst.de>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000110d5805db868373@google.com>
Subject: Re: [syzbot] WARNING in bio_free
From:   syzbot <syzbot+e08de3db8be67b2a01b0@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
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

Reported-and-tested-by: syzbot+e08de3db8be67b2a01b0@syzkaller.appspotmail.com

Tested on:

commit:         ea32d892 squashfs: free bios allocated using bio_kmall..
git tree:       git://git.infradead.org/users/hch/misc.git squashfs-fix
kernel config:  https://syzkaller.appspot.com/x/.config?x=6a82c1abd4cbb9ee
dashboard link: https://syzkaller.appspot.com/bug?extid=e08de3db8be67b2a01b0
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
