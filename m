Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA4914A3E5B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 08:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240146AbiAaHuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 02:50:15 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:52087 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237965AbiAaHuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 02:50:09 -0500
Received: by mail-il1-f197.google.com with SMTP id z11-20020a056e0217cb00b002bab54d8254so8909097ilu.18
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 23:50:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=mUUhKABASSDYvCUsc04M7XBtQBbnsrCUfjP/FgUZhxY=;
        b=2CcvpozFzPyMIG4au0H/gLdHtf+fps6Q9YUM8cDpLJNVCzPWKjr8j/dCZ1ssFDBc6Q
         m5jK7gfagD6B8aU35nSztd6XoOEgkFJS1to8wfCZGC5f3CcgJGplpsQoLKRvRHc6cCSd
         MEwlmOJ2TABM97VKQTI9gSVf6m6N1mWxi3Xc0sbKQzg9zqkyoatUjAj2aYl5ZirAYVl8
         ppM599x9gG8fi0lqVnw3qAWN4Nla7sPv0bDwYwerfuvHIzuaStiQodOEORj2sjGhE6f6
         DXAuk805bSv3WSaK342uJWWyys1+voOmQaOaFyWZsf8x+TVyVp5iZl64tgaE7+58Qhph
         j5fQ==
X-Gm-Message-State: AOAM530xad/qUiE9Pbm3ug6zcK0k4I9MecY4/zcU3x8LAOM+mHvNKRPn
        1sXnXmRW9R707zg3QTjche3fYZtoBpAybcgoqUcMKHMf8Ma4
X-Google-Smtp-Source: ABdhPJymwJlS8JsUdlrCW9lOYpIn2UaIQaZW0hA0lpGtEyFOwecg2a8tRTfuM68f+RfkiiN+E5hX3nWx76izWqmI0UiryQoaAMBM
MIME-Version: 1.0
X-Received: by 2002:a6b:d90c:: with SMTP id r12mr10512979ioc.99.1643615408629;
 Sun, 30 Jan 2022 23:50:08 -0800 (PST)
Date:   Sun, 30 Jan 2022 23:50:08 -0800
In-Reply-To: <0000000000008a7a1c05c9e53c87@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000942c2205d6dc0896@google.com>
Subject: Re: [syzbot] WARNING in drm_gem_shmem_vm_open
From:   syzbot <syzbot+91525b2bd4b5dff71619@syzkaller.appspotmail.com>
To:     airlied@linux.ie, bugs-a21@moonlit-rail.com,
        christian.koenig@amd.com, daniel.vetter@ffwll.ch,
        daniel.vetter@intel.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, javierm@redhat.com,
        linaro-mm-sig-owner@lists.linaro.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, maarten.lankhorst@linux.intel.com,
        maxime@cerno.tech, melissa.srw@gmail.com, mripard@kernel.org,
        sumit.semwal@linaro.org, syzkaller-bugs@googlegroups.com,
        tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 0499f419b76f94ede08304aad5851144813ac55c
Author: Javier Martinez Canillas <javierm@redhat.com>
Date:   Mon Jan 10 09:56:25 2022 +0000

    video: vga16fb: Only probe for EGA and VGA 16 color graphic cards

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=126571e0700000
start commit:   5d6ab0bb408f Merge tag 'xtensa-20211008' of git://github.c..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=32e6048063923b7b
dashboard link: https://syzkaller.appspot.com/bug?extid=91525b2bd4b5dff71619
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11073300b00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: video: vga16fb: Only probe for EGA and VGA 16 color graphic cards

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
