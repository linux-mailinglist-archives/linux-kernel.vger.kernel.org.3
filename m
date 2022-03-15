Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A0A4D9C44
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 14:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348701AbiCONcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 09:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348681AbiCONc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 09:32:29 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB82551307
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 06:31:16 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id gb39so40875169ejc.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 06:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LgZYqSdx3kMslzrtLD5lB/zfxM/+O4tI8gltW+rfTZU=;
        b=KVWpVMvt++DrdNgN6xWztR2tG7lkShIA329EZfk0aibDvgJJDSM0f55vYsGOG//q/+
         eImSFwEWReP/k9ENtzYGuTlj/X2kgc1Q30bGY3MnqgMfWvWTnuzK6nal97jMhw8aEYzw
         OTd+FB/jxGu59AkwiqZ8cD+zNofqur4mOzHYEwahN3NQojKykKmATKW5E7jhNGcZnPKT
         r0Fi3kDngJvHNrAUfqh49N6YTs0UdVFCqJbr033sU8qhEWRWQ+q9OB3dqTEYzZnsj3X9
         w8AdxXfe4aIDRscpxTCOR2DsUJ2NuDZF5kXMZQJzRGQXtNSYQ6FEk582PJaK5S9nPFsW
         rjww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LgZYqSdx3kMslzrtLD5lB/zfxM/+O4tI8gltW+rfTZU=;
        b=y0zyp6wP/m4eIdeWto8rvBD95oDPH53LpG25uP/wVJt/up+TlG3/gxHLmc4j9WT/37
         4w+OiboIh3nGzSis1YuwmtChnNVGF6FCUOgg0o6ojimPvp51l7X2+ljsgU7kRLnPFbcB
         I6UuH42Z4HDpDQ7paRJCLsqLrG4HEBnqGTL4r2XD7uDN1/JRnNxbrMFUlwuwGXk79CdV
         ukNlYFXUDVm/L0tBXK+1ATUC5tEbkDfe/aSZ3lY+ZRXlEqJauJ78G/pIlqoWxdHCE0Ic
         SXQREQFE71PgARhGixKC7GBCDN1T7vcydKDDNHjRDEepsV/KTDxU0AJ5wV8vRT54NhuV
         UCHQ==
X-Gm-Message-State: AOAM532Wp/brmMrsUCtnAyZpZtEeTNx1KhPHE9IlPcQ6suvMeZ+alNml
        iAaGlXr6mOgn2Rg+TFUqJDMmsqLZJzZNje8Lq84=
X-Google-Smtp-Source: ABdhPJzcETTF1nWx3Yi8xHAMNYPnEF5dCz8U1aJXdwGDUsFZhk02nBx3LTkczqtIYKXj8g/eWvJ/wrIiq/CSbAtXuBg=
X-Received: by 2002:a17:907:9956:b0:6cf:cd25:c5a7 with SMTP id
 kl22-20020a170907995600b006cfcd25c5a7mr22415503ejc.635.1647351072526; Tue, 15
 Mar 2022 06:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220315075152.63789-1-dzm91@hust.edu.cn> <bca8f865-bc3e-44d7-7298-c2c7e8973580@gmail.com>
 <YjBwtqsEOZ5JbqvS@B-P7TQMD6M-0146.local> <8d832e7a-c8da-d2fa-571a-ea150b8deb1b@gmail.com>
 <CAD-N9QX2cajf0LXKcOji_Em26-0bw9wfhx7KDV_TLDWhgQ90hQ@mail.gmail.com>
 <YjCFz1dxVJZnF3M/@B-P7TQMD6M-0146.local> <CAD-N9QXp4sCKUY2zwJduOG22B0NaMGRLevn3FVMO0qOQFxO3Bg@mail.gmail.com>
In-Reply-To: <CAD-N9QXp4sCKUY2zwJduOG22B0NaMGRLevn3FVMO0qOQFxO3Bg@mail.gmail.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Tue, 15 Mar 2022 21:30:46 +0800
Message-ID: <CAD-N9QUERu_ZurAyACT+rKnPLp8ZFGDcifENLufT2sq1N9tzoQ@mail.gmail.com>
Subject: Re: [PATCH] fs: erofs: remember if kobject_init_and_add was done
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     Huang Jianan <jnhuang95@gmail.com>,
        Dongliang Mu <dzm91@hust.edu.cn>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        linux-erofs@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Tue, Mar 15, 2022 at 8:44 PM Dongliang Mu <mudongliangabcd@gmail.com> wr=
ote:
>
> On Tue, Mar 15, 2022 at 8:26 PM Gao Xiang <hsiangkao@linux.alibaba.com> w=
rote:
> >
> > Hi Dongliang,
> >
> > On Tue, Mar 15, 2022 at 07:59:26PM +0800, Dongliang Mu wrote:
> > > On Tue, Mar 15, 2022 at 7:05 PM Huang Jianan <jnhuang95@gmail.com> wr=
ote:
> > > >
> > > > =E5=9C=A8 2022/3/15 18:55, Gao Xiang =E5=86=99=E9=81=93:
> > > > > On Tue, Mar 15, 2022 at 06:43:01PM +0800, Huang Jianan wrote:
> > > > >> =E5=9C=A8 2022/3/15 15:51, Dongliang Mu =E5=86=99=E9=81=93:
> > > > >>> From: Dongliang Mu <mudongliangabcd@gmail.com>
> > > > >>>
> > > > >>> Syzkaller hit 'WARNING: kobject bug in erofs_unregister_sysfs'.=
 This bug
> > > > >>> is triggered by injecting fault in kobject_init_and_add of
> > > > >>> erofs_unregister_sysfs.
> > > > >>>
> > > > >>> Fix this by remembering if kobject_init_and_add is successful.
> > > > >>>
> > > > >>> Note that I've tested the patch and the crash does not occur an=
y more.
> > > > >>>
> > > > >>> Reported-by: syzkaller <syzkaller@googlegroups.com>
> > > > >>> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > > > >>> ---
> > > > >>>    fs/erofs/internal.h | 1 +
> > > > >>>    fs/erofs/sysfs.c    | 9 ++++++---
> > > > >>>    2 files changed, 7 insertions(+), 3 deletions(-)
> > > > >>>
> > > > >>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> > > > >>> index 5aa2cf2c2f80..9e20665e3f68 100644
> > > > >>> --- a/fs/erofs/internal.h
> > > > >>> +++ b/fs/erofs/internal.h
> > > > >>> @@ -144,6 +144,7 @@ struct erofs_sb_info {
> > > > >>>     u32 feature_incompat;
> > > > >>>     /* sysfs support */
> > > > >>> +   bool s_sysfs_inited;
> > > > >> Hi Dongliang,
> > > > >>
> > > > >> How about using sbi->s_kobj.state_in_sysfs to avoid adding a ext=
ra member in
> > > > >> sbi ?
> > > > > Ok, I have no tendency of these (I'm fine with either ways).
> > > > > I've seen some usage like:
> > > > >
> > > > > static inline int device_is_registered(struct device *dev)
> > > > > {
> > > > >          return dev->kobj.state_in_sysfs;
> > > > > }
> > > > >
> > > > > But I'm still not sure if we need to rely on such internal
> > > > > interface.. More thoughts?
> > > >
> > > > Yeah... It seems that it is better to use some of the interfaces
> > > > provided by kobject,
> > > > otherwise we should still maintain this state in sbi.
> > > >
> > >
> > > I am fine with either way. Let me know if you reach to an agreement.
> >
> > If you have time, would you mind sending another patch by using
> > state_in_sysfs? I'd like to know Chao's perference later, and
> > apply one of them...
>
> OK, let me test this patch in my local workspace. If it works, I will
> send it later.

Hi Gao Xiang,

I've sent another patch. Please double-check.

>
> >
> > Thanks,
> > Gao Xiang
> >
