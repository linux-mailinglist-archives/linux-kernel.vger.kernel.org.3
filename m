Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830E2585DE6
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 09:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236450AbiGaHSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 03:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbiGaHSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 03:18:15 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C099BCB1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 00:18:13 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 6236042597;
        Sun, 31 Jul 2022 07:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1659251891; bh=kfVzooG27qyJrlBGaONv8AvOhI3FVvCdLGwZwOKwhbo=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=kUVkwqCkA7rnHeP4k1RTrP9kUKae5GjVXCA9K8P0mUZ87H1IYM+rB1KP9mTd8qfJT
         yz7D9vVK04L/HaxYwgX6BSjpnPVipbKQIBdGa8aVBCxJjyLl1Y/B5GCuRnqFVbumT2
         Pv+3eTWXl8tGsVW5innkrciJCh+9vZPFqhL41seTPT58y/bt18KC88yqCaQ9wKUU6q
         QBVLLjuP9X0XzxkFDynhihM7TfWnc6qv6z9UtaYZITIw0yKx1GidfScWmgp8fqifMn
         6YRxXl8yaDbpWSpivbfrNg3vCEMMcvmKitr7uLVzXoopnlxV1lx4si9oUENXILUCK7
         sv2v9iv8TJ4GQ==
Message-ID: <f3941493-de9d-1a5f-af74-ced4708dd6ce@marcan.st>
Date:   Sun, 31 Jul 2022 16:17:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/3] dt-bindings: power: drop quotes when not needed
Content-Language: es-ES
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
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
        =?UTF-8?Q?Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Michael Klein <michael@fossekall.de>,
        Dan Murphy <dmurphy@ti.com>,
        Ricardo Rivera-Matos <r-rivera-matos@ti.com>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        "Andrew F. Davis" <afd@ti.com>, Tony Lindgren <tony@atomide.com>,
        Artur Rojek <contact@artur-rojek.eu>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Stephan Gerhold <stephan@gerhold.net>,
        David Heidelberg <david@ixit.cz>,
        Dmitry Osipenko <digetx@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20220726115748.101015-1-krzysztof.kozlowski@linaro.org>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <20220726115748.101015-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/2022 20.57, Krzysztof Kozlowski wrote:
> Id and schema fields do not need quotes.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml      | 4 ++--
>  .../devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml     | 4 ++--
>  .../devicetree/bindings/power/apple,pmgr-pwrstate.yaml        | 2 +-
>  .../devicetree/bindings/power/brcm,bcm63xx-power.yaml         | 4 ++--
>  Documentation/devicetree/bindings/power/renesas,apmu.yaml     | 4 ++--
>  .../devicetree/bindings/power/renesas,rcar-sysc.yaml          | 4 ++--
>  6 files changed, 11 insertions(+), 11 deletions(-)
> 

For apple,pmgr-pwrstate:

Reviewed-by: Hector Martin <marcan@marcan.st>

- Hector
