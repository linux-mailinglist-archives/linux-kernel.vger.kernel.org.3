Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB8A4FF97B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 16:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236322AbiDMO4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 10:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235915AbiDMO4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 10:56:37 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C8435853;
        Wed, 13 Apr 2022 07:54:15 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id v4so2686088edl.7;
        Wed, 13 Apr 2022 07:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MsuM3bWxLpM0X8gDoogn/CmcOLdvtiIpUqO+59cr1LA=;
        b=cVIvzMZK3+X9w8Y8SlSIQ/kSqVSvwVRLF4mCx/phZOopUu2JsH/DrNh09pl99rMSgW
         yF81A9Xo7Azt7dIih2sHI0iazTfboB1e4dKZ8PqTjrWvoG7xz3AJTu4p/gEVO2UJELlP
         37rctWcVIbgJGk9rJ2hEzd36cktyy6aEjPvKGzFea9S3D0kyI3a3s2RJ3jE+KwJH7yG9
         QbyA1Ka/IM6OKHp244AUjPHT6ZB52t/IzFGHKCIcsI1xiSU8Zok4CefKf3g76xKIV+TS
         UKxY8GHCuDv24tRqX2ABPbbV1EDLFTBvBQ9WaspjdwmaASfOTF/rOfUKDKH1qKTqRFas
         bH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MsuM3bWxLpM0X8gDoogn/CmcOLdvtiIpUqO+59cr1LA=;
        b=gDEF1U/leYgGmHYKyVJcY9fA12Fo0ebL1Og0EQTaDz1p0rb7z0qMcx25x8WJ5tpDM3
         Vq5goxL4gBdcVmTevWd4e1LhDALwYO08kTRymxRburqM7aN7razZLnVLiSdneN/6K9vo
         XP57ObOHWwS4gBZAtLwlht2ly/+tr++EGlMeIhd2N3tNCaMPFHWbNg26OSbwytNLM1Kp
         9GXgnT5xhfAkIaGDpwtljq7fAK8Ms+sDYJDYG2i0Oumnhb2TQMHliyJ+HTfPals7dobZ
         bFnqgX3ObApDsiysbsBZ74BXxPbCntmHLA1XZQBrOc3BklPDJSyku7vpHEUFl+eROvV2
         og5Q==
X-Gm-Message-State: AOAM5334fZ90+LNZJrNVGmZNvJfkiRMUrk1zrqism39bY/QyFPYXfMsf
        uEzLwbUXvtBjL6eTFfCzBRIz7LWhUi6jSnDZL4U=
X-Google-Smtp-Source: ABdhPJxPoCxL9183qcM2JHaUk1J7xZA0AhCa/tILcvARmu0cjoFPH48I3A5IVHobbtiSKzTzkZ/GOZzCOCjs2xAvWD4=
X-Received: by 2002:a50:cc9e:0:b0:41d:7123:d3ba with SMTP id
 q30-20020a50cc9e000000b0041d7123d3bamr21071739edi.296.1649861653819; Wed, 13
 Apr 2022 07:54:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220413094011.185269-1-cosmin.tanislav@analog.com>
In-Reply-To: <20220413094011.185269-1-cosmin.tanislav@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 Apr 2022 17:50:01 +0300
Message-ID: <CAHp75VfjexQG_y5XkQWUd_aWwTyDBcwJ2-As+casajBH1ns6aQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] dt-bindings: iio: adc: add AD4130
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
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

On Wed, Apr 13, 2022 at 2:08 PM Cosmin Tanislav <demonsingur@gmail.com> wrote:
>
> AD4130-8 is an ultra-low power, high precision,
> measurement solution for low bandwidth battery
> operated applications.
>
> The fully integrated AFE (Analog Front-End)
> includes a multiplexer for up to 16 single-ended
> or 8 differential inputs, PGA (Programmable Gain
> Amplifier), 24-bit Sigma-Delta ADC, on-chip
> reference and oscillator, selectable filter
> options, smart sequencer, sensor biasing and
> excitation options, diagnostics, and a FIFO
> buffer.

Something is wrong about the indentation above. It may be reconfigured
to fit more characters per line.

-- 
With Best Regards,
Andy Shevchenko
