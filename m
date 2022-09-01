Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047D95A8BBD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 05:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbiIADDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 23:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbiIADDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 23:03:16 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3553C7756B
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 20:03:13 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id y3so32017264ejc.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 20:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=wmnsiEoq8lKi6fXSU3uMcdYEtnhfEIVER7hrMYEUhjA=;
        b=cAlkmLf3rf017PazPIONyWw1H6H4bpoEnjh/W/JYmjR9XWjIFxSt5iLolwfJlplVWj
         axv4p+0PWnc4n5TPGWKbHaYJ7dlEWionIkv0cJRbCVDOopmxtPIJr1YJ1GySHUeqJ1yi
         4AWHffmanLgGnzKeVCn8Xm0T3WJU/DEA/r2jrZE8HbFxcRCkfBhBn7x9IDaNiBBst+OK
         pp3PZor/JXBHuaoVEqFMTajB3UE7dB4dBpN3yjn/h27t8siTSzTXb5Pptk0iHmFO034h
         8vk6J0rCMhbY9+5J6hoSDz2noKgZTQ8L7kleS9gULgIT2vz4WTRbUeHZahBA25UjkPyy
         mFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=wmnsiEoq8lKi6fXSU3uMcdYEtnhfEIVER7hrMYEUhjA=;
        b=WVp7UCDFlOsyZkzHpo4I8yo698M3FxTcCV9mpwAEAd6YDfSUSOFIfUxmSMLLJhEGWP
         Wdg8Q4NQ+gkJQQenEr00UIV+yqkdq55ML5mgDFlJ+LohHsjOrHHiCKarbnDOpsjpAfFe
         YwHhwHFKGcRQvjqLB7PgghrAFcX0gyWM9s0REck+Eq67zhWrLYbTc1xvAwfLiv7D+58J
         7UDlWuS4KqVrNgI6OCnTKXEhyPK67lvRKLbjhd4wlE7h0PBvAC7rzmXpOqvKcuAmvAr0
         AZwqRH/DxxZEJXNVTD/Y7C9jXYuBFY2NlT94xW5y+2r1bB5SP3XzX4pb4qMHgEVCkeW7
         LjRg==
X-Gm-Message-State: ACgBeo1sZSwFTIzK7g4zX9hXgBBDgVehUx/EhvC8Nwgc9i0KPXuXg48p
        vGBS7oAabRaIcaN7WMw9hTCHHB5xaQ8aVKUSezTIxY4ImFtxyw==
X-Google-Smtp-Source: AA6agR6tqTwofI4asy0b6mkioNbCFeahkMrjo7dyBsT/ANsdpO9IXpJmsyYe9QKPg+uMdUfZU449kxYk5zlF/zmAX20=
X-Received: by 2002:a17:907:a057:b0:730:a2d8:d5ac with SMTP id
 gz23-20020a170907a05700b00730a2d8d5acmr21656474ejc.764.1662001391749; Wed, 31
 Aug 2022 20:03:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220825130552.29587-1-zhangtianci.1997@bytedance.com>
 <CAJfpegsAOJmT=9FdanDVA_s5xF3iy9ccXxmin4cKW9-XxKG3xQ@mail.gmail.com>
 <20220831134327.dria7um4bhpk62mn@wittgenstein> <CAJfpegvLHV34FFU+59eH0WqPKAXy8340yNA6rxWXSmKeBbSnOA@mail.gmail.com>
 <20220831152904.efqd56kayvrxsdj6@wittgenstein>
In-Reply-To: <20220831152904.efqd56kayvrxsdj6@wittgenstein>
From:   =?UTF-8?B?5aSp6LWQ5byg?= <zhangtianci.1997@bytedance.com>
Date:   Thu, 1 Sep 2022 11:02:59 +0800
Message-ID: <CAP4dvscRZZgryM=SZR94FsjQJs_8=kqt0f-TRGzuY2WUXZcArw@mail.gmail.com>
Subject: Re: [PATCH v2] ovl: Use current fsuid and fsgid in ovl_link()
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <brauner@kernel.org> =E4=BA=8E2022=E5=B9=B48=E6=9C=8831=
=E6=97=A5=E5=91=A8=E4=B8=89 23:29=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Aug 31, 2022 at 03:53:58PM +0200, Miklos Szeredi wrote:
> > On Wed, 31 Aug 2022 at 15:43, Christian Brauner <brauner@kernel.org> wr=
ote:
> > >
> > > On Wed, Aug 31, 2022 at 03:00:18PM +0200, Miklos Szeredi wrote:
> > > > On Thu, 25 Aug 2022 at 15:08, Zhang Tianci
> > > > <zhangtianci.1997@bytedance.com> wrote:
> > > > >
> > > > > There is a wrong case of link() on overlay:
> > > > >   $ mkdir /lower /fuse /merge
> > > > >   $ mount -t fuse /fuse
> > > > >   $ mkdir /fuse/upper /fuse/work
> > > > >   $ mount -t overlay /merge -o lowerdir=3D/lower,upperdir=3D/fuse=
/upper,\
> > > > >     workdir=3Dwork
> > > > >   $ touch /merge/file
> > > > >   $ chown bin.bin /merge/file // the file's caller becomes "bin"
> > > > >   $ ln /merge/file /merge/lnkfile
> > > > >
> > > > > Then we will get an error(EACCES) because fuse daemon checks the =
link()'s
> > > > > caller is "bin", it denied this request.
> > > > >
> > > > > In the changing history of ovl_link(), there are two key commits:
> > > > >
> > > > > The first is commit bb0d2b8ad296 ("ovl: fix sgid on directory") w=
hich
> > > > > overrides the cred's fsuid/fsgid using the new inode. The new ino=
de's
> > > > > owner is initialized by inode_init_owner(), and inode->fsuid is
> > > > > assigned to the current user. So the override fsuid becomes the
> > > > > current user. We know link() is actually modifying the directory,=
 so
> > > > > the caller must have the MAY_WRITE permission on the directory. T=
he
> > > > > current caller may should have this permission. This is acceptabl=
e
> > > > > to use the caller's fsuid.
> > > > >
> > > > > The second is commit 51f7e52dc943 ("ovl: share inode for hard lin=
k")
> > > > > which removed the inode creation in ovl_link(). This commit move
> > > > > inode_init_owner() into ovl_create_object(), so the ovl_link() ju=
st
> > > > > give the old inode to ovl_create_or_link(). Then the override fsu=
id
> > > > > becomes the old inode's fsuid, neither the caller nor the overlay=
's
> > > > > creator! So this is incorrect.
> > > > >
> > > > > Fix this bug by using current fsuid/fsgid to do underlying fs's l=
ink().
> > > > >
> > > > > Link: https://lore.kernel.org/all/20220817102951.xnvesg3a7rbv576x=
@wittgenstein/T
> > > > >
> > > > > Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
> > > > > Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
> > > > > Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> > > > > ---
> > > > >  fs/overlayfs/dir.c       | 16 +++++++++++-----
> > > > >  fs/overlayfs/overlayfs.h |  2 ++
> > > > >  2 files changed, 13 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > > > > index 6b03457f72bb..dd84e6fc5f6e 100644
> > > > > --- a/fs/overlayfs/dir.c
> > > > > +++ b/fs/overlayfs/dir.c
> > > > > @@ -595,8 +595,8 @@ static int ovl_create_or_link(struct dentry *=
dentry, struct inode *inode,
> > > > >         err =3D -ENOMEM;
> > > > >         override_cred =3D prepare_creds();
> > > > >         if (override_cred) {
> > > > > -               override_cred->fsuid =3D inode->i_uid;
> > > > > -               override_cred->fsgid =3D inode->i_gid;
> > > > > +               override_cred->fsuid =3D attr->fsuid;
> > > > > +               override_cred->fsgid =3D attr->fsgid;
> > > > >                 if (!attr->hardlink) {
> > > > >                         err =3D security_dentry_create_files_as(d=
entry,
> > > > >                                         attr->mode, &dentry->d_na=
me, old_cred,
> > > > > @@ -646,6 +646,8 @@ static int ovl_create_object(struct dentry *d=
entry, int mode, dev_t rdev,
> > > > >         inode_init_owner(&init_user_ns, inode, dentry->d_parent->=
d_inode, mode);
> > > > >         attr.mode =3D inode->i_mode;
> > > > >
> > > > > +       attr.fsuid =3D inode->i_uid;
> > > > > +       attr.fsgid =3D inode->i_gid;
> > > > >         err =3D ovl_create_or_link(dentry, inode, &attr, false);
> > > > >         /* Did we end up using the preallocated inode? */
> > > > >         if (inode !=3D d_inode(dentry))
> > > > > @@ -702,6 +704,7 @@ static int ovl_link(struct dentry *old, struc=
t inode *newdir,
> > > > >  {
> > > > >         int err;
> > > > >         struct inode *inode;
> > > > > +       struct ovl_cattr attr;
> > > > >
> > > > >         err =3D ovl_want_write(old);
> > > > >         if (err)
> > > > > @@ -728,9 +731,12 @@ static int ovl_link(struct dentry *old, stru=
ct inode *newdir,
> > > > >         inode =3D d_inode(old);
> > > > >         ihold(inode);
> > > > >
> > > > > -       err =3D ovl_create_or_link(new, inode,
> > > > > -                       &(struct ovl_cattr) {.hardlink =3D ovl_de=
ntry_upper(old)},
> > > > > -                       ovl_type_origin(old));
> > > > > +       attr =3D (struct ovl_cattr) {
> > > > > +               .hardlink =3D ovl_dentry_upper(old),
> > > > > +               .fsuid =3D current_fsuid(),
> > > > > +               .fsgid =3D current_fsgid(),
> > > > > +       };
> > > >
> > > > Why do we need to override fsuid/fsgid for the hardlink case?
> > > >
> > > > Wouldn't it be simpler to just use the mounter's creds unmodified i=
n
> > > > this case?   The inode is not created in this case, so overriding w=
ith
> > > > current uid/gid is not necessary, I think.
> > > >
> > > > Another way to look at it is: rename(A, B) is equivalent to an
> > > > imaginary atomic [link(A, B) + unlink(A)] pair.  But we don't overr=
ide
> > > > uid/gid for rename() or unlink() so why should we for link().
> > >
> > > So my assumption has been that we want to override for any creation
> > > request and so for the sake of consistency I would've expected to als=
o
> > > use that for ->link().
> >
> > But link() is *not* a creation op.  It's a namespace manipulation op.
>
> Yeah, I know what you mean but it's borderline in so far as the
> underlying fs might still perform permission checking based on the
> caller's fs{g,u}id which together with what I'm saying below in a bit
> was what made me go oh well, we should use the caller's fs{g,u}id then
> for consistency.
>
> >
> > > Plus, this is also what has been done before the
> > > commit  51f7e52dc943 ("ovl: share inode for hard link") iiuc.
> >
> > It wouldn't have mattered back then either, since the upper inode was
> > linked and not copied.
>
> What I meant was back then even for link the fs{g,u}id was based on a
> newly allocated inode->i_{g,u}id that was initialized through
> inode_init_owner() with the caller's fs{g,u}id:
>
>         inode =3D ovl_new_inode(dentry->d_sb, mode);
>         if (!inode)
>                 goto out;
>
>         err =3D ovl_copy_up(dentry->d_parent);
>         if (err)
>                 goto out_iput;
>
>         inode_init_owner(inode, dentry->d_parent->d_inode, mode);
>         stat.mode =3D inode->i_mode;
>
>         old_cred =3D ovl_override_creds(dentry->d_sb);
>         err =3D -ENOMEM;
>         override_cred =3D prepare_creds();
>         if (override_cred) {
>                 override_cred->fsuid =3D inode->i_uid;
>                 override_cred->fsgid =3D inode->i_gid;
>
> and it changed after that commit to be based on old inode. So emulating
> the old behavior seemed the better approach.
>
> >
> > > Fwiw, I would've opted for consistency and even use the caller's
> > > fs{g,u}id during ->rename() and ->unlink().
> > >
> > > Right now the caller's fs{g,u}id - indirectly through inode_init_owne=
r()
> > > - is used to ensure that the ownership of newly created files in the
> > > upper layer are based on the caller's not on the mounter's fs{g,u}id
> > > afaict. If we continue to only override for those cases it would real=
ly
> > > help that we document this in a good comment in ovl_create_or_link().
> >
> > Yep.
>
> Sounds good.

It looks like you've reached an agreement.

So I will send the v3 patch using the mounter's fs{g,u}id with the
proper comment in ovl_create_or_link().

Thanks,
Tianci
