Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A005865DB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 09:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiHAHti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 03:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiHAHtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 03:49:35 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CBF2CCAC;
        Mon,  1 Aug 2022 00:49:30 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id z16so12977028wrh.12;
        Mon, 01 Aug 2022 00:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc;
        bh=80kzzCCf8nSB2K9ysggA6x3/LL6kj+g+teROcEIMGYw=;
        b=QlOtf3AEZn8nEsSBwh9H1z28Flbsb6f5IsC7X8XPc3HtEuOAqCVRhMJWa4U24gbGQU
         0BGfKgMLc+0eHndENJtDasM7OfMJ6JGFpwBPn4dGwHz18womYJfq0na/XVLzuUklS4sP
         nl/4DLWVbX8l55jQEWW9+1sEUN73QDvtcuA2N+D26hGr3cvJ4wEtKDd6tDaSWW0rCsjD
         Zh4vLADYIuoG7IXl7LAmqggbcKlFHu4brJAVMPXKJhFbnClOC+rqGbOlV/VO3YviHwQK
         28UyrAzGle+berYo5+hH2QIrWbopCmC7Puq6Y8B+Pk3+iD4Z6x9vDdqJu0Oy6tnd4x1Z
         WwzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=80kzzCCf8nSB2K9ysggA6x3/LL6kj+g+teROcEIMGYw=;
        b=hQ770YE2rmHNL1bumipq/EWrIwsfaJZ/9CfoAcL/17kyjc6vaNJT/bkbSEA32wtViu
         qFdKPblPh+K3DlFUHproP112QaXTWA0zl6z6sUfnx4ixTqKQ/RmvFHQnGvtJ3pbqOPas
         90cw7keLL01Rv33uSSBOybVl7oaLReQX69+NqrCvvCbWpAaHtIGGhYk9VB1H0uEAYF6t
         X3J4qhfz0LT1XJAHT9Zkw1v/8SkZIU340iutqWcHOs2LlXShAa50oLq+Ls8SUXRrLU1X
         +NGTQLcfEAyFabb7XjNSTKUWO/44OwHeKfNoYgoUCOQ+L2UuQj/uptN/ig0jyMzeZpel
         KTNQ==
X-Gm-Message-State: ACgBeo2J2AQNGhYjGVv6q81MH78uWYVs8XjP9eJQrUeuuvo0IdtyjYQy
        jb7iq0s3fL46AhW/DUtwvZU=
X-Google-Smtp-Source: AA6agR5UTMhYNUo2cYw5asmEKX7+xloE9PdHB+erSXmewShDSr8SnMJC7jJpVFCyvvHFnkheq9gW3w==
X-Received: by 2002:a05:6000:16ce:b0:21e:8450:1b6a with SMTP id h14-20020a05600016ce00b0021e84501b6amr9654055wrf.372.1659340169249;
        Mon, 01 Aug 2022 00:49:29 -0700 (PDT)
Received: from [192.168.1.126] (68.201.26.77.dynamic.reverse-mundo-r.com. [77.26.201.68])
        by smtp.gmail.com with ESMTPSA id ba4-20020a0560001c0400b002205f0890eesm4289959wrb.77.2022.08.01.00.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 00:49:28 -0700 (PDT)
Message-ID: <accfa892cb938d72b0090085f520c0d5aa55c0d6.camel@gmail.com>
Subject: Re: [PATCH v4 4/5] iio: pressure: bmp280: Add support for BMP380
 sensor family
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 01 Aug 2022 09:49:27 +0200
In-Reply-To: <CAHp75VdQ_oCjyXsXxTEWfKJK=T+OOP=AEXz8KQq5b2Hu8VHy9w@mail.gmail.com>
References: <cover.1658597501.git.ang.iglesiasg@gmail.com>
         <50841287411a4e459487cc94a05bc6de66be4acf.1658597501.git.ang.iglesiasg@gmail.com>
         <CAHp75VdQ_oCjyXsXxTEWfKJK=T+OOP=AEXz8KQq5b2Hu8VHy9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.module_f35+14217+587aad52) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On lun, 2022-07-25 at 23:15 +0200, Andy Shevchenko wrote:
> On Sat, Jul 23, 2022 at 7:40 PM Angel Iglesias <ang.iglesiasg@gmail.com>
> wrote:
> > 
> > Adds compatibility with the new generation of this sensor, the BMP380
> > 
> > Includes basic sensor initialization to do pressure and temp
> > measurements and allows tuning oversampling settings for each channel.
> > 
> > The compensation algorithms are adapted from the device datasheet and
> > the repository https://github.com/BoschSensortec/BMP3-Sensor-API
> 
> ...
> 
> > +       /* wait for 2ms for command to be proccessed */
> 
> processed
> 
> > +       dev_dbg(data->dev, "Command 0x%X proccessed successfully\n", cmd);
> 
> Ditto. Can you run a spell checker? Kernel has a little one called codespell.

Once again, my typos strike back! I didn't know of this tool, I only checked
format issues using the script check_patch.pl

> > +
> > +       return 0;
> > +}
> 
> ...
> 
> > +static s32 bmp380_compensate_temp(struct bmp280_data *data, u32 adc_temp)
> > +{
> > +       s64 var1, var2, var3, var4, var5, var6, comp_temp;
> > +       struct bmp380_calib *calib = &data->calib.bmp380;
> > +
> > +       var1 = ((s64) adc_temp) - (((s64) calib->T1) << 8);
> > +       var2 = var1 * ((s64) calib->T2);
> > +       var3 = var1 * var1;
> > +       var4 = var3 * ((s64) calib->T3);
> > +       var5 = (var2 << 18) + var4;
> > +       var6 = var5 >> 32;
> > +       data->t_fine = (s32) var6;
> > +       comp_temp = (var6 * 25) >> 14;
> > +
> > +       comp_temp = clamp_val(comp_temp, BMP380_MIN_TEMP, BMP380_MAX_TEMP);
> > +       return (s32) comp_temp;
> > +}
> 
> ...
> 
> > +       s64 var1, var2, var3, var4, var5, var6, offset, sensitivity;
> > +       u64 comp_press;
> > +       struct bmp380_calib *calib = &data->calib.bmp380;
> > +
> > +       var1 = ((s64)data->t_fine) * ((s64)data->t_fine);
> > +       var2 = var1 >> 6;
> > +       var3 = (var2 * ((s64) data->t_fine)) >> 8;
> > +       var4 = (((s64)calib->P8) * var3) >> 5;
> > +       var5 = (((s64) calib->P7) * var1) << 4;
> > +       var6 = (((s64) calib->P6) * ((s64)data->t_fine)) << 22;
> > +       offset = (((s64)calib->P5) << 47) + var4 + var5 + var6;
> > +       var2 = (((s64)calib->P4) * var3) >> 5;
> > +       var4 = (((s64) calib->P3) * var1) << 2;
> > +       var5 = (((s64) calib->P2) - ((s64) 1<<14)) *
> > +               (((s64)data->t_fine) << 21);
> > +       sensitivity = ((((s64) calib->P1) - ((s64) 1 << 14)) << 46) +
> > +                       var2 + var4 + var5;
> > +       var1 = (sensitivity >> 24) * ((s64)adc_press);
> > +       var2 = ((s64)calib->P10) * ((s64) data->t_fine);
> > +       var3 = var2 + (((s64) calib->P9) << 16);
> > +       var4 = (var3 * ((s64)adc_press)) >> 13;
> > +
> > +       /*
> > +        * Dividing by 10 followed by multiplying by 10 to avoid
> > +        * possible overflow caused by (uncomp_data->pressure *
> > partial_data4)
> > +        */
> > +       var5 = (((s64)adc_press) * (var4 / 10)) >> 9;
> > +       var5 *= 10;
> > +       var6 = ((s64)adc_press) * ((s64)adc_press);
> > +       var2 = (((s64)calib->P11) * var6) >> 16;
> > +       var3 = (var2 * ((s64)adc_press)) >> 7;
> > +       var4 = (offset >> 2) + var1 + var5 + var3;
> > +       comp_press = ((u64)var4 * 25) >> 40;
> 
> 
> Kbuild bot is right, you forgot to (compile-)test for a 32-bit machine.

Oh I see. Thanks for heads up, I only tested arm64 and x86_64 archs.

> ...
> 
> > +       ret = regmap_bulk_read(data->regmap, BMP380_REG_TEMP_XLSB, data-
> > >buf, 3);
> 
> sizeof() ?
> 
> ...
> 
> > +       /* Read and compensate temperature so we get a reading of t_fine. */
> 
> for temperature
> 
> ...
> 
> > +       ret = regmap_bulk_read(data->regmap, BMP380_REG_PRESS_XLSB, data-
> > >buf, 3);
> 
> sizeof() ?
> 
> ...
> 
> > +       .oversampling_temp_default = ilog2(1),
> 
> > +       .oversampling_press_default = ilog2(4),
> 
> BIT()

I preserved previous committer use of ilog2() to recover the index value as it
is done on bmp280_write_oversampling_* functions, but you're right, is better to
initialize using BIT() macros.

> ...
> ´
> > +#define BMP380_REG_CMD                 0x7E
> > +#define BMP380_REG_CONFIG              0x1F
> > +#define BMP380_REG_ODR                 0X1D
> > +#define BMP380_REG_OSR                 0X1C
> > +#define BMP380_REG_POWER_CONTROL       0X1B
> > +#define BMP380_REG_IF_CONFIG           0X1A
> > +#define BMP380_REG_INT_CONTROL         0X19
> > +#define BMP380_REG_INT_STATUS          0X11
> > +#define BMP380_REG_EVENT               0X10
> > +#define BMP380_REG_STATUS              0X03
> > +#define BMP380_REG_ERROR               0X02
> > +#define BMP380_REG_ID                  0X00
> > +
> > +#define BMP380_REG_FIFO_CONFIG_1       0X18
> > +#define BMP380_REG_FIFO_CONFIG_2       0X17
> > +#define BMP380_REG_FIFO_WATERMARK_MSB  0X16
> > +#define BMP380_REG_FIFO_WATERMARK_LSB  0X15
> > +#define BMP380_REG_FIFO_DATA           0X14
> > +#define BMP380_REG_FIFO_LENGTH_MSB     0X13
> > +#define BMP380_REG_FIFO_LENGTH_LSB     0X12
> > +
> > +#define BMP380_REG_SENSOR_TIME_MSB     0X0E
> > +#define BMP380_REG_SENSOR_TIME_LSB     0X0D
> > +#define BMP380_REG_SENSOR_TIME_XLSB    0X0C
> > +
> > +#define BMP380_REG_TEMP_MSB            0X09
> > +#define BMP380_REG_TEMP_LSB            0X08
> > +#define BMP380_REG_TEMP_XLSB           0X07
> > +
> > +#define BMP380_REG_PRESS_MSB           0X06
> > +#define BMP380_REG_PRESS_LSB           0X05
> > +#define BMP380_REG_PRESS_XLSB          0X04
> > +
> > +#define BMP380_REG_CALIB_TEMP_START    0x31
> 
> Be consistent x vs X (we prefer x).
> 
Sorry about that


As always, thank you for your comments,

Kind regards,
Angel


