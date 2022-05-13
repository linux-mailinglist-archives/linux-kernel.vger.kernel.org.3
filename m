Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6066F526AF2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 22:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384099AbiEMUG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 16:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384047AbiEMUGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 16:06:51 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23D72F3A9
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:06:44 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id y19so11517976ljd.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bAlNLNPG8lCLz/0bJ8LE4u2RCdPn2myNbje+Y5Tx6fE=;
        b=ZNRxrZXPyfEcNgJIxGvFJFMYkrrdpRSzO+EvUjKrOaLJur7BO/Mf8HbmyYtbuWejrD
         RKMUynKfGI1JYtA9Us0vEFH65yOknWb7IFGHy5xikMhSF6iPX8RI72siknl32HhuKJPM
         faShExDuxMLj2PwwS1SpNts/aIxBJu7j/U7+8PwlWjyXKz+BrVfaRCxh47mPVuudAQTb
         0sGRanbU4roHxX9RD4mZsH/IoJdWSpfY0oCtamf1eMZ1EUxil5L5MQ2vOwjvBCiWJEdB
         mWXvvzVjKBD2j+Vh4RF3euwbSjMtx2bpZVaPHxav5/9PAoZiXTLT+MMrI/6KNyLxVtfH
         fEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bAlNLNPG8lCLz/0bJ8LE4u2RCdPn2myNbje+Y5Tx6fE=;
        b=L3+KBfjFrFWSsa0NiriIUmWedq8IKiY5PFliu/mPM8rR4JVhgSo9bnEszvG3s7AVJT
         GvU/j9SaeQ54BO8zpTaCkYGmJwzbJy03iLqEREaVKXe71vYlJY0ku7ZRqzNfNaUeedVd
         sux9d/NM3f0MBq2mHDbdR/p0UQ3oLBxWh449/C0jUshKipCs72cRyQZzgFeB/c9m9Ghj
         auDBo/FjF4voi5rxNQDObiowjyhSkuaMKXZxIrMu56wwoOcBWVze5H6JQrlc/FA83fki
         PqPyDQ6tjGCOIXOYK/Etny36siRw3kJvK29UzxNxWobx7JKfADp81M3cA44dO18xVTSk
         oVyw==
X-Gm-Message-State: AOAM530Wrvz4NtbuDiCKU5yr/UxbqtY9kzHQwvyoGA8G7KipasPaiPJi
        UaG6ChE9OVqI9McKGVBD3PdhnygdW7fnySBwCtH9zw==
X-Google-Smtp-Source: ABdhPJz0MyqDCm9mdJFea0YzwEqjBf5cHU3OHI2pNw5dBEwCq/KJyFPe6mum1yYUpT6ZLAplaTWmmMuSB50Wv7FU+74=
X-Received: by 2002:a05:651c:a12:b0:250:5abe:4ec4 with SMTP id
 k18-20020a05651c0a1200b002505abe4ec4mr3976051ljq.4.1652472403010; Fri, 13 May
 2022 13:06:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220304105656.149281-1-ulf.hansson@linaro.org>
 <CAPDyKFr1PzSaiKqB4ZoqTS_8bGsEH=aB3ARhxyGu+cYeRqeBew@mail.gmail.com>
 <20220504054652.GA7851@math.uni-bielefeld.de> <CAPDyKFrBVyYx+BybGR2P8paS6qA=V2EHAXH+vPUc9JzxoXn6+g@mail.gmail.com>
 <20220511064617.GA28982@math.uni-bielefeld.de>
In-Reply-To: <20220511064617.GA28982@math.uni-bielefeld.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 13 May 2022 22:06:05 +0200
Message-ID: <CAPDyKFrGCrC6fc+VDJGhCiM8nSiu8M-NeM+UGMUPERt2aeLTbg@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Restore (almost) the busy polling for MMC_SEND_OP_COND
To:     Jean Rene Dawin <jdawin@math.uni-bielefeld.de>
Cc:     "H . Nikolaus Schaller" <hns@goldelico.com>,
        Huijin Park <huijin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 May 2022 at 08:46, Jean Rene Dawin
<jdawin@math.uni-bielefeld.de> wrote:
>
> Ulf Hansson wrote on Wed  4/05/22 11:08:
> > On Wed, 4 May 2022 at 07:46, Jean Rene Dawin
> > <jdawin@math.uni-bielefeld.de> wrote:
> > >
> > > Ulf Hansson wrote on Mon  7/03/22 13:17:
> > > > On Fri, 4 Mar 2022 at 11:57, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > >
> > > > > Commit 76bfc7ccc2fa ("mmc: core: adjust polling interval for CMD1"),
> > > > > significantly decreased the polling period from ~10-12ms into just a couple
> > > > > of us. The purpose was to decrease the total time spent in the busy polling
> > > > > loop, but unfortunate it has lead to problems, that causes eMMC cards to
> > > > > never gets out busy and thus fails to be initialized.
> > > > >
> > > > > To fix the problem, but also to try to keep some of the new improved
> > > > > behaviour, let's start by using a polling period of 1-2ms, which then
> > > > > increases for each loop, according to common polling loop in
> > > > > __mmc_poll_for_busy().
> > > > >
> > > > > Reported-by: Jean Rene Dawin <jdawin@math.uni-bielefeld.de>
> > > > > Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
> > > > > Cc: Huijin Park <huijin.park@samsung.com>
> > > > > Fixes: 76bfc7ccc2fa ("mmc: core: adjust polling interval for CMD1")
> > > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > > ---
> > > > >
> > > > > Jean Rene and H. Nikolaus, if this doesn't work, please try extending the
> > > > > the MMC_OP_COND_PERIOD_US a bit, to so see if we can find a value that always
> > > > > works.
> > > > >
> > > > > Kind regards
> > > > > Uffe
> > >
> > > >
> > > > Applied for fixes and by adding two tested-by tags from you, thanks!
> > > >
> > > > Kind regards
> > > > Uffe
> > >
> > > Hi,
> > >
> > > with the current value of MMC_OP_COND_PERIOD_US = 1ms I still see
> > >
> > > mmc1: Card stuck being busy! __mmc_poll_for_busy
> > > mmc1: error -110 doing runtime resume
> > >
> > > regularly. The same with 2ms. Setting it to 4ms makes the messages go
> > > away. Would it be ok to increase MMC_OP_COND_PERIOD_US to 4ms?
> >
> > It doesn't look like we have a very good alternative - unless the
> > problem is tied to a particular type of eMMC card, is it? (If so, we
> > can add a card-quirk).
> >
> > The only other option I see, would then be to add a generic DT
> > property for eMMCs, that allows us to specify the OP_COND polling
> > period for it. See
> > Documentation/devicetree/bindings/mmc/mmc-card.yaml.
> >
> > Kind regards
> > Uffe
>
> Hi,
>
> I tested 2 beaglebones now - one with Micron eMMC and the other with Kingston.
> With the Kingston chip I don't get the errors. So it seems to be card specific.
>
> Grepping for mmc in dmesg gives the following.
>
> Beaglebone with Micron eMMC:
>
>   sdhci-omap 481d8000.mmc: supply pbias not found, using dummy regulator
>   sdhci-omap 481d8000.mmc: supply vqmmc not found, using dummy regulator
>   mmc1: SDHCI controller on 481d8000.mmc [481d8000.mmc] using External DMA
>   mmc1: new high speed MMC card at address 0001
>   mmcblk1: mmc1:0001 MMC04G 3.66 GiB
>    mmcblk1: p1
>   mmcblk1boot0: mmc1:0001 MMC04G 1.00 MiB
>   mmcblk1boot1: mmc1:0001 MMC04G 1.00 MiB
>   mmcblk1rpmb: mmc1:0001 MMC04G 128 KiB, chardev (247:0)
>   sdhci-omap 48060000.mmc: Got CD GPIO
>   sdhci-omap 48060000.mmc: supply pbias not found, using dummy regulator
>   sdhci-omap 48060000.mmc: supply vqmmc not found, using dummy regulator
>   mmc0: SDHCI controller on 48060000.mmc [48060000.mmc] using External DMA
>
>
> Beaglebone with Kingston eMMC:
>
>   sdhci-omap 481d8000.mmc: supply pbias not found, using dummy regulator
>   sdhci-omap 481d8000.mmc: supply vqmmc not found, using dummy regulator
>   mmc1: SDHCI controller on 481d8000.mmc [481d8000.mmc] using External DMA
>   mmc1: new high speed MMC card at address 0001
>   mmcblk1: mmc1:0001 M62704 3.56 GiB
>    mmcblk1: p1
>   mmcblk1boot0: mmc1:0001 M62704 2.00 MiB
>   mmcblk1boot1: mmc1:0001 M62704 2.00 MiB
>   mmcblk1rpmb: mmc1:0001 M62704 512 KiB, chardev (247:0)
>   sdhci-omap 48060000.mmc: Got CD GPIO
>   sdhci-omap 48060000.mmc: supply pbias not found, using dummy regulator
>   sdhci-omap 48060000.mmc: supply vqmmc not found, using dummy regulator
>   mmc0: SDHCI controller on 48060000.mmc [48060000.mmc] using External DMA
>
> Is this enough information to identify the mmc card?

Thanks for running the tests and sharing this information.

One thing that I realized, again, is that you seem to be encountering
the problem only during re-initialization (at runtime resume of the
eMMC card), but I guess, at least theoretically, you could meet the
same problem during the first initialization (boot). At this point we
can't use a card quirk, simply because we don't know anything about
the card yet.

That said, I think we should change the MMC_OP_COND_PERIOD_US to 4ms,
to make sure it works for all cases. Do you want to send a patch for
this - or just tell me if you prefer me to do it!?

Additionally, for those eMMC cards that can cope with a smaller
polling period, we could add a new generic DT property for the eMMC
card (Documentation/devicetree/bindings/mmc/mmc-card.yaml). In this
way we can avoid regressing eMMC initializations in general, but at
the same time allow those cards/platforms that can cope with a smaller
timeout, to specify and use this to decrease the initialization time.

Kind regards
Uffe
