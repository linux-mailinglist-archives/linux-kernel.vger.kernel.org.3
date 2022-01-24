Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB764980AF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 14:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbiAXNOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 08:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiAXNOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 08:14:09 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26752C06173B;
        Mon, 24 Jan 2022 05:14:09 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id s5so21228090ejx.2;
        Mon, 24 Jan 2022 05:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ztKNOXqsYnv3mPaTYSeul9OsaQPxd0GOtreezP6Z464=;
        b=aPh/ZfB2WE0ftAvP8aWmco8HHjLOoDhNR3oMdB+XduNWJT+Pb9Fe5BCkReL1NFg/Fh
         JOCkEPQuB1QHe0mHdqSNUQyh9LQdoKkeDxYqVwcEl3/pHqVQMTOfAjAtC0mE2k8fS0cc
         9VmbsV/P0mbP0Yu/rU352tLgwI7pR/9/CorK7bun+nG831CBceCrCgKv3OJV92g3swaD
         5pYg9RON8NgbwR3vPwQMNe6f9s2jBD4i7EG8YmcxvbsNrtLaDOXkAiBX7HGrqa/53ler
         kM9GLlcodBN+1caT+FlUHpIl7kvsftCIiYqW+SR7NRKHJH5r5Ygi2bT1YPEaAeXNHjn5
         berw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ztKNOXqsYnv3mPaTYSeul9OsaQPxd0GOtreezP6Z464=;
        b=lKzDCCTmNaaVpqnLnqXR7HFLOkWMFAMeouTTjBF7mZsSV+I3Ei2V2bzfbehxKSuacS
         6OnXn/AWnKZ5gZ9y6VEKSHTlNy2SamQw+ZIwc9ulWKhD4+4V9hJYIguQLlS1cXOkq4Z6
         hMTt1KiHUvGkfvqZc5Ch/Hdku+OIlUxtdNzdE4yGC+V7GwJ/2uwjunRvIv4WpHGBdSr9
         oLB68d2QCIaRnQbbmGapeOK6K4TKAXBpzqbz9o3pqjIhIDjTG4rsfVv+Hnw4ddYfV2mg
         E+d8oJi5MtLbodjyV0t5isuVmaWwu3RdarehmPw0c2X6DvLsKpY7acVr42da0Ipny7QC
         l/LA==
X-Gm-Message-State: AOAM531YdzS4IXfIRNISAEzmhL8DyzMJiWeqrsQCjo64EA7ZCe+IyU/+
        njcI/qBIqqh1/4sGu7L1jUy7UN1IY9EFpC+NL+c=
X-Google-Smtp-Source: ABdhPJxRDinQzNxBVqaPGOj/MDn6x4KGc725mg+vlfvFCsrzWIV0MhxBOK7suP+mIq/TsjD4HeYXjfjYlCLesFV29xQ=
X-Received: by 2002:a17:906:3004:: with SMTP id 4mr11940180ejz.579.1643030047686;
 Mon, 24 Jan 2022 05:14:07 -0800 (PST)
MIME-Version: 1.0
References: <20220124093912.2429190-1-Qing-wu.Li@leica-geosystems.com.cn> <20220124093912.2429190-5-Qing-wu.Li@leica-geosystems.com.cn>
In-Reply-To: <20220124093912.2429190-5-Qing-wu.Li@leica-geosystems.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 24 Jan 2022 15:12:27 +0200
Message-ID: <CAHp75Vc9Ef4uZR505yRGm1vzMiZUEBp0Hdc9qs=BbiAwwEqLyw@mail.gmail.com>
Subject: Re: [PATCH V1 4/6] iio: accel: sca3300: Add support for SCL3300
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Tomas Melin <tomas.melin@vaisala.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 11:39 AM LI Qingwu
<Qing-wu.Li@leica-geosystems.com.cn> wrote:
>
> Add support for Murata SCL3300, a 3-axis MEMS inclination.
> same as SCA3300, it has accel and temperature output.

accelerometer

> Datasheet link:
> www.murata.com/en-us/products/sensor/inclinometer/overview/lineup/scl3300
>

Make this a Datasheet: tag (change name and drop blank line(s) in the
tag block).

> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>

...

> @@ -68,7 +68,6 @@ static const struct iio_enum sca3300_op_mode_enum = {
>         .get = sca3300_get_op_mode,
>         .set = sca3300_set_op_mode,
>  };
> -

Stray change.

...

> +};
> +
> +

One blank line is enough.

...

>  static const int sca3300_accel_scale[CHIP_CNT][OP_MOD_CNT][2] = {
>         [CHIP_SCA3300] = {{0, 370}, {0, 741}, {0, 185}, {0, 185}},
> +       [CHIP_SCL3300] = {{0, 167}, {0, 333}, {0, 83}, {0, 83}}

+ Comma.

>  };

...

> +                       /*SCL3300 freq.tied to accel scale, not allowed to set separately.*/

Missed spaces.

...

>         struct sca3300_data *data = iio_priv(indio_dev);
> -

This even checkpatch should complain of, besides being a stray change.

>         switch (mask) {

-- 
With Best Regards,
Andy Shevchenko
