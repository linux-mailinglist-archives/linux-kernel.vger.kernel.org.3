Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C63C5911D6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 16:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238819AbiHLODV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 10:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238692AbiHLODS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 10:03:18 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EA3A2866
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 07:03:16 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id x21so1474074edd.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 07:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=duolXcn7gQG7XKIBN9ehMYZsLClpDQ/6ICkqLMlWWbE=;
        b=KW4gMJdGbWo9mDn74e4uTWIobzc3VGOXPPZe1gFA2raZ+rOgwf/DtjkHiiLIVJ3Qa1
         CHS42qQEYDwJYGXXQbn08sSnjm/yhJohRtE2A4luI5pufE+/p0dh+mTVCyL6U0KObtRq
         YRUhPr7ToxVNmrPzF2pJJHu/KcubDC8NdyW+2ONVFsDN1qRAtID8EEhDZUR8xKqLBIOv
         sv8IZSQ8iuwK4xsR3X6VLzxr1VzYF8jm0D3taPxzxXiGMRVRhuUy8wKV+Brb8NM7Ttfl
         qy/5y9nU2lt7AKclWTrHQCDC4Ryt2gKtreXYqaiShmzNgl4zixUcqTOxYpQhB/735FHw
         2rqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=duolXcn7gQG7XKIBN9ehMYZsLClpDQ/6ICkqLMlWWbE=;
        b=TSM1osFs8Wh5/P2PjiBXQ2KAtfVtoJj5prYDVkIAyR9fbMZ9El6UICYpUESRdugs24
         pnJgYnuNGCLFoaKgPLlShwGuvu8VaVfofbLJfNhV9T2SrhgAkQwCItMAG3A8AjKZB69F
         cAWLRvq+RpLrnsPdrxv61moPtX2xw9PtWazMTL8nkOPg5/E/NtmiVaRdVq6U3Db25VAT
         HmepPoPUSgoW6qVun3ffvpS3SwVcrmYo/AsPSHd5I7qelG6sGQs1pocCUKX3qNC3L9Fx
         uZHTzoS69nTqLjdkAu45bMoGwkZp3ZPz1duNqI4M19FH10aPliJguL93SL9zcfB33VZn
         3DTA==
X-Gm-Message-State: ACgBeo0nnATmyOp8wpw4F3J/yLZHIQZ7QvIPSuGZOdqLwJ+Nj8lSLFqv
        IbQQ+HNRb9kaO/mTbAOSt6SZ9zYjVVk2ov3aQ8f63imRoRSMjg==
X-Google-Smtp-Source: AA6agR7YZrmLDKgWIt8R7Sd8Gz6SutOzgFBqePyN5lSfc1M1R1frOWC6w7s/Zufpfx9KQFNV+QjaVyf1BQCJuSrP2jw=
X-Received: by 2002:a05:6402:268a:b0:43e:84d:c5cc with SMTP id
 w10-20020a056402268a00b0043e084dc5ccmr3782168edd.372.1660312995388; Fri, 12
 Aug 2022 07:03:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220812132124.2053673-1-dzm91@hust.edu.cn> <YvZYmprZ1NiMkynp@kroah.com>
 <CAD-N9QWU_tcnHMtP3iWcQogSWwDET4nhK5AQKDbh2KJQzwfF9A@mail.gmail.com>
In-Reply-To: <CAD-N9QWU_tcnHMtP3iWcQogSWwDET4nhK5AQKDbh2KJQzwfF9A@mail.gmail.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Fri, 12 Aug 2022 22:02:36 +0800
Message-ID: <CAD-N9QUfJTKFGvkNN9AZbwogxogOc7cWKetMV-CEvnROrLxvZA@mail.gmail.com>
Subject: Re: [PATCH] drivers: binderfs: fix memory leak in binderfs_fill_super
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Kees Cook <keescook@chromium.org>,
        syzkaller <syzkaller@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Fri, Aug 12, 2022 at 9:56 PM Dongliang Mu <mudongliangabcd@gmail.com> wrote:
>
> On Fri, Aug 12, 2022 at 9:41 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Aug 12, 2022 at 09:21:24PM +0800, Dongliang Mu wrote:
> > > From: Dongliang Mu <mudongliangabcd@gmail.com>
> > >
> > > In binderfs_fill_super, if s_root is not successfully initialized by
> > > d_make_root, the previous allocated s_sb_info will not be freed since
> > > generic_shutdown_super first checks if sb->s_root and then does
> > > put_super operation. The put_super operation calls binderfs_put_super
> > > to deallocate s_sb_info and put ipc_ns. This will lead to memory leak
> > > in binderfs_fill_super.
> > >
> > > Fix this by invoking binderfs_put_super at error sites before s_root
> > > is successfully initialized.
> > >
> > > Fixes: 095cf502b31e ("binderfs: port to new mount api")
> > > Reported-by: syzkaller <syzkaller@googlegroups.com>
> >
> > Where is the specific syzkaller link for this report?  It would be good
> > to reference it so it can be properly checked.
> >
> > Also, how did you test this change?
>
> I found this memory leak in my local syzkaller, and there is no any
> syzbot report about this crash, therefore I use such a Reported-by to
> indicate.
>
> Although my local syzkaller does generate any reproducer, this bug can
> be triggered by injecting faults at new_inode and d_make_root (i.e.,
> between s_sb_info allocation and code after d_make_root).
>
> >
> > > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > > ---
> > >  drivers/android/binderfs.c | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> > > index 588d753a7a19..20f5bc77495f 100644
> > > --- a/drivers/android/binderfs.c
> > > +++ b/drivers/android/binderfs.c
> > > @@ -710,8 +710,10 @@ static int binderfs_fill_super(struct super_block *sb, struct fs_context *fc)
> > >       info->mount_opts.stats_mode = ctx->stats_mode;
> > >
> > >       inode = new_inode(sb);
> > > -     if (!inode)
> > > +     if (!inode) {
> > > +             binderfs_put_super(sb);
> > >               return -ENOMEM;
> > > +     }
> > >
> > >       inode->i_ino = FIRST_INODE;
> > >       inode->i_fop = &simple_dir_operations;
> > > @@ -721,8 +723,10 @@ static int binderfs_fill_super(struct super_block *sb, struct fs_context *fc)
> > >       set_nlink(inode, 2);
> > >
> > >       sb->s_root = d_make_root(inode);
> > > -     if (!sb->s_root)
> > > +     if (!sb->s_root) {
> > > +             binderfs_put_super(sb);
> > >               return -ENOMEM;
> > > +     }
> >
> > How did you test this change to verify that you are not now just leaking
> > memory?  It looks to me like you just changed one problem for another
> > one :(
>
> As mentioned above, I just tested my change by injecting faults at
> new_inode and d_make_root.

The following is a reproducer I extracted from syzkaller log. The
fail_nth needs revision according to your own environment.

syz_mount_image$adfs(0x0, &(0x7f0000000180)='./file0\x00', 0x0, 0x0,
0x0, 0x0, 0x0)
syz_mount_image$afs(0x0, &(0x7f0000000040)='./file0/file0\x00', 0x0,
0x0, 0x0, 0x0, 0x0)
mount(&(0x7f0000000100)=@nbd={'/dev/nbd', 0x0},
&(0x7f0000000140)='./file0/file0\x00', &(0x7f0000000280)='binder\x00',
0x0, 0x0) (fail_nth: 40)

>
> Can you explain more about "changed one problem for another one"? I
> don't quite understand this statement.
>
> >
> > Please always be very very careful when making these types of changes,
> > and verify and test that they are correct.
> >
> > thanks,
> >
> > greg k-h
