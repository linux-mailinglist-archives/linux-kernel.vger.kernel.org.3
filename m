Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F79854BF31
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 03:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345423AbiFOBSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 21:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345289AbiFOBSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 21:18:43 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293FC2A274
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 18:18:10 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id a10so5519317wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 18:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=K7pGdzJdqHuYwS1bYbVurI6uCtk6tWf/NxPbeZGPiKk=;
        b=GJSIGAWb4wWJ8zVfW/PVsPdfLVoxFfdu+fX7vMMLELUREnwZiwyQ63nvuzC4+1dz/J
         atxtgSdFQZlpQffy1/MdOu+imIksqdVQVno/DmT95AU2hx80ZyxLX1LBxM8Hhwkg4Q+i
         fDbskaRzFIkDCRNqr9wjyHTFmGon1p/QhKDN0Gp1pjo2PFxXfrIrnthi6MqS70DykRMw
         qlsV5DUsfLB1NzaOOIGp4I5B9yjAVqWbKQCVjJqDfO3DMX/WbZnwqj2FTd25oyCcJuNQ
         9mhHNH9tgK7JGoAzzzXpitwQcA9W+KyO0Tc6hK5tE4NrIafd2trDuR8hf9SgSP7R4fF9
         srqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K7pGdzJdqHuYwS1bYbVurI6uCtk6tWf/NxPbeZGPiKk=;
        b=dN6XfhiyQ6SIvDkgTSKjAN3IZSGYI/dozI8+0VkvAomUgZVnJyFs/0tJVu3aqwLG6J
         6a/xCt4v4eHEa4AQaE7YMiWVwzVCZiGP4lpCrJeDsxWGiGDmJ0W1M2xlxB6vgcSwGH/N
         KP5yQKgaYOQxHtfPy4XGR8FEnxkNnlEeFyC1ufnE3Wy6+kKby241wHYDCn+cYzqShBRZ
         ZqvNDhzaBIMMBkyLdOz6Xcxpg0Y0W/whJdxCvNGnYK5irYCDXbgR17XyPcpOTioQrc11
         1QiMqBqGvqMv+9WBu02OMRpYcDe53tkR6/VUMaUox1j0VQYrEeBigEUo82DnaRWOsDxV
         neAA==
X-Gm-Message-State: AOAM533gHFIOkT4rRJMj3OzFgnKAM4DpOj31RQaWp8zfd6IAMGKaqcTi
        Mor1rPr9CoP5GAMkavCtLjvYFBu1gOk2COXjAexmjbT+1g==
X-Google-Smtp-Source: ABdhPJzq0py4jwRNDajc+XMV6fU5cc1yxRWaEgccOkiLbfpdOU8rMLWl3D6nw1mmBwN641Lc+w/Ngmp6j05FQilyTWU=
X-Received: by 2002:a7b:c38b:0:b0:39c:6964:34a2 with SMTP id
 s11-20020a7bc38b000000b0039c696434a2mr6921750wmj.165.1655255881271; Tue, 14
 Jun 2022 18:18:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220611090550.135674-1-xiujianfeng@huawei.com>
 <CAHC9VhSwYdrHw8jNYxWApPYMjnmX-ZDN1=CzmRBeS1HoL-KOOA@mail.gmail.com> <c54658e5-f0bd-b3f6-3cf8-d7d0e8b1c4df@huawei.com>
In-Reply-To: <c54658e5-f0bd-b3f6-3cf8-d7d0e8b1c4df@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 14 Jun 2022 21:17:50 -0400
Message-ID: <CAHC9VhTkfBm8zCDw=m+jaDZW15LB+bRJ5+ymxsSJKW=V645S2g@mail.gmail.com>
Subject: Re: [PATCH -next] selinux: Fix potential memory leak in selinux_add_opt
To:     xiujianfeng <xiujianfeng@huawei.com>
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        omosnace@redhat.com, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 9:18 PM xiujianfeng <xiujianfeng@huawei.com> wrote:
> =E5=9C=A8 2022/6/14 4:22, Paul Moore =E5=86=99=E9=81=93:
> > On Sat, Jun 11, 2022 at 5:07 AM Xiu Jianfeng <xiujianfeng@huawei.com> w=
rote:
> >> In the entry of selinux_add_opt, *mnt_opts may be assigned to new
> >> allocated memory, and also may be freed and reset at the end of the
> >> function. however, if security_context_str_to_sid failed, it returns
> >> directly and skips the procedure for free and reset, even if it may be
> >> handled at the caller of this function, It is better to handle it
> >> inside.
> >>
> >> Fixes: 70f4169ab421 ("selinux: parse contexts for mount options early"=
)
> >> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> >> ---
> >>   security/selinux/hooks.c | 12 +++++++-----
> >>   1 file changed, 7 insertions(+), 5 deletions(-)
> > Have you actually observed a memory leak from the selinux_mnt_opts
> > allocation in selinux_add_opt()?
> >
> > The selinux_add_opt() function has two callers:
> > selinux_sb_eat_lsm_opts() and selinux_fs_context_parse_param().  The
> > former cleans up the selinux_mnt_opts allocation it its error handler
> > while the latter will end up calling
> > security_free_mnt_opts()/selinux_free_mnt_opts() to free the
> > fs_context:security when the fs_context is destroyed.
> >
> > This patch shouldn't be necessary.
>
> I may not have made it clear, I said potential means may have a third
> caller in the future.

Let's not worry about it.  If you wanted to add a comment header to
the function (see selinux_skb_peerlbl_sid() for an example) to make it
clear that callers are responsible for cleaning up @mnt_opts on error
I think that would be okay ... although even that is going to be a
problem in the new mount API case where selinux_add_opt() is going to
be called multiple times.

> I think the error handler as following is not necessary:
>
> err:
>          if (is_alloc_opts) {
>                  kfree(opts);
>                  *mnt_opts =3D NULL;
>          }
>
> otherwise, some error paths goto err label while others don't, It's
> confusing.

That's a fair point.  Looking at the patch which added it, we should
probably also return EINVAL when @s is NULL instead of ENOMEM.  In
fact, in all the cases where we currently jump to @err, I think we are
guaranteed that @is_alloc_opts is false as it requires a previously
populated @opts.

If you want to submit another patch, I would suggest doing the
following in the patch:

1. Change the @s NULL check to return -EINVAL when @s is NULL.
2. Allocate @opts/@mnt_opts if NULL, but don't call kfree() on the
object in case of error.  The new mount API will cleanup when it is
done and selinux_sb_eat_lsm_opts() will cleanup on error.

If you don't have time to put together a patch for this, let me know and I =
will.

--=20
paul-moore.com
