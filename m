Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0EA6590FA2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 12:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238380AbiHLKr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 06:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238131AbiHLKrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 06:47:24 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BD99C52B;
        Fri, 12 Aug 2022 03:47:23 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id v5so420019wmj.0;
        Fri, 12 Aug 2022 03:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc;
        bh=lxAxMPZxgmQtDQtE+oJRxaulsge/j6wRSfGnBdmPeUs=;
        b=KHfGfVw+MUDzp8/oFMh5H/GKhNeyNSm9LNMFCJD5vt0lGyy/jt9iDr7gvVUQjMV6Ae
         TmLR9Y0PM6MTHfpRIE3McDaiTXdLzd6pBmAlSx5A/rLfG/sHVQdEFxrEd3kOeh4Z1ti1
         QnNslgJVDRGqfxoIAJF1NSLguAirb4lyZxCc5lIweCY17FlRKO7jkP+IGWv1qzsila9y
         IW3YT/DOs6KIjZMFqhIn3rv35hgZxOiOoLgL4E+AdYgyxkkNuMdM7GuJ+6rovBPVT33r
         yr0Sh+XmWBkT+UsYj7AGDprOP5OOAvcRk1PReyNI4Tqj+PdOx9gkX7m1ySqryFrZ83b3
         YAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=lxAxMPZxgmQtDQtE+oJRxaulsge/j6wRSfGnBdmPeUs=;
        b=A4dMbqsQnpCwJLD7AUXHc+XtFKJhfQP7FeYIAWdhfLU1x3jkHjD+q4Fyb0oiKn7Y28
         I1Olh93Bl6KAsuyXs+XKDQmazLZXG5x2km8uHka+zqVIG3/mI0gl2vRQW447AkOn1vVm
         3rovBCD2ZOOdATahTVXmHMK4yt/YQSJc+PHN8t1bkR81/9ESc9dGgF82oF6x9RYsk7QU
         LBnnjlaXnl5PawPb0W6iYF14EvtIhwNug2HCfo56ArHb9wCcDbwe7HS0CBR55Baowm9J
         Ji6t/XFSgCU/FjX0C13CqRVe9VQgmFGggI0oGHCCOoxLghpkkERBXj+JpBPjhH++CNfz
         80Ww==
X-Gm-Message-State: ACgBeo24mxtr6Py805pB6TKSqpdBa7RqaZHzSIzcqMxbf4YlZUtq5+Yg
        Z2r0/ukNm/q50DflB9kB3c4=
X-Google-Smtp-Source: AA6agR6hxx0ZGvoWmAtkREfac96ggJ1X8fc4X84WxGkyzC4ZfZ5/jV5GqcRJS9ShyPj/7fCRRvd7yA==
X-Received: by 2002:a7b:cc90:0:b0:3a5:3899:7be1 with SMTP id p16-20020a7bcc90000000b003a538997be1mr2192394wma.19.1660301241977;
        Fri, 12 Aug 2022 03:47:21 -0700 (PDT)
Received: from [192.168.90.166] (188.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.188])
        by smtp.gmail.com with ESMTPSA id a20-20020a5d4574000000b0021f15514e7fsm2109485wrc.0.2022.08.12.03.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 03:47:21 -0700 (PDT)
Message-ID: <61774fbafd3ce64a93d94202a77d242e8001778a.camel@gmail.com>
Subject: Re: [PATCH v5 3/5] iio: pressure: bmp280: Add support for BMP380
 sensor family
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 12 Aug 2022 12:47:20 +0200
In-Reply-To: <CAHp75VexAQ5BQEyoAJq9r8uY1MussTy12bUyLd5z6GtJSbf0NQ@mail.gmail.com>
References: <cover.1659872590.git.ang.iglesiasg@gmail.com>
         <462251c4bca30b53f06307043ad52d859eb8d5c1.1659872590.git.ang.iglesiasg@gmail.com>
         <CAHp75VexAQ5BQEyoAJq9r8uY1MussTy12bUyLd5z6GtJSbf0NQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.module_f35+14217+587aad52) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On lun, 2022-08-08 at 11:08 +0200, Andy Shevchenko wrote:
> On Sun, Aug 7, 2022 at 1:56 PM Angel Iglesias <ang.iglesiasg@gmail.com> wrote:
> > 
> > Adds compatibility with the new generation of this sensor, the BMP380
> > 
> > Includes basic sensor initialization to do pressure and temp
> > measurements and allows tuning oversampling settings for each channel.
> > 
> > The compensation algorithms are adapted from the device datasheet and
> > the repository https://github.com/BoschSensortec/BMP3-Sensor-API
> 
> Missed period.
> 
> ...
> 
> >   *
> > https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMP180-DS000-121.pdf
> >   *
> > https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMP280-DS001-12.pdf
> >   *
> > https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BME280_DS001-11.pdf
> 
> Seems like the above links are unresponsive now? Perhaps you may fix
> them as well in a separate patch?

Sure. Should I include this patch in this next version of this series, or should
I send the patch as a standalone change?

> > + *
> > https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmp388-ds001.pdf
> 
> ...
> 
> > +/* See datasheet Section 3.11.1. */
> 
> Again, a bit of consistency in (one-line) comments, please.
> 
> > +struct bmp380_calib {
> > +       u16 T1;
> > +       u16 T2;
> > +       s8  T3;
> > +       s16 P1;
> > +       s16 P2;
> > +       s8  P3;
> > +       s8  P4;
> > +       u16 P5;
> > +       u16 P6;
> > +       s8  P7;
> > +       s8  P8;
> > +       s16 P9;
> > +       s8  P10;
> > +       s8  P11;
> > +};
> 
> __packed ?
> 
> ...
> 
> > +/* Send a command to BMP3XX sensors */
> 
> > +       /* check if device is ready to process a command */
> > +       /* send command to process */
> > +       /* wait for 2ms for command to be processed */
> > +       /* check for command processing error */
> 
> Consistency, please!
> 
> ...
> 
> > +       dev_dbg(data->dev, "Command 0x%X processed successfully\n", cmd);
> 
> Useless.
> 
> ...
> 
> > +/*
> > + * Returns temperature in DegC, resolution is 0.01 DegC.  Output value of
> 
> DegC?! Perhaps "Celsius degrees"?
> 
> > + * "5123" equals 51.23 DegC.  t_fine carries fine temperature as global
> > + * value.
> > + *
> > + * Taken from datasheet, Section Appendix 9, "Compensation formula" and
> > repo
> > + * https://github.com/BoschSensortec/BMP3-Sensor-API
> 
> Missed period.
> 
> > + */
> 
> ...
> 
> > +       return (s32) comp_temp;
> 
> Do you need casting?
> 
> ...
> 
> > +/*
> > + * Returns pressure in Pa as unsigned 32 bit integer in fractional Pascal.
> 
> an unsigned
> 32-bit
> 
> > + * Output value of "9528709" represents 9528709/100 = 95287.09 Pa =
> > 952.8709 hPa
> > + *
> > + * Taken from datasheet, Section 9.3. "Pressure compensation" and
> > repository
> > + * https://github.com/BoschSensortec/BMP3-Sensor-API
> 
> Missed period.
> 
> > + */
> 
> ...
> 
> > +       var1 = ((s64)data->t_fine) * ((s64)data->t_fine);
> 
> Too many parentheses?

Yup, operator precedence of typecast precedes multiplication.

> ...
> 
> > +       /*
> > +        * Dividing by 10 followed by multiplying by 10 to avoid
> > +        * possible overflow caused by (uncomp_data->pressure *
> > partial_data4)
> 
> Missed period.
> 
> > +        */
> 
> ...
> 
> > +       return (u32)comp_press;
> 
> Do you need casting?

Not really, should fall on the implicit conversion rules of the compiler as it
works like an assignment, right?. Also, after shifting 40 bits to the right,
there's no risk of overflow, comp_press can be a u32 from the start instead of a
u64.

> ...
> 
> > +               /* reading was skipped */
> 
> The useless comment.
> 
> > +               dev_err(data->dev, "reading pressure skipped\n");
> 
> ...
> 
> > +       /* Compensated pressure is in cPa (centipascals) */
> > +       *val2 = 100000;
> 
> Anything to use from units.h?
> 
> ...
> 
> > +       ret = regmap_write_bits(data->regmap, BMP380_REG_OSR,
> > +                               BMP380_OSRS_TEMP_MASK |
> > BMP380_OSRS_PRESS_MASK,
> > +                               osrs);
> > +       if (ret < 0) {
> 
> Do all these ' < 0' parts make any sense?

I've checked regmap calls and return 0 when call is successful, so the answer is
no

> > +       }
> 
> ...
> 
> > +       { .compatible = "bosch,bmp380", .data = (void *)BMP380_CHIP_ID },
> >         { .compatible = "bosch,bme280", .data = (void *)BME280_CHIP_ID },
> >         { .compatible = "bosch,bmp280", .data = (void *)BMP280_CHIP_ID },
> >         { .compatible = "bosch,bmp180", .data = (void *)BMP180_CHIP_ID },
> 
> See below.
> 
> ...
> 
> > +       {"bmp380", BMP380_CHIP_ID },
> >         {"bmp280", BMP280_CHIP_ID },
> >         {"bmp180", BMP180_CHIP_ID },
> >         {"bmp085", BMP180_CHIP_ID },
> 
> Can we actually keep them forward-ordered? (Add 380 after 280 here and
> in a separate patch sort the rest, or other way around, sort as a
> prerequisite patch)

Sure!

> ...
> 
> > +#define BMP380_MIN_TEMP                        -4000
> > +#define BMP380_MAX_TEMP                        8500
> > +#define BMP380_MIN_PRES                        3000000
> > +#define BMP380_MAX_PRES                        12500000
> 
> Units?

Units as in I should use units.h constants or also comment in which units are
these constants?

> 
> --
> With Best Regards,
> Andy Shevchenko

Kind regards,
Angel

