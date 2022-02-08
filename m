Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689364AD9AA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377376AbiBHNW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240887AbiBHMa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 07:30:57 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DF2C03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 04:30:56 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id j14so28396056ejy.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 04:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=pyOlF6UmaaIPMj49n9I5e2YrqASqQxHSgQMcnkz9Ds4=;
        b=IBUDla5NdRwnTD1y7ixnE9OWuHg3ICqgKArWpjAignm88vnnqODVf8RIL+vDRRZdK8
         kyb0bO1C2pvtzynJNC7afc+k9jgk5mbQgtQ/jfgVfPPR0GCmZNHFhwKET7oodghB1RU7
         jiKwOHaoxH1VvD6ERbTGE6q0K3ctkR/gh4iwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=pyOlF6UmaaIPMj49n9I5e2YrqASqQxHSgQMcnkz9Ds4=;
        b=7X/38X+Oy0GcYupliGYqr0as4VRwhrbzyZtVYOvacboQJndKq4sLlDVEjIXJ7u5kIN
         jAlwytUYsY9NQh6Wk4YuMm3BDaQ1DQRfzV5bEsWilafP2PvKKnDCnasarD3vndK58FOp
         kJNQ9HVaHFrIA05irfuUrji5mn/7L1BQfJSuf6TsJL6VyHW5zxcFA37SYaOg1kWjpsO0
         azO2QN3kX0N55/SUTP4JokKmrIf+92KFk+ESxV2mx3wG09fDAjJDBnHcz28LOp3RPi6U
         1JJe7qIo8EL4NUWVGb6C9jW8lGtXifYnZAfmNCh2o28nFDSoXdv9v6KtKbLklW18/Kkj
         osjQ==
X-Gm-Message-State: AOAM533Ccsy3ZOAmUh3/PnULdzQMMl1hLExNDEMFh+fnj9sFrDPxCAj0
        P43dxbfBmMJkGqDWqjdLgmJywA==
X-Google-Smtp-Source: ABdhPJwXYw4q1btwyGQoyQq1y6twywUuMFtmW+XmsRH9NZB9ermSewsnO3Ku4Glqh91lKOk5bYCRbQ==
X-Received: by 2002:a17:907:a41f:: with SMTP id sg31mr3426142ejc.645.1644323454658;
        Tue, 08 Feb 2022 04:30:54 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id m17sm5598646edr.62.2022.02.08.04.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 04:30:54 -0800 (PST)
Date:   Tue, 8 Feb 2022 13:30:52 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     syzbot <syzbot+60df062e1c41940cae0f@syzkaller.appspotmail.com>
Cc:     dri-devel@lists.freedesktop.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in component_del
Message-ID: <YgJifE4GcWXS9p2H@phenom.ffwll.local>
Mail-Followup-To: syzbot <syzbot+60df062e1c41940cae0f@syzkaller.appspotmail.com>,
        dri-devel@lists.freedesktop.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
References: <00000000000016f4ae05d5cec832@google.com>
 <0000000000001e4c2e05d77cfcbb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000001e4c2e05d77cfcbb@google.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 11:51:29PM -0800, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    555f3d7be91a Merge tag '5.17-rc3-ksmbd-server-fixes' of gi..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=130a0c2c700000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=266de9da75c71a45
> dashboard link: https://syzkaller.appspot.com/bug?extid=60df062e1c41940cae0f
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15880d84700000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14de0c77b00000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+60df062e1c41940cae0f@syzkaller.appspotmail.com

From a quick grep usb seems to have indeed gained some component code, and
I'm not aware of any drm usb drivers using component. So I think this is
an usb issue, not a drm one.

Greg, thoughts?
-Daniel

> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 3598 at drivers/base/component.c:767 component_del+0x40c/0x540 drivers/base/component.c:765
> Modules linked in:
> CPU: 0 PID: 3598 Comm: syz-executor255 Not tainted 5.17.0-rc3-syzkaller-00020-g555f3d7be91a #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:component_del+0x40c/0x540 drivers/base/component.c:767
> Code: 00 48 39 6b 20 75 82 e8 72 b1 07 fd 48 c7 43 20 00 00 00 00 e9 70 ff ff ff e8 60 b1 07 fd 48 c7 c7 20 aa 67 8c e8 84 d4 db 04 <0f> 0b 31 ed e8 4b b1 07 fd 48 89 ef 5b 5d 41 5c 41 5d 41 5e 41 5f
> RSP: 0018:ffffc90001aafa68 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: dffffc0000000000 RCX: ffff8880745c8000
> RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffc90001aaf9b0
> RBP: ffffffff8c67a9e0 R08: 0000000000000001 R09: ffffc90001aaf9b7
> R10: fffff52000355f36 R11: 0000000000000001 R12: ffff88801dce5008
> R13: ffffffff8a4c0dc0 R14: ffff88801dce5008 R15: ffff88801dce5000
> FS:  0000555556461300(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fb3739a5130 CR3: 000000001996f000 CR4: 0000000000350ef0
> Call Trace:
>  <TASK>
>  usb_hub_remove_port_device+0x272/0x370 drivers/usb/core/port.c:653
>  hub_disconnect+0x171/0x510 drivers/usb/core/hub.c:1737
>  usb_unbind_interface+0x1d8/0x8e0 drivers/usb/core/driver.c:458
>  __device_release_driver+0x5d7/0x700 drivers/base/dd.c:1206
>  device_release_driver_internal drivers/base/dd.c:1237 [inline]
>  device_release_driver+0x26/0x40 drivers/base/dd.c:1260
>  usb_driver_release_interface+0x102/0x180 drivers/usb/core/driver.c:627
>  proc_ioctl.part.0+0x4d6/0x560 drivers/usb/core/devio.c:2332
>  proc_ioctl drivers/usb/core/devio.c:170 [inline]
>  proc_ioctl_default drivers/usb/core/devio.c:2375 [inline]
>  usbdev_do_ioctl drivers/usb/core/devio.c:2731 [inline]
>  usbdev_ioctl+0x2b29/0x36c0 drivers/usb/core/devio.c:2791
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:874 [inline]
>  __se_sys_ioctl fs/ioctl.c:860 [inline]
>  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7fb3739346f9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fff3db9d808 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007fb373978194 RCX: 00007fb3739346f9
> RDX: 0000000020000380 RSI: 00000000c0105512 RDI: 0000000000000003
> RBP: 0000000000000000 R08: 00007fff3db9d280 R09: 0000000000000001
> R10: 000000000000ffff R11: 0000000000000246 R12: 00007fff3db9d81c
> R13: 431bde82d7b634db R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
