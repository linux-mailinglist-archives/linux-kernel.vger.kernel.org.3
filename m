Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7494BF51D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 10:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiBVJuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 04:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbiBVJuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 04:50:00 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475B5119419;
        Tue, 22 Feb 2022 01:49:34 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2d66f95f1d1so166882247b3.0;
        Tue, 22 Feb 2022 01:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I+1ybMhNBxeJhewJGPotloa4lDDMgSvpF+wqTddYHZM=;
        b=FGj1/Fsy03td8VFZ0StvJLn5LyXeBDYJmtHceMh7Xh1TPTUdKJIMjmcfYkM3l05s8M
         Hwyy9sWDVtLb1nO75pimabsv8yf4Op+LZrmAyRJ/0xj68Cy/iv/YcIpt9dBKhEmYQTTF
         9Na7AyztQPF9GNEMAhsmmqYmGLcPj9uTGHvrUXVxo3tJlJsIp3vgbEtf1uhjXVHYFEHG
         56GN3VSvvRiXHpcSM2u044Q7BN118kSZNxaib8A5zLBwNubq05KJgTFY4HjX/89FxQc8
         ZHy+uQOtMDzUAoYNXpvrTyBQtKxM2U44RvJIlQun0yQ/MIZgQNG0KBDO9qp3WEbOpsPz
         yFZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I+1ybMhNBxeJhewJGPotloa4lDDMgSvpF+wqTddYHZM=;
        b=CrtPOIcktO2KAEuQkODTMUMDODJBwr75we1fD80wx0pCmfURgPnoI3TZd5QjruuArj
         nPH9GUB5zuAm67EQPHrMWUT6M1ArV5WxP51gS5/WUTmCFvEvBXiX01BURnQb53vNGFwq
         bJ4O28RW+dqL0mTNeLP7JTFdMgK/y7doJDN+ClGlWp+N1sAT/3i/O+fXKKUDjDwTwZaP
         NFe+NsvnyWTQaCNgWQyzO2vW8B1AACxfOsb3WpDP82Vpsdd69EWS4yv8xaTLj92k6efD
         gDOTdX6xsknOCuwnxD9EYGaVJwMPEarhpDFSVsj3WG7hI04v068uBXlWnL3mAqpaG7zt
         4goQ==
X-Gm-Message-State: AOAM532+iZFuSPogorYXkOMpZ39iy6ecjWt80f6PQHNFRbLK8tZ6RDYq
        p7a7OqjLlt+ZAn8rigg2FHbacIrIQ7V3V0fjhKo=
X-Google-Smtp-Source: ABdhPJxAPHayjDTcrE2Q32HSf/efRSQMSrMjyxlIKw91qY1WplFcblk7uJXq7RGfhsaoWnxwVIGf8c12RxmMx15271k=
X-Received: by 2002:a81:5f8a:0:b0:2d0:ccb1:9c9c with SMTP id
 t132-20020a815f8a000000b002d0ccb19c9cmr23818472ywb.265.1645523372069; Tue, 22
 Feb 2022 01:49:32 -0800 (PST)
MIME-Version: 1.0
References: <20220221222450.5393-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdVb38_nhxVqUdtedyP0wMWmgkC-4K+OgbY0bOO8Hw4w4Q@mail.gmail.com>
 <OS0PR01MB59226DF1128AE3BBAEA2E96E863B9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdXzz1szS=6aY7RKRo1YAGqQ_AjmkXk6x4CryRtoSADfcw@mail.gmail.com>
In-Reply-To: <CAMuHMdXzz1szS=6aY7RKRo1YAGqQ_AjmkXk6x4CryRtoSADfcw@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 22 Feb 2022 09:49:06 +0000
Message-ID: <CA+V-a8ucX_G04wU-pvUtQ7HxDdgp0sguU=x663xvXaE1RaZ8+A@mail.gmail.com>
Subject: Re: [PATCH] soc: renesas: Kconfig: Explicitly select PM and
 PM_GENERIC_DOMAINS configs
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Tue, Feb 22, 2022 at 8:31 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Biju,
>
> On Tue, Feb 22, 2022 at 9:30 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > > Subject: Re: [PATCH] soc: renesas: Kconfig: Explicitly select PM and
> > > PM_GENERIC_DOMAINS configs
> > >
> > > On Mon, Feb 21, 2022 at 11:25 PM Lad Prabhakar <prabhakar.mahadev-
> > > lad.rj@bp.renesas.com> wrote:
> > > > Explicitly select PM and PM_GENERIC_DOMAINS configs for ARCH_R9A07G044
> > > > and ARCH_R9A07G045 configs. PM and PM_GENERIC_DOMAINS configs are
> >
> > Typo ARCH_R9A07G054 configs
>
> Thanks, will fix while applying.
>
Thanks Biju & Geert.

Cheers,
Prabhakar
