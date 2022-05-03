Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D079D519262
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 01:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244330AbiECXn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 19:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234374AbiECXn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 19:43:28 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9C540902;
        Tue,  3 May 2022 16:39:52 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nm27O-0004cu-SF; Wed, 04 May 2022 01:39:46 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     krzk+dt@kernel.org, palmer@dabbelt.com, robh+dt@kernel.org,
        linux-riscv@lists.infradead.org
Cc:     conor.dooley@microchip.com, Cyril.Jean@microchip.com,
        daire.mcnamara@microchip.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, palmer@rivosinc.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Conor Dooley <mail@conchuod.ie>
Subject: Re: [PATCH v3 3/8] riscv: dts: microchip: remove soc vendor from filenames
Date:   Wed, 04 May 2022 01:39:45 +0200
Message-ID: <8058972.T7Z3S40VBb@phil>
In-Reply-To: <20220501192557.2631936-4-mail@conchuod.ie>
References: <20220501192557.2631936-1-mail@conchuod.ie> <20220501192557.2631936-4-mail@conchuod.ie>
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

Am Sonntag, 1. Mai 2022, 21:25:54 CEST schrieb Conor Dooley:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Having the SoC vendor both as the directory and in the filename adds
> little. Remove microchip from the filenames so that the files will
> resemble the other directories in riscv (and arm64). The new names
> follow a soc-board.dts & soc{,-fabric}.dtsi pattern.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

Nice cleanup

> ---
>  arch/riscv/boot/dts/microchip/Makefile                          | 2 +-
>  .../microchip/{microchip-mpfs-fabric.dtsi => mpfs-fabric.dtsi}  | 0
>  .../{microchip-mpfs-icicle-kit.dts => mpfs-icicle-kit.dts}      | 2 +-
>  .../riscv/boot/dts/microchip/{microchip-mpfs.dtsi => mpfs.dtsi} | 2 +-
>  4 files changed, 3 insertions(+), 3 deletions(-)
>  rename arch/riscv/boot/dts/microchip/{microchip-mpfs-fabric.dtsi => mpfs-fabric.dtsi} (100%)
>  rename arch/riscv/boot/dts/microchip/{microchip-mpfs-icicle-kit.dts => mpfs-icicle-kit.dts} (98%)
>  rename arch/riscv/boot/dts/microchip/{microchip-mpfs.dtsi => mpfs.dtsi} (99%)
> 
> diff --git a/arch/riscv/boot/dts/microchip/Makefile b/arch/riscv/boot/dts/microchip/Makefile
> index 855c1502d912..af3a5059b350 100644
> --- a/arch/riscv/boot/dts/microchip/Makefile
> +++ b/arch/riscv/boot/dts/microchip/Makefile
> @@ -1,3 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
> -dtb-$(CONFIG_SOC_MICROCHIP_POLARFIRE) += microchip-mpfs-icicle-kit.dtb
> +dtb-$(CONFIG_SOC_MICROCHIP_POLARFIRE) += mpfs-icicle-kit.dtb
>  obj-$(CONFIG_BUILTIN_DTB) += $(addsuffix .o, $(dtb-y))
> diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs-fabric.dtsi b/arch/riscv/boot/dts/microchip/mpfs-fabric.dtsi
> similarity index 100%
> rename from arch/riscv/boot/dts/microchip/microchip-mpfs-fabric.dtsi
> rename to arch/riscv/boot/dts/microchip/mpfs-fabric.dtsi
> diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
> similarity index 98%
> rename from arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
> rename to arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
> index c71d6aa6137a..84b0015dfd47 100644
> --- a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
> +++ b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
> @@ -3,7 +3,7 @@
>  
>  /dts-v1/;
>  
> -#include "microchip-mpfs.dtsi"
> +#include "mpfs.dtsi"
>  
>  /* Clock frequency (in Hz) of the rtcclk */
>  #define RTCCLK_FREQ		1000000
> diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/mpfs.dtsi
> similarity index 99%
> rename from arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
> rename to arch/riscv/boot/dts/microchip/mpfs.dtsi
> index bf21a2edd180..cc3386068c2d 100644
> --- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
> +++ b/arch/riscv/boot/dts/microchip/mpfs.dtsi
> @@ -3,7 +3,7 @@
>  
>  /dts-v1/;
>  #include "dt-bindings/clock/microchip,mpfs-clock.h"
> -#include "microchip-mpfs-fabric.dtsi"
> +#include "mpfs-fabric.dtsi"
>  
>  / {
>  	#address-cells = <2>;
> 




