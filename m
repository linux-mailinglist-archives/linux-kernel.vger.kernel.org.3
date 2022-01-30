Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E494A36AC
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 15:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355006AbiA3OdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 09:33:15 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50260 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355003AbiA3OdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 09:33:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B92A7B8295F;
        Sun, 30 Jan 2022 14:33:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C93B6C340E4;
        Sun, 30 Jan 2022 14:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643553190;
        bh=TFefdRhPLf81qj1p1gXB2Ss7XyPQr+9Ehf+Zq1TKv1c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hJ7NfX/RF1rTizn+NIJGmFIksXhdfn0cc1dVhJtzyLMpXIgOHuQWKMnxedNH9qw/G
         pdIGes6GclGBaRMhBEn/oNhH8NGreaA2bNBmQLNcRL1NwmXHM2EYZfR1oNq2lYLQXd
         tbZxuzgJmQwqMeLzBWecStl0mFbb3TTTgDgJ5X9Y6NRWuFgSibN+I84ZA2/4hwOkuq
         ko4rH05TBertwgbo+3d5qdiTUULMzIBUqUbztc4DRgWgU+CPinSqy0jCFn/hy71uOf
         hG4ZC0G78lnlGPnB1xO2E9LFbDc7GT1XqsbHLPrxAJQlZqAPjTIS1btALXbIfPh8we
         jzmQixhqGbcog==
Date:   Sun, 30 Jan 2022 14:39:33 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Liam Beguin <liambeguin@gmail.com>, Peter Rosin <peda@axentia.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v12 00/16] iio: afe: add temperature rescaling support
Message-ID: <20220130143933.7711025a@jic23-huawei>
In-Reply-To: <CAHp75VdyujSuTCr_+oFP9t=tardioG69k7uNkBSRAmPvqiyT7w@mail.gmail.com>
References: <20220108205319.2046348-1-liambeguin@gmail.com>
        <CAHp75VdyujSuTCr_+oFP9t=tardioG69k7uNkBSRAmPvqiyT7w@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jan 2022 15:10:36 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sat, Jan 8, 2022 at 10:53 PM Liam Beguin <liambeguin@gmail.com> wrote:
> >
> > Jonathan, Peter, Andy,
> >
> > I left out IIO_VAL_INT overflows for now, so that I can focus on getting
> > the rest of these changes pulled in, but I don't mind adding a patch for
> > that later on.
> >
> > This series focuses on adding temperature rescaling support to the IIO
> > Analog Front End (AFE) driver.
> >
> > The first few patches address minor bugs in IIO inkernel functions, and
> > prepare the AFE driver for the additional features.
> >
> > The main changes to the AFE driver include an initial Kunit test suite,
> > support for IIO_VAL_INT_PLUS_{NANO,MICRO} scales, and support for RTDs
> > and temperature transducer sensors.
> >
> > My apologies Andy for misunderstanding your left-shift comments, I don't
> > know where my head was at... Thanks for your patience!  
> 
> For the patches 1-5
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> Jonathan, perhaps you may apply them, so Liam will have less burden in
> the near future.
> 
done, Patches 1-5 applied to the togreg branch of iio.git and pushed out
as testing for 0-day to see if it can find anything we missed.

I've marked the fixes for stable, but am taking these the slow way
(via next merge window) so as to keep things simple for applying the
rest of the series later this cycle.

I got a bit lost in the discussion but seems there are some minor
requests for changes so I guess I'll see a v13 of patches 6-12.

Thanks,

Jonathan


