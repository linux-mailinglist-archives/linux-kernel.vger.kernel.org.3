Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAD55088AA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 15:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378715AbiDTND5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 09:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353831AbiDTNDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 09:03:55 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FC615A13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 06:01:09 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id m3-20020a056e02158300b002b6e3d1f97cso853068ilu.19
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 06:01:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=2IgGQLD5G+5Tfxlq7KIln/oteLHYJ2GP/WcMqcq8IfM=;
        b=6mmp0tatUmHYTYhOSGvVGbtRi0NexJT7vfKtkyb4ZcMpmMqQRdMQ5L/w+ruPRqWwMQ
         NLZplG9IEtnjJxxiG5VRFWG2VE4Q531htirhgc2IG31tBgYCA9RoS9vToS93rlV+W9i9
         tTEv6BtZ5UfVO7SMOW8SYlFVQWXvwEBi3++sj0Egqh35aUFypbgPraF+hUNufIfEtfN+
         Swq6iyNQhKMx12Lo7lvsPv7YlsBuj3OGbB0+HdD3+tVkUmcLp/VfBIDIvUeAOwOH17iW
         nojeyUd0A3OVjXlZqW49om+iSZ41BVzmqrSLau0d/pbaPm13WDZYDnTZ/L6EBu0fmeXo
         ntYw==
X-Gm-Message-State: AOAM531b+dq0nGO7O7TYdP4iSEY4bKiNHSS+/iMBw1YZXOBd4h5n1b3+
        6ihySPnWf5uwsnBhEke+SvMGpn4zmawBL7iYdhcFl/s40A5n
X-Google-Smtp-Source: ABdhPJzqgate6rM+viCu2evOUewTb40FXkpQJff38RYGkcV8cjBRUVacaL8fdpt38dEG5KKBk/tHmbreuHsoSkA+fxnJNfPU0Prp
MIME-Version: 1.0
X-Received: by 2002:a5e:9302:0:b0:648:c246:291 with SMTP id
 k2-20020a5e9302000000b00648c2460291mr8782140iom.88.1650459668859; Wed, 20 Apr
 2022 06:01:08 -0700 (PDT)
Date:   Wed, 20 Apr 2022 06:01:08 -0700
In-Reply-To: <20220420122702.lseed5l3lrssyat2@wittgenstein>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000474d8205dd1596ba@google.com>
Subject: Re: [syzbot] INFO: rcu detected stall in sys_lsetxattr
From:   syzbot <syzbot+306090cfa3294f0bbfb3@syzkaller.appspotmail.com>
To:     brauner@kernel.org, fweisbec@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+306090cfa3294f0bbfb3@syzkaller.appspotmail.com

Tested on:

commit:         bbc1e8c5 fs: unset MNT_WRITE_HOLD on failure
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git fs.mount_setattr.cleanup
kernel config:  https://syzkaller.appspot.com/x/.config?x=c01066a8395ef6d7
dashboard link: https://syzkaller.appspot.com/bug?extid=306090cfa3294f0bbfb3
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
