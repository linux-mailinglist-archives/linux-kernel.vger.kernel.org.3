Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73EA64D153C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 11:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346032AbiCHKyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 05:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346017AbiCHKyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 05:54:50 -0500
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC1041303;
        Tue,  8 Mar 2022 02:53:53 -0800 (PST)
Received: by mail-qk1-f182.google.com with SMTP id q194so720807qke.5;
        Tue, 08 Mar 2022 02:53:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y3UjhnfNllI0p7H4Pz4n1OpkqRIkGKtHIsAtcWmQ56k=;
        b=wVHo5IQ5bciRSAK0P1M09x6mXHwaDOhfHfSGVE7HnYRYSs8WMMSRJAevSGGA8CmSdj
         O7v/i1pSIl5ROilAe8XMd51r6D7irrPDX8HlU9jdfuFjlsL9zdNoBqtAvZBTG8NFXiPl
         ozZosREixJ7X703acFawjiuztlP2BOSKtwyGoaDzVKY9ROCTtuj6XPFgrcrW/p9vAcHu
         vsN3NpOgLQVnQ1c8KPWkpv6dIWM1mdN8PZzttfhhCh2T7CkC1Q80HORK3ip4QDkchMVL
         qPlk7p7DAXv8WyithiJvif5fDegJEGbp+1JzAcNtLe6njEjFRSJXJlOM74J6B5xO0mi0
         GhUA==
X-Gm-Message-State: AOAM530Psmd0RiXDuKZA+f6oz6WnsmVADtWrZYpASFRWNKdFzCLR1f85
        v4/Dd0CDgEPyFjZuxsxtNa9XKyiicv57xA==
X-Google-Smtp-Source: ABdhPJyaD6taEO+1bVn3Egmp6kNMQdMy0Ml9Ar+8QirDSJHZvhJ4Kp4/462N9EEFattiblNPh5ZoTQ==
X-Received: by 2002:a05:620a:2589:b0:67b:d0c:71bc with SMTP id x9-20020a05620a258900b0067b0d0c71bcmr8343413qko.570.1646736832493;
        Tue, 08 Mar 2022 02:53:52 -0800 (PST)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id z3-20020ac87f83000000b002deae661c08sm10069704qtj.33.2022.03.08.02.53.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 02:53:51 -0800 (PST)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-2dbc48104beso196634157b3.5;
        Tue, 08 Mar 2022 02:53:51 -0800 (PST)
X-Received: by 2002:a81:618b:0:b0:2db:d952:8a39 with SMTP id
 v133-20020a81618b000000b002dbd9528a39mr12190538ywb.132.1646736830798; Tue, 08
 Mar 2022 02:53:50 -0800 (PST)
MIME-Version: 1.0
References: <20220124121009.108649-1-alistair@alistair23.me> <20220124121009.108649-3-alistair@alistair23.me>
In-Reply-To: <20220124121009.108649-3-alistair@alistair23.me>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Mar 2022 11:53:39 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVNgVQzjrdybbnfCEr+G5Q4ztjRCC29RF9HwGnhKkPn3Q@mail.gmail.com>
Message-ID: <CAMuHMdVNgVQzjrdybbnfCEr+G5Q4ztjRCC29RF9HwGnhKkPn3Q@mail.gmail.com>
Subject: Re: [PATCH v18 2/8] mfd: simple-mfd-i2c: Add a Kconfig name
To:     Alistair Francis <alistair@alistair23.me>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-hwmon@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
        Zhang Rui <rui.zhang@intel.com>, alistair23@gmail.com,
        Amit Kucheria <amitk@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alistair,

Thanks for your patch, which is now commit bae5a4acef67db88
("mfd: simple-mfd-i2c: Add a Kconfig name") in mfd/for-mfd-next.

On Mon, Jan 24, 2022 at 1:24 PM Alistair Francis <alistair@alistair23.me> wrote:
> Add a Kconfig name to the "Simple Multi-Functional Device support (I2C)"
> device so that it can be enabled via menuconfig.

Which still does not explain why this would be needed...

> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1188,7 +1188,7 @@ config MFD_SI476X_CORE
>           module will be called si476x-core.
>
>  config MFD_SIMPLE_MFD_I2C
> -       tristate
> +       tristate "Simple Multi-Functional Device support (I2C)"
>         depends on I2C
>         select MFD_CORE
>         select REGMAP_I2C

The help text states:

| This driver creates a single register map with the intention for it
| to be shared by all sub-devices.

Yes, that's what MFD does?

| Once the register map has been successfully initialised, any
| sub-devices represented by child nodes in Device Tree will be
| subsequently registered.

OK...?

Still, no clue about what this driver really does, and why and when
it would be needed.

There is one driver symbol that selects MFD_SIMPLE_MFD_I2C.
There are no driver symbols that depend on this symbol.

If you have a driver in the pipeline that can make use of this,
can't it just select MFD_SIMPLE_MFD_I2C, so the symbol itself can
stay invisible?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
