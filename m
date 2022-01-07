Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C992486F57
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 02:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344997AbiAGBAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 20:00:43 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:33739 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236544AbiAGBAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 20:00:43 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MD9jV-1nECKG2wcL-0097oP; Fri, 07 Jan 2022 02:00:41 +0100
Received: by mail-wr1-f47.google.com with SMTP id r10so374715wrc.3;
        Thu, 06 Jan 2022 17:00:41 -0800 (PST)
X-Gm-Message-State: AOAM5335hx53U5HKfOMs7M8K3+PYufMuAtr0DC2nSITkFCuZIOAbc+T/
        o3FOM69vDjCVNXG6i3xVgS3UPbHWGqItzuAlFsQ=
X-Google-Smtp-Source: ABdhPJy+QxLYZAEh0tcKnUCPWH2awGby0oPIVh1+zunkAi9c20kfhXGBzIRZmpUDYW3Yto6/u5ecQOGKYn9Oed0f9pA=
X-Received: by 2002:a5d:4651:: with SMTP id j17mr5394152wrs.219.1641517241345;
 Thu, 06 Jan 2022 17:00:41 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641500561.git.christophe.jaillet@wanadoo.fr> <bdcc562c16d2551d6eb87baf557813330de45127.1641500561.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <bdcc562c16d2551d6eb87baf557813330de45127.1641500561.git.christophe.jaillet@wanadoo.fr>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 6 Jan 2022 20:00:38 -0500
X-Gmail-Original-Message-ID: <CAK8P3a1c_jOKX6EQihRY2TmjxMOkXDXDgdv4rUf_6e52+3o2Ag@mail.gmail.com>
Message-ID: <CAK8P3a1c_jOKX6EQihRY2TmjxMOkXDXDgdv4rUf_6e52+3o2Ag@mail.gmail.com>
Subject: Re: [PATCH 08/16] rapidio/tsi721: Remove usage of the deprecated
 "pci-dma-compat.h" API
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matt Porter <mporter@kernel.crashing.org>,
        Alex Bounine <alex.bou9@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:b3f3bLRba7qTq2kT4lU5/vMkdzInvzsiOS8Ar7cIyd0kXMIzeyX
 efKjS9bsSSCCOcf4J3uqygkcj8pkEXPyMRkWQ6CZS3kH0oDtPOWAylHHC+8YCy3Wvpf+TX6
 YYM27lOVp0cpL2YRCJwh1gZgsh/v15NsmisFlM5tY57wXhizOpWYcaCcFBAz9q8v03vbCYo
 zHLBxLhmYwO+Kng305Y+g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nfYHcHTz8G8=:hLei3higSeMShsAvGcmrmn
 NQSKlIdE0l31lqiqvaBvJdbjQOKj0//9HUenyYvKtCj1FP9BWJ8JeWz4jg4U2Iolg8nf0609j
 vrq46QV8CvSsTeV7D+VgPOc7rxva2O8VrEOJqCCVaHV60/YrkC9VoEP+qQ//MAbyG/X/GTU04
 ekobFh02Nzt/OXcaVKRapLbBpMBKoEKvElA4TGOb0fPYRh7lKEjb5cV8N19+9y8ndQC8nlRIS
 oEhJixWW0BGGLbbofYXJoPEeu45KiJuoGzeY4cUeJA/jNMacFsbBibp1fjTosKt+VYwKXiN/0
 hqyslI7Q1+2YwdxKv6ebr3RSoC8GVLrFXydvYKoGBt/VyJ26Q9/DHK6z5hIEhcIRpEyAuHfsQ
 /VaNEN9N4XEHtbuEsr7S+NOljHXH81/gvuWP5cIgeverFv1ZUwTPyzo7Ob2bPSQK31TvtXd8w
 glHhQvW73lgV2DZT9om0tiGuQfJust0RJdnrxQZpEqk9a3ktQ4Zew9Fa1/8Th458vwSZ079QH
 lksQDohOQQ3zZ17zoqWJ9DUXnqPl/uib736qDTg18UaXqsX2Mm2l2gmtVDZgM4p9xuYB1f/Mb
 OK5N7pBeGaHLcRFmnexLFYtKdb4xHYSR9wu1zrmTsdGHfQ64O7YXBn2aWRiWNnWj0MoS4de6i
 PKlev0mSQvse3R8r+r4p4GG35PH8z5QVzkYSxRVPwRYgwyXsWkWUHe5s1aq4+K6BzUhS5HR8U
 gf0WluQppmSi3UocShZDh7Kg/563hdw6oeq8Zyx6BNChJJJ/hj28O+mi/WjCGPhuf+17U+Gfi
 5oCBcBrIAxjkFYeEZLzh9zZ5+g9OMqDlszqGbJ/GSV+nao8HbM=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 6, 2022 at 4:52 PM Christophe JAILLET
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
