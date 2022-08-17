Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B590596BDC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 11:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbiHQJL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 05:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbiHQJLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 05:11:54 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BA648EAD
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 02:11:52 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id x9so12952375ljj.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 02:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=8cEHKvq4W/wjYWThAFuTlzAAkuKprBvcscd59oqr3fE=;
        b=5WcLEFDrT6Qwc1bh5Zk33hKzLH+PKb0/JTDE/t86lzoYmEAku5M/JiSmXR3ByxVSeN
         6lsmMtKQE/keV4lj6wUY3MVOpO9NWFuQoUmOsRn6heImFXJeA4JrbODI5hd9eefaT7kf
         FM426Tc6tByGvhnB04EwZZrF/azG6Wc2JMDcfZHoWrFBIsPZ2LhTBYTkr8aZDivygJPF
         kMQDgt/+6F5MDh/UeydxjjXqlDKfjZrQ9qXZvIMyk1vtI6f6u2RgpKEesaUgqL9Ixu8R
         9Wg/nmfV7G/LaNDbNP6do5pdvjVxwWJd063A51RPar/1GWFPdKYhkCjjgoDAO6jhLoTM
         ZDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=8cEHKvq4W/wjYWThAFuTlzAAkuKprBvcscd59oqr3fE=;
        b=xUhtSn/PUqLi6N1JMpayGuG60QWO94ZUyzgbRQ0WnUcoIC90XrPzUf9uaKdFN+i1Av
         nNbIRKQB96grkPPf/p1Q/cyjYTyE8RHUg2rSizHKlPytcwfS4R6KHUmCV25eZxT5iZb9
         ARm1l+iCTAjb8q5PJR+XFjXExAVHQnDYSN4FwJrOt47QYG3r7F3302Nna95xGRvD3AS4
         NX3hJMFUThHe0gBwlc+Kuzp6Fv5VKJWt1hrGyxq7CCQudpfMGFzmZavwy26hrRiCey6Z
         kYZ4sIKHKqR7SauA+qK5LMZ3Z7tbCiwb3FZ0PBygsbtDAF559gEkLWVknhi1KJi7+WDj
         DcYA==
X-Gm-Message-State: ACgBeo0Yd2LSPYr2c3MyiiYA/rj0P5SIWutkQVPfQsAUaPEBtRN+MU+S
        ZwC38KQsa/rHnf7oBIoiRukFxtP7bQu6cPmKDgXDJt2Vw54NDDe8
X-Google-Smtp-Source: AA6agR4A1i+oXgOJ7ySLT2F6wsF+A40u59M0kjmDn3Wq1eMeQxGeFgegnkjnvwQ0KOe8GbkYZ98S5VI58LPpQirNbIY=
X-Received: by 2002:a05:651c:12cb:b0:25e:44ef:8bfa with SMTP id
 11-20020a05651c12cb00b0025e44ef8bfamr7867723lje.324.1660727511269; Wed, 17
 Aug 2022 02:11:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220817034559.44936-1-zhangtianci.1997@bytedance.com> <CAOQ4uxgrkPYBkZG--70s4PnUiT0ht=GdWrrm+aY4ZHoZjZrWAw@mail.gmail.com>
In-Reply-To: <CAOQ4uxgrkPYBkZG--70s4PnUiT0ht=GdWrrm+aY4ZHoZjZrWAw@mail.gmail.com>
From:   =?UTF-8?B?5aSp6LWQ5byg?= <zhangtianci.1997@bytedance.com>
Date:   Wed, 17 Aug 2022 17:11:40 +0800
Message-ID: <CAP4dvsfqxEGJtQgSdfN+nxbyMAdm2rj_tmUeqXc8syPyK98MHA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] ovl: Do not override fsuid and fsgid in ovl_link()
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 3:36 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Wed, Aug 17, 2022 at 6:49 AM Zhang Tianci
> <zhangtianci.1997@bytedance.com> wrote:
> >
> > ovl_link() did not create a new inode after commit
> > 51f7e52dc943 ("ovl: share inode for hard link"), so
> > in ovl_create_or_link() we should not override cred's
> > fsuid and fsgid when called by ovl_link().
> >
> > Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
> > Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
> > ---
> >  fs/overlayfs/dir.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > index 6b03457f72bb..568d338032db 100644
> > --- a/fs/overlayfs/dir.c
> > +++ b/fs/overlayfs/dir.c
> > @@ -595,9 +595,9 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
> >         err = -ENOMEM;
> >         override_cred = prepare_creds();
> >         if (override_cred) {
> > -               override_cred->fsuid = inode->i_uid;
> > -               override_cred->fsgid = inode->i_gid;
> >                 if (!attr->hardlink) {
> > +                       override_cred->fsuid = inode->i_uid;
> > +                       override_cred->fsgid = inode->i_gid;
> >                         err = security_dentry_create_files_as(dentry,
> >                                         attr->mode, &dentry->d_name, old_cred,
> >                                         override_cred);
> > --
>
> This change looks incorrect.
> Unless I am missing something, fsuid/fsgid still need to
> be overridden for calling link() on underlying fs.
> What made you do this change?
>
> Thanks,
> Amir.

Hi Amir,

I ran into an error when I tested overlay on fuse:
  $ mkdir /lower /fuse /merge
  $ mount -t fuse /fuse
  $ mkdir /fuse/upper /fuse/work
  $ mount -t overlay /merge -o lowerdir=/lower,upperdir=/fuse/upper,workdir=work
  $ touch /merge/file
  $ chown bin.bin /merge/file // the file's caller becomes "bin"
  $ ln /merge/file /merge/lnkfile

Then I got an error(EACCES) because fuse daemon checks the link()'s
caller is "bin", it denied this request.
I browsed the changing history of ovl_link(). There are two key commits:
The first is commit bb0d2b8ad296 ("ovl: fix sgid on directory") which
overrides the cred's fsuid/fsgid using the new inode. The new inode's
owner is initialized by inode_init_owner(), and inode->fsuid is
assigned to the current user. So the override fsuid becomes the
current user. We know link() is actually modifying the directory, so
the caller must have the MAY_WRITE permission on the directory. The
current caller may should have this permission. I think this is
acceptable to use the caller's fsuid(But I still feel a little
conflicted with the overlay's design).
The second is commit 51f7e52dc943 ("ovl: share inode for hard link")
which removed the inode creation in ovl_link(). This commit move
inode_init_owner() into ovl_create_object(), so the ovl_link() just
give the old inode to ovl_create_or_link(). Then the override fsuid
becomes the old inode's fsuid, neither the caller nor the overlay's
creator! So I think this is incorrect.
I think the link() should be like unlink(), overlay fs should just use
the creator cred to do underlying fs's operations.

Thanks,
Tianci.
