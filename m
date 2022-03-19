Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A154DE745
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 10:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242585AbiCSJdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 05:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbiCSJdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 05:33:05 -0400
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C650726367D;
        Sat, 19 Mar 2022 02:31:45 -0700 (PDT)
Received: by mail-qk1-f181.google.com with SMTP id g8so8460043qke.2;
        Sat, 19 Mar 2022 02:31:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KeQ7yX2kKuYHHbbbBJLbr6R2DhCE63F4Wa3rnEOCJlg=;
        b=j3b7ESQXfAwpy9DEoH1UD0vsE2mSrLSFS0QXi37jHC8RE3FT3FTiwlgLMEIT23cdK5
         ZTrzH2JSZvdWIDaP9oTEIn4+awAiYkjJqcLwyg1V2wzkU12cWxYh4NBe+BThqAq0tCKk
         3t873GUhoGIpOP5KGxeXdaksG4spvkwrdeL7Xv8IaoW4C0zqKv422pYpTkc7lhsjakER
         S2gWKBX/yTqysoMAvAegWTDRwSo49a8/p+1e2xJok6A/wE0T2Jmq773KZA6Avg3Lv086
         vwC3Yx/USwbyrCwyo2XrbJlfNTnDcvesyUCAbeHjGo59V1AI6Q2yYTnQVnNp5XHMC174
         SYMQ==
X-Gm-Message-State: AOAM533Y73NTMIpc4Dm283t79ojj8Mpbdlw5ILhlCKKf4nWET5nzLlE/
        vQ7yzovIFHLCB6a3DgmgLdpcM7bndyrtgQ==
X-Google-Smtp-Source: ABdhPJyQmP2/SXwka8vQTI+lrtMD6jR6nWHvS/VEpo2i49x/180A36XSCYwLCsPGSRSpQ09EuALnOg==
X-Received: by 2002:a05:620a:4309:b0:67b:3fc1:86eb with SMTP id u9-20020a05620a430900b0067b3fc186ebmr7855300qko.495.1647682304439;
        Sat, 19 Mar 2022 02:31:44 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id b17-20020a05622a021100b002e1f86db385sm4402948qtx.68.2022.03.19.02.31.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Mar 2022 02:31:43 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id z8so19794201ybh.7;
        Sat, 19 Mar 2022 02:31:43 -0700 (PDT)
X-Received: by 2002:a25:45:0:b0:633:96e2:2179 with SMTP id 66-20020a250045000000b0063396e22179mr14151314yba.393.1647682303385;
 Sat, 19 Mar 2022 02:31:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220124121009.108649-1-alistair@alistair23.me> <20220124121009.108649-4-alistair@alistair23.me>
In-Reply-To: <20220124121009.108649-4-alistair@alistair23.me>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 19 Mar 2022 10:31:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUp3ze1muL2kRDWF+msuEqNFx1ueuZ0hNXm59HiU=5vaw@mail.gmail.com>
Message-ID: <CAMuHMdUp3ze1muL2kRDWF+msuEqNFx1ueuZ0hNXm59HiU=5vaw@mail.gmail.com>
Subject: Re: [PATCH v18 3/8] mfd: simple-mfd-i2c: Enable support for the
 silergy, sy7636a
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

On Mon, Jan 24, 2022 at 1:24 PM Alistair Francis <alistair@alistair23.me> wrote:
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

> --- a/drivers/mfd/simple-mfd-i2c.c
> +++ b/drivers/mfd/simple-mfd-i2c.c
> @@ -62,8 +62,19 @@ static int simple_mfd_i2c_probe(struct i2c_client *i2c)
>         return ret;
>  }
>
> +static const struct mfd_cell sy7636a_cells[] = {
> +       { .name = "sy7636a-regulator", },
> +       { .name = "sy7636a-temperature", },
> +};
> +
> +static const struct simple_mfd_data silergy_sy7636a = {
> +       .mfd_cell = sy7636a_cells,
> +       .mfd_cell_size = ARRAY_SIZE(sy7636a_cells),
> +};
> +
>  static const struct of_device_id simple_mfd_i2c_of_match[] = {
>         { .compatible = "kontron,sl28cpld" },
> +       { .compatible = "silergy,sy7636a", .data = &silergy_sy7636a},
>         {}
>  };

This is slowly turning into a "board file" for an ever-growing random
bunch of devices, none of which is described in the help text?

See also my reply to patch 2/8
https://lore.kernel.org/all/CAMuHMdVy4E1pX+VLLq_05FX4pM+BPZycQgn68ArGh2s8qL24=w@mail.gmail.com/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
