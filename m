Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21ED94B2F71
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 22:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242027AbiBKVgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 16:36:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348044AbiBKVgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 16:36:10 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EA1C63
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 13:36:09 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id k5-20020a926f05000000b002be190db91cso6776103ilc.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 13:36:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=uZFH8v5hdkuD13HWKXbwlKXOFU1tLj/1KgXaqFsCP+w=;
        b=nEYOuK5dfdor+NMxD+jhAq0ePTbniTeXbr0jCNixdF+wWy39fWkcQ6kyeO2i9p2uaU
         oCxmFsogoeCl28SrFJbshBJEZQ89Prn87/oKB3I4JMX/J3Hy7PBpDta5jpR2JhshTxfw
         lXOd2PyxkTyDqMBiJrTpw5G4B2D6vufc45rWfln+kUiE2k/McvAasbWAt6PCky619Q8k
         IehEKM/6RHq4Memq4G4dSSB8LRSb8Tuc0Qp0VGWKFLvzMjTgp1K6+2HEG7cA1VgcE4Hj
         3T6yn+LxGAefxf6wRk3JsGz/KQH5h/c/zjCYavsZ5e9U1sDmFSMCcPhauF+iVCkt4L9y
         Wsmg==
X-Gm-Message-State: AOAM5335Rj8is5Hxy/3Pl5zwxIM+WN4h4WOQkYyI6dqj2Ew+PEcxOR8j
        huxqUiO5oh3T/DyMayg3vXbbURuBMolkA0hqSytdnuz+60QE
X-Google-Smtp-Source: ABdhPJxIMl3Dj6whKaFjTGnZrRnkr5JcDWjIWAL80oKZ7CA90a6/GGlca6MO6Yn7/LWch5SH1DLI8BFkEEZ5aN7OR35Og6xECnE3
MIME-Version: 1.0
X-Received: by 2002:a05:6638:164f:: with SMTP id a15mr1964678jat.272.1644615368382;
 Fri, 11 Feb 2022 13:36:08 -0800 (PST)
Date:   Fri, 11 Feb 2022 13:36:08 -0800
In-Reply-To: <YgbT4uqSIVY9ku10@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d31cac05d7c4da7e@google.com>
Subject: Re: [syzbot] memory leak in hub_event (3)
From:   syzbot <syzbot+8caaaec4e7a55d75e243@syzkaller.appspotmail.com>
To:     benjamin.tissoires@redhat.com, gregkh@linuxfoundation.org,
        heikki.krogerus@linux.intel.com, jikos@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, noralf@tronnes.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com,
        tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+8caaaec4e7a55d75e243@syzkaller.appspotmail.com

Tested on:

commit:         dfd42fac Linux 5.17-rc3
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ v5.17-rc3
kernel config:  https://syzkaller.appspot.com/x/.config?x=48b71604a367da6e
dashboard link: https://syzkaller.appspot.com/bug?extid=8caaaec4e7a55d75e243
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=121f0f78700000

Note: testing is done by a robot and is best-effort only.
