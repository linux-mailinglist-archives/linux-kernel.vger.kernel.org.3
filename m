Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586A45999BE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 12:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348276AbiHSKbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 06:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348042AbiHSKbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 06:31:46 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF9BF14D5;
        Fri, 19 Aug 2022 03:31:44 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id n7so4683681wrv.4;
        Fri, 19 Aug 2022 03:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc;
        bh=S5k8ZCJni3UL0WQ48e88TPbgvrbpo4Cons2frUXSviI=;
        b=pkk4Blrjvsirn3+XzQbOc481V0K85S55+qb5UDQI8LqNw8stAarO0zQl/yQeWVNYU9
         8ddcICcQF6erv4mSrZK8XEEnVtmgWn5mtP42Nu0Iw3WPEBaCUpCxoAaqrjxWMAAz5y6S
         +c83VRx61KJO/OWqBLAatDe4o3J3Y/yVpP71V6snjmIey/bubvmykty7jMU2XxUgpJTs
         wA+2DFT5Kx6iyKOr6E7IhxFJAcaPCawGPghxCM3oIgXYCcFg4nVMvXVU5UO9lveKsx4a
         lroGm0RqSTuHtvD3aDQ6g+fpksyATl3ijj3FHwoifELsDyuYYpLuzHsGe1mAcjSOFXuN
         s3Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=S5k8ZCJni3UL0WQ48e88TPbgvrbpo4Cons2frUXSviI=;
        b=jZP4FscejM/OuQJSaV/PWAEUbxYcbIOotvLvxQQBSEhxdV8ZK0QplCLmpHLjKDfowg
         Vj8bQiOz0vPAgJc+GEQ2wWAUtdj/ASerjH0A6bf+BSisX3/BB8rFEVdLEgz0hfBqGnfM
         WQyexgSgHC7JUTYqzFnb/lSkCAezn5qwWa8TVX3U4cUNBLXrhvaKkKbOv5M7HiLpVUWo
         +n3tR3l+4NxdYtuHvYaXg1ID8N2jS4DV6nf5+v6kgTItrjJLb/WipVrEo1MaC0zrLHM/
         vGzeQukakINpUnXFPZBUikEDv4Z43rzD9dCjCYtr5NJXNMckKSDfv9KghIdcXgkaWSTJ
         AFhw==
X-Gm-Message-State: ACgBeo2UD9SXUHMI1qgwNjLzLx0I+IOAJWSjchT7Nn0/YuIakbDdfzNd
        flP++781n4sytSqkceJgrkY=
X-Google-Smtp-Source: AA6agR5RAgFD53s5JdkYUUOp+pMAXYKgWpDePCH/nKlI9urWFaExgPVXWbEytt2eaVI/klXWRUvI+g==
X-Received: by 2002:a05:6000:2c7:b0:225:16cc:aa33 with SMTP id o7-20020a05600002c700b0022516ccaa33mr3867028wry.609.1660905102927;
        Fri, 19 Aug 2022 03:31:42 -0700 (PDT)
Received: from DreamMachine2.lan (188.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.188])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c1c0700b003a319b67f64sm3541287wms.0.2022.08.19.03.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 03:31:42 -0700 (PDT)
Message-ID: <8a1f372f34be71895268e874bb3fbbf105dfabdb.camel@gmail.com>
Subject: Re: [PATCH] iio: pressure: bmp280: fix datasheet links
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 19 Aug 2022 12:31:18 +0200
In-Reply-To: <CAHp75VdTZ_JYB2aYVdQTOx9QW1HPKhwYyQH-0tVCtpjHV=VcaQ@mail.gmail.com>
References: <6e908cc827c70b95dae683717592aff0b003e7c9.1660606478.git.ang.iglesiasg@gmail.com>
         <CAHp75VdTZ_JYB2aYVdQTOx9QW1HPKhwYyQH-0tVCtpjHV=VcaQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (by Flathub.org) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-08-19 at 12:37 +0300, Andy Shevchenko wrote:
> On Tue, Aug 16, 2022 at 2:39 AM Angel Iglesias <ang.iglesiasg@gmail.com>
> wrote:
> >=20
> > Updated links for BMP280 and BME280 datasheets on Bosch website.
>=20
> > Datasheet of BMP180 is no longer available on the manufacturer's websit=
e,
> > changed the link to a copy hosted by a third party.
>=20
> Note, that the version is downgraded (from 12.1 to 9).

Apologies, I forgot to add a note about this. Changelog on datasheet 12.1 l=
isted
these three changes from version 9:
* Page 26: Changed document referral from ANP015 to BST-MPS-AN004-00
* Chapter 3.5: New equation for B3 (adds a long cast to AC1)
* Page 26: Updated RoHS directive to 2011/65/EU effective 8 June 2011

Unfortunately, I couldn't find the most updated version in good quality hos=
ted
in a trustworthy place.

>=20
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>=20
> > Reported-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
> > ---
> > =C2=A0drivers/iio/pressure/bmp280-core.c | 6 +++---
> > =C2=A01 file changed, 3 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/iio/pressure/bmp280-core.c
> > b/drivers/iio/pressure/bmp280-core.c
> > index fe7aa81e7cc9..e98b024d510b 100644
> > --- a/drivers/iio/pressure/bmp280-core.c
> > +++ b/drivers/iio/pressure/bmp280-core.c
> > @@ -9,9 +9,9 @@
> > =C2=A0 * Driver for Bosch Sensortec BMP180 and BMP280 digital pressure =
sensor.
> > =C2=A0 *
> > =C2=A0 * Datasheet:
> > - *
> > https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMP1=
80-DS000-121.pdf
> > - *
> > https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMP2=
80-DS001-12.pdf
> > - *
> > https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BME2=
80_DS001-11.pdf
> > + * https://cdn-shop.adafruit.com/datasheets/BST-BMP180-DS000-09.pdf
> > + *
> > https://www.bosch-sensortec.com/media/boschsensortec/downloads/datashee=
ts/bst-bmp280-ds001.pdf
> > + *
> > https://www.bosch-sensortec.com/media/boschsensortec/downloads/datashee=
ts/bst-bme280-ds002.pdf
> > =C2=A0 */
> >=20
> > =C2=A0#define pr_fmt(fmt) "bmp280: " fmt
> >=20
> > base-commit: b82217e73b5aa6db8453ad91b929ca2366e47184
> > --
> > 2.37.2
> >=20
>=20
>=20
Kind regards,
Angel

