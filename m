Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28FF55B1FD
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 14:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbiFZMzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 08:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiFZMzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 08:55:01 -0400
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729ACDFC8;
        Sun, 26 Jun 2022 05:55:00 -0700 (PDT)
Received: by mail-vk1-f175.google.com with SMTP id h26so3336654vkc.2;
        Sun, 26 Jun 2022 05:55:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=yqtz03d/8VVQOOrMgydVQiE0moemMjNzZ8U8z/Pzx84=;
        b=elUFHirKxEpFfsl3HuOqSNl83TzWNQDbOCR4tIZqcZJCC7ZuEoe4szt1Isj1RMFdHW
         hPD6lN8mpgG4EqIZoMjHdoK7pazkFXIfibnQvxyLfEBGoaErWvenDeZ+XrrIhYvqWl9b
         vYRR1uvT7Z94rF4DSFIsgiIYyipQSGUtyKMmpkD7rlnaILAnroPmwv2piezNHOZZVg2F
         uZqS8hT7qz0pM0pzMN7JxGyArbLFkc/p/0CoypLJHa+Dd/weSbqm2aT2x3c4VF+EHk+N
         pTfVrfXiEo7I2SIufhOMVKl0fLM/HMd9keZmbIARPsYbwkz1O6gyVQTxQYQ5XC6mdCkA
         QbYA==
X-Gm-Message-State: AJIora9ppI5C/njzs9bs2u0ex0Wjk9N/T/DAYBlSvtK9ibfh3llOtDl7
        uEpdk4yWk+7GX2C6kxaNyqOtZO7ATBflaA==
X-Google-Smtp-Source: AGRyM1uTFdWobjldvp8Q+rfyFvu7OTLZf+MRbfoxvmzqiE0DyNWuQZEbpdfXWGBDeSSSys7xnqNykQ==
X-Received: by 2002:a05:6122:2205:b0:321:230a:53e1 with SMTP id bb5-20020a056122220500b00321230a53e1mr2713060vkb.25.1656248099422;
        Sun, 26 Jun 2022 05:54:59 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id y66-20020a1f3245000000b0036ca4583f08sm1018384vky.16.2022.06.26.05.54.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 05:54:59 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id x24so2526081uaf.11;
        Sun, 26 Jun 2022 05:54:59 -0700 (PDT)
X-Received: by 2002:ab0:3148:0:b0:381:dead:3100 with SMTP id
 e8-20020ab03148000000b00381dead3100mr202079uam.73.1656248098889; Sun, 26 Jun
 2022 05:54:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220621034224.38995-1-samuel@sholland.org> <20220621034224.38995-4-samuel@sholland.org>
In-Reply-To: <20220621034224.38995-4-samuel@sholland.org>
Reply-To: wens@csie.org
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sun, 26 Jun 2022 20:54:47 +0800
X-Gmail-Original-Message-ID: <CAGb2v64exg=+=u2OGm63diCNf1AQbB3VVUcQ3a6EKOcdRvgE6w@mail.gmail.com>
Message-ID: <CAGb2v64exg=+=u2OGm63diCNf1AQbB3VVUcQ3a6EKOcdRvgE6w@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] pinctrl: axp209: Support the AXP221/AXP223/AXP809 variant
To:     Samuel Holland <samuel@sholland.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Tue, Jun 21, 2022 at 11:42 AM Samuel Holland <samuel@sholland.org> wrote:
>
> These PMICs each have 2 GPIOs with the same register layout as AXP813,
> but without an ADC function. They all fall back to the AXP221 compatible
> string, so only that one needs to be listed in the driver.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
