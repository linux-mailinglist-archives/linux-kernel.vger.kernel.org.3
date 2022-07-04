Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77AE7564E85
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 09:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbiGDHSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 03:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiGDHSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 03:18:47 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073502706;
        Mon,  4 Jul 2022 00:18:46 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id i11so8812197qtr.4;
        Mon, 04 Jul 2022 00:18:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6tMtEfymLYGpun2wH/z81xUpOjguCTsRicvBylQy/MA=;
        b=hq5w4SbQHpxl7Ey0K87sGwMKfXP4ggpGDpyLf9fwGfeFqz8KZ/oqgudYEs/kkBnqDy
         7pcXnGNlFniy3rCpecX4Jj12W1/08J1aihoQM7uwSwvn5aeGjZIwbzterypVzpqWffgC
         QAVhQI7ntTQGadYujqym8EdrswvfZmp9uXSRVy69M7JyxgxtCL4TWvTuw2FBY3xO8vu1
         y9jwbeM0dev3QMIAvghZCZRCzVRgM08x1ymB2lHutUqthrUa/nSEScWucMThxtSW8jfW
         A3BZwGZ+gbMNYuFZZFTUu+GFeUnr6LnwTklqM1DVt4xtEGOmVY9y16cHcH04H+QEBQYb
         2Yvg==
X-Gm-Message-State: AJIora+KNZa03V39VGKieeS8uNULYFFa3RUhWrChe1gsIDqQ/BqaD/KH
        BmHEXc0SfGSw0+elO0eL+2FtXQhxpjkmhg==
X-Google-Smtp-Source: AGRyM1uHguglRTerPiZ2GTjdMYiNuPMtINQpWWbgGtvStgk6gzOJRScEmfEFLzGs558MLx2l4aPtuA==
X-Received: by 2002:ac8:5c06:0:b0:31d:4bc6:1ec8 with SMTP id i6-20020ac85c06000000b0031d4bc61ec8mr3664264qti.123.1656919124900;
        Mon, 04 Jul 2022 00:18:44 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id v12-20020a05620a0f0c00b006a73654c19bsm25993326qkl.23.2022.07.04.00.18.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 00:18:44 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id r3so15336689ybr.6;
        Mon, 04 Jul 2022 00:18:44 -0700 (PDT)
X-Received: by 2002:a05:6902:a:b0:65c:b38e:6d9f with SMTP id
 l10-20020a056902000a00b0065cb38e6d9fmr31391726ybh.36.1656919124017; Mon, 04
 Jul 2022 00:18:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220703183449.12917-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220703183449.12917-1-krzysztof.kozlowski@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Jul 2022 09:18:31 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUnH0oRQg3i1VorZOmNSKKXRP91BiQEgBaV5W5ig+YH2A@mail.gmail.com>
Message-ID: <CAMuHMdUnH0oRQg3i1VorZOmNSKKXRP91BiQEgBaV5W5ig+YH2A@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] dt-bindings: hwinfo: group devices and add s5pv210-chipid
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
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

Hi Krzysztof,

On Sun, Jul 3, 2022 at 8:35 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> As suggested by Rob [1], I organized a bit bindings for SoC devices having
> similar purpose - chip identification.
>
> These sometimes are put under nvmem directory, although in that case the
> purpose is usually broader than just chipid.

Thanks for your series!

>   dt-bindings: hwinfo: group Chip ID-like devices
>   dt-bindings: hwinfo: samsung,s5pv210-chipid: add S5PV210 ChipID

So why not call it "chipid"?
"hwinfo" sounds too generic to me; aren't all DT bindings hardware
information?

>
>  .../{soc/renesas => hwinfo}/renesas,prr.yaml  |  2 +-
>  .../samsung,exynos-chipid.yaml}               |  2 +-
>  .../hwinfo/samsung,s5pv210-chipid.yaml        | 30 +++++++++++++++++++
>  .../ti,k3-socinfo.yaml}                       |  2 +-
>  MAINTAINERS                                   |  3 ++
>  5 files changed, 36 insertions(+), 3 deletions(-)
>  rename Documentation/devicetree/bindings/{soc/renesas => hwinfo}/renesas,prr.yaml (92%)
>  rename Documentation/devicetree/bindings/{soc/samsung/exynos-chipid.yaml => hwinfo/samsung,exynos-chipid.yaml} (92%)
>  create mode 100644 Documentation/devicetree/bindings/hwinfo/samsung,s5pv210-chipid.yaml
>  rename Documentation/devicetree/bindings/{soc/ti/k3-socinfo.yaml => hwinfo/ti,k3-socinfo.yaml} (92%)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
