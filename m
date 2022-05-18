Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2A552B83F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 13:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235274AbiERLAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 07:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235152AbiERLAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 07:00:12 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CD516688A
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 04:00:11 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id g16-20020a05660226d000b00638d8e1828bso14259299ioo.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 04:00:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=/zrbhaSQ27urrJpLijpgrnimuJoTrLLy3BmKBKQSJ3g=;
        b=J0MDB3Jae0Sw4j1/4T2caQowFc+IDO9k/L/betM6X2xi9C7ZMB/rRHDEYJcZkc8oky
         rAjNUU1jqZ06K0ykzjZ8ZxzS8HGK58ujVn0cfY4twVY9ffb6Yqee+hCOM2a8OjOd/4o1
         p1vMSGkqs2eUmtGuKAq5E3WXFhwrSLj23qQf7Iouklgm7v0aU9nA9K/J86B3JEoznRpi
         7FzJEUhPjKwBsU/QpA/gqbFjGGHZtQm7h5z9g8GGQ0jHKoJ9p2SfNbhFTGUnQAjCGfu8
         pu5QmVdJlJGXhik+mSdMhjt9J3Fv2n5vO7OmvUu+W9XmOHsf8VpH5pNoloCk2CKjgtCh
         D2Fg==
X-Gm-Message-State: AOAM530hh3sOKUVabkp8UZYXkw+x/CpPnNdCNx9kuXb7mr9nZTgOhAJ4
        WLf3MHoxPLhWMOKrbrtORMYSI3gWdCyIPxEYL2/JQXproiXw
X-Google-Smtp-Source: ABdhPJyCWbN0SIAlVVHn5LWP4d0a4UkJX97lsh9TKPKPi1meR17i7ofDtxNYa1/y9cN/qHZuO70MShmErXS+6q8wNESxrwnUL6bi
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:164e:b0:2cf:82bc:6c76 with SMTP id
 v14-20020a056e02164e00b002cf82bc6c76mr14238689ilu.95.1652871610738; Wed, 18
 May 2022 04:00:10 -0700 (PDT)
Date:   Wed, 18 May 2022 04:00:10 -0700
In-Reply-To: <20220518104052.2373-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000037b05505df4729ea@google.com>
Subject: Re: [syzbot] WARNING in mntput_no_expire (3)
From:   syzbot <syzbot+5b1e53987f858500ec00@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+5b1e53987f858500ec00@syzkaller.appspotmail.com

Tested on:

commit:         feb9c5e1 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
kernel config:  https://syzkaller.appspot.com/x/.config?x=79caa0035f59d385
dashboard link: https://syzkaller.appspot.com/bug?extid=5b1e53987f858500ec00
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12f8dccef00000

Note: testing is done by a robot and is best-effort only.
