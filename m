Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5046E54F8ED
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 16:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382693AbiFQOJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 10:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382639AbiFQOJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 10:09:09 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD261C92A
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:09:08 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id h4-20020a056602008400b0066a011ac3d6so2566621iob.14
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:09:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=UTquv6dzsd7VZmkp2eRx4bPA13TO8qPulfP8oc4oJsU=;
        b=PFE3RahE5eNz+gFs0RYDygYJ6E9jvVYkGvbRuUQv5phx06KQv+eqKuQV/nicD35of0
         uhdptJIQGR/++sl53uQ4Au+4tY5XcMVv3QbNsBisEJY3l1wWl1F6/MfNVGlq9TVK4E8p
         3oiXKXOw1TE7pvmxQK9ptPQfI1BYZSdkOtUmFJDrUvFhePdCURKIGYh7SJNT5jZxA05h
         1wlo5gYoTKsKRoeMVkl9TKkqjCCtPMkI8uebOxGKcnfq1YYb6ic9LnKhYxRf7XGGUNg/
         9CBjlcKQg+c3h+Oh4Qok642slK3kEYIsvLUomWUdMoLfPm27cdTDg66tkyzAdMtlz3TW
         hZqA==
X-Gm-Message-State: AJIora/eAngSCbxPUfx/7YjBvHXZ1eLq9fnVPC/goGO+xGfYdP4prcqE
        vq+9ozR46LIPWfE75wvRSD64zSukN+ePr2IFs2McH10orhqK
X-Google-Smtp-Source: AGRyM1t8p2ZCM2Y5ozZ5VYC9/UFIrdlLGI37YivpudWLs5aFFp+hP9v8okSSXJZ/woOmf68cMQ1y1LXAXDRNDsC/CvdN+Vp+HGh8
MIME-Version: 1.0
X-Received: by 2002:a02:3448:0:b0:331:84bb:d66b with SMTP id
 z8-20020a023448000000b0033184bbd66bmr5627954jaz.292.1655474947719; Fri, 17
 Jun 2022 07:09:07 -0700 (PDT)
Date:   Fri, 17 Jun 2022 07:09:07 -0700
In-Reply-To: <20220617123413.2734-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000031884405e1a54c42@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in ath9k_hif_usb_reg_in_cb (3)
From:   syzbot <syzbot+b05dabaed0b1f0b0a5e4@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+b05dabaed0b1f0b0a5e4@syzkaller.appspotmail.com

Tested on:

commit:         4378e427 usbip: vudc: Make use of the helper macro LIS..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16ef952ff00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ceddcfc6e4531984
dashboard link: https://syzkaller.appspot.com/bug?extid=b05dabaed0b1f0b0a5e4
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1199603ff00000

Note: testing is done by a robot and is best-effort only.
