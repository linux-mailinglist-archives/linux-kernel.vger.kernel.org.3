Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8FA5B0625
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 16:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiIGOKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 10:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiIGOKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:10:04 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BFC29816;
        Wed,  7 Sep 2022 07:10:02 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id s13so7558935qvq.10;
        Wed, 07 Sep 2022 07:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=4Uh0JA5EU6H+1OexYGpjrqOI/Bfa0fFdYPaYWN4TUUs=;
        b=H8bvtiXRiLr+7v2NbeN91wsOkgkueTmt1Kqa3UEfwGT5Njjt9ie6tdbpvOs4lH7fbZ
         Mbe625L06UHDT66CcSNKLWld6aj5KC3xBuhsekrQGaVLxZWiA8BjUuVBrmWewy46g1kf
         ggJjog91MPQLtoElfB2VvXJdNX1qgUxxwhHS0l0NcoCz+1dTxuRxYFs69V7pAUBglqSH
         j6795uNXkss9AJYWcSKyMp0/HBIMgBbSH8yU4ycX5X/xM6+TdJYkNZlIZ8ZwWMgaSGMQ
         bcguQkp22aov2NwrB9g6x0RVNV0+j7mTLQ+osRlsOBzleIuJv3cNSQR/I7Vib789qaQt
         CL3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=4Uh0JA5EU6H+1OexYGpjrqOI/Bfa0fFdYPaYWN4TUUs=;
        b=ZvMwA948/UUVQLFBj5w04gV01fLXtnUNwr0KLReuCxYCNuG0xCrPriiLDSUnyMPZtn
         4W8K3z0xhQWmjxg+TSxwAoXXvNuhPIjcGU+EZaA2dyxn0dd+QHUIPAKxuuPfol/STsQK
         7rq0yj3y8b7UJaqnoRDzkFGDY1d6fKK007PEN+VP+WL8zUIZKiJreS20HedlJnkHrRiL
         C7p2UqMUew1XN9tmPQbZPzeAkmviIsvsIAfogd/4fzFUrkZRBmZJdxHrlzBDlyTQegaY
         gOUPfncpU87GxvhKUIHtjFj2MYnJhzCMzAprRjR1M/S4autRGAFHt5NI9qzAayk0sust
         1Wug==
X-Gm-Message-State: ACgBeo0rLJ0VcDzABdiSOwoFfRM6+/FGnqKW1G88q3+6LEXLpbQhWEFv
        x/qHGJ+1XXUam9isAFWwhr+TnKMlbYPuh5Gj6P8=
X-Google-Smtp-Source: AA6agR76HipePhpMmPr9Y+5Dx6vWNEndPbm1mC1mYYKey5QMVE53NQS66t5iCqDDAECoHzd3cPIBVDISi7Cp7sQ4bHs=
X-Received: by 2002:a05:6214:c8f:b0:499:21eb:ba3b with SMTP id
 r15-20020a0562140c8f00b0049921ebba3bmr3179469qvr.97.1662559801880; Wed, 07
 Sep 2022 07:10:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220907132205.28021-1-andrea.merello@iit.it> <20220907132205.28021-14-andrea.merello@iit.it>
In-Reply-To: <20220907132205.28021-14-andrea.merello@iit.it>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 7 Sep 2022 17:09:26 +0300
Message-ID: <CAHp75Vdc8bAiqiUhEmgjNmcpY5s0fArTy26g2i0wH7srwY6RQA@mail.gmail.com>
Subject: Re: [v7 13/14] iio: imu: add BNO055 I2C driver
To:     Andrea Merello <andrea.merello@iit.it>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        jmondi <jacopo@jmondi.org>,
        Andrea Merello <andrea.merello@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
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

On Wed, Sep 7, 2022 at 4:22 PM <andrea.merello@iit.it> wrote:
>
> From: Andrea Merello <andrea.merello@iit.it>
>
> Add an I2C driver for communicating to a BNO055 IMU via I2C bus and enable
> the BNO055 core driver to work in this scenario.
>
> Signed-off-by: Andrea Merello <andrea.merello@iit.it>

> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Hmm... It has my tag but I have noticed something to improve.

...

> +#define BNO055_I2C_XFER_BURST_BREAK_THRESHOLD 3 /* FIXME */

Can we elaborate what to fix and why it can't be fixed right now?

...

> +static const struct of_device_id __maybe_unused bno055_i2c_of_match[] = {
> +       { .compatible = "bosch,bno055" },

> +       { },

No comma for the terminator entry.

> +};

...

> +               .of_match_table = of_match_ptr(bno055_i2c_of_match),

No of_match_ptr(). This will disable ACPI support along with potential
compiler warning.

-- 
With Best Regards,
Andy Shevchenko
