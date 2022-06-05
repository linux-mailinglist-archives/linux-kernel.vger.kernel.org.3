Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C1353DE78
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 23:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348016AbiFEVwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 17:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbiFEVww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 17:52:52 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DA72657;
        Sun,  5 Jun 2022 14:52:51 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id fu3so24124682ejc.7;
        Sun, 05 Jun 2022 14:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jqTk340kUGoNwvIFE+KUlemPpmjVQ4n06NM+Fh67geI=;
        b=S7PqYSet+vFl8kirvv4A6Qj3FyqLfBo228GfA3RfabMvlQmLo/s3OVoof1ooAGwJ3O
         unGBnwV4EiXcgJxpynVgRcp4PSZjjn8j13ixj5R9mEka6MDWqepLy8A66iXeuAPsufwX
         mHoP0ZSAxQv7Ge2g52W057FMKljiqg3+xVVN1IUAqd49D+Owx1ee/15lRWRnoU8r07l/
         d5nFwzYjK+kq4TI7akEb9KUteEikzmQBEaKkJH0Tdwr6/4MI79G4E1mp9xlNHBMz9q94
         SU4L30TKJX19OYFXv+UXJT0ADC9gpd/Dos+m6tZk+X778Ca+QMozAZhDGC232x3Z1qQZ
         pnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jqTk340kUGoNwvIFE+KUlemPpmjVQ4n06NM+Fh67geI=;
        b=e20e9pYEk+4LpTLL/PdpIJhbwhqCvWcn4/sbsP5hyp8mSbEV6vuV2Ru9eiCQcv2vk1
         QMB2mtiMzTsaFGI6tPD+uudShMe9H2FGQ208yAnXYAUe7pe0YNLAEBAQbgsBF6hcAToj
         eDsqlIWpm2kmGXKoqvMM3olLi8w8pE5KVFOV2t39UQ5atR40uoMvMPZ5u3nWMohUTzJd
         Oe6Kwo71pdSBFV8CpX6CAx1WRs+1dh/ySJ4cpHUihD0ZS6G3MWmUjKUoX1wGngBCqI2w
         HM+7ApCKyB/WtElJ+tA0TP9G8qFLjvvOcEBrQ59nK6FTaKQOxd00V7sNQ6y5+B/U1qnv
         WkEQ==
X-Gm-Message-State: AOAM530/2h1PqZ2h5WfrrFvV6dv/CBSRsMJDGNHZCMTzcF2+H6N8JZnT
        XHGPlxK08yZZclq6KmFNPBo5qtaZvd0bQaNZSsU=
X-Google-Smtp-Source: ABdhPJyajjoGEdHfoyCFfJ5xd/VGskW7hkoSyT1FnOhazKlHAmOLujiBhmJOBWa5cnZ57m/vRbQEmQ7U9GhZYiWGRT0=
X-Received: by 2002:a17:907:7f21:b0:6ff:10b:9cee with SMTP id
 qf33-20020a1709077f2100b006ff010b9ceemr18748924ejc.302.1654465970323; Sun, 05
 Jun 2022 14:52:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220603100004.70336-1-andriy.shevchenko@linux.intel.com> <20220603100004.70336-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220603100004.70336-2-andriy.shevchenko@linux.intel.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 5 Jun 2022 23:52:39 +0200
Message-ID: <CAFBinCDJm=hvbE3gy0H-3rQvnxOO6bnQe-5yir9=aMG1BiXVuw@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] iio: adc: meson_saradc: Align messages to be with
 physical device prefix
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
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

On Fri, Jun 3, 2022 at 12:00 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Align messages to be printed with the physical device prefix as it's done
> everywhere else in this driver.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
