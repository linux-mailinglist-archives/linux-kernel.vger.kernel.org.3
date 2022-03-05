Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF2C4CE4D6
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 13:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbiCEMkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 07:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiCEMkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 07:40:17 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF19F63BCA;
        Sat,  5 Mar 2022 04:39:26 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id gb39so22716179ejc.1;
        Sat, 05 Mar 2022 04:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ziVlNME90XkjVCUOc4D/WI9RHYcSooGFrcTvyny9BL8=;
        b=CiLsz+Z/mFV0v2uCLfoVi/IF2pVrLSTsJlm08TDTzjBXHiOPH3/i/Dr/0x2I7UXn2i
         1twmlm9fSlPLpbuIDgocNtgSYf9UVEvKtf2a041oWFNnwMW1ei3lB8OSpNhP1e9vtFtU
         vPCtXmtEildmLSv+biMTaM+IEM9FIuNn0vgiIGS0fUI1Jjyiv4s30Kb8gn2OZlQwJdqL
         u91x7DKTHIHwMWCXObo3nq8pAUeYbdWeALUVXSGoQG7CRgkYg9LgvnmWdNFQcXkzHfRb
         vGALOstYHe/HZugGmu5YHCz2PFEMmIDgNK6WnIse7H+XizwWn4gKd5FDS/O6199WHSd6
         oW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ziVlNME90XkjVCUOc4D/WI9RHYcSooGFrcTvyny9BL8=;
        b=JG6dMY8MeoWmLt/RBmj5gBHPTQefToEttfcmo9dSZxSI2eoHcQAzJ43jUdlRWEOw32
         EQNgDv2Y4Q+moXnSGJLjUGdZKS8PP3gVmVaTFce2WOnv97o9UxlfLq1524ZjeiviPITK
         aZUoaXbgPVKkP8E6TSAPlPGhUruS8OEEV44Jlk6ANXwcQQ5XN9kivx/RsZ5rAs4qmEI3
         qGOgV3zz6PxiGMOg5CrHnEfMH6IFFzLW048aLiyAkuZRjfQuEQ/JeuJSKeDypWenCtm6
         +KX+sEiuJd0GXvtiuqWZzb8L0Z7bKxHJHIN88NcZSgnSQnE+OKdVBDStSLw/MWNwpwuX
         ZT8w==
X-Gm-Message-State: AOAM532AdbD5VjRZFhfHAFYs/MS1Eqo4PZmxFoZXPZQM8cFkZeStZv1H
        zt1RTmfpsuTWpZGE764JJ7c=
X-Google-Smtp-Source: ABdhPJz1YuGZoTM1x0GJ1AWBZxVtm3Rk4xiJJ5gyn+BQAuoD7dad8m4BhNE0B4r7XX3zR+vpEmhmGQ==
X-Received: by 2002:a17:906:2991:b0:6cf:1fd4:39a3 with SMTP id x17-20020a170906299100b006cf1fd439a3mr2704852eje.21.1646483964936;
        Sat, 05 Mar 2022 04:39:24 -0800 (PST)
Received: from ?IPv6:2001:a61:2ae0:801:d90b:c312:2baa:2aa3? ([2001:a61:2ae0:801:d90b:c312:2baa:2aa3])
        by smtp.gmail.com with ESMTPSA id l2-20020a1709066b8200b006bbea7e566esm2841650ejr.55.2022.03.05.04.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 04:39:24 -0800 (PST)
Message-ID: <f5277691fad2a7a5330353ac38ccaf7111d5b084.camel@gmail.com>
Subject: Re: [PATCH v4 3/3] iio: temperature: ltc2983: Make use of device
 properties
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Date:   Sat, 05 Mar 2022 13:39:23 +0100
In-Reply-To: <20220304180257.80298-3-andriy.shevchenko@linux.intel.com>
References: <20220304180257.80298-1-andriy.shevchenko@linux.intel.com>
         <20220304180257.80298-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
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

On Fri, 2022-03-04 at 20:02 +0200, Andy Shevchenko wrote:
> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.
> 
> The conversion slightly changes the logic behind property reading for
> the configuration values. Original code allocates just as much memory
> as needed. Then for each separate 32- or 64-bit value it reads it
> from
> the property and converts to a raw one which will be fed to the
> sensor.
> In the new code we allocate the amount of memory needed to retrieve
> all
> values at once from the property and then convert them as required.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Tested-by: Nuno Sá <nuno.sa@analog.com>
> ---
> v4: added checks for error pointer (Nuno), added Tb tag (Nuno)
> v3: no changes
> 

Hi Andy,

Just small observation/question from my side...

>  drivers/iio/temperature/ltc2983.c | 209 +++++++++++++++-------------
> --
>  1 file changed, 106 insertions(+), 103 deletions(-)
> 
> diff --git a/drivers/iio/temperature/ltc2983.c
> b/drivers/iio/temperature/ltc2983.c
> index 636bbc9011b9..6971e8828d44 100644
> --- a/drivers/iio/temperature/ltc2983.c
> +++ b/drivers/iio/temperature/ltc2983.c
> @@ -12,11 +12,15 @@
>  #include <linux/iio/iio.h>
>  #include <linux/interrupt.h>
>  #include <linux/list.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> -#include <linux/of_gpio.h>
> +#include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/spi/spi.h>
>  
> +#include <asm/byteorder.h>
> +#include <asm/unaligned.h>
> +
>  /* register map */
>  #define LTC2983_STATUS_REG                     0x0000
>  #define LTC2983_TEMP_RES_START_REG             0x0010
> @@ -219,7 +223,7 @@ struct ltc2983_sensor {
>  
>  struct ltc2983_custom_sensor {
>         /* raw table sensor data */
> -       u8 *table;
> +       void *table;
>         size_t size;
>         /* address offset */
>         s8 offset;
> @@ -377,25 +381,25 @@ static int
> __ltc2983_chan_custom_sensor_assign(struct ltc2983_data *st,
>         return regmap_bulk_write(st->regmap, reg, custom->table,
> custom->size);
>  }
>  
> -static struct ltc2983_custom_sensor *__ltc2983_custom_sensor_new(
> -                                               struct ltc2983_data
> *st,
> -                                               const struct
> device_node *np,
> -                                               const char *propname,
> -                                               const bool
> is_steinhart,
> -                                               const u32 resolution,
> -                                               const bool
> has_signed)
> +static struct ltc2983_custom_sensor *
> +__ltc2983_custom_sensor_new(struct ltc2983_data *st, const struct
> fwnode_handle *fn,
> +                           const char *propname, const bool
> is_steinhart,
> +                           const u32 resolution, const bool
> has_signed)
>  {
>         struct ltc2983_custom_sensor *new_custom;
> -       u8 index, n_entries, tbl = 0;
>         struct device *dev = &st->spi->dev;
>         /*
>          * For custom steinhart, the full u32 is taken. For all the
> others
>          * the MSB is discarded.
>          */
>         const u8 n_size = is_steinhart ? 4 : 3;
> -       const u8 e_size = is_steinhart ? sizeof(u32) : sizeof(u64);
> +       u8 index, n_entries;
> +       int ret;
>  
> -       n_entries = of_property_count_elems_of_size(np, propname,
> e_size);
> +       if (is_steinhart)
> +               n_entries = fwnode_property_count_u32(fn, propname);
> +       else
> +               n_entries = fwnode_property_count_u64(fn, propname);
>         /* n_entries must be an even number */
>         if (!n_entries || (n_entries % 2) != 0) {
>                 dev_err(dev, "Number of entries either 0 or not
> even\n");
> @@ -423,21 +427,33 @@ static struct ltc2983_custom_sensor
> *__ltc2983_custom_sensor_new(
>         }
>  
>         /* allocate the table */
> -       new_custom->table = devm_kzalloc(dev, new_custom->size,
> GFP_KERNEL);
> +       if (is_steinhart)
> +               new_custom->table = devm_kcalloc(dev, n_entries,
> sizeof(u32), GFP_KERNEL);
> +       else
> +               new_custom->table = devm_kcalloc(dev, n_entries,
> sizeof(u64), GFP_KERNEL);
>         if (!new_custom->table)
>                 return ERR_PTR(-ENOMEM);
>  
> -       for (index = 0; index < n_entries; index++) {
> -               u64 temp = 0, j;
> -               /*
> -                * Steinhart sensors are configured with raw values
> in the
> -                * devicetree. For the other sensors we must convert
> the
> -                * value to raw. The odd index's correspond to
> temperarures
> -                * and always have 1/1024 of resolution. Temperatures
> also
> -                * come in kelvin, so signed values is not possible
> -                */
> -               if (!is_steinhart) {
> -                       of_property_read_u64_index(np, propname,
> index, &temp);
> +       /*
> +        * Steinhart sensors are configured with raw values in the
> firmware
> +        * node. For the other sensors we must convert the value to
> raw.
> +        * The odd index's correspond to temperatures and always have
> 1/1024
> +        * of resolution. Temperatures also come in Kelvin, so signed
> values
> +        * are not possible.
> +        */
> +       if (is_steinhart) {
> +               ret = fwnode_property_read_u32_array(fn, propname,
> new_custom->table, n_entries);
> +               if (ret < 0)
> +                       return ERR_PTR(ret);
> +
> +               cpu_to_be32_array(new_custom->table, new_custom-
> >table, n_entries);
> +       } else {
> +               ret = fwnode_property_read_u64_array(fn, propname,
> new_custom->table, n_entries);
> +               if (ret < 0)
> +                       return ERR_PTR(ret);
> +
> +               for (index = 0; index < n_entries; index++) {
> +                       u64 temp = ((u64 *)new_custom->table)[index];
>  
>                         if ((index % 2) != 0)
>                                 temp = __convert_to_raw(temp, 1024);
> @@ -445,16 +461,9 @@ static struct ltc2983_custom_sensor
> *__ltc2983_custom_sensor_new(
>                                 temp = __convert_to_raw_sign(temp,
> resolution);
>                         else
>                                 temp = __convert_to_raw(temp,
> resolution);
> -               } else {
> -                       u32 t32;
>  
> -                       of_property_read_u32_index(np, propname,
> index, &t32);
> -                       temp = t32;
> +                       put_unaligned_be24(temp, new_custom->table +
> index * 3);
>                 }
> -
> -               for (j = 0; j < n_size; j++)
> -                       new_custom->table[tbl++] =
> -                               temp >> (8 * (n_size - j - 1));
>         }
>  
>         new_custom->is_steinhart = is_steinhart;
> @@ -597,13 +606,12 @@ static int ltc2983_adc_assign_chan(struct
> ltc2983_data *st,
>         return __ltc2983_chan_assign_common(st, sensor, chan_val);
>  }
>  
> -static struct ltc2983_sensor *ltc2983_thermocouple_new(
> -                                       const struct device_node
> *child,
> -                                       struct ltc2983_data *st,
> -                                       const struct ltc2983_sensor
> *sensor)
> +static struct ltc2983_sensor *
> +ltc2983_thermocouple_new(const struct fwnode_handle *child, struct
> ltc2983_data *st,
> +                        const struct ltc2983_sensor *sensor)
>  {
>         struct ltc2983_thermocouple *thermo;
> -       struct device_node *phandle;
> +       struct fwnode_handle *ref;
>         u32 oc_current;
>         int ret;
>  
> @@ -611,11 +619,10 @@ static struct ltc2983_sensor
> *ltc2983_thermocouple_new(
>         if (!thermo)
>                 return ERR_PTR(-ENOMEM);
>  
> -       if (of_property_read_bool(child, "adi,single-ended"))
> +       if (fwnode_property_read_bool(child, "adi,single-ended"))
>                 thermo->sensor_config = LTC2983_THERMOCOUPLE_SGL(1);
>  
> -       ret = of_property_read_u32(child, "adi,sensor-oc-current-
> microamp",
> -                                  &oc_current);
> +       ret = fwnode_property_read_u32(child, "adi,sensor-oc-current-
> microamp", &oc_current);
>         if (!ret) {
>                 switch (oc_current) {
>                 case 10:
> @@ -651,10 +658,11 @@ static struct ltc2983_sensor
> *ltc2983_thermocouple_new(
>                 return ERR_PTR(-EINVAL);
>         }
>  
> -       phandle = of_parse_phandle(child, "adi,cold-junction-handle",
> 0);
> -       if (phandle) {
> -               ret = of_property_read_u32(phandle, "reg",
> -                                          &thermo-
> >cold_junction_chan);
> +       ref = fwnode_find_reference(child, "adi,cold-junction-
> handle", 0);
> +       if (IS_ERR_OR_NULL(ref)) {
> +               ref = NULL;
> +       } else {
> +               ret = fwnode_property_read_u32(ref, "reg", &thermo-
> >cold_junction_chan);
>                 if (ret) {
>                         /*
>                          * This would be catched later but we can
> just return
> @@ -682,41 +690,41 @@ static struct ltc2983_sensor
> *ltc2983_thermocouple_new(
>         thermo->sensor.fault_handler =
> ltc2983_thermocouple_fault_handler;
>         thermo->sensor.assign_chan =
> ltc2983_thermocouple_assign_chan;
>  
> -       of_node_put(phandle);
> +       fwnode_handle_put(ref);
>         return &thermo->sensor;
>  
>  fail:
> -       of_node_put(phandle);
> +       fwnode_handle_put(ref);
>         return ERR_PTR(ret);
>  }
>  
> -static struct ltc2983_sensor *ltc2983_rtd_new(const struct
> device_node *child,
> -                                         struct ltc2983_data *st,
> -                                         const struct ltc2983_sensor
> *sensor)
> +static struct ltc2983_sensor *
> +ltc2983_rtd_new(const struct fwnode_handle *child, struct
> ltc2983_data *st,
> +               const struct ltc2983_sensor *sensor)
>  {
>         struct ltc2983_rtd *rtd;
>         int ret = 0;
>         struct device *dev = &st->spi->dev;
> -       struct device_node *phandle;
> +       struct fwnode_handle *ref;
>         u32 excitation_current = 0, n_wires = 0;
>  
>         rtd = devm_kzalloc(dev, sizeof(*rtd), GFP_KERNEL);
>         if (!rtd)
>                 return ERR_PTR(-ENOMEM);
>  
> -       phandle = of_parse_phandle(child, "adi,rsense-handle", 0);
> -       if (!phandle) {
> +       ref = fwnode_find_reference(child, "adi,rsense-handle", 0);
> +       if (IS_ERR_OR_NULL(ref)) {
>                 dev_err(dev, "Property adi,rsense-handle missing or
> invalid");

I'm wondering... Is there any way for NULL being returned? Looking at
the API, it seems it always return error pointers... Also, all the
current users of fwnode_find_reference() only care to check for error
pointers...

Or is this just personal preference and you being prepared for any
potential change in the API? Note that Im fine with this as-is...

Anyways, will try to re-test this Monday...

- Nuno Sá


