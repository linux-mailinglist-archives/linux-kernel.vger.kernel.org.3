Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6172A5998EE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 11:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348101AbiHSJiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 05:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347163AbiHSJiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 05:38:01 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563ADF2CAA;
        Fri, 19 Aug 2022 02:38:00 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id j17so2912840qtp.12;
        Fri, 19 Aug 2022 02:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=2ZvHFToN8Dd1qgj57u+OE1lMQuyHL7jpimxd9I1F2Ww=;
        b=JK187mUaQ2BGEhTlqcpxOSbM6UCjwFZ8WKw/e9kJ5lW8ox40U3ef3Fz8GXnk2lZaIZ
         C4MlYA+y2wGH1whdds1cwnCYY8YOJH/aUmUM86vTL/yIrXLggSN7/hDTdTVHyxDAvWPd
         ffhyzhHhCkTMfbUsJ0WagkRSneTYSxnU07Ru0vHxi6QVHcITYiKK3ourSloXgy31nUYl
         fdQANwxAy3JNU/tEI6YIpuEKPg3eHqsWkpfxBTrqjMqXEbiVAPL519xLoA0D+QZGKjkN
         jwHID+9pMayPzJV5QuBDl5AU3Fn0JPKZhzvuo7hXOny3KAumQLsR2qY7Tud+ZvNXvHJA
         j9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=2ZvHFToN8Dd1qgj57u+OE1lMQuyHL7jpimxd9I1F2Ww=;
        b=4kBWnJshfvJDlBP/ECtdZn+pdOAillV/IHHzol9WrJ8bbSggVX4neuzDsnmOc4FpTs
         TTonAwzHagpTAf8WYfhyAB9FSJBKqMCrXNRBmXkdX6P+7IyOAV2D0o+tFInfJieOCaT/
         wmBHLLeV5ENGgc7O+NTyvQvgGugq66+W4VR86T4AGk9/JBXFcmeMR0S19oULnH4DA7if
         z++oPr0uFB6TWecwCJAwughEw07b77/ChPiPSnC553cH27SGGn6wJTSHLFaAUHyJ8Ksl
         QC1/sNlA0OgdOjmDVmtJYkjWlqD6JVE36H88afXGyc0URVWmQpxeFUdsZkGU67xV/ovW
         QTyw==
X-Gm-Message-State: ACgBeo08MOkmS0Jcfaj/h8w4cvcJGmAKUENARalkjeLChNU7FkJ/mpMI
        A/+Ps7fBP9IfFjMoRh5ZG/EFLSesjkuz7oKmHMbLURFkBpc=
X-Google-Smtp-Source: AA6agR7o1puuoJSfrHhFyu86GOzh4LBgcVvXJuyhExfJe6WX0eF5AI/OommjDEYzFIn+bp84nDd7DisnZdiIAkzB2Pk=
X-Received: by 2002:a05:622a:491:b0:344:95bf:8f05 with SMTP id
 p17-20020a05622a049100b0034495bf8f05mr4284991qtx.61.1660901879325; Fri, 19
 Aug 2022 02:37:59 -0700 (PDT)
MIME-Version: 1.0
References: <6e908cc827c70b95dae683717592aff0b003e7c9.1660606478.git.ang.iglesiasg@gmail.com>
In-Reply-To: <6e908cc827c70b95dae683717592aff0b003e7c9.1660606478.git.ang.iglesiasg@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Aug 2022 12:37:23 +0300
Message-ID: <CAHp75VdTZ_JYB2aYVdQTOx9QW1HPKhwYyQH-0tVCtpjHV=VcaQ@mail.gmail.com>
Subject: Re: [PATCH] iio: pressure: bmp280: fix datasheet links
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
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

On Tue, Aug 16, 2022 at 2:39 AM Angel Iglesias <ang.iglesiasg@gmail.com> wrote:
>
> Updated links for BMP280 and BME280 datasheets on Bosch website.

> Datasheet of BMP180 is no longer available on the manufacturer's website,
> changed the link to a copy hosted by a third party.

Note, that the version is downgraded (from 12.1 to 9).

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Reported-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
> ---
>  drivers/iio/pressure/bmp280-core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index fe7aa81e7cc9..e98b024d510b 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -9,9 +9,9 @@
>   * Driver for Bosch Sensortec BMP180 and BMP280 digital pressure sensor.
>   *
>   * Datasheet:
> - * https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMP180-DS000-121.pdf
> - * https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMP280-DS001-12.pdf
> - * https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BME280_DS001-11.pdf
> + * https://cdn-shop.adafruit.com/datasheets/BST-BMP180-DS000-09.pdf
> + * https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmp280-ds001.pdf
> + * https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bme280-ds002.pdf
>   */
>
>  #define pr_fmt(fmt) "bmp280: " fmt
>
> base-commit: b82217e73b5aa6db8453ad91b929ca2366e47184
> --
> 2.37.2
>


-- 
With Best Regards,
Andy Shevchenko
