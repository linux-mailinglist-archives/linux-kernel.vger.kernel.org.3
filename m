Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0939A586589
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 09:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiHAHNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 03:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiHAHNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 03:13:10 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C6A326D2;
        Mon,  1 Aug 2022 00:13:09 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id w15so2195983ljw.1;
        Mon, 01 Aug 2022 00:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tfEi2wATHr5s4kAbTzVzbDuu02MelmoOTRN0imH5lW8=;
        b=lKuwDM5luzL0HuSV27/K8oRHXozyJBISiaUy73xruCv38UkGcbVNfgTQWJJseAW08I
         ChOX8NOriHiLVOV2uIpKIrBq7GS0HwZ4+fGEoHpmsgFIKnArf7c7uqlCSMdUhkzvhM76
         HCLdzTlQvmtf0HM1ALOImkUaM/+QVB5Bf1eaz9RSsguGg/FqiBRVyBhzGkhXk9Cw+ELH
         fMLGhjeumaJ4I8dOVY+ND/whsG+ilHWQrnxPSc0kYcbIh2V4eu8SXpHz7PF24RDXBNs5
         KZqnLUPp9JJF8Hq5kHCydF7TPr5GEgGJmlDoHsOf6aSdMDmYnzoPSFU6kLj5hFebAjEi
         CE4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tfEi2wATHr5s4kAbTzVzbDuu02MelmoOTRN0imH5lW8=;
        b=nMBQpx3TnU29xqM0fuwRc+kIy/BFrteA3ritE0xUGVlcjywkXJrvN//tE8rI+4PaZk
         ii5zs69Qw9+SqTAi/prfPF/keP8c2gL8C23wgxmEc1Q1c0I+1gFuKtjDyHWOgzkKKj1b
         egSPpVnVpVjYwFuTQjv/bIoZ4X3wrTl88bhNZ4cTRSGcl3mDWTDWQT7ZAHcFUaEFYT2D
         Bb+tROTjcctl/MszLsCfRBmvkzj+brTIhU+sVmGT8wjVGqiDZl/xil7CEIwbciBrhLjx
         ZnO2fyHH9LTELbfb7929dyVdhHEg1ZkOWNSL/FicOEr5F4WwzaVhEgTRXPsu9dW9tBCd
         QgtQ==
X-Gm-Message-State: ACgBeo2w9SDpB9MQxEaobYq2+kBR1hPfAhyGMiMW56hLrT0BYgs40UFF
        YHi4WuQbTTYYGEtwSdb0f6w=
X-Google-Smtp-Source: AA6agR7vEFgdSYQVtY7U/GEd7y4UkOGiCvIE2pQTwLE1T3EdkgiOpNcpYXFaK6rn0MMLGWrDFxVyOw==
X-Received: by 2002:a2e:9dcc:0:b0:25e:45d8:6184 with SMTP id x12-20020a2e9dcc000000b0025e45d86184mr2659982ljj.46.1659337987555;
        Mon, 01 Aug 2022 00:13:07 -0700 (PDT)
Received: from gmail.com (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id w11-20020a2e958b000000b0025d6ecbc897sm75939ljh.46.2022.08.01.00.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 00:13:06 -0700 (PDT)
Date:   Mon, 1 Aug 2022 09:17:17 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/9] iio: adc: mcp3911: add support for buffers
Message-ID: <Yud9/eDs4i36T7Gk@gmail.com>
References: <20220722130726.7627-1-marcus.folkesson@gmail.com>
 <20220722130726.7627-6-marcus.folkesson@gmail.com>
 <20220731175121.5d9493a0@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="duuZgvRLw+wN+EG6"
Content-Disposition: inline
In-Reply-To: <20220731175121.5d9493a0@jic23-huawei>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--duuZgvRLw+wN+EG6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Sun, Jul 31, 2022 at 05:51:21PM +0100, Jonathan Cameron wrote:
> On Fri, 22 Jul 2022 15:07:22 +0200
> Marcus Folkesson <marcus.folkesson@gmail.com> wrote:
>=20
> > Add support for buffers to make the driver fit for more usecases.
> >=20
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>=20
> Assuming the Kconfig change from previous patch is pulled into this one...

Yep

>=20
> A few questions / comments inline.
>=20
> Thanks,
>=20
> Jonathan
>=20
> > ---
> >  drivers/iio/adc/mcp3911.c | 96 ++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 89 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
> > index 00dadb1761dc..96c0a2a50c7c 100644
> > --- a/drivers/iio/adc/mcp3911.c
> > +++ b/drivers/iio/adc/mcp3911.c
> > @@ -5,15 +5,22 @@
> >   * Copyright (C) 2018 Marcus Folkesson <marcus.folkesson@gmail.com>
> >   * Copyright (C) 2018 Kent Gustavsson <kent@minoris.se>
> >   */
> > +#include <linux/bitfield.h>
> > +#include <linux/bits.h>
> >  #include <linux/clk.h>
> >  #include <linux/delay.h>
> >  #include <linux/err.h>
> >  #include <linux/iio/iio.h>
> > +#include <linux/iio/buffer.h>
> > +#include <linux/iio/triggered_buffer.h>
> > +#include <linux/iio/trigger_consumer.h>
> > +#include <linux/iio/trigger.h>
> >  #include <linux/module.h>
> >  #include <linux/mod_devicetable.h>
> >  #include <linux/property.h>
> >  #include <linux/regulator/consumer.h>
> >  #include <linux/spi/spi.h>
>=20
> Line break here to separate the 'chunks' of includes.
>=20

OK

> > +#include <asm/unaligned.h>
> > =20
> >  #define MCP3911_REG_CHANNEL0		0x00
> >  #define MCP3911_REG_CHANNEL1		0x03
> > @@ -22,6 +29,7 @@
> >  #define MCP3911_REG_GAIN		0x09
> > =20
> >  #define MCP3911_REG_STATUSCOM		0x0a
> > +#define MCP3911_STATUSCOM_READ		GENMASK(7, 6)
> >  #define MCP3911_STATUSCOM_CH1_24WIDTH	BIT(4)
> >  #define MCP3911_STATUSCOM_CH0_24WIDTH	BIT(3)
> >  #define MCP3911_STATUSCOM_EN_OFFCAL	BIT(2)
> > @@ -54,6 +62,13 @@ struct mcp3911 {
> >  	struct regulator *vref;
> >  	struct clk *clki;
> >  	u32 dev_addr;
> > +	struct {
> > +		u32 channels[MCP3911_NUM_CHANNELS];
> > +		s64 ts __aligned(8);
> > +	} scan;
> > +
> > +	u8 tx_buf[MCP3911_NUM_CHANNELS * 3] __aligned(IIO_DMA_MINALIGN);
> > +	u8 rx_buf[MCP3911_NUM_CHANNELS * 3];
> >  };
> > =20
> >  static int mcp3911_read(struct mcp3911 *adc, u8 reg, u32 *val, u8 len)
> > @@ -196,16 +211,63 @@ static int mcp3911_write_raw(struct iio_dev *indi=
o_dev,
> >  		.type =3D IIO_VOLTAGE,				\
> >  		.indexed =3D 1,					\
> >  		.channel =3D idx,					\
> > +		.scan_index =3D idx,				\
> >  		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |	\
> >  			BIT(IIO_CHAN_INFO_OFFSET) |		\
> >  			BIT(IIO_CHAN_INFO_SCALE),		\
> > +		.scan_type =3D {					\
> > +			.sign =3D 's',				\
> > +			.realbits =3D 24,				\
> > +			.storagebits =3D 32,			\
> > +			.endianness =3D IIO_BE,			\
> > +		},						\
> >  }
> > =20
> >  static const struct iio_chan_spec mcp3911_channels[] =3D {
> >  	MCP3911_CHAN(0),
> >  	MCP3911_CHAN(1),
> > +	IIO_CHAN_SOFT_TIMESTAMP(2),
> >  };
> > =20
> > +static irqreturn_t mcp3911_trigger_handler(int irq, void *p)
> > +{
> > +	struct iio_poll_func *pf =3D p;
> > +	struct iio_dev *indio_dev =3D pf->indio_dev;
> > +	struct mcp3911 *adc =3D iio_priv(indio_dev);
> > +	struct spi_transfer xfer =3D {
> > +		.tx_buf =3D adc->tx_buf,
> > +		.rx_buf =3D adc->rx_buf,
> > +		.len =3D sizeof(adc->rx_buf),
> > +	};
> > +	int scan_index;
> > +	int i =3D 0;
> > +	int ret;
> > +
> > +	mutex_lock(&adc->lock);
> > +	adc->tx_buf[0] =3D MCP3911_REG_READ(MCP3911_CHANNEL(0), adc->dev_addr=
);
> > +	ret =3D spi_sync_transfer(adc->spi, &xfer, 1);
> > +	if (ret < 0) {
> > +		dev_warn(&adc->spi->dev,
> > +				"failed to get conversion data\n");
> > +		goto out;
> > +	}
> > +
> > +	for_each_set_bit(scan_index, indio_dev->active_scan_mask,
> > +			indio_dev->masklength) {
> > +		const struct iio_chan_spec *scan_chan =3D &indio_dev->channels[scan_=
index];
> > +
> > +		adc->scan.channels[i] =3D get_unaligned_be24(&adc->rx_buf[scan_chan-=
>channel * 3]);
>=20
> This has me a little curious.  It seems to be potentially reading from by=
te 0 which in the spi
> transfer is at the same time as the tx that tells the device what the com=
mand is.  I'd expect
> it to be one byte later.  Easiest way to do that being to have two transf=
ers (though you could
> just add to the offset). I might be misremembering how the spi_transfer s=
tuff works though.
> Been a while since I hacked anything SPI based...
>=20

Good catch.
I did not even notice that the resolution of my plot-script was wrong...


> > +		i++;
> > +	}
> > +	iio_push_to_buffers_with_timestamp(indio_dev, &adc->scan,
> > +			iio_get_time_ns(indio_dev));
> > +out:
> > +	mutex_unlock(&adc->lock);
> > +	iio_trigger_notify_done(indio_dev->trig);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> >  static const struct iio_info mcp3911_info =3D {
> >  	.read_raw =3D mcp3911_read_raw,
> >  	.write_raw =3D mcp3911_write_raw,
> > @@ -214,7 +276,7 @@ static const struct iio_info mcp3911_info =3D {
> >  static int mcp3911_config(struct mcp3911 *adc)
> >  {
> >  	struct device *dev =3D &adc->spi->dev;
> > -	u32 configreg;
> > +	u32 regval;
> >  	int ret;
> > =20
> >  	ret =3D device_property_read_u32(dev, "microchip,device-addr", &adc->=
dev_addr);
> > @@ -233,29 +295,43 @@ static int mcp3911_config(struct mcp3911 *adc)
> >  	}
> >  	dev_dbg(&adc->spi->dev, "use device address %i\n", adc->dev_addr);
> > =20
> > -	ret =3D mcp3911_read(adc, MCP3911_REG_CONFIG, &configreg, 2);
> > +	ret =3D mcp3911_read(adc, MCP3911_REG_CONFIG, &regval, 2);
>=20
> If I was being fussy I'd ask you to pull the refactoring in here out as a=
 precusor
> patch to simplify reviewing the new stuff a little.  However it's fairly =
minor
> so I'll let that go this time.

Ok, I got you wrong. Thanks.


Best regards
Marcus Folkesson


--duuZgvRLw+wN+EG6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmLnffgACgkQiIBOb1ld
UjJrsA//QNPLk1KdyBX/KMqbppkvEFxQ+f4oB2ZP4V2KTgYVKvHDPtIpMpee8CA7
EJjJ/xNEsaFgF+OaYuAyuxSdutjELmhnahInt44U0vHjCJf8yjool08Ana+uZAdN
Fs+ZbaCAZLaLgmYcZ3J73SnlsXLT1gLb5XLsKeajjPGL444pIL3WzYqgguRgANMv
GQ5tz1cZbS2iKXUa0il6QoC6wGvoMR97nq8k5hAJAfcJMCrwDsjjIsiJBeiwX0Wu
n6sfHH3XcGOtjeT6lywsGOR0k9X4M2gmZraOSr35laZeBF9XRoZWA9SJw2UKfYnz
g+9sZj58umwqpCHYu7ylGi/yUVJY4Xzu+oFTvxaSbN9yiljPaoCHDBSw29KtXr/E
YD20x0kIO7E5aoVZPiAn5vugC2OSubm0BoPPNRyKQMdfSiqmy+fVANjI46aA/lrl
prkdWX4h3RPHqlGkwEI7kX1F7KxN5dPyYcWsY4tpsqQ2PBirTt8QBfySOU/B1Jxr
Y1ZnOa2VZs5u1Wxy3qodui2NU6KCEKuAgKs4KpNKNKDZd2rgZO6qz1zMT0/NMWND
uhgV+1E0kUrCY1fHh6scYFXwFf2tepMEHkY13dOobnVkby2FGMGeBc1uTx1d+WzG
vqBlyw2rFhNshCEQPcHcDlBVd1GLhmjqZB4oQDu5t6Jf2IRPx34=
=c9jC
-----END PGP SIGNATURE-----

--duuZgvRLw+wN+EG6--
