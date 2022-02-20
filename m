Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC05E4BCF9C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 16:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244248AbiBTPyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 10:54:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiBTPye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 10:54:34 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28C7532E5
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:54:12 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id 24-20020a5d9c18000000b0064075f4edbdso5574096ioe.19
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:54:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=/jAKQWywRbjkCW1vm16BADmhGiyY4nbess2Zmzgstyo=;
        b=HctPRaNLpPtd+WLALI9iGwrwCJiWHAj1mhsE7+1dwh0rY5BKGSZSTG9AM5+XTMOdA9
         xjjaONFupkdT7fKF1jj1Pql9kpsX2dJywja/xrSp2s+RlcS/d9qEHpYzyPApHc6CQ2BE
         Ytb5JoIIlYmoLDsCqkMAF5K0gDiAb90mScf4LEJzbouNNHtAkV0ULgFy04k4EpWiVgOy
         usscyvuYpqpADapzl/gp7yP+3x0HNWHmWXzSfHB2r1uWC1ne1QN/lpGcCJjDb6F4vQFv
         D9k2PAMsy1NxESmpCJgi6MufJxUu8vbaEWo10EHD0iQTyS+wtkIM1GA63cVA+JTJb0Mx
         iwlw==
X-Gm-Message-State: AOAM531vHBJQxY+QYyY0cAYKG3cxHhGP7ADCm7Pke6Zv1N1qR8pbX5aw
        p5iRxio+FNj99hgTkY87Uttl4ScqQQhZ3UVMsom61NLLbuVe
X-Google-Smtp-Source: ABdhPJwMXxFZQ8UZcNlJ/kMhe+N7a/AVJBAovKtGkkifMPhJAhYz0pfqVHEfvJAak5fcXLhRufk6f+GBuzfFcD2w9HoNOJayBxN9
MIME-Version: 1.0
X-Received: by 2002:a02:8664:0:b0:30d:e657:7847 with SMTP id
 e91-20020a028664000000b0030de6577847mr12046321jai.283.1645372450899; Sun, 20
 Feb 2022 07:54:10 -0800 (PST)
Date:   Sun, 20 Feb 2022 07:54:10 -0800
In-Reply-To: <cd08c05f-f648-071f-d8f5-0a022cd35b7b@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000758ca405d87520c7@google.com>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in thrustmaster_probe
From:   syzbot <syzbot+35eebd505e97d315d01c@syzkaller.appspotmail.com>
To:     alexandre.torgue@foss.st.com, benjamin.tissoires@redhat.com,
        jikos@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        mcoquelin.stm32@gmail.com, paskripkin@gmail.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+35eebd505e97d315d01c@syzkaller.appspotmail.com

Tested on:

commit:         4f12b742 Merge tag 'nfs-for-5.17-3' of git://git.linux..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=a78b064590b9f912
dashboard link: https://syzkaller.appspot.com/bug?extid=35eebd505e97d315d01c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16de330a700000

Note: testing is done by a robot and is best-effort only.
