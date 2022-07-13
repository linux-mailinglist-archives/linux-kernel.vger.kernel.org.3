Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6705739DA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 17:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236822AbiGMPP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 11:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiGMPP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 11:15:56 -0400
Received: from relay-us1.mymailcheap.com (relay-us1.mymailcheap.com [51.81.35.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B31B32066;
        Wed, 13 Jul 2022 08:15:54 -0700 (PDT)
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.248.207])
        by relay-us1.mymailcheap.com (Postfix) with ESMTPS id 75205200E6;
        Wed, 13 Jul 2022 15:15:53 +0000 (UTC)
Received: from relay3.mymailcheap.com (relay3.mymailcheap.com [217.182.66.161])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id B4E34267CE;
        Wed, 13 Jul 2022 15:15:50 +0000 (UTC)
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com [149.56.130.247])
        by relay3.mymailcheap.com (Postfix) with ESMTPS id A989D40003;
        Wed, 13 Jul 2022 17:15:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by filter1.mymailcheap.com (Postfix) with ESMTP id 0A57E2A37A;
        Wed, 13 Jul 2022 15:15:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
        by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SKa0_JsYQgeN; Wed, 13 Jul 2022 15:15:46 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter1.mymailcheap.com (Postfix) with ESMTPS;
        Wed, 13 Jul 2022 15:15:46 +0000 (UTC)
Received: from edelgard.icenowy.me (unknown [59.41.163.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 3F308401DE;
        Wed, 13 Jul 2022 15:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1657725346; bh=Y2nH9P4lQd9MCR3ibpoDErgHg30yJR8WsNyQiLQQcnI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=LGXGcFvpUIwwuv5s0jAN4DZ2KHePtfeo5GrfVTdeVDaYABtdN/qhFsbi1gX4d6PbB
         iJSdRlj+drTxKqkj0YuAOx6ri7fzGlH+jnT0WJ/1nT59SciFDNmfq4BzohFYx8RZEe
         aOU+qtxheODRZVckakLifKIqw6LY33dVCKiZTSk0=
Message-ID: <2303fc91e5110f22fc9ea6008fa4bbc77c1bdb13.camel@aosc.io>
Subject: Re: [PATCH v1 2/2] riscv: dts: starfive: add the missing monitor
 core
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Conor Dooley <mail@conchuod.ie>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 13 Jul 2022 23:15:02 +0800
In-Reply-To: <20220711184325.1367393-3-mail@conchuod.ie>
References: <20220711184325.1367393-1-mail@conchuod.ie>
         <20220711184325.1367393-3-mail@conchuod.ie>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SORBS_HTTP,
        RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022-07-11星期一的 19:43 +0100，Conor Dooley写道：
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The JH7100 has a 32 bit monitor core that is missing from the device
> tree. Add it (and its cpu-map entry) to more accurately reflect the
> actual topology of the SoC.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  arch/riscv/boot/dts/starfive/jh7100.dtsi | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/starfive/jh7100.dtsi
> b/arch/riscv/boot/dts/starfive/jh7100.dtsi
> index c617a61e26e2..92fce5b66d3d 100644
> --- a/arch/riscv/boot/dts/starfive/jh7100.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7100.dtsi
> @@ -67,6 +67,23 @@ cpu1_intc: interrupt-controller {
>                         };
>                 };
>  
> +               E24: cpu@2 {
> +                       compatible = "sifive,e24", "riscv";

Oh, by the way "sifive,e24" is not a documented compatible in the DT
binding.

If you really want to add it here, you need to add the compatible
string to the DT binding first.

> +                       reg = <2>;
> +                       device_type = "cpu";
> +                       i-cache-block-size = <32>;
> +                       i-cache-sets = <256>;
> +                       i-cache-size = <16384>;
> +                       riscv,isa = "rv32imafc";
> +                       status = "disabled";
> +
> +                       cpu2_intc: interrupt-controller {
> +                               compatible = "riscv,cpu-intc";
> +                               interrupt-controller;
> +                               #interrupt-cells = <1>;
> +                       };
> +               };
> +
>                 cpu-map {
>                         cluster0 {
>                                 core0 {
> @@ -76,6 +93,10 @@ core0 {
>                                 core1 {
>                                         cpu = <&U74_1>;
>                                 };
> +
> +                               core2 {
> +                                       cpu = <&E24>;
> +                               };
>                         };
>                 };
>         };


