Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2DE7547143
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 04:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348166AbiFKCTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 22:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236391AbiFKCTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 22:19:13 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC95934EC6B
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 19:19:11 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id i16-20020a056e021d1000b002d3bbe39232so510942ila.20
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 19:19:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=tHVTwt2PWD/vy8v6ZvoCr74jkGvVIE7FZgcQ84tt83I=;
        b=KxCNTEUmXAD00y21cOqSjqGle8hhTdXxTmFjTmoaJXkl1StBpTyNX3fQX6fjrrSPBN
         YA0zC4zmFBE/npNY9vTxJS5W2r4V2bCVYgjk8Zn1Zj9uTJif5MGpCLGrOjqJSaNEDwDH
         gIe5wBoL4VlGBXIuOOTv3f6wz7mM5zpvfwlHsrXVFedJBwsc9tomqBQJIUhp6WVwtIK6
         eke2AdVNnUmqVyJoxEzNZyMfKDeQiY3h+o8zbp3skUGPcmo47YVYI/VR+lL0m4L6lADo
         y9Gb4se52Esj+wSd3zNukt5GhQ2dKf4kJTwFYYLphdB8uSvM62NlGdoHOsVqFpkgdARi
         Ju3w==
X-Gm-Message-State: AOAM530EzbZV3l99f2udAgY9xZK4fsEo0/EjCthwF8M/E/dMonkgAqWT
        NHqm14SLW14Y25hbiOkMDLoyiYaqiEYFd3jfFLGdgpdLxPAN
X-Google-Smtp-Source: ABdhPJxn8Jwh13gBFKkfTlnqFbBzUky0CWR7V7toMn7uWTyhXx8Vo3XDtLyog5dr+WDD/RfKZueOv4/JX/jlt1DLbZ1w/OjWq3Yb
MIME-Version: 1.0
X-Received: by 2002:a5d:9948:0:b0:669:a41d:6ee8 with SMTP id
 v8-20020a5d9948000000b00669a41d6ee8mr6745950ios.24.1654913950865; Fri, 10 Jun
 2022 19:19:10 -0700 (PDT)
Date:   Fri, 10 Jun 2022 19:19:10 -0700
In-Reply-To: <20220611015957.1549-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002cde2f05e122ae55@google.com>
Subject: Re: [syzbot] BUG: sleeping function called from invalid context in sk_psock_stop
From:   syzbot <syzbot+140186ceba0c496183bc@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+140186ceba0c496183bc@syzkaller.appspotmail.com

Tested on:

commit:         ff539ac7 Add linux-next specific files for 20220609
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1462f61bf00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a5002042f00a8bce
dashboard link: https://syzkaller.appspot.com/bug?extid=140186ceba0c496183bc
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12a7d9bff00000

Note: testing is done by a robot and is best-effort only.
