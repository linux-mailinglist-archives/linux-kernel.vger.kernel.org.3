Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9B34D1280
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 09:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345056AbiCHInq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 03:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbiCHIno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 03:43:44 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B18289B3;
        Tue,  8 Mar 2022 00:42:48 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id hw13so37399669ejc.9;
        Tue, 08 Mar 2022 00:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RJwREQe2rzsaUUGeqr/8vwfZc2NQhjWpufINTjklvZI=;
        b=GxdqOvf3fZbSHFWFsSAHXHL0EDWTrSTIrguz0lZMpsIB+QjCDpe+n163V35HQjJAND
         xwioITH8uAJa2NztY6Z4KaECyn5IymbrAeNjaqFI7LLGY4rMrePpNdXC0M1pX/LjwNs0
         2KcgEuidjDEN30w8bKYiFJVecPqkfFeZhdn6OBkXDsGLv3QQo4/bG3wYgBqKob9sGDL+
         Tu3xlNA9nSraytJ9BPpLPSzh0R/rjfAeclDT998z1bmhUQU70W/uVnRZ7coBFQA88z4l
         Hy9r0oDTJ2B4AWJRlHMSNvIuxKD1f1UIZkS5QB/APH8ZNGqGIKxnJO5ff54DM7mTtvZS
         YIXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RJwREQe2rzsaUUGeqr/8vwfZc2NQhjWpufINTjklvZI=;
        b=p1Z+1i2sPf5gDTrehHbknh+GPftUXyvVN6igSL4cQLx3PYEdtT/l6XisgTk9f13czi
         d9A2cwmEukL+Q1f2O9xN1xrvKTYJWg5RaaSe1g5V/TNdf3mbZ3JEA0B/FI6pIhlOVldD
         SpdCmTob05YsYMNjCOn0A+bNHFPkXE4L+ag8b2MfWt1btf4ktxFrimBMfeOvlQavw+0f
         61srGRYlgPyhGloAgi8QL/bZHCeyivFsNA57Y6r1rAb9Mb/AHIfojKqYwaBlH4MD1eb2
         ydG9j2CnsveHeS3naenc2I0IU07Lp5/JG6AeGERjy3sD0tG08R6BZfhG9fuQJX8BSrRI
         qH4g==
X-Gm-Message-State: AOAM5303UsbVu8YmZnxXUOjAnneWwcqZTtKZ4BOx9yHU2xwufEZjL68h
        gwckxvH4Yf4kxo6b14rJB8dfpun8gYzeN3p2PDc=
X-Google-Smtp-Source: ABdhPJyb+hc3/3rA9GnhrdNsJD59ESwTazVEpooRJTAvwXoiZ9YM4kXFhet84PQA+/trFGQXDzVZJd4iPh3vl4r4vRA=
X-Received: by 2002:a17:907:9956:b0:6cf:cd25:c5a7 with SMTP id
 kl22-20020a170907995600b006cfcd25c5a7mr12074318ejc.635.1646728966454; Tue, 08
 Mar 2022 00:42:46 -0800 (PST)
MIME-Version: 1.0
References: <3192BC90-D082-472B-B310-6E09A14A77C6@hust.edu.cn>
 <CAD-N9QUqfq+0UeMjQALUmGpX5xgjS6=BXvsqcXQpJRzhB6hHLw@mail.gmail.com>
 <CAKFNMokdB+Zph-1OyC1-Xnyi93r+yKSusgaEaa=CkuUBttwRZA@mail.gmail.com>
 <CAD-N9QU8-Od3G+-=RHM5K7vR2-4Af+4t=XutJJVdmkKhH7OarA@mail.gmail.com> <CAKFNMo=E8mMuY7Et0auH02fOzGKx04k2=LOj8mZJ6a-=J+sPzQ@mail.gmail.com>
In-Reply-To: <CAKFNMo=E8mMuY7Et0auH02fOzGKx04k2=LOj8mZJ6a-=J+sPzQ@mail.gmail.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Tue, 8 Mar 2022 16:42:20 +0800
Message-ID: <CAD-N9QWt=d2Vj2bevSzOPL4AWF08_zTyq=hHOcOOROCazNY4_A@mail.gmail.com>
Subject: Re: Fw:Re: [PATCH] fs: nilfs2: fix memory leak in nilfs sysfs create
 device group
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     Pavel Skripkin <paskripkin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nanyong Sun <sunnanyong@huawei.com>,
        =?UTF-8?B?5oWV5Yas5Lqu?= <dzm91@hust.edu.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 8, 2022 at 4:31 PM Ryusuke Konishi
<konishi.ryusuke@gmail.com> wrote:
>
> Hi Dongliang,
>
> On Tue, Mar 8, 2022 at 11:22 AM Dongliang Mu <mudongliangabcd@gmail.com> wrote:
> >
> > On Sat, Jan 22, 2022 at 12:22 PM Ryusuke Konishi
> > <konishi.ryusuke@gmail.com> wrote:
> > >
> > > Hi Dongliang,
> > >
> > > On Sat, Jan 22, 2022 at 9:31 AM Dongliang Mu <mudongliangabcd@gmail.com> wrote:
> > > > > (added Nanyong Sun to CC)
> > > > > Hi Dongliang,
> > > > >
> > > > > On Thu, Jan 20, 2022 at 11:07 PM Pavel Skripkin <paskripkin@gmail.com> wrote:
> > > > >
> > > > >
> > > > > Hi Dongliang,
> > > > >
> > > > > On 1/20/22 16:44, Dongliang Mu wrote:
> > > > >
> > > > > The preivous commit 8fd0c1b0647a ("nilfs2: fix memory leak in
> > > > > nilfs_sysfs_delete_device_group") only handles the memory leak in the
> > > > > nilfs_sysfs_delete_device_group. However, the similar memory leak still
> > > > > occurs in the nilfs_sysfs_create_device_group.
> > > > >
> > > > > Fix it by adding kobject_del when
> > > > > kobject_init_and_add succeeds, but one of the following calls fails.
> > > > >
> > > > > Fixes: 8fd0c1b0647a ("nilfs2: fix memory leak in nilfs_sysfs_delete_device_group")
> > > > >
> > > > >
> > > > > Why Fixes tag points to my commit? This issue was introduced before my patch
> > > > >
> > > > >
> > > > > As Pavel pointed out, this patch is independent of his patch.
> > > > > The following one ?
> > > >
> > > > Hi Pavel,
> > > >
> > > > This is an incorrect fixes tag. I need to dig more about `git log -p
> > > > fs/nilfs2/sysfs.c`.
> > > >
> > > > I wonder if there are any automatic or semi-automatic ways to capture
> > > > this fixes tag. Or how do you guys identify the fixes tag?
> > >
> > > I guess `git blame fs/nilfs2/sysfs.c` may help you to confirm where the change
> > > came from.   It shows information of commits for every line of the input file.
> > > If you are using github, 'blame button' is available.
> > >
> > > If an issue is reproducible, we use `git bisect` to identify the patch
> > > that caused the
> > > issue, however, even then, try to understand why and how it affected
> > > by looking at
> > > source code and the commit.
> > >
> > > >
> > > > >
> > > > > 5f5dec07aca7 ("nilfs2: fix memory leak in nilfs_sysfs_create_device_group")
> > > > >
> > > > > Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> > > > > ---
> > > > > fs/nilfs2/sysfs.c | 5 ++++-
> > > > > 1 file changed, 4 insertions(+), 1 deletion(-)
> > > > >
> > > > >
> > > > > Can you describe what memory leak issue does this patch actually fix ?
> > > > >
> > > > > It looks like kobject_put() can call __kobject_del() unless circular
> > > > > references exist.
> > > > >
> > > > > kobject_put() -> kref_put() -> kobject_release() ->
> > > > > kobject_cleanup() -> __kobject_del()
> > > > >
> > > > > As explained in Documentation/core-api/kobject.rst,
> > > > >
> > > > > kobject_del() can be used to drop the reference to the parent object, if
> > > > > circular references are constructed.
> > > > >
> > > > > But, at least, the parent object is NULL in this case.
> > > > > I really want to understand what the real problem is.
> > > > >
> > > > > Thanks,
> > > > > Ryusuke Konishi
> > > >
> > > > I know where my problem is. From the disconnect function, I think the
> > > > kobject_del and kobject_put are both necessary without checking the
> > > > documentation of kobjects.
> > > >
> > > > Then I think the current error handling may miss kobject_del, and this
> > > > patch is generated.
> > > >
> > > > As a result, I think we can ignore this patch. Sorry for my false alarm.
> > >
> > > Okay, thank you for your reply.
> > > If you notice anything we missed on this difference, please let us know.
> >
> > Hi Ryusuke,
> >
> > My local syzkaller instance always complains about the following crash
> > report no matter how many times I clean up the generated crash
> > reports.
> >
> > BUG: memory leak
> > unreferenced object 0xffff88812e902be0 (size 32):
> >   comm "syz-executor.2", pid 25972, jiffies 4295025942 (age 12.490s)
> >   hex dump (first 32 bytes):
> >     6c 6f 6f 70 32 00 00 00 00 00 00 00 00 00 00 00  loop2...........
> >     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >   backtrace:
> >     [<ffffffff8148a466>] kstrdup+0x36/0x70 mm/util.c:60
> >     [<ffffffff8148a4f3>] kstrdup_const+0x53/0x80 mm/util.c:83
> >     [<ffffffff8228dcd2>] kvasprintf_const+0xc2/0x110 lib/kasprintf.c:48
> >     [<ffffffff8238ca5b>] kobject_set_name_vargs+0x3b/0xe0 lib/kobject.c:289
> >     [<ffffffff8238d3bd>] kobject_add_varg lib/kobject.c:384 [inline]
> >     [<ffffffff8238d3bd>] kobject_init_and_add+0x6d/0xc0 lib/kobject.c:473
> >     [<ffffffff81d39d3a>] nilfs_sysfs_create_device_group+0x9a/0x3d0
> > fs/nilfs2/sysfs.c:991
> >     [<ffffffff81d22ee0>] init_nilfs+0x420/0x580 fs/nilfs2/the_nilfs.c:637
> >     [<ffffffff81d108e2>] nilfs_fill_super fs/nilfs2/super.c:1046 [inline]
> >     [<ffffffff81d108e2>] nilfs_mount+0x532/0x8c0 fs/nilfs2/super.c:1316
> >     [<ffffffff815de0db>] legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
> >     [<ffffffff81579ba8>] vfs_get_tree+0x28/0x100 fs/super.c:1497
> >     [<ffffffff815bb582>] do_new_mount fs/namespace.c:3024 [inline]
> >     [<ffffffff815bb582>] path_mount+0xb92/0xfe0 fs/namespace.c:3354
> >     [<ffffffff815bba71>] do_mount+0xa1/0xc0 fs/namespace.c:3367
> >     [<ffffffff815bc084>] __do_sys_mount fs/namespace.c:3575 [inline]
> >     [<ffffffff815bc084>] __se_sys_mount fs/namespace.c:3552 [inline]
> >     [<ffffffff815bc084>] __x64_sys_mount+0xf4/0x160 fs/namespace.c:3552
> >     [<ffffffff843dd8e5>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >     [<ffffffff843dd8e5>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >     [<ffffffff84400068>] entry_SYSCALL_64_after_hwframe+0x44/0xae
> >
> > Unfortunately, there is no reproducer attached to the crash report.
> > But I still think there should be another issue in the code.
>
> The bug is happening in the call to kobject_init_and_add() in
> nilfs_sysfs_create_device_group().
> So, it looks like a separate issue from your original patch.  Is this right ?

Yes, it may not be related to my patch. But it makes me confusing about the bug.

>
> Which version of kernel does this bug occur on ?
> (Are you testing against the latest mainline kernel or some stable version?)

I always test against the latest mainline kernel.

Now I am checking the log and trying to find error injection in the
log file, as said by Pavel.

>
> Thanks,
> Ryusuke Konishi
