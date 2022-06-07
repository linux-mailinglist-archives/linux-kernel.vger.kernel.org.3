Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A00A53FF2C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244090AbiFGMm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244081AbiFGMmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:42:52 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F671C93D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 05:42:50 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id i19so12212587qvu.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 05:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KCA+Y9dgW4Jgevx79kF7IXZRJWrbeJFPviDARnJw5Mc=;
        b=qknqJjglN56ohEAbFyDfNeXUIP9FeORmYBmG/najnECYVQ6aERWwK3uNx/5aLZaH9V
         6DpOhAFl9r19IYVWnRXrEpmoW3D5UkDfBp8DcWHy8dD4QVPHDpW+B4/YSvcG/JoIiitm
         BUx7m4W+baMryknlVA4UPqRxIluniQ0hlMWfK08uVWpWTaxHcGUVagzJwo7lWcOhA8En
         1n5+rwoecE7EbguzW7fmGpz7Jh+bIpbuy1uy8qWQbg0ovwXMykXX3WEv06Tu7F9Osngq
         og1oAM8PvbTalUVyhQH1hMeb84cKkT80sO37aXhLSrDn9WCTrjFcS4umI1E7zm+K/sRk
         J2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KCA+Y9dgW4Jgevx79kF7IXZRJWrbeJFPviDARnJw5Mc=;
        b=hTVCC/CGRaQS7nHFnWy5aimSVZ92UirZa88h1tlAn1Ap/a9H0JfISS29pX2LAnUJRU
         ap+2D5hWYjxz6LdSuMJ+wuvtwrgjoXLhoE+aI72JUHteCXL3rv0ySmiLwaXtVpFWZrTR
         BHkyu13RZXa3jWFEIVqBhuYQS8tCdkmhpzD/zek4IgJ0maKqaYxaU07xUoTV6ermF4jh
         Gb3Isp1Q8yi1WX4XVYR9kzQ5YDHP31I853TUyZ0bJ8d8vDVFwzjsoE254L+AWARcDd2M
         qIspocNJvXFqbLapL9X5DZSLAIhTcUKjYqClQDqlr07yyfUwk2HZ8pSwVn3jNxate+Rq
         a5Ww==
X-Gm-Message-State: AOAM530qbWhAhvaEq1m8xghgAOHtRO1GtpmFm5YnqF11eQU95Bh3J3gl
        GgE5outsf3jHTKb47MD3cqySAPWBkgZ87ZE8Lac=
X-Google-Smtp-Source: ABdhPJzURX7nJxppBGO7nDeeb8f3GP7bnqNS72VUGNXWWCu86vAljqYLzZLTtFNKiAx/tprPSJr3CHJUCQnf5FDThVg=
X-Received: by 2002:a05:6214:2422:b0:467:d777:7cda with SMTP id
 gy2-20020a056214242200b00467d7777cdamr17957263qvb.118.1654605769540; Tue, 07
 Jun 2022 05:42:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220604145624.47326-1-robimarko@gmail.com> <a08c5dd0-279d-724a-4836-6e66bfa183e8@wanadoo.fr>
In-Reply-To: <a08c5dd0-279d-724a-4836-6e66bfa183e8@wanadoo.fr>
From:   Robert Marko <robimarko@gmail.com>
Date:   Tue, 7 Jun 2022 14:42:38 +0200
Message-ID: <CAOX2RU5zUMEVZeScSPV6MvzvxwghECJy1DHDTfW5CFDeyPuE+A@mail.gmail.com>
Subject: Re: [PATCH 1/3] regulator: mp5416: alphabetically sort header includes
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        open list <linux-kernel@vger.kernel.org>
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

On Sat, 4 Jun 2022 at 17:41, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 04/06/2022 =C3=A0 16:56, Robert Marko a =C3=A9crit :
> > Sort the header include list alphabetically.
> >
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > ---
> >   drivers/regulator/mp5416.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/regulator/mp5416.c b/drivers/regulator/mp5416.c
> > index 39cebec0edb6..d8245080df03 100644
> > --- a/drivers/regulator/mp5416.c
> > +++ b/drivers/regulator/mp5416.c
> > @@ -6,14 +6,14 @@
> >   //
> >   // Author: Saravanan Sekar <sravanhome@gmail.com>
> >
> > +#include <linux/err.h>
> > +#include <linux/i2c.h>
> > +#include <linux/init.h>
> >   #include <linux/kernel.h>
>
> Nitpick: it seems that kernel.h is not needed here. (at least it compile
> without it).

Hi,

It also seems to work fine without it, will send a patch to remove it.

Regards,
Robert
>
> CJ
>
> >   #include <linux/module.h>
> > -#include <linux/init.h>
> > -#include <linux/err.h>
> >   #include <linux/platform_device.h>
> >   #include <linux/regmap.h>
> >   #include <linux/regulator/driver.h>
> > -#include <linux/i2c.h>
> >
> >   #define MP5416_REG_CTL0                     0x00
> >   #define MP5416_REG_CTL1                     0x01
>
