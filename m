Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 968CA486F15
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 01:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344543AbiAGAvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 19:51:53 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:60753 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343978AbiAGAvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 19:51:52 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M9WmQ-1n09J41MW4-005WCs; Fri, 07 Jan 2022 01:51:50 +0100
Received: by mail-wm1-f52.google.com with SMTP id f189-20020a1c1fc6000000b00347ac5ccf6cso36492wmf.3;
        Thu, 06 Jan 2022 16:51:50 -0800 (PST)
X-Gm-Message-State: AOAM530JXeCunWgC14kNAntx869YryWbY/IS/8diWBuSzOkhXeGAZwET
        g/gtrdDUkEspc90YpZ93GKi0HBLi9CeJX863z3Q=
X-Google-Smtp-Source: ABdhPJxaOooSi6JuNuFqsiQf70TarUb7k59G6O1fatVVJVQP6kddZ7utdE6PGLlDcAYxwZk5b9AxJWt6LAM83gxSrd0=
X-Received: by 2002:a7b:c190:: with SMTP id y16mr8483309wmi.35.1641516709979;
 Thu, 06 Jan 2022 16:51:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641500561.git.christophe.jaillet@wanadoo.fr> <e89f4b29b9f7e0c711a3ccc16a009f49f416e1fc.1641500561.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <e89f4b29b9f7e0c711a3ccc16a009f49f416e1fc.1641500561.git.christophe.jaillet@wanadoo.fr>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 6 Jan 2022 19:51:47 -0500
X-Gmail-Original-Message-ID: <CAK8P3a0w51bnDy2whAC8WOCx2=9UB1ViX3veOfhSmQwwLr3VNQ@mail.gmail.com>
Message-ID: <CAK8P3a0w51bnDy2whAC8WOCx2=9UB1ViX3veOfhSmQwwLr3VNQ@mail.gmail.com>
Subject: Re: [PATCH 04/16] media: Remove usage of the deprecated
 "pci-dma-compat.h" API
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        awalls@md.metrocast.net,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:xYiG2GR/hmv7XwdTZf69kHeOBGd9/1CmiJMtN+/LJx73FDb0km1
 K3uMGRLJLzptbOiB6Tyc1CwlUoIjb3EDmwLamoC/W8hcq7emjVtOGJze4q48QgoketJdw/n
 3YqKcz4+xAWQPUPVKa5FLRULsPD+uKb0jRSA0WuNRl0K73pkH+DG/4zDxskldlAeBProp1I
 0Dup8FkH6f8VvYT1HzjVQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:thErucJKSqk=:Gys1v3E2yQEJcL+DNPrBRT
 +uqmBWAqehiHSCNUQqaOT1HI8ucgq1t0y1MEx7IDX0BN0NySa2teh9h09puCwWLwbbKD1iSVs
 JbRu9VV/OxdsQIVCA+ocPbKm9pRyVJ7tunWpjoAWaPzNZRtPry3Y+Ksxh+/M2dvQGpUA/SaQE
 gcEcpuKJWn+RomGR1SU2Kthrb9acxBS/CySx+YOdnGIfEBHHxnL1fWax65VSIUQjeuKh304QB
 u4/jRwS3MXJmHRSSmI6J3TKqMM4s6JxbUv/6oTJtdC8atU/IRBy3AKQc7PyzqCMHT5vels+uX
 t0TXX19F0oLuPhDzc4+K6T90RmvR3MFOG6u5KRfGcJ+aBTshTfjCb+xoqVdQRST39eRMT1NsS
 tJ1gLaKNDgZ6Ud19stmR6UlBEJcPMEL79R/iO62Zv0hToLp0oKLsbKOagFd+wBtSInZpI4joq
 U1v4Oc2MZSzI83x7fRlJehKx7FFDq83E+4J+b2rPB7OU1wK2LnVa4Xn1Ei8ic2lo3CSPKYtki
 /IwuaZ27wW+AkllEq8/homa6P5sjKA0IqjOq70mtslxMg65tzj3iv+WJ7/D+lB3cx9ETvXut2
 0ZO0lsRD/TX0Rqmnyn8mzgKpNamfWpQb1x1ccOIMzpvWTmxb6u+BvErj8TIlDEUrKYpNaRoDp
 mROp0tldm+lls41DaIOLAIKWVmCbE364VoInI24g6jqzVIAoNGv//glGIWBn9DjO7aDo=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 6, 2022 at 4:50 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> In [1], Christoph Hellwig has proposed to remove the wrappers in
> include/linux/pci-dma-compat.h.
>
> Some reasons why this API should be removed have been given by Julia
> Lawall in [2].
>
> A coccinelle script has been used to perform the needed transformation.
> It can be found in [3].
>
> [1]: https://lore.kernel.org/kernel-janitors/20200421081257.GA131897@infradead.org/
> [2]: https://lore.kernel.org/kernel-janitors/alpine.DEB.2.22.394.2007120902170.2424@hadrien/
> [3]: https://lore.kernel.org/kernel-janitors/20200716192821.321233-1-christophe.jaillet@wanadoo.fr/
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Mauro, could you pick this up directly? It has no dependencies on the rest of
the series.
