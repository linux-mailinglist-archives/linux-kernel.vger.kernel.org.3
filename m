Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8745B531416
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236675AbiEWNzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 09:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236402AbiEWNzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 09:55:09 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EE756C38
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 06:55:08 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id p12-20020a056e02144c00b002d196a4d73eso2877335ilo.18
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 06:55:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=8tSOs/5Ug4mAsUNPTHsRAD+4foKtB2hFf1Ue+2j7E9o=;
        b=mslC959eqhrjPFMGVzAowqDPtXR4qIUBo4jTzI4kndajovbG7LPuRUZrgi/9Z3uNbE
         j6F1ypVOsnFACGeDSp2tVnyibNz5LpsNZA8+euYfKkXV3agYdBzdhXpRGvWVW0dTIulN
         wnXiy4KKu3QSONzIKnmCPo2W/amNx3y0+Iq4FC9kWb6lkb1L1lRCbvO+k3U+vx6j54s+
         s7fCDwRZWRy4Ln/WUdcslA0Wd1ai2qdWFnyBiYD6FoHj66Z51fSdVzO2cyT7vXMfadCP
         9lgz/AQq8fqA5vgePrCYsU5WMdl7+W0YbcV6qKJel2abudzQZx4OBSKJZPI38hnW2cki
         1EnQ==
X-Gm-Message-State: AOAM532ILPmzynAS4wkSeCONsIp4neL+BKMalT72Aq6JNVIyEHWR3V77
        +ySAMQDkaxsKdCRDAW1SxWyezl4SApYZ/gXBkxuQm3W9PVgU
X-Google-Smtp-Source: ABdhPJz36MnZqdSLO4HIvCupcOV2SlFE8lSmwOD4T7X/uNxr0HddgU8PclRE1YR4mBB2lbojDq/ia5HxXATeoxHUHLi7Oy8F+qGx
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a88:b0:2d1:f00:78b0 with SMTP id
 k8-20020a056e021a8800b002d10f0078b0mr11582162ilv.20.1653314108284; Mon, 23
 May 2022 06:55:08 -0700 (PDT)
Date:   Mon, 23 May 2022 06:55:08 -0700
In-Reply-To: <20220523133145.3269-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000020666d05dfae3059@google.com>
Subject: Re: [syzbot] general protection fault in ath9k_hif_usb_rx_cb (2)
From:   syzbot <syzbot+c6dde1f690b60e0b9fbe@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+c6dde1f690b60e0b9fbe@syzkaller.appspotmail.com

Tested on:

commit:         4b0986a3 Linux 5.18
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=55eba09345624206
dashboard link: https://syzkaller.appspot.com/bug?extid=c6dde1f690b60e0b9fbe
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=176788def00000

Note: testing is done by a robot and is best-effort only.
