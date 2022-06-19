Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24EC055080D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 05:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbiFSD1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 23:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbiFSD1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 23:27:04 -0400
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0475DBC3C;
        Sat, 18 Jun 2022 20:27:04 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id r4so7563857vsf.10;
        Sat, 18 Jun 2022 20:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=KN2s3veZQx9XEF2XQ7UaJVGx89CsCem7FDC+Kh/76iE=;
        b=NKTwsZeHat4DmJLaLYdSAo1EnY9xV/NB4FqJDNySuS9XpO7sh23j7hws5KqnjYWXcY
         RWpkLohI5Kx+7k8t4H2easKIm8DjjUWD496aqB+1JscZwAWPd5LGxj/hh+XTxtIwMr/o
         MFXDNLDSq9dT/E2DENur4sJCVbWxomwGOncOFbsIKOxhCWcxvhHY1hKuTPUoa46NYUCC
         7P+o+ViZsQR7PLltnBHhdsKAEr5IqJGb2h85el6S9UYP5MDwO6KGHwYP7m7EDQFVI8wA
         xipa/F1URgA1Z6Ul/zM1d3jUgjiSjs7BdCvck6mf3wVNctWoXaGWrHygA5TH2mW2kX4j
         66+g==
X-Gm-Message-State: AJIora9OSsCBLTvV5uaEI0EQYjkZ7ibVljKZKA9J0X/44CrLMClYAjAI
        ADYYqVakzbTojhlNuS2Eru3sgzh6Hsdmjg==
X-Google-Smtp-Source: AGRyM1vnDdq9NF+Fwc82pzEZdr3lnypGD4/MCCTPB5SAn+UfKXEIUsGDGcl8EbMEyGklJaUU3+jM9A==
X-Received: by 2002:a67:f88e:0:b0:354:2fd5:1869 with SMTP id h14-20020a67f88e000000b003542fd51869mr75963vso.42.1655609223008;
        Sat, 18 Jun 2022 20:27:03 -0700 (PDT)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id b25-20020a056102233900b00349dedb879esm1247612vsa.1.2022.06.18.20.27.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jun 2022 20:27:02 -0700 (PDT)
Received: by mail-vk1-f169.google.com with SMTP id k5so600111vkd.8;
        Sat, 18 Jun 2022 20:27:02 -0700 (PDT)
X-Received: by 2002:a05:6122:2205:b0:321:230a:53e1 with SMTP id
 bb5-20020a056122220500b00321230a53e1mr6915323vkb.25.1655609222328; Sat, 18
 Jun 2022 20:27:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220618214009.2178567-1-aidanmacdonald.0x0@gmail.com> <20220618214009.2178567-5-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220618214009.2178567-5-aidanmacdonald.0x0@gmail.com>
Reply-To: wens@csie.org
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sun, 19 Jun 2022 11:26:50 +0800
X-Gmail-Original-Message-ID: <CAGb2v65GLH_bFRXYxkzRqUsmdZoLZg7MLTLPMj6d0FqHzN8avw@mail.gmail.com>
Message-ID: <CAGb2v65GLH_bFRXYxkzRqUsmdZoLZg7MLTLPMj6d0FqHzN8avw@mail.gmail.com>
Subject: Re: [PATCH v3 04/16] dt-bindings: iio: adc: axp209: Add AXP192 compatible
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
> The AXP192 is identical to the AXP20x, except for two additional
> GPIO ADC channels.
>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
