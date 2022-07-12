Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C775E571688
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 12:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbiGLKGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 06:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbiGLKGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:06:30 -0400
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C688AAB05;
        Tue, 12 Jul 2022 03:06:29 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id q5so6830756plr.11;
        Tue, 12 Jul 2022 03:06:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I/GNme+MtVJkgqzMSsHjFjb6byOWszb8bonzRL3iNS0=;
        b=pkbmKYnswFHa8Ow74jbNkUokMGZS0kURrYLWZhlVPND3c2pYDySTN9qiypzPNGshOu
         ZlN6xZVlAGaCkQLeyl6+EiRr6WsOXCS+uoIngV+BVExHh20CA/p59FInOVAPnvf3HjwL
         eu1sGVrNY95idmh7/c5z1i7R/+9YB3G2RC9ikKonrkwrfnjlmO1s5R7NyNMrFNmcCXl6
         n3PN5/lN7ew51qU7mOjZg907g06OEdv3WojIfJ4S6ZNGyyf5ms5cMou0u2M5IXHiq7/d
         0FXOO1ddf+x+fHSjf0fuwCNAnU763U0jiUrEb9yJWIfhDRsqpB0ZalV3ttxjuVjEJjps
         N9qQ==
X-Gm-Message-State: AJIora/JOShkUrzY2293WX2rFCJUmEaGy9U9GW1mMz3ofxW5SB5/FjlG
        9PfieBmiT+nq/JksaRdVgm4gGhMixIiZXD6Pv3Q=
X-Google-Smtp-Source: AGRyM1sXl72aEPLr4xAqWhAchej63N/4nkbWw1wGQRhxvxjivf3WMEdGdZSd/0v4llF2oWc11raqubKhdHiP03Rr7XY=
X-Received: by 2002:a17:903:1c8:b0:16c:4e2f:926f with SMTP id
 e8-20020a17090301c800b0016c4e2f926fmr8713764plh.76.1657620388698; Tue, 12 Jul
 2022 03:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220711184325.1367393-1-mail@conchuod.ie> <20220711184325.1367393-3-mail@conchuod.ie>
In-Reply-To: <20220711184325.1367393-3-mail@conchuod.ie>
From:   Emil Renner Berthing <kernel@esmil.dk>
Date:   Tue, 12 Jul 2022 12:06:17 +0200
Message-ID: <CANBLGcw6=EKZhS3t9+1G3_eczoid_jcTRV3=XD6wSwVkFQr_Gw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] riscv: dts: starfive: add the missing monitor core
To:     Conor Dooley <mail@conchuod.ie>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Mon, 11 Jul 2022 at 20:44, Conor Dooley <mail@conchuod.ie> wrote:
>
> From: Conor Dooley <conor.dooley@microchip.com>
>
> The JH7100 has a 32 bit monitor core that is missing from the device
> tree. Add it (and its cpu-map entry) to more accurately reflect the
> actual topology of the SoC.
>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

Thanks!
/Emil
> ---
>  arch/riscv/boot/dts/starfive/jh7100.dtsi | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7100.dtsi b/arch/riscv/boot/dts/starfive/jh7100.dtsi
> index c617a61e26e2..92fce5b66d3d 100644
> --- a/arch/riscv/boot/dts/starfive/jh7100.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7100.dtsi
> @@ -67,6 +67,23 @@ cpu1_intc: interrupt-controller {
>                         };
>                 };
>
> +               E24: cpu@2 {
> +                       compatible = "sifive,e24", "riscv";
> +                       reg = <2>;
> +                       device_type = "cpu";
> +                       i-cache-block-size = <32>;
> +                       i-cache-sets = <256>;
> +                       i-cache-size = <16384>;
> +                       riscv,isa = "rv32imafc";
> +                       status = "disabled";
> +
> +                       cpu2_intc: interrupt-controller {
> +                               compatible = "riscv,cpu-intc";
> +                               interrupt-controller;
> +                               #interrupt-cells = <1>;
> +                       };
> +               };
> +
>                 cpu-map {
>                         cluster0 {
>                                 core0 {
> @@ -76,6 +93,10 @@ core0 {
>                                 core1 {
>                                         cpu = <&U74_1>;
>                                 };
> +
> +                               core2 {
> +                                       cpu = <&E24>;
> +                               };
>                         };
>                 };
>         };
> --
> 2.37.0
>
