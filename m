Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E74C494929
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 09:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358941AbiATILM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 03:11:12 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:50816 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358401AbiATILK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 03:11:10 -0500
Received: by mail-il1-f198.google.com with SMTP id h6-20020a926c06000000b002b97ec9827fso409702ilc.17
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 00:11:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=BJlzqqjrs17SVp97ypy2bLlCbjlSXkVkZRZti+CfRQs=;
        b=lEfFYt51XF0aZTIbaFXaWWgGqWJAba0i63tQkRLDdNUJYvo0dSn8sMhtcK1B/rNaVB
         zr+Lcj42q3/tvqXL7SL4JgVgi3Zt+LVzQTQEwiAnzVNBKnycgtDxFtI7tR7NOol9pwxt
         EgDh1RR1yBRQuPybL08FbMC+msXx8pagw+GIeRtuyCNl2G7benTlfZdFpUH6VIXEcaz4
         dfFlc9AJbY9X9G95iS8vRhZJY3FRb5MKFVHq3SYiepzWRgaiEwK8r9t7S5G0Z6WvUnSH
         G18hhzOpwGoMg/fxgwKIerM5/tALi02XZTkg/cJXzDwRStgaX6k7yRaT9OLl2DAqrYyw
         OLeA==
X-Gm-Message-State: AOAM530ZiDdFhSnw8e5YF1s455aE4XR9bWEkKUbOsb5P03vDaN38Q3dO
        Gm+R6e1uPk9lJ4XOr0mOal562v+KndyCBXkZuawMgZ1fdpZQ
X-Google-Smtp-Source: ABdhPJwWlG4sbAoREBXQf9F9/dCtvTwajJXGqo5aO+aMprHZaFCbq/ikMbuPBBCk9mxPfSNhZNclzSCRxhsfveOKGgaEQPUJOpu1
MIME-Version: 1.0
X-Received: by 2002:a02:29c1:: with SMTP id p184mr15858242jap.301.1642666270090;
 Thu, 20 Jan 2022 00:11:10 -0800 (PST)
Date:   Thu, 20 Jan 2022 00:11:10 -0800
In-Reply-To: <20220120080020.2619-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000836a4805d5ff0b2b@google.com>
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
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=94e8da4df9ab6319
dashboard link: https://syzkaller.appspot.com/bug?extid=76629376e06e2c2ad626
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=101ba7efb00000

Note: testing is done by a robot and is best-effort only.
