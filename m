Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC00F4A93CC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 07:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245752AbiBDGAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 01:00:18 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:40646 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbiBDGAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 01:00:17 -0500
Received: by mail-io1-f70.google.com with SMTP id y22-20020a5ec816000000b006115762d153so3519543iol.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 22:00:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=/NQjNIC6JOCGaLd70PYaq3sVxdkml93lT1M2KaXNDMo=;
        b=ojtGNZyCl7WmO64zGgQ+/mx3j1MVQ21KmbE3IvogQKzVDgOiWY8rNsjX56rJAdMKr/
         Y0vVY8Wkmu2T34S4BTsix9kQpMtcMjRAuf6bvynavuhG9z2ADGF5vcW4Bu73ykZG6/m/
         XamTsrHSrZvLHO8VA3Gq4sdPGqNE1JrZZdyQcbPqUCVbISOPMEuq5guAgG3PatSdlSsJ
         c5OvxspagqNYteRFH19XjysNVjq5EESlLnkJZ7w7gY3hgwgtrC4IcRxuzIG0pWl9W6WM
         RQ1zjKCuEg+9GjHzhwpfzz9L+MXS3BomJFWuTzeHjO5pS/RGGmW1yGrQDpdn25GlqJhs
         Kurg==
X-Gm-Message-State: AOAM530sewgTq5v8o3PDKC07SEDBj4zMNOFvw4ZaXXN6Cbk9pixbAyG2
        YbLs4n2++5dVBNfVxHfb1bakIUNUgQdoEVpqqtJHPM1G5CN5
X-Google-Smtp-Source: ABdhPJwuhPxceWwnQx+K5tyCGqyaY8DEgSgxyPJ8Iqq3pe3ctvVRaogZ5+BjXZmHxBWltzizSoOI/W/WwdnrMDxS3utghryN8I4K
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b85:: with SMTP id h5mr743910ili.16.1643954417008;
 Thu, 03 Feb 2022 22:00:17 -0800 (PST)
Date:   Thu, 03 Feb 2022 22:00:17 -0800
In-Reply-To: <20220204054708.2335-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000d8a7305d72af7f8@google.com>
Subject: Re: [syzbot] general protection fault in hidraw_release
From:   syzbot <syzbot+953a33deaf38c66a915e@syzkaller.appspotmail.com>
To:     benjamin.tissoires@redhat.com, dvyukov@google.com,
        hdanton@sina.com, jikos@kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+953a33deaf38c66a915e@syzkaller.appspotmail.com

Tested on:

commit:         9f7fb8de Merge tag 'spi-fix-v5.17-rc2' of git://git.ke..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
kernel config:  https://syzkaller.appspot.com/x/.config?x=b4a89edfcc8f7c74
dashboard link: https://syzkaller.appspot.com/bug?extid=953a33deaf38c66a915e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1665d17c700000

Note: testing is done by a robot and is best-effort only.
