Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B75456BC67
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 17:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238292AbiGHOkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 10:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234285AbiGHOkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 10:40:12 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6E913F0D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 07:40:11 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id c8-20020a056602334800b0067500ca88aaso11385890ioz.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 07:40:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=BGyGI0nhO1tZ1AiSieZOwo6ROGPm380AjmQ87Ia1ekY=;
        b=BSjzMA7PP1UffyRFkr2qnVEn0t9ZuA+UuKjf2pHDSx096bHUsppQFariZBI5doaICL
         0nsVsukP5mrGZ5ZheZZ4aKcRxASXWlnbKkbazjB4ZCcUaT8JytaIG6dgZn3EjkjuyQVY
         nzUWouMqGMTTRTt8wAR4D6fpLSbGcPOVewz1zLvZA3LwW9V0Cg4cafIDCnPPoeeKnEP6
         DpDP5mxs5O4RjC6B+h5sKfGJnn8O/ttRpv3O0lE5jOkRE49wOSje3Ht3zqj0ta5s5Cjq
         GhjAUPRxCkPjeYG5IChKkn7DgoZXH7E1AYRdqPcKyXLLS3scEbmmpBkKohx0a4QagLMU
         nbiw==
X-Gm-Message-State: AJIora9WMvhZFItnEYiHy4ROJkryjFHIEAj79wJmWp/UZlLgO5Vhaqmt
        ipeQu8vz2eMDuPrzBnbGSROthEtxBURcpHUPBw+OFJFBkqty
X-Google-Smtp-Source: AGRyM1tm3H3yD6tBRgRxZsaFRN6bkJTuDaIc+hjHrKNa80PBrWifvwUGsdveaWT7rXDpL7dEKho2VTMAefF18WP4P4t9kM8/w7Lo
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d15:b0:2dc:20a1:f3f with SMTP id
 i21-20020a056e021d1500b002dc20a10f3fmr2340565ila.60.1657291210840; Fri, 08
 Jul 2022 07:40:10 -0700 (PDT)
Date:   Fri, 08 Jul 2022 07:40:10 -0700
In-Reply-To: <20220708111638.2224-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e9631505e34c2d7f@google.com>
Subject: Re: [syzbot] WARNING in notifier_chain_register
From:   syzbot <syzbot+5214f8dac5863061e37c@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+5214f8dac5863061e37c@syzkaller.appspotmail.com

Tested on:

commit:         cb71b93c Add linux-next specific files for 20220628
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14bedff4080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=badbc1adb2d582eb
dashboard link: https://syzkaller.appspot.com/bug?extid=5214f8dac5863061e37c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=163fa292080000

Note: testing is done by a robot and is best-effort only.
