Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A86252AB6D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 21:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352465AbiEQTCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 15:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345117AbiEQTCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 15:02:11 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2A53F30D
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 12:02:10 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id n5-20020a056602340500b0065a9f426e7aso13040122ioz.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 12:02:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=trJlUoBsAU0Gfja7NVm8U0mdQqxyIpgiYU5DZakIhBI=;
        b=0zUtqd+nEynqrlcVtDjsniIKNj+8xLfTFJmjgBiKWTOHRjIPYHjN/x2cUxdMnViNgK
         j7HYH8hJ+Ad/vi4iOtC4zb+NedPcMO5MC5/OpxwBZDiQ7SvajGpwn1lgoWO5NgUy/Kjc
         AEWfob7McgftlZXSd3Q5b/kQVjBL/+BZinGuRWgigqe3lZazU09IJ+BeWlgQ27Kv4I8E
         xtDNQw2PNaaQe1jps6OEmpd1HM3JxKLeEQ12l7b00M6O8auceypmIZ0eMZaL2GoKR0lL
         vBm/eo6oKiEg70h49kLbPd0XB0rpgymKXfcUydIco9vrulHua2XbT0ywGmjcC3vc+Dce
         LXOw==
X-Gm-Message-State: AOAM5310nZS2Lwa9bSFGdoIBF+NVk9WdMfYhfPCXIiouQ/ObCTv37/0J
        a3noq2vh9JxWwN6l2eFTYTxCy0fEjNwHX4YbOAsHklqQZXVU
X-Google-Smtp-Source: ABdhPJzi+HvE6EnVZG74GdN+JteT30NG17qd1T8Fck4gK/b02ljT7Ivc1HOnroXCMXiZvdak88P7i4HRbU5ddf6lP8jLjD9XV1eY
MIME-Version: 1.0
X-Received: by 2002:a05:6638:d13:b0:32b:cf94:275b with SMTP id
 q19-20020a0566380d1300b0032bcf94275bmr13195448jaj.22.1652814130055; Tue, 17
 May 2022 12:02:10 -0700 (PDT)
Date:   Tue, 17 May 2022 12:02:10 -0700
In-Reply-To: <b6f36795-97ac-fac0-ab07-98de8255e4f9@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001a0dba05df39c7d3@google.com>
Subject: Re: [syzbot] BUG: unable to handle kernel NULL pointer dereference in io_do_iopoll
From:   syzbot <syzbot+1a0a53300ce782f8b3ad@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
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

Reported-and-tested-by: syzbot+1a0a53300ce782f8b3ad@syzkaller.appspotmail.com

Tested on:

commit:         aa184e86 io_uring: don't attempt to IOPOLL for MSG_RIN..
git tree:       git://git.kernel.dk/linux-block io_uring-5.18
kernel config:  https://syzkaller.appspot.com/x/.config?x=e408a5da421f07d4
dashboard link: https://syzkaller.appspot.com/bug?extid=1a0a53300ce782f8b3ad
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
