Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CFA530F79
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236025AbiEWNM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 09:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236155AbiEWNMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 09:12:14 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8812CDCD
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 06:12:07 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id x5-20020a923005000000b002d1a91c4d13so2002828ile.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 06:12:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=bb2fBgp8rleyQWFo5k2i1W76jOqpII6fQInRn3aiZCM=;
        b=rBry863PiNeGBK2UfgxFcVhZet3EVx1MTfCq2Y1wj2GUmVIRCPfh3l0ih2D+eam8Nq
         TeIT9lF0I1/WyUQh15IiPluo9Ng5G5+4CLKYF67ThePtvN0YhvsfzfGYyyT6m8BrCItg
         FRccCxGiEMFrYPHUIuQvd68A2rcmblXkrKj7a2P/IHoxFtuWNwCVE9OwLtyqDfGaeQPH
         RsPD3b28Lhjk6FC+Dl5IPB3aijZeNHwXbW8pQk4fbB5xUBEQyzL6cDdEW0GtZEYON8cF
         stwIcwFGgJw2JPZpIaQOiMpt5KDXmUi9DdPX9MiP/lBvbYqTyaW3j/PRSOceRZUHTf6Z
         PVHQ==
X-Gm-Message-State: AOAM531UyJz7WG7lgJB8KxvrlNqIKKTcA48XJAWtcZNm3ytLTuwS+hEH
        1j34kHhBxGy58GbEW803G2cH77FCxoluCuk7Q2KO7U5puzwP
X-Google-Smtp-Source: ABdhPJwe1+FrHSgI6wqF3zuZeASXQ7uUonOys7HC27c2cvFQ8E1uHvOXxfJ1eNSneOwceUOK9uPyMn0SWjXOkjAiWCkmfrKFKcVN
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2cca:b0:664:d9c6:3674 with SMTP id
 j10-20020a0566022cca00b00664d9c63674mr1759652iow.67.1653311526774; Mon, 23
 May 2022 06:12:06 -0700 (PDT)
Date:   Mon, 23 May 2022 06:12:06 -0700
In-Reply-To: <20220523124859.3210-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000041ae3505dfad968c@google.com>
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
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10c01fc3f00000

Note: testing is done by a robot and is best-effort only.
