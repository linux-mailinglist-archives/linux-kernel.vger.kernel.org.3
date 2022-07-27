Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7085823B1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 12:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbiG0KBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 06:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbiG0KBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 06:01:19 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA87312D1D;
        Wed, 27 Jul 2022 03:01:03 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id bp15so30603311ejb.6;
        Wed, 27 Jul 2022 03:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hu9vzP64XwhX+ZdLcLcSumH2ekV9zS7ocnz6sZ1vnwc=;
        b=bfvUk1cETyrb0eQt+9NlKSYqQJeOz7zsMf4O48z/lky2Rr6rg/RqQzZiN9u0yKTfKd
         T0l/PZYJcETuBPZw18eCrV2TPyQ0x8B/ZJq3aOoE8xEJvdiQwwrig6qClfyFUlATt9eA
         RFta70XMrVUx5sE5DOTQ08yW1cNM6PUAUpPpCCGOVpOeNnBdWjg0iLcaxMc6DP/jpN6i
         UuslT6iKN0vwos4S3IZquSWUTK/hSxbwcfGjpiw+w72Sk+1/zIm9wNqqrfQkOhd2htmu
         0OZ/TPQuWesEFA5HANIIVmZ5osYw0OfHOddihF9b9AHNjVQBdqiHdZfbcualTujNwQXx
         Z3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hu9vzP64XwhX+ZdLcLcSumH2ekV9zS7ocnz6sZ1vnwc=;
        b=HqzGNLWSJweiiuDy4IVHBvgszrpIKubwUGxLvX/v02wF/BkjzYhLsxRSTEs7qFkyIo
         N3EcZf+T+Z/EQuFojxKYWkkfV/D4Nw2Yxzxdd7MD6ASDe9IwpWs1RE0Ecq9Pcrqj9BQn
         4cjspkULZuo4FkOs5nTu5o+U5+pWVyWFdkNL/P67tW5nW/MNbR25SPmyheQQPohxqqVD
         no0AJj3VQVSKypFj36C47cW9MSnMYE2L8zDTtVaUBso3R8wY2+2kgEaya2r7HhNxsStK
         +m+ve08a3JZG9PDy27GYEsLev/ohhyYmEo7po1ls73uNS85Mw3/OYOI5ff6j6K7qc7cu
         7/fw==
X-Gm-Message-State: AJIora+UUMyt33dcd+2PbAUlp0rRsbabQMaFJ5pKSmufGBXTADmYs5Zj
        pH2EcKJHjW+9BtT5UG7bD18FUl4VCG/EBDlrRjSgt6+V1tE=
X-Google-Smtp-Source: AGRyM1v/qCqMVlLEC3IVyn9wHHay9PlnlAxtzBecJmNJSzcJWtw/aRp4ZQs44/HkqtKUtUfQ6ybYkkhGm4rFXkkJnsM=
X-Received: by 2002:a17:907:9706:b0:72b:4b0d:86a2 with SMTP id
 jg6-20020a170907970600b0072b4b0d86a2mr16368231ejc.242.1658916061452; Wed, 27
 Jul 2022 03:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220727064415.940690-1-potin.lai.pt@gmail.com>
In-Reply-To: <20220727064415.940690-1-potin.lai.pt@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 27 Jul 2022 12:00:22 +0200
Message-ID: <CAHp75VfNmq12Yv7mqVeijqK0vwRdPsSrH5wMzg9qR15+t7ArSQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] iio: humidity: hdc100x: add manufacturer and
 device ID cehck
To:     Potin Lai <potin.lai.pt@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 8:46 AM Potin Lai <potin.lai.pt@gmail.com> wrote:
>
> Add manufacturer and device ID checking during probe, and skip the
> checking if chip model not supported.
>
> Supported:
> - HDC1000
> - HDC1010
> - HDC1050
> - HDC1080
>
> Not supported:
> - HDC1008

Thanks for an update, my comments below.

...

> +       const struct of_device_id *match;

Don't you have a compiler warning? Always compile your code with `make W=1`

...

> +       data = device_get_match_data(&client->dev);

> +       if (data) {

This check is redundant. Too much protective programming. Just oblige
that matched ID has to always have an associated data.

> +               if (!data->support_mfr_check)
> +                       return true;
> +       }

...

> -       .probe = hdc100x_probe,
> +       .probe_new = hdc100x_probe,

Make this a separate patch before the presented one.

-- 
With Best Regards,
Andy Shevchenko
