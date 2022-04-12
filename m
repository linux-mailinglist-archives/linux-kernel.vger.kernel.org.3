Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25804FCC32
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 04:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243573AbiDLCJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 22:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242780AbiDLCJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 22:09:24 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A14E338BF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 19:07:08 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id g11-20020a056602072b00b00645cc0735d7so10755718iox.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 19:07:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=rgLhKgyYYXped5y5Egl1XGVJSyw4pIOBxrcsqBBOMPM=;
        b=3v/o5Y7oiUl8dueJnfvD9r2vgT4g1eV12bAtkvsx9F8W/xPYPFxb+QzFm3/lRcK3LA
         6f/S+egPyiT95+zSnXfItXDtFGJClMOnicRa5dGO38Fkck1Qzp8DqIYdyoFR1FczJY1Z
         pjTlQ51M+Atw3P4OiFWGtP7Wf8Q0pn3O+2pFVZgDkPQJAtUQDXKm8y9Pk/Mm15C4AGx5
         1YwBC2qgwIpWtwVYsezT6k9FvxPQPx4ybkGsboxHkrS1idrdm56S1nQ1ScmrsPG1zEPB
         +WPPgpU7uiRrTMTcD9csR9GiIOtw87XAgh5KpRpcDZoMOvd8VaX8RUwIG/F4xcw4ZVTj
         XxjQ==
X-Gm-Message-State: AOAM5330VGzeSGB+QArlajCRQQUdz/UDue50p6DFh8XaBP5MxTPLX20W
        0pmCixn3fLAzmznMzHWoGi3yaiysJWaLLD7qyQ765YKNusYX
X-Google-Smtp-Source: ABdhPJxIQgnlTG6611QNF85mk+GE0GJsYrhE1dmIPSFt+vn4RQPBc5gWboiYalgK2FPu7DY4f5GKByS9KaJbMktyCjEYOz5HhU6T
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ba9:b0:2ca:8e77:82e1 with SMTP id
 n9-20020a056e021ba900b002ca8e7782e1mr7327019ili.311.1649729227774; Mon, 11
 Apr 2022 19:07:07 -0700 (PDT)
Date:   Mon, 11 Apr 2022 19:07:07 -0700
In-Reply-To: <20220412015446.6243-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000098e01a05dc6b8433@google.com>
Subject: Re: [syzbot] possible deadlock in sco_conn_del
From:   syzbot <syzbot+b825d87fe2d043e3e652@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

Reported-and-tested-by: syzbot+b825d87fe2d043e3e652@syzkaller.appspotmail.com

Tested on:

commit:         d12d7e1c Add linux-next specific files for 20220411
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/
kernel config:  https://syzkaller.appspot.com/x/.config?x=58fcaf7d8df169a6
dashboard link: https://syzkaller.appspot.com/bug?extid=b825d87fe2d043e3e652
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13879aa8f00000

Note: testing is done by a robot and is best-effort only.
