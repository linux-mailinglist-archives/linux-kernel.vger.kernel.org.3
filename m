Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286A3581B98
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 23:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239239AbiGZVL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 17:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiGZVL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 17:11:28 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345672A723;
        Tue, 26 Jul 2022 14:11:27 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id j195so7940049ybj.11;
        Tue, 26 Jul 2022 14:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3t16s+OcKDcEZXENZbwqgCIwk/X+UcCVddI7l2RgCtI=;
        b=NLlIwrwDW5ocpVXLAcOp1+TDqUcPCxfwIlZYoT416DevuJKD+dUfl9bBi679g2rqK2
         CIUnAduiKXZV+uuX9vvtefQgXdxUXYyXsEuPfPNgM1dBPFpPcOIBJkPmyIsfPKqSlPvZ
         cs/NXt5vjastEJs668It7JG7h3U2M1XnFaZoUdfMr98yqbX8+51XzA9qScCCtr/0CPcf
         UKlseVrk75xrMR4lK0kFjvrou6WhmwoB1FSX4TmmBRPU0s2fcpACCZRIARCrZi4V0YhC
         R+/cA4lOo/YX9n2B3Mt9qqQ08B8mD20uA8ooW7zBv+hqRY2P5MRhNrqbHt2mKx2geVrI
         ym4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3t16s+OcKDcEZXENZbwqgCIwk/X+UcCVddI7l2RgCtI=;
        b=QqkqoyZJNoso85P4Gg1rhUTPeliPe2/gNCD/mjXNtL7XeM0pcfD8h/c1bW5TDz5RAC
         Zv7gCmFOPdYTae2z2KvZLS8fs3rofN88GR6XPHiYOfR/P8vdMqzSjFa9eMBFSsqWE8yk
         rH3ZrDH5vJt0jhLkfuBiHfJ5QNr5iqaEbeTP/b02ikmzl6tvsjZmfuzErh4NZIVr1TAO
         h3s6uCwZh4dI3UTBR41y4GzQAlRSdG2K4IBKIN5ObrPevTfDvKBWcXuF/yquh7oaFrOF
         m45dmjFpuryoHICJkiDSCvez/mTh8zQYgYtPePfyfOvdQiolHmI8Cf2Y88zp3eGDA3JM
         Dagg==
X-Gm-Message-State: AJIora8QBJuvouUmuGjvXCTKoBIoyLIx+g3j178GP8FyCuOCiUPg10OB
        gZHx+/rB9rgxiDtnacK3g+wfaFzo2BbPpa7J7T0=
X-Google-Smtp-Source: AGRyM1vRom4tJven8LPA373fu9mUzwWFI/x5WXxjSDmq4hHFo5RlkMbpmY16sruCIKeXcaYVkHJkHeLZd0gOeU0DUKc=
X-Received: by 2002:a25:e682:0:b0:671:79d9:66c7 with SMTP id
 d124-20020a25e682000000b0067179d966c7mr2977858ybh.5.1658869886200; Tue, 26
 Jul 2022 14:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220726115748.101015-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220726115748.101015-1-krzysztof.kozlowski@linaro.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 26 Jul 2022 23:11:15 +0200
Message-ID: <CAFBinCCOcuHeuXvEe9obBu2qby0bwQLPmaSbginmFh3_gSz4GA@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: power: drop quotes when not needed
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sebastian Reichel <sre@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        David Lechner <david@lechnology.com>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Hans de Goede <hdegoede@redhat.com>,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Purism Kernel Team <kernel@puri.sm>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        =?UTF-8?Q?Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Michael Klein <michael@fossekall.de>,
        Dan Murphy <dmurphy@ti.com>,
        Ricardo Rivera-Matos <r-rivera-matos@ti.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        "Andrew F. Davis" <afd@ti.com>, Tony Lindgren <tony@atomide.com>,
        Artur Rojek <contact@artur-rojek.eu>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Stephan Gerhold <stephan@gerhold.net>,
        David Heidelberg <david@ixit.cz>,
        Dmitry Osipenko <digetx@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 1:57 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Id and schema fields do not need quotes.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml      | 4 ++--
>  .../devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml     | 4 ++--
For the Amlogic ones:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


Thank you!
Martin
