Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F67F54B53D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 18:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344684AbiFNQAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 12:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344449AbiFNP75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 11:59:57 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C0C344D8;
        Tue, 14 Jun 2022 08:59:55 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id w27so12282888edl.7;
        Tue, 14 Jun 2022 08:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HZYr+nXVFt3ZV35WpvqABpP4HeHLwMa+rutNRooSlOQ=;
        b=SwknY7SV+R82lZZu6lBWLGF6ZlNtU3MgUkz3FhJxCvKCZ/YahpmE7dJP9Jvh0OeIEF
         K//Mhb50M8XBLpdHVIGud3xpYZA5syjpS/EWGdBLFANwYM7GOMYFnKWWpJw5JCYT/fwS
         YmvpXBHZCKDQlXM2hkqzWT6EqwIjrNE30zueK0+TTphfirxG8MsR0+CRkBdnGu3f55Eg
         tsi/S1eWaQXHAy6N6rbFTRPZM68RufoT6onEOzCra0Bm3NxvF7ZVdDWrwAp56sIBNn/9
         kx22/4ZXycDGuqZvT3reJcElpPB+SHEGRv24Qp+YdiWasFtgAn7ol+YT5R9qtlVY6g/1
         oElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HZYr+nXVFt3ZV35WpvqABpP4HeHLwMa+rutNRooSlOQ=;
        b=Dpa+zt4KgqFWqsT3Rlo84JrZ+WPdAstrcyUuCCbnjdCBLzZ1JNdeXRkniYm+QNQxF0
         Ir46mM/en6d+LpOpRIpA4xIfHoEGsHq275eeJKvlPZItg5Dt2hFX+YZab6ikO0ZGCjMT
         Zk/kE8GILqzykBRh/n+cqaTDmr3jOSkpQpSTZOAJORb5irteLNTXS1pMcUgR5j+G3l+e
         Kf/J193og0RNefAKATXQ6xbfyep6uSgBb50UDDuKMslcebU13YaVTEKciFblvuLL1eVK
         nsxU1gY/AkdjoB5UH/kF1j13cvJqK7TD1rpkQ5ypBY36D2xyNku4tRiCNV1EF+syrIA5
         Cs8g==
X-Gm-Message-State: AOAM530n7aO+pGedbQqX0kKJOSPzdlaPxXxVxNZqLjJngQswyChS2fpo
        fAgOBAMm8kjiN0c3g/VBBESGyu5sEocxtvcjPAk=
X-Google-Smtp-Source: ABdhPJxBgzGSfDSa2OPyIAwZWVZ4H69sFDzX7scvb8R//2XlGvyvV2b2Ots/wrP8InfDFXtxvo8keG0hr7BkujAlk8s=
X-Received: by 2002:aa7:d481:0:b0:42d:d5fd:f963 with SMTP id
 b1-20020aa7d481000000b0042dd5fdf963mr6906009edr.209.1655222394209; Tue, 14
 Jun 2022 08:59:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220614154245.354167-1-jjhiblot@traphandler.com>
In-Reply-To: <20220614154245.354167-1-jjhiblot@traphandler.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 14 Jun 2022 17:59:17 +0200
Message-ID: <CAHp75VdCYNGhvEd4kbMX1s26QNatEej5_pi6BhjxuDb+0dP9Vw@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Add support for the TLC5925
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     Pavel Machek <pavel@ucw.cz>, krzk+dt@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
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

On Tue, Jun 14, 2022 at 5:42 PM Jean-Jacques Hiblot
<jjhiblot@traphandler.com> wrote:
>
> This series adds the support for the TLC5925 LED controller.
> This LED controller is driven through SPI. There is little internal logic
> and it can be thought of as a deserializer + latches.
> The TLC5925 itself drives up to 16 LEDs, but multiple TLC5925s can be
> chained to drive more.
>
> The first patch describes the dt bindings.
> The second patch implements most of the driver and supports only
> synchronous brightness setting (brightness_set_blocking).
> The last patch implements the non-blocking version (brightness_set).

Thanks!

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
for the entire series.

You may (if v6 is needed) to keep headers ordered (like gpio/consumer
as G and workqueue as W in alphabet).

> changes v4->v5:
>  * add the headers that the code is a direct user of
>  * replace dev_err() with dev_err_probe() in ->probe()
>  * comestic changes (spaces, alignment and blank lines)
>
> changes v3->v4:
>  * add missing MODULE_DEVICE_TABLE(of, ...)
>  * use dev_err_probe() to avoid spamming the log in case of deferred probe
>  * use bitmap ops instead of direct memory access + lock
>  * sort headers and a few other cosmetic changes.
>
> changes v2->v3:
>  * fixed the yaml description of the bindings (now passes dt_binding_check)
>  * renamed shit-register-length into ti,shift-register-length and specify
>    its type
>
> changes v1->v2:
>  * renamed property shift_register_length into shift-register-length
>  * add a SPI MODULE_DEVICE_TABLE structure
>  * fixed the yaml description of the bindings (now passes dt_binding_check)
>
> Jean-Jacques Hiblot (3):
>   dt-bindings: leds: Add bindings for the TLC5925 controller
>   leds: Add driver for the TLC5925 LED controller
>   leds: tlc5925: Add support for non blocking operations
>
>  .../devicetree/bindings/leds/ti,tlc5925.yaml  | 107 +++++++++++
>  drivers/leds/Kconfig                          |   6 +
>  drivers/leds/Makefile                         |   1 +
>  drivers/leds/leds-tlc5925.c                   | 181 ++++++++++++++++++
>  4 files changed, 295 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/ti,tlc5925.yaml
>  create mode 100644 drivers/leds/leds-tlc5925.c
>
> --
> 2.25.1
>


-- 
With Best Regards,
Andy Shevchenko
