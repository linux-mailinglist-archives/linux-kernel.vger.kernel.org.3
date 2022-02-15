Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145D24B7544
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242856AbiBOSFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 13:05:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236250AbiBOSFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 13:05:34 -0500
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96C6119410;
        Tue, 15 Feb 2022 10:05:23 -0800 (PST)
Received: by mail-vk1-xa2b.google.com with SMTP id f12so3503133vkl.2;
        Tue, 15 Feb 2022 10:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gLFgGT6YwvXW1wx34JstmO2egBx2eW53mLM0rtTg/Sc=;
        b=KID333ITUi73ySWGz7NI+m+E5EGqFpblrSqIqmNw1gXZev9/XDAyukTbxvSCm4gKSe
         4hYTBpYMUl4w0qe6b2urizheFZs7flA7mMy2m+0fkW90KTAMc+4l9325zTeoom60nPYs
         i+UJ1fb2Wu06ksFS/igVcQQwtTeaW27Mni+l43Dx8F84mRa5xhAlk0ArF6LaheuBX6UJ
         WHqlzTFf2rTWdyR0g6exXoLT4XNmSbbdBXaXd9n+7Gd5TlNR6J7zfjZ5wdPk+lhxINmr
         oHu0f4OoYTlA1u0+xeryBjS4Nv1D6zvvWZo2zQnWHVoFn8lk/rrpf7ABra2C4cpBlveU
         hhcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gLFgGT6YwvXW1wx34JstmO2egBx2eW53mLM0rtTg/Sc=;
        b=U8jzPXmfTs1E3eZFsBePME+9oxHNW7t85bCsW3NOyYsIVUERF94d2q5gUxqz2iDf8G
         vXT3p8HGuNNrC7ambIS5pct8R4mFiW8h4zuFns2vDl9rXN7ilAThNSjUVIOsyd5jHuRi
         9T/rIsG/BXRndmVAVm+YWVsVqmoBrQM/hacUT6aua3Y//YA6606zYv44/pXKiVhZAsqT
         ZYgt1ZHaUlqcK5ZxL+FLKPOTMc5hP6FDuzX2DgV2wzN/SA7o08sR4hMNdfcopinz9UWV
         fNZ7j21OeEtvjpvOV7M7yqyggDStLo6TcP7oozLS28h6nbtKImJoHFOdy7Ek+Y5FDpzq
         l8AA==
X-Gm-Message-State: AOAM5326sfqanDRs9LTumaCp+0bfmiqAw9HuzRQHvC7OzZZTw3W9ihQt
        KK8bH4xXFC5uu5TWor9rQ/7yKCkVDVVsdRN8Oco=
X-Google-Smtp-Source: ABdhPJwZ2c4DluFw+8AgtAZO4eg8n+SwcAKGWvctDBdUls3kAzfoEoE5KmSOu0LxpAWQttLVgi0QdO4HXYfEG/R2j3s=
X-Received: by 2002:a05:6122:54e:: with SMTP id y14mr63443vko.37.1644948322750;
 Tue, 15 Feb 2022 10:05:22 -0800 (PST)
MIME-Version: 1.0
References: <20220126175604.17919-1-romain.perier@gmail.com>
In-Reply-To: <20220126175604.17919-1-romain.perier@gmail.com>
From:   Romain Perier <romain.perier@gmail.com>
Date:   Tue, 15 Feb 2022 19:05:11 +0100
Message-ID: <CABgxDo+hRsDo-Hmf4TUmuWQFo0+LnWOTrEQQz0beSjBhxkZ6_Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] ARM: mstar: cpupll
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ping :)

Regards,
Romain

Le mer. 26 janv. 2022 =C3=A0 18:56, Romain Perier <romain.perier@gmail.com>=
 a =C3=A9crit :
>
> This series adds a basic driver for the PLL that generates
> the cpu clock on MStar/SigmaStar ARMv7 SoCs.
>
> Unfortunately there isn't much documentation for this thing
> so there are few magic values and guesses.
>
> This needs to come after the MPLL DT changes.
>
> Changes since v3:
> - Added Reviewed-by on Daniel's patches
> - Removed "[PATCH v3 8/9] ARM: mstar: Add OPP table for mercury5"
>
> Changes since v2:
> - Re-ordered Kconfig by name
> - Re-ordered includes alphabetically and removed useless ones
> - Used timeout for cpu_relax
> - Returned DIV_ROUND_DOWN_ULL() directly in
>   msc313_cpupll_frequencyforreg()
> - Returned DIV_ROUND_DOWN_ULL() directly in
>   msc313_cpupll_regforfrequecy()
> - Reduced the number of lines for msc313_cpupll_of_match
> - Removed CLK_IS_CRITICAL
>
> Changes since v1:
> - Re-worked the series and ensure that 'make dt_binding_check' passes.
>   The required commit is merged now, so it is okay.
> - Fixed coding style issues in the driver and makes check_patch.pl happy
> - Added one more commit for extending the opp_table for infinity2m.
>
> Daniel Palmer (7):
>   dt-bindings: clk: mstar msc313 cpupll binding description
>   clk: mstar: msc313 cpupll clk driver
>   ARM: mstar: Add cpupll to base dtsi
>   ARM: mstar: Link cpupll to cpu
>   ARM: mstar: Link cpupll to second core
>   ARM: mstar: Add OPP table for infinity
>   ARM: mstar: Add OPP table for infinity3
>
> Romain Perier (1):
>   ARM: mstar: Extend opp_table for infinity2m
>
>  .../bindings/clock/mstar,msc313-cpupll.yaml   |  45 ++++
>  arch/arm/boot/dts/mstar-infinity.dtsi         |  34 +++
>  arch/arm/boot/dts/mstar-infinity2m.dtsi       |  17 ++
>  arch/arm/boot/dts/mstar-infinity3.dtsi        |  58 +++++
>  arch/arm/boot/dts/mstar-v7.dtsi               |   9 +
>  drivers/clk/mstar/Kconfig                     |   8 +
>  drivers/clk/mstar/Makefile                    |   2 +-
>  drivers/clk/mstar/clk-msc313-cpupll.c         | 221 ++++++++++++++++++
>  8 files changed, 393 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/mstar,msc313-=
cpupll.yaml
>  create mode 100644 drivers/clk/mstar/clk-msc313-cpupll.c
>
> --
> 2.34.1
>
