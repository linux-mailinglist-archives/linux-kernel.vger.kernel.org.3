Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D16503649
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 13:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbiDPLSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 07:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbiDPLR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 07:17:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9A6377FD;
        Sat, 16 Apr 2022 04:15:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BA4B60E99;
        Sat, 16 Apr 2022 11:15:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A895DC385A5;
        Sat, 16 Apr 2022 11:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650107724;
        bh=nqtzCAVG0UydeJj9805KTNz5rLFTdeSKGY2+Q6Dlv4k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=K+2dJ9pFOvsCgPHvg2S0S3x366hrjxBuSmjcsqUiS9p72g3EW0juNGCqpdL86ne4T
         MjOu7YszoKpmLWSUOMXdSfzXKBX594H9cwF4evc/r9gSO6xo3+JGt2/0l8g1HWIk4F
         n0n1QlN4xII1Yao19ZLH7czyqaFwIhgOdwwVRrv8BUQgMQlFUg0jImftfoVuBKMqeE
         q3LdFkVbxgXu3/S5T7WPHZfpksGMxZ5KldpcQq+JPqXTX1E3uQ1rmgrroMZClUGoP9
         iVWbwtWMYgHtQim1ovjFVL3d9OVlDDhRcfmRh5F0W47w6JMFBNuXHOeSSzxAVasYt/
         Ey49IWzqDZNeQ==
Date:   Sat, 16 Apr 2022 12:23:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH] iio: adc: Kconfig: Make RZG2L_ADC depend on ARCH_RZG2L
Message-ID: <20220416122322.7aa14706@jic23-huawei>
In-Reply-To: <CAMuHMdViXg2ZpKG+fJJyMjA_uY-7Tu2E1WwWed97OX5LOMq4tQ@mail.gmail.com>
References: <20220406070315.13862-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
        <20220410174713.1a4e013f@jic23-huawei>
        <CAMuHMdViXg2ZpKG+fJJyMjA_uY-7Tu2E1WwWed97OX5LOMq4tQ@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Apr 2022 16:40:20 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Jonathan,
> 
> On Sun, Apr 10, 2022 at 7:52 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > On Wed,  6 Apr 2022 08:03:15 +0100
> > Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> >  
> > > ADC block is common on Renesas RZ/G2L and RZ/V2L SoC's, so instead of
> > > adding dependency for each SoC's add dependency on ARCH_RZG2L. The
> > > ARCH_RZG2L config option is already selected by ARCH_R9A07G044 and
> > > ARCH_R9A07G054.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>  
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Applied. Thanks,

Jonathan

> 
> > Sounds like a fix?
> >
> > If so, please supply a Fixes tag.
> > no need to resend, just reply with one to this email.  
> 
> This is not really a fix, as the original dependency was correct at
> that time.
> This is a change to add support for the RZ/V2L (r9a07g054) SoC, and
> avoiding the need to update the dependencies when support is added
> for more SoCs of the RZ/G2L family later.
> 
> > > --- a/drivers/iio/adc/Kconfig
> > > +++ b/drivers/iio/adc/Kconfig
> > > @@ -910,7 +910,7 @@ config ROCKCHIP_SARADC
> > >
> > >  config RZG2L_ADC
> > >       tristate "Renesas RZ/G2L ADC driver"
> > > -     depends on ARCH_R9A07G044 || COMPILE_TEST
> > > +     depends on ARCH_RZG2L || COMPILE_TEST
> > >       help
> > >         Say yes here to build support for the ADC found in Renesas
> > >         RZ/G2L family.  
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

