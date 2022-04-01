Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C594EE935
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 09:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343960AbiDAHtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 03:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243493AbiDAHtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 03:49:02 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AB218C0F8;
        Fri,  1 Apr 2022 00:47:13 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id t2so1521844qtw.9;
        Fri, 01 Apr 2022 00:47:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hsgG5k1IRB7JkkSvYRKFqt0X90anL2wVYww9yxyb0VA=;
        b=lnOnBBtJyi+ptYHryHFTbrSIM8RtWYeGSVrzVT8ziC8F/Nvt53QglIDMITc2ZX7AhZ
         lrvLKKpXG1PL5hdaAM8vmXsVVGAU/Vd2+aC8GketleM3dPW9YNP0ai6RePkDhl5LVzT0
         FObZUBHwcESGALGiPZLUAugR1xpF5buIXSAhIe4UiaFHlj5D4UyufWZTWiAr2DoDJIfu
         eQ2fID1iWNGcmc5ctX+QJgdx9dPAF5llfXwhwMa/75goEfEsOtIvFwx/nQ6sHtAz8MSD
         Jn0hfb2U4f41ebz2Qndq/UuapX/YJ5UBpzplb0f//nqX69RyWMR3tkk5kQG+00TfP5O8
         Z3yw==
X-Gm-Message-State: AOAM5337dPgbNs8vtYMzN2DFDS9dvLaeg979Rh6dNmtx6Af/MNsw5pmj
        M9Svs/HHxLvSBtctklh2Hg6p3+hxKUWgVw==
X-Google-Smtp-Source: ABdhPJwZE4sp1jfUL16KYUDF2Yg41lwFL597VHQxrQFo3hwFvOCVshdhzRqByH59tiWLWbTzIE+Mzg==
X-Received: by 2002:a05:622a:2d5:b0:2e1:ea60:231 with SMTP id a21-20020a05622a02d500b002e1ea600231mr7530800qtx.460.1648799232308;
        Fri, 01 Apr 2022 00:47:12 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id y17-20020a05622a121100b002e0702457b2sm1303952qtx.20.2022.04.01.00.47.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 00:47:12 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-2e592e700acso23523827b3.5;
        Fri, 01 Apr 2022 00:47:11 -0700 (PDT)
X-Received: by 2002:a81:5c2:0:b0:2e5:e4eb:c3e7 with SMTP id
 185-20020a8105c2000000b002e5e4ebc3e7mr8846053ywf.62.1648799231230; Fri, 01
 Apr 2022 00:47:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220331211653.175200-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220331211653.175200-1-krzysztof.kozlowski@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 1 Apr 2022 09:46:59 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVX-6A5KH1+WodNviq1LKqZ4qo7aq92S-j+zf79xQD0gQ@mail.gmail.com>
Message-ID: <CAMuHMdVX-6A5KH1+WodNviq1LKqZ4qo7aq92S-j+zf79xQD0gQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] regulator: dt-bindings: maxim,max8997: correct array
 of voltages
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 11:17 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> uint32-array with voltages should be within one bracket pair <>, not
> each number in its own <>.  Also the number of elements in the array
> should be defined within "items:".
>
> This fixes DT schema warnings like:
>
>   maxim,max8997.example.dtb: pmic@66: max8997,pmic-buck1-dvs-voltage:
>     [[1350000, 1300000, 1250000, 1200000, 1150000, 1100000, 1000000, 950000]] is too short
>
> Fixes: 1d2104f21618 ("regulator: dt-bindings: maxim,max8997: convert to dtschema")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks!
Warning going, and if I add one entry too much, it still complains, so:
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
