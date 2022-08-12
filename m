Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537DB5914A9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 19:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiHLRLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 13:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234019AbiHLRLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 13:11:16 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CD492F64;
        Fri, 12 Aug 2022 10:11:14 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 2D8A35FD07;
        Fri, 12 Aug 2022 20:11:13 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1660324273;
        bh=khfS3tNU6teiR9cjTGL46mJ7z3D6ck0knm4eJ1iLa/Y=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=MlefdIawhFdXdAQpUe+vk4gGTDE37bozj1bcRKBiT/7zYrebBeBFhhvPdvSE6h3is
         coQrmZsZN7proiIaHu/ABBRqmbHcPZRHIOjj7nzADQ4UMndeOf1ftACz1EcZcqZcK6
         4d/yfIdZ7OIEaLw+N2kEIxsrftlwiHELbkjx7l/dxDRDhXq1cZmTWFgN/wZm/r2tWM
         NyvLdOEEhIl1TH2ETEC+WIIX1VXrp4gK8SGAp0CHj1NpIPVf4JpRXyCw2NGSa7VgYp
         VcQMJoe8IljnWdVGJU9ZonHVt7FhlvcJx4NLqemPZHgxNIJH6JdmyDFG6DzRZnio0h
         zrxftpsdiEbDQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Fri, 12 Aug 2022 20:11:08 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "wsa@kernel.org" <wsa@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
        "jbhayana@google.com" <jbhayana@google.com>,
        "lucas.demarchi@intel.com" <lucas.demarchi@intel.com>,
        "jani.nikula@intel.com" <jani.nikula@intel.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 6/7] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Thread-Topic: [PATCH v5 6/7] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Thread-Index: AQHYrmvoIVWL45TwmUSMsw+zEhPYFa2rTd8A
Date:   Fri, 12 Aug 2022 17:10:38 +0000
Message-ID: <20220812171104.vgvpobwovqlxggsd@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220812165243.22177-1-ddrokosov@sberdevices.ru>
 <20220812165243.22177-7-ddrokosov@sberdevices.ru>
In-Reply-To: <20220812165243.22177-7-ddrokosov@sberdevices.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AF575DA8D4514D469B85338ECBEC59CE@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/08/12 13:28:00 #20103614
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jonathan and Andy,

Please find a few comments below. They explain why I didn't do something
which was mentioned or suggested in the v4.

On Fri, Aug 12, 2022 at 04:52:29PM +0000, Dmitry Rokosov wrote:

[...]

> +/*
> + * Possible Full Scale ranges
> + *
> + * Axis data is 12-bit signed value, so
> + *
> + * fs0 =3D (2 + 2) * 9.81 / (2^11) =3D 0.009580
> + * fs1 =3D (4 + 4) * 9.81 / (2^11) =3D 0.019160
> + * fs2 =3D (8 + 8) * 9.81 / (2^11) =3D 0.038320
> + * fs3 =3D (16 + 16) * 9.81 / (2^11) =3D 0.076641
> + */
> +enum {
> +	MSA311_FS_2G,
> +	MSA311_FS_4G,
> +	MSA311_FS_8G,
> +	MSA311_FS_16G,
> +};
> +
> +static const struct {
> +	int val;
> +	int val2;
> +} msa311_fs_table[] =3D {
> +	{0, 9580}, {0, 19160}, {0, 38320}, {0, 76641}
> +};
> +
> +/* Possible Output Data Rate values */
> +enum {
> +	MSA311_ODR_1_HZ,
> +	MSA311_ODR_1_95_HZ,
> +	MSA311_ODR_3_9_HZ,
> +	MSA311_ODR_7_81_HZ,
> +	MSA311_ODR_15_63_HZ,
> +	MSA311_ODR_31_25_HZ,
> +	MSA311_ODR_62_5_HZ,
> +	MSA311_ODR_125_HZ,
> +	MSA311_ODR_250_HZ,
> +	MSA311_ODR_500_HZ,
> +	MSA311_ODR_1000_HZ,
> +};
> +
> +static const struct {
> +	int val;
> +	int val2;
> +} msa311_odr_table[] =3D {
> +	{1, 0}, {1, 950000}, {3, 900000}, {7, 810000}, {15, 630000},
> +	{31, 250000}, {62, 500000}, {125, 0}, {250, 0}, {500, 0}, {1000, 0}
> +};

I didn't change odr and fs table structures to s32_fract, because they
don't have numerator/denominator format, but it's an integer.fractional
format. I didn't find such a common struct for this format. If we want to
generalize such a fractional number format, I suppose it's better to do it
in the separate patch series over the whole IIO subsystem, due to the many
val.val2-like structures inside it.

[...]

> +/**
> + * struct msa311_priv - MSA311 internal private state
> + * @regs: Underlying I2C bus adapter used to abstract slave
> + *        register accesses
> + * @fields: Abstract objects for each registers fields access
> + * @dev: Device handler associated with appropriate bus client
> + * @lock: Protects msa311 device state between setup and data access rou=
tines
> + *        (power transitions, samp_freq/scale tune, retrieving axes data=
, etc)
> + * @chip_name: Chip name in the format "msa311-%hhx" % partid
> + * @new_data_trig: Optional NEW_DATA interrupt driven trigger used
> + *                 to notify external consumers a new sample is ready
> + * @vdd: Optional external voltage regulator for the device power supply
> + */
> +struct msa311_priv {
> +	struct regmap *regs;
> +	struct regmap_field *fields[F_MAX_FIELDS];
> +
> +	struct device *dev;

I stay struct device *dev pointer in the msa311 private structure,
because without it code looks more grubby and we can't retrieve indio_dev
from msa311_priv object using container_of or something else
(it's just a dynamic pointer).

> +	struct mutex lock;

I've removed the state guard comment, but checkpatch.pl is still raising
a warning.

[...]

> +	err =3D msa311_chip_init(msa311);
> +	if (err)
> +		return err;
> +
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;

I returned INDIO_DIRECT_MODE initialization, but actually I'm not sure
if it's needed when we setup buffer mode regardless of any optional
parameters.

[...]

--=20
Thank you,
Dmitry=
