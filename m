Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373785A5122
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 18:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiH2QLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 12:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiH2QLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 12:11:39 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBBC7AC27;
        Mon, 29 Aug 2022 09:11:37 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 142so8641251pfu.10;
        Mon, 29 Aug 2022 09:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=ZLJprdSF7B9VmDv96y32lbC/nxnuJtlLWqkvWQJI7GM=;
        b=QNoZpQoksuaTayMbMPSS3WlcUO5QtSSqmsHxgSUZ65MnrVcKCcxL6MKypW/+cwyXni
         2+Ovg7HruU//xwKfY1FLHjMrN1SAYBJ+Dt3RIA/DzwhtlAUTfIOQSN7vbCCeNxqhj5X6
         tNgMymMaB4Br9JUZB65cYaxzLfzXbdIUIWcMzOL7QQbfClprpG9BCTxw8Kn+BWUMQNOE
         4WKpXmY8ZVi1rQcqu+rngsayxfqe+68g/znOhSzbR7GVs5/R+JeBZiOkNdrucnpg2crb
         wIbyR4P8uD18rrtj6FSPiyw2gaXOOaFAHrqUTobKhBe9CoBmJNpomdIFM0mtgMaTuPuI
         /gfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=ZLJprdSF7B9VmDv96y32lbC/nxnuJtlLWqkvWQJI7GM=;
        b=PY9tbUsqrerOoSFcD2S4feR35QK1e+1ThJefbj3smBHPeAbAMJmi8Qr9pC7P0OGh8Q
         IM+I7GjMQkfbB24BLjJie7p+fg2/eGEnIAm/D+skKRq5YZC5HjQnFBoxjODrPmHb/GPz
         AhI+skcbGbRqhDfh6iDxyMjuJg+766nV8KLhYlSZFtp4pMML16bRfakTfpWLnX6jdKDh
         m/L0dNpsiYR3gHpg8IsD7w9zFvbUQjhpsX25EXGMDeBtUMbgTPiDL6krU2xevh6dNmlk
         3MzcewfKpFS1rm+mM3hv7U9N0sz4E7ePUnUM/3v2HgcY4PiSYkF+25AjZGiusg7Tl9yv
         yp4A==
X-Gm-Message-State: ACgBeo1/hPQs5Z2RGOnnE2qaJuexxtXGwk9w8FnL5TTQ5rDBJLQIar3X
        U6M4A9Wo0by2Y1Gw4NTZXX8=
X-Google-Smtp-Source: AA6agR7Ue+C+yLLKp7/pE8ChoOX6D+a1sm8YZkdo4UfIDyMYoqHe0yfr71HJxLEPtJENEwOfQfub0g==
X-Received: by 2002:a63:4621:0:b0:429:f162:555e with SMTP id t33-20020a634621000000b00429f162555emr14299561pga.63.1661789497044;
        Mon, 29 Aug 2022 09:11:37 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p66-20020a625b45000000b0052e5bb18a41sm7384266pfb.58.2022.08.29.09.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 09:11:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 29 Aug 2022 09:11:35 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Justin Ledford <justinledford@google.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (max31790) add fanN_enable
Message-ID: <20220829161135.GB1320973@roeck-us.net>
References: <20220829024351.2415147-1-justinledford@google.com>
 <20220829132017.GA3039965@roeck-us.net>
 <CAHCvCEcGvrS=3p2Whj0Cmx9sx+aSzX2097LahQ=f3eRCCAN_bA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHCvCEcGvrS=3p2Whj0Cmx9sx+aSzX2097LahQ=f3eRCCAN_bA@mail.gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 08:09:21AM -0700, Justin Ledford wrote:
> The tach input isn't enabled in the device by default. So the only way
> to start using the fan input sensors is to set the regulator mode
> through the driver to RPM mode and then back to whatever mode you
> actually want to use. The I2C interface to the device doesn't couple
> the tach input to the regulator mode so I don't think it makes sense
> for the driver to do this either.
> 
Please don't top-post.

The above does not answer my question why fan_config[] wound need to
be updated repeatedly.

Guenter

> On Mon, Aug 29, 2022 at 6:20 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On Mon, Aug 29, 2022 at 02:43:51AM +0000, Justin Ledford wrote:
> > > The MAX31790 has a tach input enable bit in each fan's configuration
> > > register. This is only enabled by the driver if RPM mode is selected,
> > > but the driver doesn't provide a way to independently enable tachometer
> > > input regardless of the regulator mode.
> > >
> > > By adding the fanN_enable sysfs files, we can decouple the tach input
> > > from the regulator mode. Also update the documentation.
> > >
> > > Signed-off-by: Justin Ledford <justinledford@google.com>
> > > ---
> > >  Documentation/hwmon/max31790.rst |  1 +
> > >  drivers/hwmon/max31790.c         | 44 +++++++++++++++++++++++++++-----
> > >  2 files changed, 38 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/Documentation/hwmon/max31790.rst b/Documentation/hwmon/max31790.rst
> > > index 7b097c3b9b90..33c5c7330efc 100644
> > > --- a/Documentation/hwmon/max31790.rst
> > > +++ b/Documentation/hwmon/max31790.rst
> > > @@ -38,6 +38,7 @@ Sysfs entries
> > >  fan[1-12]_input    RO  fan tachometer speed in RPM
> > >  fan[1-12]_fault    RO  fan experienced fault
> > >  fan[1-6]_target    RW  desired fan speed in RPM
> > > +fan[1-6]_enable    RW  enable or disable the tachometer input
> > >  pwm[1-6]_enable    RW  regulator mode, 0=disabled (duty cycle=0%), 1=manual mode, 2=rpm mode
> > >  pwm[1-6]           RW  read: current pwm duty cycle,
> > >                         write: target pwm duty cycle (0-255)
> > > diff --git a/drivers/hwmon/max31790.c b/drivers/hwmon/max31790.c
> > > index 7e9362f6dc29..3ae02be4b41e 100644
> > > --- a/drivers/hwmon/max31790.c
> > > +++ b/drivers/hwmon/max31790.c
> > > @@ -118,6 +118,12 @@ static struct max31790_data *max31790_update_device(struct device *dev)
> > >                                       goto abort;
> > >                               data->target_count[i] = rv;
> > >                       }
> > > +
> > > +                     rv = i2c_smbus_read_byte_data(client,
> > > +                                     MAX31790_REG_FAN_CONFIG(i));
> > > +                     if (rv < 0)
> > > +                             goto abort;
> > > +                     data->fan_config[i] = rv;
> >
> > Why is this needed ?
> >
> > Guenter
> >
> > >               }
> > >
> > >               data->last_updated = jiffies;
> > > @@ -202,6 +208,9 @@ static int max31790_read_fan(struct device *dev, u32 attr, int channel,
> > >               }
> > >               mutex_unlock(&data->update_lock);
> > >               return 0;
> > > +     case hwmon_fan_enable:
> > > +             *val = !!(data->fan_config[channel] & MAX31790_FAN_CFG_TACH_INPUT_EN);
> > > +             return 0;
> > >       default:
> > >               return -EOPNOTSUPP;
> > >       }
> > > @@ -214,7 +223,7 @@ static int max31790_write_fan(struct device *dev, u32 attr, int channel,
> > >       struct i2c_client *client = data->client;
> > >       int target_count;
> > >       int err = 0;
> > > -     u8 bits;
> > > +     u8 bits, fan_config;
> > >       int sr;
> > >
> > >       mutex_lock(&data->update_lock);
> > > @@ -243,6 +252,23 @@ static int max31790_write_fan(struct device *dev, u32 attr, int channel,
> > >                                       MAX31790_REG_TARGET_COUNT(channel),
> > >                                       data->target_count[channel]);
> > >               break;
> > > +     case hwmon_fan_enable:
> > > +             fan_config = data->fan_config[channel];
> > > +             if (val == 0) {
> > > +                     fan_config &= ~MAX31790_FAN_CFG_TACH_INPUT_EN;
> > > +             } else if (val == 1) {
> > > +                     fan_config |= MAX31790_FAN_CFG_TACH_INPUT_EN;
> > > +             } else {
> > > +                     err = -EINVAL;
> > > +                     break;
> > > +             }
> > > +             if (fan_config != data->fan_config[channel]) {
> > > +                     err = i2c_smbus_write_byte_data(client, MAX31790_REG_FAN_CONFIG(channel),
> > > +                                                     fan_config);
> > > +                     if (!err)
> > > +                             data->fan_config[channel] = fan_config;
> > > +             }
> > > +             break;
> > >       default:
> > >               err = -EOPNOTSUPP;
> > >               break;
> > > @@ -270,6 +296,10 @@ static umode_t max31790_fan_is_visible(const void *_data, u32 attr, int channel)
> > >                   !(fan_config & MAX31790_FAN_CFG_TACH_INPUT))
> > >                       return 0644;
> > >               return 0;
> > > +     case hwmon_fan_enable:
> > > +             if (channel < NR_CHANNEL)
> > > +                     return 0644;
> > > +             return 0;
> > >       default:
> > >               return 0;
> > >       }
> > > @@ -423,12 +453,12 @@ static umode_t max31790_is_visible(const void *data,
> > >
> > >  static const struct hwmon_channel_info *max31790_info[] = {
> > >       HWMON_CHANNEL_INFO(fan,
> > > -                        HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
> > > -                        HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
> > > -                        HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
> > > -                        HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
> > > -                        HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
> > > -                        HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
> > > +                        HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT | HWMON_F_ENABLE,
> > > +                        HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT | HWMON_F_ENABLE,
> > > +                        HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT | HWMON_F_ENABLE,
> > > +                        HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT | HWMON_F_ENABLE,
> > > +                        HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT | HWMON_F_ENABLE,
> > > +                        HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT | HWMON_F_ENABLE,
> > >                          HWMON_F_INPUT | HWMON_F_FAULT,
> > >                          HWMON_F_INPUT | HWMON_F_FAULT,
> > >                          HWMON_F_INPUT | HWMON_F_FAULT,
> > > --
> > > 2.37.2.672.g94769d06f0-goog
> > >
