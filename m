Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A35487353
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 08:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbiAGHKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 02:10:10 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36346 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233511AbiAGHKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 02:10:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 455FE61F00;
        Fri,  7 Jan 2022 07:10:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3023C36AEB;
        Fri,  7 Jan 2022 07:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641539407;
        bh=Uhul5yfTlK51NvXqmK+aJv/o9GFXVvISZlskunMwVPw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A1BXTvBzhvz5BYVJNRiFgUFgHt1n93t7Vw8bBDRvvCbAWUSyCGApyI5k2Jhv6Gg30
         ifXzT2LyYV0MCnr0ekV3XEj+cTwjwnIqHrH6QloHVJd6CBMhpqOUE7oSzT5SqRB7S2
         D795jEmWsdnfcN30eP5FRKffmOgEtwttDK0r1Sgr114QURpR/C2uyXnCyKBQrhC2Kl
         pWNY+xU+64pY9h90ic2oH112rFrIqCc1BjemMEZd9ni3KJESgDrVQRFZlSfLNqERAM
         Iqr17qBDIdnOWakNBdLtqOO1UiZagEYFL42vUxazNgPeU7QSqJ3T6eEOkgSQLrj2eU
         ZLUGARrkJCoSw==
Date:   Fri, 7 Jan 2022 08:10:03 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        awalls@md.metrocast.net,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH 04/16] media: Remove usage of the deprecated
 "pci-dma-compat.h" API
Message-ID: <20220107081003.63c7cea6@coco.lan>
In-Reply-To: <CAK8P3a0w51bnDy2whAC8WOCx2=9UB1ViX3veOfhSmQwwLr3VNQ@mail.gmail.com>
References: <cover.1641500561.git.christophe.jaillet@wanadoo.fr>
        <e89f4b29b9f7e0c711a3ccc16a009f49f416e1fc.1641500561.git.christophe.jaillet@wanadoo.fr>
        <CAK8P3a0w51bnDy2whAC8WOCx2=9UB1ViX3veOfhSmQwwLr3VNQ@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 6 Jan 2022 19:51:47 -0500
Arnd Bergmann <arnd@arndb.de> escreveu:

> On Thu, Jan 6, 2022 at 4:50 PM Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
> >
> > In [1], Christoph Hellwig has proposed to remove the wrappers in
> > include/linux/pci-dma-compat.h.
> >
> > Some reasons why this API should be removed have been given by Julia
> > Lawall in [2].
> >
> > A coccinelle script has been used to perform the needed transformation.
> > It can be found in [3].
> >
> > [1]: https://lore.kernel.org/kernel-janitors/20200421081257.GA131897@infradead.org/
> > [2]: https://lore.kernel.org/kernel-janitors/alpine.DEB.2.22.394.2007120902170.2424@hadrien/
> > [3]: https://lore.kernel.org/kernel-janitors/20200716192821.321233-1-christophe.jaillet@wanadoo.fr/
> >
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>  
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> Mauro, could you pick this up directly? It has no dependencies on the rest of
> the series.

Sure, but I already closed the media merge window. If you prefer to
apply it directly via your tree, that would be OK for me as well.
If so, just let me know. On such case:

Acked-by: Mauro Carvalho Chehab <mchehab@kernel.org>

Regards,
Mauro
