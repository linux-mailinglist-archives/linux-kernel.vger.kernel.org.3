Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4C3486D3E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 23:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245125AbiAFWdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 17:33:10 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:51875 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245072AbiAFWdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 17:33:09 -0500
Received: by mail-io1-f71.google.com with SMTP id z73-20020a6bc94c000000b00601d9159578so2784857iof.18
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 14:33:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Gt9eD7PwKSOXgXvc7qjCtq/BCtwFiuR9TKZmMih6Bic=;
        b=pJE/FizKP79UjWMznyNuQTrRkKJpEHyf2j00Hk9noTaX88BZ73l4Qxwfo272EXQvAK
         ILo8zQI3T9etL0kc47QceTaVzkI+XyzhdsumHofRRCeIeGwEExsftIODis5iR3qX60Ll
         cHk9U5MDqXV7M6P/vOnMZ0RyChU4jHDn3EUQOZPI/+USZtVl+CAKxpd+EgMfAezTj8SP
         go07OJptCNBQPp1gMouOj2eHpZlosYHd5Svc4rDWGXYG9giGrxNwUqnPcF2dNQVJoXgV
         4WObvnze0M+Yu0dAahK9wWq2DkwpqkIHM4eOkdk+jnC0/9/IE0anh1W+Ep/GIBSuG3Ec
         rOXg==
X-Gm-Message-State: AOAM533pgiCyMqI0gBlpjE5VZuTICHMkFlTXh7i40LQOky7EZuyZowTM
        LWkRvz3VxF7dvq0BIpaoc6NzPFuBAwyv53sI+jUWWyik3jBi
X-Google-Smtp-Source: ABdhPJw5fVYRytZ2MPpMi+5KevebaJQc2UNL6L9g9FQPtrrJ2bgITaL8izgm6Q3TrJw/KZhiL9SMs0yx//vpyG9q6RtHfkDlEbFW
MIME-Version: 1.0
X-Received: by 2002:a02:c6ab:: with SMTP id o11mr28395658jan.303.1641508389398;
 Thu, 06 Jan 2022 14:33:09 -0800 (PST)
Date:   Thu, 06 Jan 2022 14:33:09 -0800
In-Reply-To: <60e9caf1-7b9f-c5a4-a3e8-ff9135e16197@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000722d9705d4f17431@google.com>
Subject: Re: [syzbot] KMSAN: kernel-usb-infoleak in usbnet_write_cmd (3)
From:   syzbot <syzbot+003c0a286b9af5412510@syzkaller.appspotmail.com>
To:     glider@google.com, gregkh@linuxfoundation.org, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        paskripkin@gmail.com, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+003c0a286b9af5412510@syzkaller.appspotmail.com

Tested on:

commit:         81c325bb kmsan: hooks: do not check memory in kmsan_in..
git tree:       https://github.com/google/kmsan.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=2d8b9a11641dc9aa
dashboard link: https://syzkaller.appspot.com/bug?extid=003c0a286b9af5412510
compiler:       clang version 14.0.0 (/usr/local/google/src/llvm-git-monorepo 2b554920f11c8b763cd9ed9003f4e19b919b8e1f), GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11dd4b71b00000

Note: testing is done by a robot and is best-effort only.
