Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E472F57862D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 17:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235345AbiGRPWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 11:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiGRPWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 11:22:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA962654A;
        Mon, 18 Jul 2022 08:22:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 433E66120D;
        Mon, 18 Jul 2022 15:22:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C246C341C0;
        Mon, 18 Jul 2022 15:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658157756;
        bh=27LgImjzRSqPlFe7cCtgL1kCoiCEsjgBWZk7Q1LJaq8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=krRe4lUf87BqgwR0AigLhxGg+4m6XcIA2ikmRaNQsToDcA/d9/KKecvawbx+Q3cua
         WF6hghhtdeWZTBs4Zeywa6C/lswDosW6Vc8oDBfXu/dxj7Uvm5UwP7ZR1lE7RPKhsn
         NYft3769XhJzB0Ji6Dr16vIDNVwTJLxem8ycjVMhiuxUkBBrKUO/VlDhhX+DSVsMg9
         PcO32slIBWwNEM6goh9B3285h6MmEWhyJ54hdWEo8QdBc5OCNwlRlnTTz9HrQ8QMVs
         tvQBlwCytjGqKGKpMKlOBYBHTHbOYFVslKgyrJJNI3F+DZeR3ZpDxyBdzUWxvKs5vk
         TacM5voRS11TQ==
Received: by mail-vk1-f175.google.com with SMTP id g25so4473481vkm.13;
        Mon, 18 Jul 2022 08:22:36 -0700 (PDT)
X-Gm-Message-State: AJIora9ATdAWOWBazibClMrOWSFU4ItJnFiTWG0A4GQE1caEbnqmXrOq
        dkCuC/4V2wJHi4aJGTdeL0abXVAWt0ftRngZJw==
X-Google-Smtp-Source: AGRyM1sLIFUaJQDbfjbz5+S3v75qo9h9OuQ74+x7dGhVs191H7KQ5q/Fz21q7/SiVPvvLSH2Qi4xuaJT9dqmOhcCy8U=
X-Received: by 2002:ac5:c346:0:b0:374:a4f8:4c5b with SMTP id
 l6-20020ac5c346000000b00374a4f84c5bmr9600810vkk.19.1658157755454; Mon, 18 Jul
 2022 08:22:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220624112106.111351-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220624112106.111351-1-krzysztof.kozlowski@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 18 Jul 2022 09:22:24 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK--sXnVCm1cQPP5-_URzYjANdA1UBvUVF6zdanrscrkQ@mail.gmail.com>
Message-ID: <CAL_JsqK--sXnVCm1cQPP5-_URzYjANdA1UBvUVF6zdanrscrkQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: leds: class-multicolor: reference class
 directly in multi-led node
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dan Murphy <dmurphy@ti.com>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        ChiaEn Wu <peterwu.pub@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 5:21 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The leds/common.yaml is referenced directly in each LED node, which
> leads to people doing the same with leds/leds-class-multicolor.yaml.
> This is not correct because leds-class-multicolor.yaml defined multi-led
> property and its children.  Some schemas implemented this incorrect.
>
> Rework this to match same behavior common.yaml, so expect the multi-led
> node to reference the leds-class-multicolor.yaml.  Fixing allows to add
> unevaluatedProperties:false.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> This will conflict with any new users of leds-class-multicolor, e.g.:
> https://lore.kernel.org/all/20220623115631.22209-4-peterwu.pub@gmail.com/
>
> The new users should be updated to match the usage introduced here.
> ---
>  .../leds/cznic,turris-omnia-leds.yaml         |  2 ++
>  .../bindings/leds/leds-class-multicolor.yaml  | 32 +++++++++----------
>  .../devicetree/bindings/leds/leds-lp50xx.yaml |  2 ++
>  .../bindings/leds/leds-pwm-multicolor.yaml    |  5 ++-
>  .../bindings/leds/leds-qcom-lpg.yaml          |  2 ++
>  5 files changed, 24 insertions(+), 19 deletions(-)

Looks like this introduced a new warning:

/builds/robherring/linux-dt/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.example.dtb:
led-controller: multi-led: Unevaluated properties are not allowed
('max-brightness' was unexpected)
 From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml

Rob
