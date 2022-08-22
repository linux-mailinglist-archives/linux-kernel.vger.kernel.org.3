Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5A059C3E5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 18:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236026AbiHVQRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 12:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234679AbiHVQRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 12:17:15 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24772399CF;
        Mon, 22 Aug 2022 09:17:15 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id g18so11506936pju.0;
        Mon, 22 Aug 2022 09:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc;
        bh=SpO1ZUZxHjqkqzt3Alck94fcA4kylx6d/PVTjW+B3W0=;
        b=goZ7b8+sezuuKxI9mWamIEjv7pl+YPwrYBbF4DPBRDTkmxfMDwq5pwPO6D2RmdaPOy
         3Akg+DR/eKSPlb5+JoM9QDsT/wME65UKotFq07k7P6bH9mBXx7aL2gZ4TppyRZ9WLFld
         oJkzSYoHvQ5qNnyAs+Qu0kqNKxpSjxiDmGfS9EVXrPEe2lEFI5piuhsGRidU2JMvTy9n
         sYhkmFaac9GGygQbD3pcV9CKyIrIvH46bWSqp6eI7kQKaM4kWrQyEGTOwwM6kc60+BTw
         P8CbkBa8pUjdYEWqPN2XA76RrpdOZKI+6VWgqBPcXe+5zd/wzZpqnm1FX4GWHxWkXDgG
         8QxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc;
        bh=SpO1ZUZxHjqkqzt3Alck94fcA4kylx6d/PVTjW+B3W0=;
        b=lGGMsSnTRyCi8evb6F0aEI84D6Ouph0ee0lzQZW8JYO8zBl/LfSKyAV8gaTU20mdQc
         ZywBbeAlyE5s7GH2X65oW9xa5U+/i+jsCVeOoGIZDZ590vKtPnBvweNcqrAZJnt4WL4d
         wvST367m9ymPWCW/3fGAYQosBjnXMI8RnJtwC4/YHZnOtEkfZ3oFQoiNDned3Hx02I9p
         1adKPu3KX7/8OtAVufkrxdmIBoOZ5LUjQ/CI8aVLcy9fDwyWrKMIbzuTQLzAyXI6mvyj
         FvsnZ5OIgHtcxL/TJyYesZsyfU1fWOqvSipovZMJV4U3x2g1+LJna+sMdSLyxMla2fS7
         toQA==
X-Gm-Message-State: ACgBeo05e1ty1s5LhpUlJxGtPWHhbga7TRlHo/ZAGRk1gz77tImYZL94
        iJhvTfnDozUJaHuLXKSOI3htpiU7Ejs=
X-Google-Smtp-Source: AA6agR5l7xd32VvovzNxuq1MOahelp+er/kaFnUnqzicC35PrwEkZorvAg5n1DCXEKV675INUcFSDA==
X-Received: by 2002:a17:90b:3ec2:b0:1f7:3f49:17c3 with SMTP id rm2-20020a17090b3ec200b001f73f4917c3mr28930679pjb.203.1661185034526;
        Mon, 22 Aug 2022 09:17:14 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e62-20020a621e41000000b0052da33fe7d2sm9071546pfe.95.2022.08.22.09.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 09:17:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 22 Aug 2022 09:17:12 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] hwmon: (dell-smm) Fail probing when cooling device
 registration fails
Message-ID: <20220822161712.GA4098765@roeck-us.net>
References: <20220821151713.11198-1-W_Armin@gmx.de>
 <20220821151713.11198-2-W_Armin@gmx.de>
 <20220821154145.v7da76besv2qzqhj@pali>
 <ea06f15d-cb22-1d5d-9437-59d595e24e43@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ea06f15d-cb22-1d5d-9437-59d595e24e43@gmx.de>
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

On Sun, Aug 21, 2022 at 09:11:24PM +0200, Armin Wolf wrote:
> Am 21.08.22 um 17:41 schrieb Pali Rohár:
> 
> > On Sunday 21 August 2022 17:17:11 Armin Wolf wrote:
> > > Previously, it was thought that failing to register a cooling device
> > > would not be critical, so the probing was not aborted in such a case.
> > > This however would lead to userspace being unable to rely on those
> > > cooling devices, since they might not represent all fans being present.
> > > Fix that by failing probing when cooling device registration fails.
> > This patch does not fix address this issue fully. CONFIG_THERMAL can be
> > disabled during compile time and then cooling device would not be
> > registered too.
> 
> I though of the cooling device feature as being optional "as a whole".
> So when CONFIG_THERMAL is disabled during compile time, the driver does
> not create any cooling devices. If however CONFIG_THERMAL was enabled
> during compile time, the driver should fail probing if it cannot register
> all cooling devices.
> 

I disagree. The primary objective of this driver is to report environmental
data. Support for the thermal subsystem is an add-on. If instantiating
the thermal device fails, the driver should at least report temperatures
and fan speeds, as it did before thermal support was added.

Thanks,
Guenter

> Armin Wolf
> 
> > > Tested on a Dell Inspiron 3505.
> > > 
> > > Fixes: e0d3f7cb2606 ("hwmon: (dell-smm) Add cooling device support")
> > > Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> > > ---
> > >   drivers/hwmon/dell-smm-hwmon.c | 4 +---
> > >   1 file changed, 1 insertion(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> > > index 7f8d95dd2717..1dab7591576a 100644
> > > --- a/drivers/hwmon/dell-smm-hwmon.c
> > > +++ b/drivers/hwmon/dell-smm-hwmon.c
> > > @@ -1013,12 +1013,10 @@ static int __init dell_smm_init_hwmon(struct device *dev)
> > > 
> > >   		data->fan[i] = true;
> > > 
> > > -		/* the cooling device is not critical, ignore failures */
> > >   		if (IS_REACHABLE(CONFIG_THERMAL)) {
> > >   			err = dell_smm_init_cdev(dev, i);
> > >   			if (err < 0)
> > > -				dev_warn(dev, "Failed to register cooling device for fan %u\n",
> > > -					 i + 1);
> > > +				return err;
> > >   		}
> > > 
> > >   		data->fan_nominal_speed[i] = devm_kmalloc_array(dev, data->i8k_fan_max + 1,
> > > --
> > > 2.30.2
> > > 
