Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23C8346EE66
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241720AbhLIRAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:00:03 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:36608 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241716AbhLIQ7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:59:46 -0500
Received: by mail-il1-f199.google.com with SMTP id y15-20020a056e02174f00b002a4222f24a5so7731524ill.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 08:56:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=StI9htrsT9nAfOWxOwIUSz384tvOEJibgAyyKfuu94M=;
        b=6FzFouD11ziiDUdNFku3lg5Q97z8pZcuuGb8l+fR7Ik5uz3Lzz82SJ+ScWgy1kPXTf
         0P5iSajdOJ9RjxD6PfTXmpCzj+aFKdg3CpW9iaWQ4u8l0QNdAzXv8tth4iGzpBzX7svC
         dTkQWYWa2kzQzlN8MlfY0m8rwCkrzaGaeo2otfwpLzQMO+6Ust7FONgx55GhZ+oy0ZKn
         ZOWB/GBbzkG4z/ZhMJim4y95cROoh681R6n4grIayV9tw6couYWZ5L9P5fAX8V7DslrF
         hnag0nLM42WAO0T8GuWUt7VKCv2cLAgjLMjIaEUkYJCILNnmI09NUY+bxYz2/0dEwCp6
         LvWQ==
X-Gm-Message-State: AOAM533ebc/C9UxJw2/gAHTeWiQ+CqH+gP8D+7JvLo+Z8LkZv0K+RJaj
        O6O89h+xaLbFdJIjfvtls/ebY9ECdbT5SfbskRhvg6ICo+F4
X-Google-Smtp-Source: ABdhPJylw/81I/nLoI8OtCd07PKPJbCgDmiv6LeRlCXOeEfrSkyRuz/Sv5bVLCazKWZhGEFvDxMAvkeWWZnUE5ePteGtDwJXoKnS
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160d:: with SMTP id t13mr14013859ilu.306.1639068972803;
 Thu, 09 Dec 2021 08:56:12 -0800 (PST)
Date:   Thu, 09 Dec 2021 08:56:12 -0800
In-Reply-To: <053430b4-8b7a-249e-19a9-17752b47504a@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e2eddb05d2b97be5@google.com>
Subject: Re: [syzbot] INFO: task hung in io_uring_cancel_generic (2)
From:   syzbot <syzbot+21e6887c0be14181206d@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+21e6887c0be14181206d@syzkaller.appspotmail.com

Tested on:

commit:         59614c5c io_uring: ensure task_work gets run as part o..
git tree:       git://git.kernel.dk/linux-block io_uring-5.16
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7264d1cb8ba2795
dashboard link: https://syzkaller.appspot.com/bug?extid=21e6887c0be14181206d
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: testing is done by a robot and is best-effort only.
