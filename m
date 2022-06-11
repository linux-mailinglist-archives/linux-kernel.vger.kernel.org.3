Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D29547125
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 03:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349309AbiFKBiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 21:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348886AbiFKBiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 21:38:12 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D1219039
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 18:38:10 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id f16-20020a056602071000b00669bb12a6baso405233iox.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 18:38:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=fR2ebMThzKS+/nDQcBpwFSrDlBIp3UvgcJYb3PbbAIw=;
        b=grUm5if2pgLY/kgoFTEmFrUTybwld6GjEZMoB1x9AThhBpjoHvkypFaARA6hk2HI9D
         e9M9vPnhTq1w6FM1RNyhPEBF2z83DgVmx0UrZ8gMWBvxOccb38nt4d/uqY1HcBE6VH2H
         HeBk/BCxxvH0Xr+OXPs6V7Go3g68VQTFfjFhdza5IP9bBPFYxrf3Hv1fhNp5Ux7rtpUr
         cpXB7PsfW1zgr1Gh1a6++0ms7e9smd3tOySp26qwlS1pf2ZMOd9fiYKPr3cZIbG6JrFe
         oAf3s3q/5CDiZh5tIHVrCwg6v8XjWq3RoZL8bY7ozrY5hpj5zqJcJiPFeuvBoT2pzQU2
         JLIw==
X-Gm-Message-State: AOAM531iYPwFHsHWzloeTd4PkAEhRtJ/a+bdZj/ZIE04q6rPQJSmO4Vy
        tgLDcRaKIef9TXFiEeJvoz13+oTsdELYro43NFN4S44oaGZr
X-Google-Smtp-Source: ABdhPJzL+X23HCba4RmJCnm+uyNL3hnyasFWHjv/yRO3dn4rArQg68rZabRDg3rSv8tpxImQQ8a5jPG4Z/qV4Si69zdeOH0i3d7x
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c0c:b0:669:c1a9:245c with SMTP id
 w12-20020a0566022c0c00b00669c1a9245cmr2243252iov.218.1654911489350; Fri, 10
 Jun 2022 18:38:09 -0700 (PDT)
Date:   Fri, 10 Jun 2022 18:38:09 -0700
In-Reply-To: <20220611005547.1454-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000075231705e1221b38@google.com>
Subject: Re: [syzbot] possible deadlock in bpf_trace_printk
From:   syzbot <syzbot+c49e17557ddb5725583d@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+c49e17557ddb5725583d@syzkaller.appspotmail.com

Tested on:

commit:         d678cbd2 xsk: Fix handling of invalid descriptors in X..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13743f27f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc5a30a131480a80
dashboard link: https://syzkaller.appspot.com/bug?extid=c49e17557ddb5725583d
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16922173f00000

Note: testing is done by a robot and is best-effort only.
