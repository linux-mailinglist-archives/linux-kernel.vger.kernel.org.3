Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F773553435
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 16:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350636AbiFUOIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 10:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350568AbiFUOIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 10:08:53 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C75201BB;
        Tue, 21 Jun 2022 07:08:52 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id lw20so5439777ejb.4;
        Tue, 21 Jun 2022 07:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mQG2kFC6sca6rA/f7INQsblCLnW/IWpeSGsMk6bXM4s=;
        b=Ev6nwGN3/gWEcJlfXWIkrbioZNZnAetkcmIeqMDZQxkokhC1RCYup9RU287cRXstmg
         YAM0m4ePeG0Uu4Vy1+SZ3OLpNDL3v8aTFJo/AnAg4uQMnAx3yX0tme3A3R1RsQGMqBGY
         uk+AVb12OM6ge7TFsKuELxTBkRXvuLjwDKo70iIJbLmZT9mNQwrV93lVgygdzgrKOI87
         T0X2jr8OzFhxhmbhiyNi8N/+/xgtpv5tV52jF74A+weZNBBOqBGOcWcad/q2RttgnpbW
         SbQvAZEijJAjjjtdwRhkzf2EuUH69ywAQoTz0AhZYw+RYGxfmGPDROh7Y4vojnK0c2VD
         PsNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mQG2kFC6sca6rA/f7INQsblCLnW/IWpeSGsMk6bXM4s=;
        b=Bej7NUpQrm2gTWlrAKl4U2UQ+azGmbyP9ksZpt7BZ32GugQGg0xcozz2toFrxA+yi2
         yBv98n/Nlj8hioqB7Cj8Ae8t+yeYq9Q7D5ORLEr+0CG5CEQAZSMxAPRm1crJ+JbB51Z7
         zSMnhw33OB+vaLC3LOx+a8fRDQ3JCDwFxfjIKX6kcT49CTw1POmtunQtZ2V3nclSOyui
         3m5j0Kg1Qs9W5kVvnPCpecKMEgXc/NMPxAcw4M1AGYAYSN8ufmPRFaHWgQq/22baZ2CF
         zJrhIgV+P27+flsde9ppPB4nsUVLA69GIloV8dUZWbP+ZeFv+0VKB2dRpwEmBx4xj16j
         cYEQ==
X-Gm-Message-State: AJIora+RBdCdky+MlwNZrXHtHbAXRQ1MKlZqCRACuGpwMBXDpCV0v9h4
        4Y4rJPOUFsfsjFd44AlviD3bcW41MRFAym2vDTs=
X-Google-Smtp-Source: AGRyM1srtXDuySbBqeVGVmkAovCjNpTRwOL5wi5lPmSzkEF81MAKsve+VnUWQo9PXtsGZV8pX4Apl/RXh6bLTxP8/R0=
X-Received: by 2002:a17:906:434f:b0:711:eb76:c320 with SMTP id
 z15-20020a170906434f00b00711eb76c320mr25938171ejm.636.1655820530793; Tue, 21
 Jun 2022 07:08:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220621092319.69598-1-jiangjian@cdjrlc.com>
In-Reply-To: <20220621092319.69598-1-jiangjian@cdjrlc.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 21 Jun 2022 16:08:14 +0200
Message-ID: <CAHp75Veau14x1_8oauUZ=d4TxqJ9wcRyAQF6dR9YrwuTKjP3rQ@mail.gmail.com>
Subject: Re: [PATCH] iio: dac: ad5380: aligned '*' each line and drop unneeded
 blank line
To:     Jiang Jian <jiangjian@cdjrlc.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
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

On Tue, Jun 21, 2022 at 11:26 AM Jiang Jian <jiangjian@cdjrlc.com> wrote:
>
> Consider '*' alignment in the comments of struct ad5380_chip_info declaration.

Next time don't forget to bump the version of the patch (use -vX, X =
0,1, ..., with the `git format-patch`) and add a changelog (after
cutter '---' line).

> ...
> >   * @channel_template:  channel specification template
> >   * @num_channels:      number of channels
> >   * @int_vref:          internal vref in uV
> > -*/
> > + */
> >
> While at it, drop the unneeded blank line here.
> >  struct ad5380_chip_info {
> ...
> }

This should be replaced by something simpler, like:
While at it, drop the unneeded blank lines.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

I do not think you need to resend this simplest patch and Jonathan
will help you this time, but consider the above for future
contributions, thanks!

> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
> ---
>  drivers/iio/dac/ad5380.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/iio/dac/ad5380.c b/drivers/iio/dac/ad5380.c
> index a44c83242fb1..81775152aac6 100644
> --- a/drivers/iio/dac/ad5380.c
> +++ b/drivers/iio/dac/ad5380.c
> @@ -36,8 +36,7 @@
>   * @channel_template:  channel specification template
>   * @num_channels:      number of channels
>   * @int_vref:          internal vref in uV
> -*/
> -
> + */
>  struct ad5380_chip_info {
>         struct iio_chan_spec    channel_template;
>         unsigned int            num_channels;
> @@ -53,7 +52,6 @@ struct ad5380_chip_info {
>   * @pwr_down:          whether the chip is currently in power down mode
>   * @lock:              lock to protect the data buffer during regmap ops
>   */
> -
>  struct ad5380_state {
>         struct regmap                   *regmap;
>         const struct ad5380_chip_info   *chip_info;
> --
> 2.17.1
>


--
With Best Regards,
Andy Shevchenko
