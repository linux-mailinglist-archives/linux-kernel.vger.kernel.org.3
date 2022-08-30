Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F17D5A6E13
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 22:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiH3UES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 16:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbiH3UD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 16:03:59 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF9C80511;
        Tue, 30 Aug 2022 13:02:46 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id n4so6976186qvt.7;
        Tue, 30 Aug 2022 13:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=sKUb5B3iNP9JffwnPezxUr8DBbsDdDXj2jgeVcIymz0=;
        b=A3OmI/NAKUxctLonPwyddHe16W4iMUhmCzfz5d7ui4tHfPU2KAupuIYIvihNmubfCx
         U3vHOuKN0gXyrem202xA4EJJil22adqKJnpSLAQ+/vEzVns0fiAbnF0StHMOqRYoyPlX
         p6MavOBNcnjfa2GrBNhEvPqowEdehgx5CSO5AQWshTW+tcES+lUq3iJ4oasuX972OtxP
         JML0J+IljDep1TmtJea9Z+lYqrmsvFmX5qoTxyZuPCGtNdLlI7qrQpFa1nPyZV8IKnUi
         EbFgOs8hJpOVeSTa/GoTXEyphH1U4KQWqo+dhrel8Qc5uKR05gZBZGfA+f2RckGKVzXy
         I0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=sKUb5B3iNP9JffwnPezxUr8DBbsDdDXj2jgeVcIymz0=;
        b=y4el+/MB/tFSi2K+JlgCXLBjzmEyTZk4nhbWHBpP7S556tx5jD71wwAiR7hU/J+f0i
         1V9E+7GelegvlBEwBF+fH+O/nRjGxUQNfTrjlQ9HJbYybIcpxNAfvKeXbwSzPogIQYvt
         97XP+itJkgVHbBhjC1m6HihN1ndZUV3PslQAsTF6wM4B1haHOVf1jXEL9GOqkFask3FL
         8ek4wiVQb3UK7KOtRHzzFSdRtBwv83FUSIvN6TfRenJOC+3rszqAWtkgbELREt/ejfp5
         j4b68/TYoHASU0aIuAjUBYrHyriw9psZh3gYvmRl7RCk9crzpuBzw+3uWirNXLq9GApN
         csUA==
X-Gm-Message-State: ACgBeo18LMqEVGz8Cltd2rLVrtPyGyWagQnLdTQ99/W8xL+d0PXAMMgz
        iMc02Wd406cWPh0mGKfNOLvBS3NSz1exYgoc83c=
X-Google-Smtp-Source: AA6agR6Q1ZPykvZNTAf+ebF6H58KCUdYQ+AG5QbdDvM+SLqBqlhLVQsL5sAJCupIpLaWn9he2SzgKpwrDmEvMkESArI=
X-Received: by 2002:a05:6214:2022:b0:497:2c03:61 with SMTP id
 2-20020a056214202200b004972c030061mr16994102qvf.11.1661889763980; Tue, 30 Aug
 2022 13:02:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220830110709.2037302-1-o.rempel@pengutronix.de> <20220830110709.2037302-3-o.rempel@pengutronix.de>
In-Reply-To: <20220830110709.2037302-3-o.rempel@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 30 Aug 2022 23:02:08 +0300
Message-ID: <CAHp75Vc-NNZfSaM8wwf+558aHKU9ZL0Fp3aJEop475mHTExKjw@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] iio: adc: tsc2046: silent spi_device_id warning
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

On Tue, Aug 30, 2022 at 2:19 PM Oleksij Rempel <o.rempel@pengutronix.de> wrote:
>
> Add spi_device_id to silent following warning:
>  SPI driver tsc2046 has no spi_device_id for ti,tsc2046e-adc

Missed period.

...

> -       dcfg = device_get_match_data(dev);

Why remove this and duplicate the check below with the inverted conditional?

> +       if (!dev_fwnode(dev)) {
> +               const struct spi_device_id *id;
> +
> +               id = spi_get_device_id(spi);
> +               dcfg = (const struct tsc2046_adc_dcfg *)id->driver_data;
> +       } else {
> +               dcfg = device_get_match_data(dev);
> +       }

if (!dcfg) {
  ...try SPI ID...
}
if (!dfg)
  return -E...

-- 
With Best Regards,
Andy Shevchenko
