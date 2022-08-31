Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA155A7D70
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiHaMds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiHaMdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:33:46 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433B7D1E0D;
        Wed, 31 Aug 2022 05:33:43 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id kh8so10925796qvb.1;
        Wed, 31 Aug 2022 05:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=WJzy/1nFT0rKIpQxVCFdW9fFqLCzRixOrKbEu2Xp5NI=;
        b=IfxcdONwMKB4VxhK6Hg2FQ8kn6Pg9GGLkhaaF4ljZIc72hOZLXdPchEJMkv7Oj78ZI
         xS77kb42d3+YAz9vBWDQncCXmeOLrcf+kPgizAot2w8f7cMLLzIc6zAeSzvhB4JiPh9I
         HUalZI0gbLNnLucNK2AZGfRg7IYNcfOQ9I+TR+XVzF0//oPIBbGx82Z45JDh5sXaPlN5
         WOPWLbmFudFzv2ESgC4xHiRFIX0UoDear/oydi+Xj6mbQMScSIdwbXwFP4EgMuTLEXqc
         dMOnw/CHJxNXyby9MJIdmWB/ifV62SkabytkaGPs5fIqDbm9zfNfsz3lGmHMoglmJlyZ
         KhTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=WJzy/1nFT0rKIpQxVCFdW9fFqLCzRixOrKbEu2Xp5NI=;
        b=ALUfSXyzn9uGEJKRPW9+4OIsmZD+PSrRN+BGmYewZvRpZWYuf4yY9gEG+Gwt0auaCE
         L2Cj3GDC1lMWTuR9FDIV3C5+kxQpvzFUSmNCyJwcKoBQYKLARKPZ7qJCSgWvc/4QNTqY
         lBGmdLs5EFRtXNmHI9rWA1GDv2gaWMjxJFHnlO1/IjGS19J0FxxAqNmttp+VEkihiIig
         FAOoDVpebzOq7g97otx1AlvZVZPGOK7iaHQNDPhnL58ceDEA8GGXiVilAXD5s+jTi9Te
         jdHOJEmhmiZU4Cwdiucp4T3/Erw2tJWoXywkSUnmklVKefgPLiEx/NBtmYKkzi62K9fs
         28Ug==
X-Gm-Message-State: ACgBeo3raV9E3nL46ibYAkoM5jTrRJwz0BjXPvP+U5omjnHg7+SiuEhc
        vBk6KkMU9eTna559FwZq+8G7EaDBdssocAnFGxk=
X-Google-Smtp-Source: AA6agR5hRcaT1OGzoc0WqIOyYpPuMWCqb0BMnTkFBjoK+voV4yeDEG3ddZNv273hvZ96Ju8BaQnZiCHY+cUeZLYm3R8=
X-Received: by 2002:a05:6214:2022:b0:497:2c03:61 with SMTP id
 2-20020a056214202200b004972c030061mr19621272qvf.11.1661949222422; Wed, 31 Aug
 2022 05:33:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220831095601.4157195-1-o.rempel@pengutronix.de> <20220831095601.4157195-3-o.rempel@pengutronix.de>
In-Reply-To: <20220831095601.4157195-3-o.rempel@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 31 Aug 2022 15:33:06 +0300
Message-ID: <CAHp75VcO=ipD8nW8CdQ18u1-SaD8GU1W=dUihCu+GqQrq3Uwcg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] iio: adc: tsc2046: silent spi_device_id warning
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
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

On Wed, Aug 31, 2022 at 1:01 PM Oleksij Rempel <o.rempel@pengutronix.de> wrote:

All below are minors (but you really need to Cc reviewers from the
previous round(s) to pay the respect), so I leave them to IIO
maintainers.

...

> Add spi_device_id to silent following kernel runtime warning:
> "SPI driver tsc2046 has no spi_device_id for ti,tsc2046e-adc"

Missed period.

>         dcfg = device_get_match_data(dev);
> +       if (!dcfg) {

> +               const struct spi_device_id *id;
> +
> +               id = spi_get_device_id(spi);

You can move assignment to the definition line.

> +               dcfg = (const struct tsc2046_adc_dcfg *)id->driver_data;
> +       }

> +

Unneeded blank line, since these all are grouped semantically.

>         if (!dcfg)
>                 return -EINVAL;

-- 
With Best Regards,
Andy Shevchenko
