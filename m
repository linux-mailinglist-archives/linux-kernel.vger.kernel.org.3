Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71BD4A738D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 15:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbiBBOtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 09:49:09 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:44853 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242012AbiBBOtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:49:07 -0500
Received: by mail-io1-f70.google.com with SMTP id k2-20020a6bba02000000b00604f85cceffso15298824iof.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 06:49:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=6Nd1L82ICndPV9f8V8g1zVMprvZUqDrKLntRDzaTUKs=;
        b=bHZ4CVHC6QaeN47EqPhV1oT+tRQzlN3iicCeZsW+xPyOWJxH4eU0dsoSOBe48UTKha
         +LA7ctLt+Xnq5HijFhDgJBxcwyMVZZ7UghlyoiTjZnEIrB5liUDXzZM5TujdpT6yAyeP
         gsn46L3nzbQM+mSmqOydwVTZ7n5drUzReWvx/AvrJYLagBHh/G40G7BRuGVsasYPbBWR
         0wWRLfCKfuECY/CkzPxLh4KzYFQFiBT370jK2ywxdktg8KdBAzPPVGil+vluZf3eFtav
         L2Ip5H21rscqDMXmpplfx9Qx2fVL+NQIVENEXsssUSVkT1emqOK2C4Ev4yJHftnQrL7I
         lDhw==
X-Gm-Message-State: AOAM530OoxgFbrniFvuvyng4jLuHsXpUFqaaa6Jwenb2BWmXx9HK89on
        95p3VhaaHRRYu313l347FtJJpAn9mc/fpZ6UGWm0EIc4Jmf6
X-Google-Smtp-Source: ABdhPJwiZSvL8CqwB5CvuzxGq57yo5R2vWvAErDKljFwjGmHcp5ZqIzV1eqZaQcleFi335EERjmwRhGGhgIxSPAe8IBZNR1RLDj2
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20cd:: with SMTP id 13mr17352269ilq.225.1643813346862;
 Wed, 02 Feb 2022 06:49:06 -0800 (PST)
Date:   Wed, 02 Feb 2022 06:49:06 -0800
In-Reply-To: <8d1abb6f-17c3-4323-d56b-a910092e9989@iogearbox.net>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009deb3105d70a1e67@google.com>
Subject: Re: [syzbot] KASAN: vmalloc-out-of-bounds Write in ringbuf_map_alloc
From:   syzbot <syzbot+5ad567a418794b9b5983@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, hotforest@gmail.com,
        houtao1@huawei.com, john.fastabend@gmail.com, kafai@fb.com,
        kpsingh@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+5ad567a418794b9b5983@syzkaller.appspotmail.com

Tested on:

commit:         48f52cba bpf: use VM_MAP instead of VM_ALLOC for ringbuf
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/dborkman/bpf.git pr/rb-vmap
kernel config:  https://syzkaller.appspot.com/x/.config?x=5044676c290190f2
dashboard link: https://syzkaller.appspot.com/bug?extid=5ad567a418794b9b5983
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: testing is done by a robot and is best-effort only.
