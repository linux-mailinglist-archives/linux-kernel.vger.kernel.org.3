Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF378536A5D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 04:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355693AbiE1CyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 22:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355638AbiE1CxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 22:53:09 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D851312E312
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 19:53:07 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id u18-20020a5d8712000000b0064c7a7c497aso3703688iom.18
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 19:53:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=QWSyAHKfzIY1OHoU9+6VpQoFbsrYf2vgv+jKDLElsyc=;
        b=bHjl/fcPsAIIZfEc2xXRsr9TiuNOQ56VV7RpcNc7RmbQJeF3D3VmkaeAJOX7dpkK8e
         uigZ2HZi0SMwuLpOuHfmrLQGh9YbaKz3xi5EWaVf5/x4/+UM3PDZe48M7wr6QngiY916
         wz1UtVMAXmC3v23CV4f68hZlqqB4lVhVh2EHwWYrsIMepdgEeWN//BwP/brK8nFwv5VC
         49LDFTV/kCs+C7BwOZcRkFzXB3GS6bXBfKZqffnzjmLKB9mZO2Zjq3s/DNEh+keoSOWB
         YRvZJiflILwmDE7hu+EcLo8GD2/s/K6qHMSqdBzfrgt+6nc0g4PtZkVBG2ec6t/LaweG
         H/9g==
X-Gm-Message-State: AOAM5322fISx0o/ZRPbtv8oXNIzGHAwomBCSyn9KY9pWT0B4Ih+JdeCe
        8poAW7KYKr4Gq7BuhgL0lC7fpLrdeZkBOp85d2PXDcalwYOj
X-Google-Smtp-Source: ABdhPJxJi0ol2DMTwrLC0ImM3K7KAEttvHIusR3cF/HqxJ+TrmU+FP4t6DxZBAeXscwC5ONMjXXB+yv24KkMd+6chuCjZCPdVkTE
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:178f:b0:2d1:b8d7:2ed6 with SMTP id
 y15-20020a056e02178f00b002d1b8d72ed6mr12839110ilu.275.1653706387216; Fri, 27
 May 2022 19:53:07 -0700 (PDT)
Date:   Fri, 27 May 2022 19:53:07 -0700
In-Reply-To: <20220528023054.3646-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c5debc05e0098538@google.com>
Subject: Re: [syzbot] WARNING in driver_unregister
From:   syzbot <syzbot+02b16343704b3af1667e@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+02b16343704b3af1667e@syzkaller.appspotmail.com

Tested on:

commit:         97fa5887 USB: new quirk for Dell Gen 2 devices
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=d7b232ec3adf5c8d
dashboard link: https://syzkaller.appspot.com/bug?extid=02b16343704b3af1667e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13564f6bf00000

Note: testing is done by a robot and is best-effort only.
