Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A454FA0CC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 02:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237179AbiDIAxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 20:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiDIAxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 20:53:13 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD16B5FE2
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 17:51:07 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id i19-20020a5d9353000000b006495ab76af6so6786087ioo.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 17:51:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=p4tSdoEjjT6Vgz/3cnEspxzOcbZnhthfckc5hh0b6Hc=;
        b=g7Z7madCFw0l0WgZmipKz1vY7CcTwbf5DgOb2aIwqfPDB1/vj8kDhODCBK2cmRQg8r
         rPJR51QQyhLxaFOTcf0KqcPfnVyvA6sfR9vPuCYtrXHnqlh4WnyXYicAMCVxCEQvXEM+
         kkb0o1I19bZohpa2G+hPBhzhnVp3yqNpMRb7XeNMmt0TXZZieqdUbhLTz2U2r3nywfAS
         IZRD6pxrHx0DaBP8oGEjfXLMMWwQdeWVSoAxQwzTCfO5RS++TcMoDrtuab75268oAkux
         QSqD0l+871clupeq4UOjOGcD+ley+EWv/y8FRwdKCC5k4Qn/5HAQZZ7Gc9aY/dwe658s
         OzBA==
X-Gm-Message-State: AOAM533Ym21HaezeyBgFaW7rcmKbkK4bYgZV/GLEkFmKtshchh49EuCU
        +85wEXzp1UUWYLLCSLumEtTxeVxU2BSF0QJzMAE2mz4FwU7t
X-Google-Smtp-Source: ABdhPJx08oINfFjBwA2dtIUwkZzRTuzr96IgUhEdMLKVuPWd3luAlN8gTq4QWs3UgOLw9oGD7vUyFyMaZQQlqejbX5bdGobM/kfo
MIME-Version: 1.0
X-Received: by 2002:a92:cd84:0:b0:2ca:3bf1:fa08 with SMTP id
 r4-20020a92cd84000000b002ca3bf1fa08mr10043708ilb.219.1649465467091; Fri, 08
 Apr 2022 17:51:07 -0700 (PDT)
Date:   Fri, 08 Apr 2022 17:51:07 -0700
In-Reply-To: <4181875.ejJDZkT8p0@leap>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003c427705dc2e1b1d@google.com>
Subject: Re: [syzbot] KASAN: null-ptr-deref Write in snd_pcm_format_set_silence
From:   syzbot <syzbot+205eb15961852c2c5974@syzkaller.appspotmail.com>
To:     alsa-devel@alsa-project.org, fmdefrancesco@gmail.com,
        linux-kernel@vger.kernel.org, perex@perex.cz,
        syzkaller-bugs@googlegroups.com, tiwai@suse.com
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

Reported-and-tested-by: syzbot+205eb15961852c2c5974@syzkaller.appspotmail.com

Tested on:

commit:         1a3b1bba Merge tag 'nfs-for-5.18-2' of git://git.linux..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=df0c3f2244c64190
dashboard link: https://syzkaller.appspot.com/bug?extid=205eb15961852c2c5974
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17fb5d30f00000

Note: testing is done by a robot and is best-effort only.
