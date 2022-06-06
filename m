Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0406353E86D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239691AbiFFOZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239581AbiFFOZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:25:49 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F1E2D6AA6;
        Mon,  6 Jun 2022 07:25:48 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id y19so29294228ejq.6;
        Mon, 06 Jun 2022 07:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a0c8aCXTnV+YnzgcVK3cYCsnaQ2OrGwT8XZ+B+Q/jUg=;
        b=GcisAG8Oa7796L9CONDDt6OIIQn0huGp9VfxwdG6OouVCGHztFap6mMZZrhHRGubZm
         VD9xcpd+/w40aih8Uj1iNf3fS6OHMI7M428hiwgs1qwYgoB6xRXUdr6DXRRE+wJRgH17
         X4yAfXt9TFiN0Uq9XO6mGXYiYh9CvWMwBB46Ob6gs+X5yZBGTSuFuJhdyu8tZjKKDja9
         5vQxw+xJdSKO/qUzjCo7Lw8T0N2E1gfSSON+TWD+Yiro/wHufQAbakKOR9o/ALbwWw39
         Mjk4pA0NCdIy1PD7V9S++yqxdnhdQL7NJn4Bpr+QigZIH/aJOArjyD89A2r0AyQMM3MF
         +9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a0c8aCXTnV+YnzgcVK3cYCsnaQ2OrGwT8XZ+B+Q/jUg=;
        b=xRUfZLbt7pgkmkndADiD5svasc8yeKo7IFKHDng827fF079+05zFEltgmS+5eTZKAm
         /8HNggDCMP51NDyJlAne0cAR0oUui3Rutl2Ig8PEsWCQoSMn++8CEm+G0r2rwcgTs2cn
         YO6MHVOtc7B55qTGJnlr9OFyqSMoagTyiAo+ftq9sr958qG94YC7mvGYX0Fq75NHom/l
         kcppgoMfkOiOMDqL4mcoswbf2hSV8QrGwTPPseXgaUdK2noeI0kligEfJVoUVOA5t/9q
         3RpFno1Nq21ztOdhJFatHA2ZOELanMmkfixWJx9KH1K/YtFDqTM1lG+NiA5rbejzwpgL
         ZTbA==
X-Gm-Message-State: AOAM531b/4O2RqX6jLFYGJCl2vdEHSBv5KfHL9SG33CdcsuGEJ4IngOc
        nFzCGhlVMWGMDyOJDFtsiPW6EskmpIZ2RrpBfILXaLwUX4SADg==
X-Google-Smtp-Source: ABdhPJzD7u77fBcesP17TjFNq0z2fD+tq04dRC4JePcC1QiaGc2nhtbfkRYB0490U7l5eh6dTvULHUrEbwCqVDzeShc=
X-Received: by 2002:a17:907:2ce3:b0:6ff:1447:d3a4 with SMTP id
 hz3-20020a1709072ce300b006ff1447d3a4mr22624124ejc.497.1654525547146; Mon, 06
 Jun 2022 07:25:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220605144659.4169853-1-demonsingur@gmail.com>
In-Reply-To: <20220605144659.4169853-1-demonsingur@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 6 Jun 2022 16:25:10 +0200
Message-ID: <CAHp75VeHAGM=cxGRzWsv7KxUD0rjiudxOJ2HrtgtTFbuG+z8=g@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] MAX310X I2C support
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Mon, Jun 6, 2022 at 8:08 AM Cosmin Tanislav <demonsingur@gmail.com> wrote:
>
> V1 -> V2:
>  * set_ext_reg_en -> extended_reg_enable
>  * move extended_reg_enable functions under guards
>  * move if_cfg structs under guards
>  * remove __maybe_unused from max310x_i2c_driver
>  * fix order of error labels in module register
>  * guard i2c register error label

LGTM, thanks!
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Cosmin Tanislav (4):
>   serial: max310x: use regmap methods for SPI batch operations
>   serial: max310x: use a separate regmap for each port
>   serial: max310x: make accessing revision id interface-agnostic
>   serial: max310x: implement I2C support
>
>  drivers/tty/serial/Kconfig   |   1 +
>  drivers/tty/serial/max310x.c | 261 ++++++++++++++++++++++++++---------
>  2 files changed, 200 insertions(+), 62 deletions(-)
>
> --
> 2.36.1
>


-- 
With Best Regards,
Andy Shevchenko
