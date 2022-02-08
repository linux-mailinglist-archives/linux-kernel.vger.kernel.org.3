Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017EE4ADA58
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376443AbiBHNrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348721AbiBHNrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 08:47:07 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0D4C03FECE;
        Tue,  8 Feb 2022 05:47:05 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id s7so10929328edd.3;
        Tue, 08 Feb 2022 05:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Uu1nmskTHfo9hf/W5wz6SlkksAW9cfa8fGOqXsoeu0=;
        b=Gk264vUVXqULqzqf8r/V2hhm+hrlBz33ptFcQz961+WAYCu63lke2girCZMbuqBNVo
         wQCza+VJ/CWrAWTDsf9opfmeHeZdOMPCEYWK13gurn9ek/yD7yRPAmomj0572H5kn2eX
         FwLrdPQOhTD6SZkpLlxM7amzIjLfH0Ss/vhceG5nA/1i6PVchCUE9tWGyIIrlGnqNwlU
         SVDhFdLdHHO1adtLeGj00RtBsyIuOdUdh8J+tYLGUtmu0v/DHfTpSocddpCVXgTzmZpf
         LXiF8vS1aXYt/a1HakbTNovY6pOptFhAaFHlvEjXDke9KLyD9iIT52OytpJT+rk48QSN
         PBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Uu1nmskTHfo9hf/W5wz6SlkksAW9cfa8fGOqXsoeu0=;
        b=f5pylbW5EjMAhjDKg83m3fpnbCLfhnonREJzXG31Ak5XNQUdw8X9C0TNLgxIgzjv8j
         CJ8A3+Y76X0s0lK25sHxYXJMNUtP/GpavlglQ193MldVNzt+L4jtF7taVKNgv4omm3XY
         7mB9UYTs7DZMuKM6lECMZgY3bO7KLBV87Aay+KP5MDdieqGYuxg5wMVPIVYDt4k1+rf1
         ZRsQ8+cU+lFq4axBtHc9uRpQ2VOxcuPF5SilTEEjeGD1tdS7y1OTS+2IN0KDOYGye72J
         5Pfjs5z6AM/Fa2BMZGe5b4Ps68iWyqUL9TZSdsXRFRMh8r1SlVxZF0eyUFHZtIGrLfyY
         kESg==
X-Gm-Message-State: AOAM532JiByC42LZEE8E78NneAYSYgj/sxEuBCzOPgNpXuTQxhYy7+5N
        fEopzdCLQ/YuoUsc8RwWY8J7pXoF+ScPRJOovsI=
X-Google-Smtp-Source: ABdhPJz2GmTrp8kspjWPIrO//kFaIZIY6zuZ3x2Mu5vF8Z/DPZ7MBkknv+oLENEgrJA6ASawew8rshblrdr780Qg7Wc=
X-Received: by 2002:aa7:c413:: with SMTP id j19mr3709836edq.200.1644328023983;
 Tue, 08 Feb 2022 05:47:03 -0800 (PST)
MIME-Version: 1.0
References: <20220208020441.3081162-1-liambeguin@gmail.com> <20220208020441.3081162-10-liambeguin@gmail.com>
In-Reply-To: <20220208020441.3081162-10-liambeguin@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 8 Feb 2022 15:46:27 +0200
Message-ID: <CAHp75Vf+FkofvC3_jvNadGed+eH7mQvVYXTOiWKCzwinJ3-2-w@mail.gmail.com>
Subject: Re: [PATCH v14 09/11] iio: afe: rescale: add temperature transducers
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
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

On Tue, Feb 8, 2022 at 4:04 AM Liam Beguin <liambeguin@gmail.com> wrote:
>
> A temperature transducer is a device that converts a thermal quantity
> into any other physical quantity. This patch adds support for
> temperature to voltage (like the LTC2997) and temperature to current
> (like the AD590) linear transducers.
> In both cases these are assumed to be connected to a voltage ADC.

...

> +       rescale->offset = div_s64((s64)offset * rescale->denominator,
> +                                 rescale->numerator);

Wonder if we can use mult_frac() here. Would it require 64-bit division?

-- 
With Best Regards,
Andy Shevchenko
