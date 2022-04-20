Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF49A50890F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 15:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378888AbiDTNU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 09:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378877AbiDTNUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 09:20:55 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD6D42A0A
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 06:18:08 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id v14-20020a056e020f8e00b002caa6a5d918so885987ilo.15
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 06:18:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=aM2Q2d/hJNPY2DMp/gPkgY7NILmg4uzapPLGnb3ip8g=;
        b=A5CFDfh0lFMQwyAMRF0M99eV8VhN2GQsxxyZ1nglR526O9FH322FCSSR4MGjbC2hA7
         8ywZkWimeJYS87Z5VXz7q0gqufCD997zxtdG43uL/AbpJ0i4ZMMDLZ3/r+ZtZOQ2Gu1O
         AyqvkRDt5bfHlnop8rMVs1rbHx5kekAQN0oVLRmue3sqKuPpyQWot4jrM4jQbITnIKaQ
         FDobK6e3gSDcbw8yI32SR3mEN10ia0r7dhtAlRTlXb9g2/qUMBJDgKbpnNzaM5GdriQB
         sJaBUecbE/TJhGo6HMMbyz/tj7K3HEvRX2y16EkVxIaotQhQQ780LVXNdkkeTFG2izEZ
         YUPA==
X-Gm-Message-State: AOAM532bG/dIB/8iIINGXcJlZz0qI1zkCZVVMVC50kRUi1xFJNjt9WOM
        B92r5f6a1CzjHo6/KlaT3OaGWl+lqOkNeuTrtA+ci6kHDpec
X-Google-Smtp-Source: ABdhPJxu2RZ1CiqGWLVPPnLZOgLlP+uI8/5OKKR0Jj8q6RcsN/iR/FYUjqXCQ8Grb+eaoxDkLTK1mB+0cIZUNs/BZUi4pP4tC7Am
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:152f:b0:2cc:b71:5b34 with SMTP id
 i15-20020a056e02152f00b002cc0b715b34mr8878949ilu.23.1650460687500; Wed, 20
 Apr 2022 06:18:07 -0700 (PDT)
Date:   Wed, 20 Apr 2022 06:18:07 -0700
In-Reply-To: <9ac31ca6-7141-74c0-a22b-4d908839d8e7@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fe8ae105dd15d214@google.com>
Subject: Re: [syzbot] possible deadlock in io_disarm_next
From:   syzbot <syzbot+57e67273f92d7f5f1931@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+57e67273f92d7f5f1931@syzkaller.appspotmail.com

Tested on:

commit:         0f00d115 io_uring: refactor io_disarm_next() locking
git tree:       https://github.com/isilence/linux.git syz_timeout_deadlock
kernel config:  https://syzkaller.appspot.com/x/.config?x=c01066a8395ef6d7
dashboard link: https://syzkaller.appspot.com/bug?extid=57e67273f92d7f5f1931
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
