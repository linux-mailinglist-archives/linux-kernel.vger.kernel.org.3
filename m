Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB90562D95
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236065AbiGAIQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236059AbiGAIQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:16:13 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E5070ADA;
        Fri,  1 Jul 2022 01:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656663374; x=1688199374;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OJ9GWkLVaAs1Fsv4I7CHxNkbdrvjBd0hQHJ/FoewQ1k=;
  b=geGgtg2x/qfyj4iIO9KsKggh5BqYchQS/0XsTOBIv91yz9mFOXJuHGhI
   o0a8Ht+nlnzQnmK2WAmhcTgvdz6bc39jHhKyKByjEiVStK9+orfNBDmdl
   Zj4ar1HHCYMtCH4P451Nxx5dOB7GN9uiQ5SfTF4DEuZBOwJxh1P+BODNh
   PJcLpw9pwkyLbX6cNBJH8iWykgesEE8xl7RrAVlLAhYEWhEjzCtPphaJU
   0wnM0o5Vm+xoBWHZueREJVTJagC3rhkqXF5YCptqnG5V5FRhuVqL36ijE
   ZOP4khp9Lecw5fneLhVwW1Zu34DbIZFL/lqBnZO1vg41txJGsg2eqa6Er
   A==;
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="162901313"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Jul 2022 01:16:11 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 1 Jul 2022 01:16:10 -0700
Received: from [10.12.72.20] (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 1 Jul 2022 01:16:08 -0700
Message-ID: <91e03ee2-a11c-7c71-73f6-d76e07c10cd0@microchip.com>
Date:   Fri, 1 Jul 2022 10:16:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] ARM: dts: lan966x: Add mcan1 node.
Content-Language: en-US
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        <alexandre.belloni@bootlin.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        Claudiu Beznea <Claudiu.Beznea@microchip.com>
CC:     <arnd@arndb.de>, <soc@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>
References: <20220627110552.26315-1-kavyasree.kotagiri@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20220627110552.26315-1-kavyasree.kotagiri@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/06/2022 at 13:05, Kavyasree Kotagiri wrote:
> Add the mcan1 node. By default, keep it disabled.
> 
> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>

Looks good to me:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

We'll queue in the next dt branch soon, for integration through arm-soc 
tree.

Thanks, regards,
   Nicolas

> ---
>   arch/arm/boot/dts/lan966x.dtsi | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/lan966x.dtsi b/arch/arm/boot/dts/lan966x.dtsi
> index 3cb02fffe716..25cfa89dde7b 100644
> --- a/arch/arm/boot/dts/lan966x.dtsi
> +++ b/arch/arm/boot/dts/lan966x.dtsi
> @@ -473,6 +473,21 @@
>   			status = "disabled";
>   		};
>   
> +		can1: can@e0820000 {
> +			compatible = "bosch,m_can";
> +			reg = <0xe0820000 0xfc>, <0x00100000 0x8000>;
> +			reg-names = "m_can", "message_ram";
> +			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "int0", "int1";
> +			clocks = <&clks GCK_ID_MCAN1>, <&clks GCK_ID_MCAN1>;
> +			clock-names = "hclk", "cclk";
> +			assigned-clocks = <&clks GCK_ID_MCAN1>;
> +			assigned-clock-rates = <40000000>;
> +			bosch,mram-cfg = <0x4000 0 0 64 0 0 32 32>;
> +			status = "disabled";
> +		};
> +
>   		reset: reset-controller@e200400c {
>   			compatible = "microchip,lan966x-switch-reset";
>   			reg = <0xe200400c 0x4>;


-- 
Nicolas Ferre
