Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1133F480708
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 08:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235350AbhL1HrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 02:47:18 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:45696 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235334AbhL1HrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 02:47:17 -0500
Received: by mail-il1-f200.google.com with SMTP id k14-20020a056e021a8e00b002b4b2388c48so10674875ilv.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 23:47:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=Uw0HySQnOliUjUKI3r/PFZeo3az9rpmElYd8X6AhRRc=;
        b=iGgzwJcD5OoE+fp5JAnptDKAMdM3Ch8ZF6K9YSVOsa5vPQI2FRPfEq4jo9lpbaLiey
         EI+15a9pfdZMr/NVCZwpseekUzmD63J2fuKM1Y8fU1eH4mId4Be6/WNslyK49bVFA48m
         yhbRU0UePOn6Vk//8e2InTGaIs2VIMNEcuri61sX6q9qbzqxDfJlnzA4vWbYWKl7I8Ob
         S+VcF/+7+7Zw+K1p6+u076ShFh8zIMHaoY/wq62tL3x8qCFcBgxtFnJXUwdB1kphlfOC
         yAgp+QzClysUpiAtZj5YxQMuLuJjPjhpe61Q4hMjJnJkgTvKR+BdSASfvJBF8TmJdzqE
         tptg==
X-Gm-Message-State: AOAM532bTZCBFHzGhlo2/V+IxX3g11ikbP+MhgvB6pdMCEB41fe5LaJ/
        Nq4Ch86fX7g6Q+8cHxyq9hGqRv0BnhVRpkMYPfNluW0Pk0U4
X-Google-Smtp-Source: ABdhPJzzBDBBy/cd8LQS9PQTs66isAN0tM25racBxresrnv1pJK8DlLuL0yS3O/+BJ612+mJNZ8W9lYMUF7fK4TZa/4hMmvqZTBX
MIME-Version: 1.0
X-Received: by 2002:a02:b11d:: with SMTP id r29mr9712662jah.71.1640677637200;
 Mon, 27 Dec 2021 23:47:17 -0800 (PST)
Date:   Mon, 27 Dec 2021 23:47:17 -0800
In-Reply-To: <f78b974a-e36b-6d23-6977-fdf50c05600b@wanadoo.fr>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c1a01605d4300787@google.com>
Subject: Re: KMSAN: uninit-value in alauda_check_media
From:   syzbot <syzbot+e7d46eb426883fb97efd@syzkaller.appspotmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     christophe.jaillet@wanadoo.fr, glider@google.com,
        gregkh@linuxfoundation.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com,
        usb-storage@lists.one-eyed-alien.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
>
> (2nd try - text only format - sorry for the noise)
>
>
> first try to use syzbot. I hope I do it right.
> Discussion about the syz report can be found at 
> https://lore.kernel.org/linux-kernel/0000000000007d25ff059457342d@google.com/
>
> This patch only test if alauda_get_media_status() (and its embedded 
> usb_stor_ctrl_transfer()) before using the data.
> In case of error, it returns USB_STOR_TRANSPORT_ERROR as done elsewhere.
>
> #syz test: 

KMSAN bugs can only be tested on https://github.com/google/kmsan.git tree
because KMSAN tool is not upstreamed yet.
See https://goo.gl/tpsmEJ#kmsan-bugs for details.

> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
>
> CJ
>
