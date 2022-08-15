Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0A259291C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 07:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiHOFg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 01:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiHOFg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 01:36:56 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE35C12A88;
        Sun, 14 Aug 2022 22:36:52 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id l4so7844939wrm.13;
        Sun, 14 Aug 2022 22:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=iwr7XkJX8s+Vxxl+k0pY94n0/ODkYyQntmhI8k+Qn6I=;
        b=ochcn0nAwaI+uZle8oxq2CMwsp35gCjwnpn4Q/BbMfX+/bVmddN92C70y9YQzJ8bk9
         3YnkpIGDwNf+olWm8vc3x9RrD+G5wgQGS3MAgJZcxU6YZX1yYOG1exd2hYIaokrfH956
         Doh55Xz+oDkE4li+WV9kkAnFw41V9U+30TY0TOjXQoGYbM69sLBEpzhqTwYI8mV5fLKW
         WJRd6GNgOx87Afp83QtX5xz3iCja+EjwBtPFavqCbaH5k75Sbn9DsjVz5fWlEyx4T2Ao
         CVtuCECiSvCTC8jfwK39UjB58B9BqZ+H5cqPn+MwyU9fzgAhXzV+uxTye3AslKkCpQPX
         fj2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=iwr7XkJX8s+Vxxl+k0pY94n0/ODkYyQntmhI8k+Qn6I=;
        b=3c27AUdYXzPTdvTlL7rM1hu7WbEcx4yAk2LlhLqJQWdWZsdlXeVHCG4r1o3Au2UOR2
         BnH3TMtgXDF7XS1K0c1V2dW/MAcGe+3M/rx5TvWVIf6wLWmV0QNfEl/rRj8VMqci1Cap
         6dVTOFGPzK1e/NoNOzHdwGyvy8Z81WVQU1yfKmg+mrc3xF4s38sxls50uTReU+XnXpIh
         F6x7Uv+HxXfrsSvC2/SwrMau46CYS1lT51V/eWacbjjIo1eWcIYEsl1yqsotoQy7auki
         RnDvDGPnoVhcmPEODnlVaDGLHNVA9wGChhxcXyasptz6ZkzCi6I7W5Viq38eUruhxGsD
         mlPQ==
X-Gm-Message-State: ACgBeo2ZdrtC657nry4AhpVWiQP5bN6euIZAyFeNs4it4oy3GTuadAW2
        TwX3mW9OusQdnKlUZY0UovPcBRVgb4I4gpeuXJ4=
X-Google-Smtp-Source: AA6agR6zEn89cFvufHE8chEgz2jlIkGasvC8tMwTtwMNFTMfHDOM1OkMTmoUyaytKEWPYis+Q6YeOgEF0rN7lxUcm98=
X-Received: by 2002:a05:6000:178f:b0:221:7dcb:7cbf with SMTP id
 e15-20020a056000178f00b002217dcb7cbfmr7791842wrg.58.1660541811221; Sun, 14
 Aug 2022 22:36:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220805070610.3516-1-peterwu.pub@gmail.com> <20220805070610.3516-11-peterwu.pub@gmail.com>
In-Reply-To: <20220805070610.3516-11-peterwu.pub@gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Date:   Mon, 15 Aug 2022 08:36:39 +0300
Message-ID: <CANhJrGOmFiC42_F+vX9zxg0uP_wdjQbBCPyn6+Zy3DkBycnaGw@mail.gmail.com>
Subject: Re: [PATCH v7 10/13] power: supply: mt6370: Add MediaTek MT6370
 charger driver
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sebastian Reichel <sre@kernel.org>, chunfeng.yun@mediatek.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        deller@gmx.de, Andy Shevchenko <andy.shevchenko@gmail.com>,
        chiaen_wu@richtek.com, alice_chen@richtek.com,
        ChiYuan Huang <cy_huang@richtek.com>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-usb@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-fbdev@vger.kernel.org, szunichen@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ChiaEn,

pe 5. elok. 2022 klo 10.09 ChiaEn Wu (peterwu.pub@gmail.com) kirjoitti:
>
> From: ChiaEn Wu <chiaen_wu@richtek.com>
>
> MediaTek MT6370 is a SubPMIC consisting of a single cell battery charger
> with ADC monitoring, RGB LEDs, dual channel flashlight, WLED backlight
> driver, display bias voltage supply, one general purpose LDO, and the
> USB Type-C & PD controller complies with the latest USB Type-C and PD
> standards.
>
> Add a support for the MediaTek MT6370 Charger driver. The charger module
> of MT6370 supports High-Accuracy Voltage/Current Regulation,
> Average Input Current Regulation, Battery Temperature Sensing,
> Over-Temperature Protection, DPDM Detection for BC1.2.
>
> Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
> ---
>
> +
> +#define MT6370_CHG_LINEAR_RANGE(_rfd, _min, _min_sel, _max_sel, _step) \
> +[_rfd] = {                                                             \
> +       .min = _min,                                                    \
> +       .min_sel = _min_sel,                                            \
> +       .max_sel = _max_sel,                                            \
> +       .step = _step,                                                  \
> +}

Just a minor thing but I think this macro could be useful also for
other drivers. Do you think you could rename it to LINEAR_RANGE_IDX()
(or some such) and move it to the linear_range.h? That would allow
also other drivers to use it instead of reinventing the wheel :)

Best Regards
  -- Matti Vaittinen



---

Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
