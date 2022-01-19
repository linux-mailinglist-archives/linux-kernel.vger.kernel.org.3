Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7784933A1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 04:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351310AbiASD2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 22:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237525AbiASD2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 22:28:53 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4208CC061574;
        Tue, 18 Jan 2022 19:28:53 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id r11so1095847pgr.6;
        Tue, 18 Jan 2022 19:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vJF4j7McmN6NGFjUcNJT2nC2Arf7tOJynnQu/tMAGAE=;
        b=epztSRp3deGpw95GiJhCU1vISAyvzA5voS3NT2kPHbElGawx2HKhtxeo5x80esHl89
         g22obUlynxSWSsoSs0KqCfqxs1UFtxTk+d2lDRUgoHlfGsNo78P+uZsTBlfCxBIHcUN4
         WTRRTyMSfeQT2c9Au3HoiGhqi5bd6yIVLV54FNJYXhhynrJ0Uc+nv/qz2QzxeGxX0jI9
         Ub3Wpljm8e/Ft9B7xOfrOFLcYTC/GYF7UENDqSEoWRFiTCLfulvG8vNifnHO7Tftt+6J
         PJ7U8F3K1tc6oP0Mmze6C1y2cyxlcpgRRcbMeKxsqueQaOEwykNylxfylC92hvi0d0Jq
         6lhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vJF4j7McmN6NGFjUcNJT2nC2Arf7tOJynnQu/tMAGAE=;
        b=f36jG5DGQqufZ9vsu50GDmoaUZ2HS7nRI+P6XHF8ij0Ryd67KBFGg500jRjt3Nj6yM
         1PZ4uPASqDs1hAAdRd+AcL7ZK+NkB1asI7F70A6aOItTRIbAxpIMDr1LJujvaKGNgb4Z
         lvRrYUupY/9Hn7WN78TAQIXPhUCQQVIJO1JFlNLElO2zqCnpQxTgX34oY9HjmXMH6I9F
         kEPYLYl517/ih3YISrGZ3pqcUJCClZeRqOPB5zIzGGB47wpYx/uw/sMWMmHcIYIyP3b7
         ezeBXhi55AhuNR81ySOB4FgWCLzywVU5Zqjkr4jcdZiGNghDbHH0jxgyfN+SHpeURb5h
         OTtw==
X-Gm-Message-State: AOAM532kIC2fHpYi2eV3x8HKX9iVFQDiocbNs6LzW0RvFEFQlmkCHYF8
        /wNJfdAYO+2NAQDzCk4lrzM9dtIGUIxl3YvPBj0=
X-Google-Smtp-Source: ABdhPJzhDDbAIc/Hu6OH5ojHDbvWcMm+aXz/wdJcT0j7bUarj6tBjHc5Pq6m7BOIW0oIEU6kpc0RpuBiQncdceMPUDo=
X-Received: by 2002:a63:8c4c:: with SMTP id q12mr25917057pgn.149.1642562932667;
 Tue, 18 Jan 2022 19:28:52 -0800 (PST)
MIME-Version: 1.0
References: <1642003482-48935-1-git-send-email-wang.yong12@zte.com.cn>
 <CAMU9jJquKLfzLOjN3xTLHgPJFWONpeVgUDG-0vsf_8ia3r3ALQ@mail.gmail.com>
 <CAOH5QeBxnK-vOwVh9HNeu5PjMPJrHtWCyTK_y43iCbfzN+aoEg@mail.gmail.com> <CAOH5QeAka4QsLCOHaNK8NBp1BUFsu3HqEqiOhWOewabA58fVqw@mail.gmail.com>
In-Reply-To: <CAOH5QeAka4QsLCOHaNK8NBp1BUFsu3HqEqiOhWOewabA58fVqw@mail.gmail.com>
From:   teng sterling <sterlingteng@gmail.com>
Date:   Wed, 19 Jan 2022 11:28:42 +0800
Message-ID: <CAMU9jJr4A0jsZGAqdOUTc-gBeshCgPAS=2Vvubs_kmsJSegzkQ@mail.gmail.com>
Subject: Re: [PATCH] docs/zh_CN: Update zh_CN/accounting/delay-accounting.rst
To:     yong w <yongw.pur@gmail.com>
Cc:     Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, wang.yong12@zte.com.cn,
        yang.yang29@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

yong w <yongw.pur@gmail.com> =E4=BA=8E2022=E5=B9=B41=E6=9C=8818=E6=97=A5=E5=
=91=A8=E4=BA=8C 20:38=E5=86=99=E9=81=93=EF=BC=9A
>
> Hello,
> Is this patch OK?
>
> yong w <yongw.pur@gmail.com> =E4=BA=8E2022=E5=B9=B41=E6=9C=8813=E6=97=A5=
=E5=91=A8=E5=9B=9B 22:56=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Hello,
> > teng sterling <sterlingteng@gmail.com> =E4=BA=8E2022=E5=B9=B41=E6=9C=88=
13=E6=97=A5=E5=91=A8=E5=9B=9B 10:11=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > Hi Yong,
> > > <yongw.pur@gmail.com> =E4=BA=8E2022=E5=B9=B41=E6=9C=8813=E6=97=A5=E5=
=91=A8=E5=9B=9B 07:27=E5=86=99=E9=81=93=EF=BC=9A
> > > >
> > > > From: wangyong <wang.yong12@zte.com.cn>
> > > >
> > > > Update zh_CN/accounting/delay-accounting.rst.
> > > > The document modification has been merged which refers to the follo=
wing link:
> > > > https://lore.kernel.org/all/1639583021-92977-1-git-send-email-wang.=
yong12@zte.com.cn/
> > > The normal way to handle this is to add an appropriate Fixes tag.
Since 4d3959d65968(Documentation/accounting/delay-accounting.rst: add
thrashing page cache and direct compact) Modified the original
document=EF=BC=8C
It seems we forgot to update the Chinese documentation, let's update it now=
.
> > >
> > > By the way, this patch should be submitted together as part of that
> > > patch series where you modified the original documentation. Also chec=
k
> > > out the documentation for other languages and send it in the same way=
.
> > > If you get stuck, simply --CC the maintainer is an elegant way to
> > > handle it. >_<
> > The previous patch has been merged into linux-next. There was no
> > Chinese translation when I submitted it.
> > At present, this document is only translated into Chinese, which was
> > translated not long ago.
> > So I update it in this patch.
> > >
> > > >
> > > > Signed-off-by: wangyong <wang.yong12@zte.com.cn>
> > > > Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
> > > This looks like the first version of the patch and doesn't seem to
> > > have been reviewed by anyone yet, so you can't sign it instead of
> > > someone else.
> > Yang Yang reviewed it offline.
I'm not sure if this is appropriate, but lore is missing the review
process and the mailing list developers don't know what's going on,
which in a way makes it more difficult for future developers to learn.

Apart from the above=EF=BC=8CLGTM.

Thanks,
Yanteng
> > >
> > > Thanks,
> > > Yanteng
> > Thanks for your reply.
