Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5724DD4EA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 07:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbiCRGwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 02:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbiCRGwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 02:52:46 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772FA205BC3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 23:51:28 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id hu12so5899854qvb.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 23:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ah0sFHBrNeCGFAv3lamX5tp5CChwx2V2ddiNsKmIEZU=;
        b=ENEJUMO5x78+VpstvWRt5QR96WX9DzLVsA/B/NIjCyezFxTehliQwXn27dYcnDaxfY
         dNRzD0yCoxib68Tc+HXSXLdevRvUQrhwUGC+ninc1STy/q9vPfHEL0qKpgN11wifZ5So
         cdpXsRYm6sC5fweNWbF3fCduBD36es03DWGlBZmDanI7wyMmHgNoXni5KCPGCFFnZeIS
         IZk0DWhhYFJErNJa7iUiAwpjp30CdJBzHRhuzAgN2YCHqAK/ifAed1UV0btNGf5p83Ar
         6osnY9QtWd92qecolbdxQEk3w473sjcDK/OhaRzJb5muvtObG9HSSFoqOD6kmpxagy+q
         xJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ah0sFHBrNeCGFAv3lamX5tp5CChwx2V2ddiNsKmIEZU=;
        b=d35t4XBiSAwWRxHXu/FcgaY6jyx44D6Haqbl3NIjrKotnOrGjAKvzmqJbNfitLgcew
         P0Bhe5h/YI6KAHDyKIWMgMqM5FXCpn7KMBTGXNfEapevBRxAmKjncMHtmMd4HMD1emVY
         C/MBIx+TOfy3h70GBdxbFdkRgXDchfn3w+Xu4TZIWczAq+63DnhdEovl1I4FE92DHrpP
         fei5L3T0vf8jrhsHD0Iz5Er9ON1N3No8czXDucow3+SGpdwbX9LaQe+V1VWKt8g+qdsi
         jeDYAKntf4CR00l/kKlS5+5I/iEwFkElbqAve+RhiwZn6HyRRTteLA2HCsrTpX/MQ+TC
         cV4A==
X-Gm-Message-State: AOAM530oIe2LU17xPlJM27igLITx2pDNQvtm0iCJeyo4ohS9KThtiJ9o
        FfDrjEbDss0NtsZWAlrWmacYtO0v4qIlO800z/91nVkDlfA=
X-Google-Smtp-Source: ABdhPJxORIHcWth0Ohy54c3RXzUR8p71YqdSSHHAbCkvwEnZU+mIuFeeIVIKjid234fjG7NJDeVRBcKv/iukK5bbFW0=
X-Received: by 2002:a05:6214:5297:b0:435:7a09:1eb9 with SMTP id
 kj23-20020a056214529700b004357a091eb9mr6117166qvb.127.1647586287576; Thu, 17
 Mar 2022 23:51:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAPmgiUJVaACDyWkEhpC5Tfk233t-Tw6_f-Y99KLUDqv6dEq0tw@mail.gmail.com>
 <YjMFTSKZp9eX/c4k@localhost.localdomain>
In-Reply-To: <YjMFTSKZp9eX/c4k@localhost.localdomain>
From:   hui li <juanfengpy@gmail.com>
Date:   Fri, 18 Mar 2022 14:51:15 +0800
Message-ID: <CAPmgiUJsd-gdq=JG1rF8BHfpADeS45rcVWwnC2qKE=7W1EryiQ@mail.gmail.com>
Subject: Re: discussing about proc_misc_d_delete
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, there may be overflow problems when increased very rapidly
(refcout of /proc/pid/net/). Dentries are put on lru as they may be
accessed again in the future, these dentries will never be accessible
for the system, keeping them on lru is a waste of memory, releasing
them may be a better choice.
In the production environment, we see more than fifty million
proc_inode_cache, using  "echo 3 >/proc/sys/vm/drop_caches" takes long
time and may cause performance problems as drop cache is  a heavy
work. Besides, we believe that in function drop_pagecache_sb there is
a chance that s_inode_list_lock may be held for long time as
"inode->i_mapping->nrpages =3D=3D 0" is always true which may defer inode
creation and deletion under /proc when there are too much proc inode
caches.

Alexey Dobriyan <adobriyan@gmail.com> =E4=BA=8E2022=E5=B9=B43=E6=9C=8817=E6=
=97=A5=E5=91=A8=E5=9B=9B 17:54=E5=86=99=E9=81=93=EF=BC=9A
>
>         [cc linux-kernel ]
>
> On Mon, Mar 14, 2022 at 11:54:37AM +0800, hui li wrote:
> > We noticed that, commit 1da4d377f94 (=E2=80=9Cproc: revalidate misc den=
tries=E2=80=9D)
> > introduced proc_misc_dentry_ops as default ops for /proc dentry,
> > dentry ops for /proc/pid/net/stat/ is set as proc_net_dentry_ops,
> > which will revalidate dentry each time when this path is resolved and
> > dentry for the stat file is removed from dcache. This time, if files
> > under /proc/pid/net/stat/ are in use, then dentries of these files
> > will be put in lru when closed, which is meanlingless,  as parrent
> > dentry (stat) of these files are remove from dcache.
> >
> > This can be reproduced when use linux command "while :;do du
> > /proc/;done=E2=80=9D, then refcount of each dentry of /proc/pid/net/sta=
t/ will
> > increase rapidly which should be deleted at once.
>
> Are you worried that reference count can overflow? Those dentries will be
> flushed eventually and reference count goes back to normal values.
> This is easy to see with "echo 3 >/proc/sys/vm/drop_caches".
>
> > I think this problem may by solved by checking whether parrent
> > dentries are in d_cache inside proc_misc_d_delete, or set
> > proc_misc_dentry_ops->d_delete =3D always_delete_dentry, just as what i=
s
> > used in kernel version 4.x and 3.x.
> > --- a/fs/proc/generic.c
> > +++ b/fs/proc/generic.c
> > @@ -236,6 +236,16 @@ static int proc_misc_d_revalidate(struct dentry
> > *dentry, unsigned int flags)
> >
> >  static int proc_misc_d_delete(const struct dentry *dentry)
> >  {
> > +       struct dentry *p;
> > +       for (p =3D dentry->d_parent; !IS_ROOT(p); p =3D p->d_parent) {
> > +               if (!spin_trylock(&p->d_lock))
> > +                       break;
> > +               if (unlikely(d_unhashed(p))){
> > +                       spin_unlock(&p->d_lock);
> > +                       return 1;
> > +               }
> > +               spin_unlock(&p->d_lock);
> > +       }
> >         return atomic_read(&PDE(d_inode(dentry))->in_use) < 0;
> >  }
