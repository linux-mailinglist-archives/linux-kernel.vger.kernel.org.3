Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E654933B8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 04:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351379AbiASDmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 22:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351362AbiASDmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 22:42:20 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D445C061574;
        Tue, 18 Jan 2022 19:42:19 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id d14so1083204ila.1;
        Tue, 18 Jan 2022 19:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=r7JMEviKgX7h7dwTMY/Scut1yLu5dIsiftxrDpb7xA4=;
        b=FwecmbS5j43h2MdrGoTc/SA07Kt3B1rkC8h4gpljYPb73LyIoubYgHRN9UaZ7c8WYF
         5mIZLpFUdoyVBg6Nu7xioqJPsxrU6taF4Met/zLrBPMWEld0/19Id5AJ0g3v3jewZ1xL
         K5MG6MMlQhnU0NRHZIHnvHU8JJCpoipZAG73/nSRd4fe1S3NGv4eX1O7U7ifTxPcgmmP
         eLQroS3P5Pybr76JPSVxaOXfCcx5Kn6FucRifppfipVEi9eDvsWZ8V6DO/7N+T2X20jA
         nNyiM7FkEFzQiJ2G5b05oUt3JFYnIqWOHxj58k+OyblcV65qqc3tRWCgSj+lpTq/DPo6
         I1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=r7JMEviKgX7h7dwTMY/Scut1yLu5dIsiftxrDpb7xA4=;
        b=OXF2/1vXmyqhqLWd5Rw6lzXooWQ6z/o2wMmqoTchHr0U+/oR+qDUI1kU3yR4Y0GM9L
         XWvz6Ty2K8jQ4OIVQmD4OMnyXyoolvbeWi+A6R1kfR0PxsptLQ8t6Lh8QK+HOuEIk5cp
         tV4Y1B7C7267vppGk/+xly3asWILSqfDbV2pFGc3dj9cfpGNzeRK8zVGp5D0r4YUlKCI
         1lqUcQQP2S+hLaZWR00INYOTaMWi8YAWZDsdjlbXEfyf6/6qdHFRnsPL8WTK/lTGr5Vi
         VN+5azJEh6lu0JGhLohfEy7ThjTBVE3fX5osuGRyyPXcFjkz3OY0szXKJFw2WWonZR5s
         fgZg==
X-Gm-Message-State: AOAM531FO6XxDSsraU9eWjl2sayYmfrzobSzBLsOkyZhUh/KiuWQTgh+
        U47tY6te5L0aYZP9a2bbH+ZbpLF/bx+BoxpbXSs=
X-Google-Smtp-Source: ABdhPJxLRPu+hUwMNgV6oFE1Pv54GbsGaXtQPkntOSn/upzk8UtPVN8k7Cnk2z17zKcquQa6gBv2O1e03N2meKMiU6M=
X-Received: by 2002:a92:8750:: with SMTP id d16mr14349699ilm.103.1642563738987;
 Tue, 18 Jan 2022 19:42:18 -0800 (PST)
MIME-Version: 1.0
References: <1642003482-48935-1-git-send-email-wang.yong12@zte.com.cn>
 <CAMU9jJquKLfzLOjN3xTLHgPJFWONpeVgUDG-0vsf_8ia3r3ALQ@mail.gmail.com>
 <CAOH5QeBxnK-vOwVh9HNeu5PjMPJrHtWCyTK_y43iCbfzN+aoEg@mail.gmail.com>
 <CAOH5QeAka4QsLCOHaNK8NBp1BUFsu3HqEqiOhWOewabA58fVqw@mail.gmail.com> <CAMU9jJr4A0jsZGAqdOUTc-gBeshCgPAS=2Vvubs_kmsJSegzkQ@mail.gmail.com>
In-Reply-To: <CAMU9jJr4A0jsZGAqdOUTc-gBeshCgPAS=2Vvubs_kmsJSegzkQ@mail.gmail.com>
From:   Alex Shi <seakeel@gmail.com>
Date:   Wed, 19 Jan 2022 11:41:43 +0800
Message-ID: <CAJy-Amne22+2cApoeEAGSc7d7ppSQja7pLX6SY_3+0wr8i3Asw@mail.gmail.com>
Subject: Re: [PATCH] docs/zh_CN: Update zh_CN/accounting/delay-accounting.rst
To:     teng sterling <sterlingteng@gmail.com>
Cc:     yong w <yongw.pur@gmail.com>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, wang.yong12@zte.com.cn,
        Yang Yang <yang.yang29@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 11:28 AM teng sterling <sterlingteng@gmail.com> wro=
te:
>
> yong w <yongw.pur@gmail.com> =E4=BA=8E2022=E5=B9=B41=E6=9C=8818=E6=97=A5=
=E5=91=A8=E4=BA=8C 20:38=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Hello,
> > Is this patch OK?
> >
> > yong w <yongw.pur@gmail.com> =E4=BA=8E2022=E5=B9=B41=E6=9C=8813=E6=97=
=A5=E5=91=A8=E5=9B=9B 22:56=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > Hello,
> > > teng sterling <sterlingteng@gmail.com> =E4=BA=8E2022=E5=B9=B41=E6=9C=
=8813=E6=97=A5=E5=91=A8=E5=9B=9B 10:11=E5=86=99=E9=81=93=EF=BC=9A
> > > >
> > > > Hi Yong,
> > > > <yongw.pur@gmail.com> =E4=BA=8E2022=E5=B9=B41=E6=9C=8813=E6=97=A5=
=E5=91=A8=E5=9B=9B 07:27=E5=86=99=E9=81=93=EF=BC=9A
> > > > >
> > > > > From: wangyong <wang.yong12@zte.com.cn>
> > > > >
> > > > > Update zh_CN/accounting/delay-accounting.rst.
> > > > > The document modification has been merged which refers to the fol=
lowing link:
> > > > > https://lore.kernel.org/all/1639583021-92977-1-git-send-email-wan=
g.yong12@zte.com.cn/
> > > > The normal way to handle this is to add an appropriate Fixes tag.
> Since 4d3959d65968(Documentation/accounting/delay-accounting.rst: add
> thrashing page cache and direct compact) Modified the original
> document=EF=BC=8C
> It seems we forgot to update the Chinese documentation, let's update it n=
ow.
> > > >
> > > > By the way, this patch should be submitted together as part of that
> > > > patch series where you modified the original documentation. Also ch=
eck
> > > > out the documentation for other languages and send it in the same w=
ay.
> > > > If you get stuck, simply --CC the maintainer is an elegant way to
> > > > handle it. >_<
> > > The previous patch has been merged into linux-next. There was no
> > > Chinese translation when I submitted it.
> > > At present, this document is only translated into Chinese, which was
> > > translated not long ago.
> > > So I update it in this patch.
> > > >
> > > > >
> > > > > Signed-off-by: wangyong <wang.yong12@zte.com.cn>
> > > > > Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
> > > > This looks like the first version of the patch and doesn't seem to
> > > > have been reviewed by anyone yet, so you can't sign it instead of
> > > > someone else.
> > > Yang Yang reviewed it offline.
> I'm not sure if this is appropriate, but lore is missing the review
> process and the mailing list developers don't know what's going on,
> which in a way makes it more difficult for future developers to learn.

Right. The better way is asking Yang Yang to give a reviewed-by in
mailing list next time. Otherwise, the private tag can't give a good
support.


for this patch. Reviewed-by: Alex Shi <alexs@kernel.org>

>
> Apart from the above=EF=BC=8CLGTM.
>
> Thanks,
> Yanteng
> > > >
> > > > Thanks,
> > > > Yanteng
> > > Thanks for your reply.
