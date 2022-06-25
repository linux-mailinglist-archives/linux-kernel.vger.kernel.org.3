Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5785E55AA61
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 15:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbiFYNRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 09:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbiFYNRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 09:17:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2020011821;
        Sat, 25 Jun 2022 06:17:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4AA5612CB;
        Sat, 25 Jun 2022 13:17:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641EDC3411C;
        Sat, 25 Jun 2022 13:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656163024;
        bh=EQ5NzjxPicxRp5lCLKniHD4eu7yQO6P2W6htjFIhPvo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oNKh52OCnc31NiXe1GV1IVpnKRb03djN/vdb0EGtjIegIo1BGnsdA9aMFihL5Ak1d
         6KBakA5oxES5lSMArs9M+KgHNR84Ty3R2yWpDAYZ+A7rjy8nVsLmu4Qmg8RXng0Km/
         0VbXRxWOEdiwaWVPRnSfJNhabxbqUEy6WeHWoqrxoN8goScd2aORNwATDP8QVDKXmU
         R8xDqhPLCTZD597FDJZ8ay+kv3s6s4SA+zPyqNk9RKPGWckLs61i6oOyXax9vZkQe+
         dTqaJFa5Nmt2EySO13vQzkmn64S01t9xHhXorrW8fi+L5b0G5wm8dglZRncGWz8IZZ
         uBOihqtn2BaxQ==
Date:   Sat, 25 Jun 2022 14:26:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jiang Jian <jiangjian@cdjrlc.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: dac: ad5380: aligned '*' each line and drop
 unneeded blank line
Message-ID: <20220625142632.1d0201a1@jic23-huawei>
In-Reply-To: <CAHp75Veau14x1_8oauUZ=d4TxqJ9wcRyAQF6dR9YrwuTKjP3rQ@mail.gmail.com>
References: <20220621092319.69598-1-jiangjian@cdjrlc.com>
        <CAHp75Veau14x1_8oauUZ=d4TxqJ9wcRyAQF6dR9YrwuTKjP3rQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2022 16:08:14 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Jun 21, 2022 at 11:26 AM Jiang Jian <jiangjian@cdjrlc.com> wrote:
> >
> > Consider '*' alignment in the comments of struct ad5380_chip_info declaration.  
> 
> Next time don't forget to bump the version of the patch (use -vX, X =
> 0,1, ..., with the `git format-patch`) and add a changelog (after
> cutter '---' line).
> 
> > ...  
> > >   * @channel_template:  channel specification template
> > >   * @num_channels:      number of channels
> > >   * @int_vref:          internal vref in uV
> > > -*/
> > > + */
> > >  
> > While at it, drop the unneeded blank line here.  
> > >  struct ad5380_chip_info {  
> > ...
> > }  
> 
> This should be replaced by something simpler, like:
> While at it, drop the unneeded blank lines.
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> I do not think you need to resend this simplest patch and Jonathan
> will help you this time, but consider the above for future
> contributions, thanks!
Tweaked and applied to the togreg branch of iio.git which I'll
push out initially as testing to let the 0-day bot poke it.

Thanks,

Jonathan

> 
> > Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
> > ---
> >  drivers/iio/dac/ad5380.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/drivers/iio/dac/ad5380.c b/drivers/iio/dac/ad5380.c
> > index a44c83242fb1..81775152aac6 100644
> > --- a/drivers/iio/dac/ad5380.c
> > +++ b/drivers/iio/dac/ad5380.c
> > @@ -36,8 +36,7 @@
> >   * @channel_template:  channel specification template
> >   * @num_channels:      number of channels
> >   * @int_vref:          internal vref in uV
> > -*/
> > -
> > + */
> >  struct ad5380_chip_info {
> >         struct iio_chan_spec    channel_template;
> >         unsigned int            num_channels;
> > @@ -53,7 +52,6 @@ struct ad5380_chip_info {
> >   * @pwr_down:          whether the chip is currently in power down mode
> >   * @lock:              lock to protect the data buffer during regmap ops
> >   */
> > -
> >  struct ad5380_state {
> >         struct regmap                   *regmap;
> >         const struct ad5380_chip_info   *chip_info;
> > --
> > 2.17.1
> >  
> 
> 
> --
> With Best Regards,
> Andy Shevchenko

