Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77AA5564A9F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 01:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbiGCXl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 19:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiGCXl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 19:41:57 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD95160CC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 16:41:53 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id bi22-20020a05600c3d9600b003a04de22ab6so4715055wmb.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 16:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/2KxyRrp3TRn/WaQ777l/5OLDpcxpRs5tZ2huVSaFVE=;
        b=ekkt/b+97PkfY5eoJHudZ29CeSCQonrAT7vVbbRds8jlg6Ef1ps8U3SAP0qTX+klTx
         UVXeOhhPr9VLO5xjNlEngyYvn08QWJvKkjVGSetGqbtp84KFRaitMDhIJrCXx3ly8jsz
         WfiLZnvvpz3fdHrW6Xia1qR19pCDt2eEm173WzPPwcy7OeTNEmhVknFIxwAoRTQ8ypKP
         RoDIXdB+8Wm1Yfc4Syv4vs052cve7kAgambBqvHUKqru4YrCLFx3xWdlPrLIZNqMYmzi
         zxZkKZDlyHd+/gqvtN0qzaMkHRnJVmnwnNVLatXDtM+Sbm6S7QtY2c2l3SWdsS731+SM
         G7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/2KxyRrp3TRn/WaQ777l/5OLDpcxpRs5tZ2huVSaFVE=;
        b=lKCONhlDbYXYWBgycsRfnXXssUVYmLqNVoCPMKkxYrJ9BZMEc33phFKGNgMplFhT+O
         boZiDsvpjuy7dkh6g39ORsahWsJSut34kfuo2sEpCIksGO3mG3xmwZis3u0WNLtLL9d9
         oq3O6u1xp3ipqWbiTTSlaG8lVkcdrhbCouFePKzZEjljO1twiMpkB0/y4aCYxZ9eDBjB
         8P7b8NDVhEaEi3DsoqxE6OO+Uc65822qKQAoDcuia1FystWGEULnJvoreRVuyYL/L/V1
         6VzC/9XYh1e8KzPiYmopsgfXyd10lyjNTcNTX+pvXih8PJtkzYyTonksVrT6FpsbWizr
         3Mgw==
X-Gm-Message-State: AJIora9E1Wj1nEl/K5k2IApZ2l4NI7WHZTb/LYIaZ6azEvlRDOfhDM91
        HEx5MDwfdYZYNB3DiQhUI7GI8hemIWxzJyvgFukV/A==
X-Google-Smtp-Source: AGRyM1syKWyVQnRX+KNFIh0qO1Fu/FxomivNEho5XvS7NURPSvHX18dDHeMCypu0UAYUcGAn76afZcnBPtD9SJzuJfc=
X-Received: by 2002:a05:600c:2051:b0:3a0:3c58:6ff6 with SMTP id
 p17-20020a05600c205100b003a03c586ff6mr29223882wmg.98.1656891712322; Sun, 03
 Jul 2022 16:41:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220613195658.5607-1-brad@pensando.io> <20220613195658.5607-7-brad@pensando.io>
 <b42b197f-2b11-cb6e-458a-ed12b2eb997d@linaro.org>
In-Reply-To: <b42b197f-2b11-cb6e-458a-ed12b2eb997d@linaro.org>
From:   Brad Larson <brad@pensando.io>
Date:   Sun, 3 Jul 2022 16:41:41 -0700
Message-ID: <CAK9rFnwj0c5fuWk8TxxX_RBXDCBpEa8f-rh3V13BN_j_U7Fo7w@mail.gmail.com>
Subject: Re: [PATCH v5 06/15] dt-bindings: mfd: amd,pensando-elbasr: Add AMD
 Pensando Elba System Resource chip
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Cooper <alcooperx@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, blarson@amd.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Gabriel Somlo <gsomlo@gmail.com>, gerg@linux-m68k.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Pratyush Yadav <p.yadav@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>, samuel@sholland.org,
        Serge Semin <fancer.lancer@gmail.com>,
        suravee.suthikulpanit@amd.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Will Deacon <will@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Mon, Jun 20, 2022 at 5:56 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 13/06/2022 21:56, Brad Larson wrote:
> > From: Brad Larson <blarson@amd.com>
> >
> > Add support for the AMD Pensando Elba SoC System Resource chip
> > using the SPI interface.  The Elba SR is a Multi-function Device
> > supporting device register access using CS0, smbus interface for
> > FRU and board peripherals using CS1, dual Lattice I2C masters for
> > transceiver management using CS2, and CS3 for flash access.
> >
> > Signed-off-by: Brad Larson <blarson@amd.com>
> > ---
> >  .../bindings/mfd/amd,pensando-elbasr.yaml     | 93 +++++++++++++++++++
> >  1 file changed, 93 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml
> ...
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/reset/amd,pensando-elba-reset.h>
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    spi0 {
>
> Just "spi"

Changed to spi

> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +        num-cs = <4>;
> > +
> > +        spi@0 {
>
> "spi" is for SPI controllers. Use generic name matching the device.
> Usually this is "system-controller", however Rob pointed out your
> inaccurate bindings and example.

Proposed the below change node in the reply to Rob.  The model I
followed for this was the Altera mfd/altera-a10sr.c

spi@0 {
        sr_regs@0 {
                rstc: reset-controller@0 {

        dw_i2c@1 {

        lattice_i2c@2 {

        flash@3 {

Regards,
Brad
