Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6202B519255
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 01:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244287AbiECXeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 19:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244299AbiECXdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 19:33:45 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE6442EF9;
        Tue,  3 May 2022 16:30:08 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nm1xv-0004a6-LY; Wed, 04 May 2022 01:29:59 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     krzk+dt@kernel.org, palmer@dabbelt.com, robh+dt@kernel.org,
        linux-riscv@lists.infradead.org
Cc:     conor.dooley@microchip.com, Cyril.Jean@microchip.com,
        daire.mcnamara@microchip.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, palmer@rivosinc.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Conor Dooley <mail@conchuod.ie>
Subject: Re: [PATCH v3 1/8] riscv: dts: microchip: remove icicle memory clocks
Date:   Wed, 04 May 2022 01:29:57 +0200
Message-ID: <2237223.ElGaqSPkdT@phil>
In-Reply-To: <20220501192557.2631936-2-mail@conchuod.ie>
References: <20220501192557.2631936-1-mail@conchuod.ie> <20220501192557.2631936-2-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 1. Mai 2022, 21:25:52 CEST schrieb Conor Dooley:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The clock properties in the icicle kit's memory entries cause dtbs_check
> errors:
> arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dtb: /: memory@80000000: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Get rid of the clocks to avoid the errors.
> 
> Reported-by: Palmer Dabbelt <palmer@rivosinc.com>
> Fixes: 0fa6107eca41 ("RISC-V: Initial DTS for Microchip ICICLE board")
> Fixes: 5b28df37d311 ("riscv: dts: microchip: update peripherals in icicle kit device tree")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

I guess the memory controller consuming this clock will be sitting
somewhere in the io-area of the soc instead

> ---
>  arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
> index 3392153dd0f1..c71d6aa6137a 100644
> --- a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
> +++ b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
> @@ -32,14 +32,12 @@ cpus {
>  	ddrc_cache_lo: memory@80000000 {
>  		device_type = "memory";
>  		reg = <0x0 0x80000000 0x0 0x2e000000>;
> -		clocks = <&clkcfg CLK_DDRC>;
>  		status = "okay";
>  	};
>  
>  	ddrc_cache_hi: memory@1000000000 {
>  		device_type = "memory";
>  		reg = <0x10 0x0 0x0 0x40000000>;
> -		clocks = <&clkcfg CLK_DDRC>;
>  		status = "okay";
>  	};
>  };
> 




