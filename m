Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFD955081B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 05:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbiFSDfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 23:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiFSDfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 23:35:10 -0400
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95754E0AA;
        Sat, 18 Jun 2022 20:35:09 -0700 (PDT)
Received: by mail-vk1-f175.google.com with SMTP id b5so424877vkp.4;
        Sat, 18 Jun 2022 20:35:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=PYdi3RN1EFrd9W5OnYRhUPpSnzGMgBN8JOB8wfBDroI=;
        b=rz7qQWHyrbqjyTlEefLBPqbAqatDXLfnisjHYIMedkUqC3js7ZnyeYGsYQle/APKDU
         Tj2A12YoNqg7t54lqrT4k+Ot2pKnhPxpLicGfS12Rnq3DdJIwFIfIuS4B0OY148lrgno
         61pyR4IkjmEr/PG3NCMCg3qShJ/p6FPrzNZMGe8pfCzO0WxWvdMgEykqwUIoLLShYxUe
         0JZrLba2oG5P0tb8c70SqdjrZiosah9nz+eAkHuYwvXrzNrnyiH+Ibih5GNmhUfk/Od5
         BSZbgVVQ8zqLT5n5MWP0sf+he7b73Y6B8LrFoRCAHDUpFgaGRhn7GSf+5IxRj5ul/kYK
         8wew==
X-Gm-Message-State: AJIora9NVS2wDp3WKpiJWwYFJRNr0rNsasxBwdbwrJ8QVq7de0yTIcBO
        5JITOt+/Iuxr9B4wOWUo8IfuiKxsZjrY+g==
X-Google-Smtp-Source: AGRyM1tUqzTITQHEg4LfU/KCr4BmsIjdWYQx7TpAihFjAP/XjXdmF5yUUzbGF5mUReRJVeOYwlKpjw==
X-Received: by 2002:a05:6122:1990:b0:36b:f70c:ba55 with SMTP id bv16-20020a056122199000b0036bf70cba55mr1223702vkb.12.1655609708486;
        Sat, 18 Jun 2022 20:35:08 -0700 (PDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id r21-20020a056122015500b0035cf844fdf6sm1313728vko.53.2022.06.18.20.35.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jun 2022 20:35:08 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id l9so2851359uac.4;
        Sat, 18 Jun 2022 20:35:07 -0700 (PDT)
X-Received: by 2002:ab0:2705:0:b0:379:7378:3c75 with SMTP id
 s5-20020ab02705000000b0037973783c75mr6476337uao.77.1655609707538; Sat, 18 Jun
 2022 20:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220618214009.2178567-1-aidanmacdonald.0x0@gmail.com> <20220618214009.2178567-6-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220618214009.2178567-6-aidanmacdonald.0x0@gmail.com>
Reply-To: wens@csie.org
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sun, 19 Jun 2022 11:34:56 +0800
X-Gmail-Original-Message-ID: <CAGb2v6455AN7BGoUoOigvVvJ0nrrp1HvA4tsNs4AkaOKJ-mxfA@mail.gmail.com>
Message-ID: <CAGb2v6455AN7BGoUoOigvVvJ0nrrp1HvA4tsNs4AkaOKJ-mxfA@mail.gmail.com>
Subject: Re: [PATCH v3 05/16] dt-bindings: power: supply: axp20x: Add AXP192 compatible
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>, quic_gurus@quicinc.com,
        sebastian.reichel@collabora.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>, michael@walle.cc,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 19, 2022 at 5:40 AM Aidan MacDonald
<aidanmacdonald.0x0@gmail.com> wrote:
>
> The AXP192's USB power supply is similar to the AXP202 but it has
> different USB current limits.

Should also mention the different register offset for VBUS status.

ChenYu

>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  .../bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml  | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
> index 0c371b55c9e1..e800b3b97f0d 100644
> --- a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
> @@ -22,6 +22,7 @@ properties:
>    compatible:
>      oneOf:
>        - enum:
> +          - x-powers,axp192-usb-power-supply
>            - x-powers,axp202-usb-power-supply
>            - x-powers,axp221-usb-power-supply
>            - x-powers,axp223-usb-power-supply
> --
> 2.35.1
>
