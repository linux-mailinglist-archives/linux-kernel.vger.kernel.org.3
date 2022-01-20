Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D18D49539B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 18:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbiATRzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 12:55:08 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:50149 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233004AbiATRzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 12:55:07 -0500
Received: by mail-io1-f70.google.com with SMTP id g16-20020a05660203d000b005f7b3b0642eso4435816iov.16
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 09:55:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=PgHxSdlHdOrLmXID6kwrwLEwhOW4ZwdFFAu3sMkS4us=;
        b=qTrn6w3Zpiix7NL0DHywBFUSdYJbDyiUJOPyOR9qXe4JN2KgvW/CUSaC5mZiF60Fin
         eJPXndEswzpObGRv6Z3qmKY8ASdpE7uq8oJ8J6u8tycn+V5eyKQY1oKl85kE/JB5sWXz
         a14ULCgimgKcQtKAAMRB1C4NUq9NK2A6FHZ71tt8fTmsiFXnhaFX5+zkkbyY7MCKkXHE
         6TtsvZRvBokhfNmVf0ld3Ct/gw6T3uS89P/K21UBBl6Oh38HrzO6lWNY5S7sdC0z9ep3
         iw7AczUzaykbZ+/sr8STpE6SZMbno9rJJ86W12isDIWMX7OW/dd3G0GnNhEq9dzzTvww
         /m0g==
X-Gm-Message-State: AOAM5326oYhq9veH6lw2cgaooVCWXxYDFyCXqmlBil6CWSH9gMN8aDP4
        ZLWtXMZ1TrJTbOkN37eRLrQIGeI1egN0DYzQkYAVsBU4zndQ
X-Google-Smtp-Source: ABdhPJwYKv/aqTjtiFeKjgHzsrq4lX7eFkoOPieYwlVboN334XuAVGOTylthd+c/LVLblNC0nJaUNyuIGZNe44NNe6cnKynDC/Nu
MIME-Version: 1.0
X-Received: by 2002:a92:ca0c:: with SMTP id j12mr39083ils.105.1642701307187;
 Thu, 20 Jan 2022 09:55:07 -0800 (PST)
Date:   Thu, 20 Jan 2022 09:55:07 -0800
In-Reply-To: <YembypBPqEXg+YB+@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e3395b05d607330c@google.com>
Subject: Re: [syzbot] INFO: task hung in hub_port_init (2)
From:   syzbot <syzbot+76629376e06e2c2ad626@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, hdanton@sina.com, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        paskripkin@gmail.com, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+76629376e06e2c2ad626@syzkaller.appspotmail.com

Tested on:

commit:         6f59bc24 Add linux-next specific files for 20220118
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/
kernel config:  https://syzkaller.appspot.com/x/.config?x=94e8da4df9ab6319
dashboard link: https://syzkaller.appspot.com/bug?extid=76629376e06e2c2ad626
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1596bbdfb00000

Note: testing is done by a robot and is best-effort only.
