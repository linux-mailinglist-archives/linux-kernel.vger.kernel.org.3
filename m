Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2019855879B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 20:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbiFWSdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 14:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237565AbiFWSdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 14:33:02 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48433515AE;
        Thu, 23 Jun 2022 10:34:35 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id u12so42536257eja.8;
        Thu, 23 Jun 2022 10:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=StaOvFslk0m+dKjepijTVYAfivMfIONPjbCLyZTW4N4=;
        b=ppoAqXTrOEh7t1yD6clZoj2QYqGpEfRfaUPEbprI4huv/LwzstWKH+TRw7yP7LIlD1
         srxISJP4erkJSkXBAvSPfRYMVs0jv2SLhy70QQk/l1fkKrsNxM+RLJwpGBIURELxSuLW
         qPXz9Hk2CevAWZyFeJoTh+0T0hcpj/Iri+RTwNZPmlVUvR/74THS2o14h85h+XxQA30j
         Rja4f9GJ2DdMH2ydNwRxY7Vq4jUcq8EvAYfasZj/r9YRYbg8e3BS3tkpwRq+m1CyOKQU
         NLGa+Z+IwbIzW0sizAVKx9TdkHPcvsQpm5sIEaghD6LgfFF60ZW4jqkaRNYiHLvvHzUe
         d6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=StaOvFslk0m+dKjepijTVYAfivMfIONPjbCLyZTW4N4=;
        b=SERMOHvIZDmhNvDOdVVNmHi3HCavQPooE6E/Ubf0KUSKZY1duxtwBPom3urVhJKhg5
         T81xz79p6EchnmBJq20lZxuftfSfZWQWK/H0snC9bdZQyKDQ8ZyNFUNhak+hXUcazhx/
         lqYSOYtHgz/21JXIZi/1upKxD+n+Aq/am/flNz3pnELQm8s7gWp9J5fcS5Z2bcPXTViG
         QzHHUZ29TdrR63WShW/IPbBZfXWs9FLGOTnHTMdwbVaU4Bk7SlmRlIkcuudjQLlm4Amj
         1v+at4MfYRGslGXT3shMEIDOtt4ZxXbSS54vAJnFg0b9iSRFe9sOSiViVu8dauPMCPvC
         TWuw==
X-Gm-Message-State: AJIora9Xge+KglS1JAxH/CyTHmnSx3jb/v/EYaM7KNlniv0WLphB8IOS
        /U7Y25wSYL8ByxZRInXJOhoYZF22Hf7i6wJSBfaQyhJJ2W5SAA==
X-Google-Smtp-Source: AGRyM1vgwgYNmYAbTlPj5EBqvUwvQ4xZRF6kkTNk8PmhpEDTStQku06Gc0Vam6zA78Y9OXdkGSCDWJBgwyM9Wl2Zi28=
X-Received: by 2002:a17:907:9620:b0:722:fc5e:3259 with SMTP id
 gb32-20020a170907962000b00722fc5e3259mr6150250ejc.579.1656005662167; Thu, 23
 Jun 2022 10:34:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220620162059.1097264-1-cosmin.tanislav@analog.com>
 <20220620162059.1097264-3-cosmin.tanislav@analog.com> <CAHp75VcBJkQ+CwyoDaTJ_AD+mv9d0tEd_txqHwkPRy4-xvnyKg@mail.gmail.com>
 <2aa93eab-de6d-866b-a829-36b47ff00982@gmail.com> <CAHp75Vc_fcAP6gGwMkYZUoMM6jKeUoQr8J+zYCUz8inSHnTF_w@mail.gmail.com>
 <54bfff70-938f-16e1-198d-47ed9ba95db4@gmail.com>
In-Reply-To: <54bfff70-938f-16e1-198d-47ed9ba95db4@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 23 Jun 2022 19:33:45 +0200
Message-ID: <CAHp75VeRgnCLP0YqiOe8OkW3hQ178ia+Y3PjFtCMW4Sh7JfCZQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] iio: adc: ad4130: add AD4130 driver
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
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

On Thu, Jun 23, 2022 at 6:14 PM Cosmin Tanislav <demonsingur@gmail.com> wrote:
> On 6/23/22 18:39, Andy Shevchenko wrote:
> > On Thu, Jun 23, 2022 at 5:27 PM Cosmin Tanislav <demonsingur@gmail.com> wrote:
> >> On 6/20/22 21:29, Andy Shevchenko wrote:
> >>> On Mon, Jun 20, 2022 at 6:27 PM Cosmin Tanislav <demonsingur@gmail.com> wrote:

...

> >>>> +       /*
> >>>> +        * DMA (thus cache coherency maintenance) requires the
> >>>> +        * transfer buffers to live in their own cache lines.
> >>>> +        */
> >>>
> >>> This is a good comment, but what fields does it apply to?
> >>
> >> Whatever is below it, grouped together. This is not hard to
> >> understand.
> >
> > It's hard to understand what exactly is DMA-aware here. I see only one
> > buffer that is aligned properly for DMA, the rest are not, except the
> > case if all of them are going in one DMA transaction. Is this the case
> > here?
> >
> >>>> +       u8                      reset_buf[AD4130_RESET_BUF_SIZE] __aligned(IIO_DMA_MINALIGN);
> >
> > This is aligned.
> >
> >>>> +       u8                      reg_write_tx_buf[4];
> >
> > This one is aligned + offset (== AD4130_RESET_BUF_SIZE + 0).
> >
> >>>> +       u8                      reg_read_tx_buf[1];
> >
> > This one is aligned + offset (== AD4130_RESET_BUF_SIZE + 0 + 4).
> >
> >>>> +       u8                      reg_read_rx_buf[3];
> >
> > This one is aligned + offset (== AD4130_RESET_BUF_SIZE + 0 + 4 + 1).
> > And this is Rx.
> >
> >>>> +       u8                      fifo_tx_buf[2];
> >
> > Here is Tx again which is most likely is not aligned...
> >
> >>>> +       u8                      fifo_rx_buf[AD4130_FIFO_SIZE *
> >>>> +                                           AD4130_FIFO_MAX_SAMPLE_SIZE];
> >>>> +};
> >
>
> This has been mentioned before by Jonathan as a reply to V6 of my
> AD74413R driver.
>
>  > I'm surprised I didn't mention this before but you only need to
> ensure  > that any memory used for DMA is not in a cacheline with memory
> used
>  > for other things that might change concurrently.
>
> To my understanding, as long as the DMA buffers will all be accessed by
> the same DMA-compatible SPI controller, you only need to align them so
> they're not in the same cacheline with memory that will not be accessed
> by the SPI controller.

SPI is synchronous by nature, what will happen if the Tx and Rx
buffers are sharing the same cache line? Anybody to shed a light here?

(I.o.w. I'm not sure that we don't need to split the Rx and Tx buffers
of the same transfer.)

-- 
With Best Regards,
Andy Shevchenko
