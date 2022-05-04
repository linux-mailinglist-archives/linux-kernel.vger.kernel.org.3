Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C42519CA8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 12:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347967AbiEDKRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 06:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347963AbiEDKRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 06:17:04 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D5915A24;
        Wed,  4 May 2022 03:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651659206; x=1683195206;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sM5HZKwbi/TbzfSgE0bd7h9vz8tIFdLqFavip4Djt7k=;
  b=j70ERuNUipp6l7ToB0KbhP5yxfb1uW1+MJaVoUyjXL0GO9QaDPdl+Ili
   +VA6Tl4nd/P36yq/cEt85lJoNG2et5X9LOCehiBJTqyC+GXC2uEelbHnS
   haPp/WGtUs9mKtpUU0J/Go6LHeg4xzEQljvgdoka8XCopF/vNGfci98dx
   Zu04gXvK2FflQX2WokCXWTrrOmsW0i50cllEamWzxsLeec0nkP8/jlka3
   eSTlO7PasxkYdCSRuqN1sNHV+3tZ3fs5OLB3A82dos91YkGyRYB5qpN0O
   Li4oeAC79WSQn54QUpt7XCjctq27qrbLiCL+4e1/cjGmtVoPJk76tqAPL
   w==;
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="162277051"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 May 2022 03:13:25 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 4 May 2022 03:13:24 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Wed, 4 May 2022 03:13:24 -0700
Date:   Wed, 4 May 2022 12:16:54 +0200
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Michael Walle <michael@walle.cc>
CC:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        <soc@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH v4 00/13] ARM: dts: lan966x: dtsi improvements and
 KSwitch D10 support
Message-ID: <20220504101654.cuui4kaxrjiw67ky@soft-dev3-1.localhost>
References: <20220502224127.2604333-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20220502224127.2604333-1-michael@walle.cc>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 05/03/2022 00:41, Michael Walle wrote:
> 
> Add missing nodes for the flexcom blocks and a node for the SGPIO
> block. Then add basic support for the Kontron KSwitch D10.
> 
> The first submission of this patchset was a long time ago. Since
> then networking matured and is now working. Thus this now also
> contains patches for all the networking related nodes and enables
> them on the Kontron D10 switch.

I have tested these changes on the lan966x-pcb82891 board which seems to
work fine.
Tested-by: Horatiu Vultur <horatiu.vultur@microchip.com>

> 
> changes since v3:
>  - basic d10 switch support dropped the i2c mux and added a
>    dedicated bus for the second SFP cage.
>  - new patch to add the hwmon node
>  - new patches to add the network related nodes and to enable
>    the nodes on the d10 switch
> 
> changes since v2:
>  - add second kontron board variant and moved common stuff into a
>    new dtsi
>  - moved the uart/i2c nodes inside of the flexcom node
>  - moved sgpio child nodes inside of the sgpio node
> 
> changes since v1:
>  - fixed indendation
>  - keep compatible, reg first, move #address-cells and #size-cells
>    towards the end
> 
> Michael Walle (13):
>   ARM: dts: lan966x: swap dma channels for crypto node
>   ARM: dts: lan966x: add sgpio node
>   ARM: dts: lan966x: add missing uart DMA channel
>   ARM: dts: lan966x: add all flexcom usart nodes
>   ARM: dts: lan966x: add flexcom SPI nodes
>   ARM: dts: lan966x: add flexcom I2C nodes
>   ARM: dts: lan966x: add basic Kontron KSwitch D10 support
>   ARM: dts: lan966x: add hwmon node
>   ARM: dts: lan966x: add MIIM nodes
>   ARM: dts: lan966x: add reset switch reset node
>   ARM: dts: lan966x: add serdes node
>   ARM: dts: lan966x: add switch node
>   ARM: dts: kswitch-d10: enable networking
> 
>  arch/arm/boot/dts/Makefile                    |   4 +-
>  ...lan966x-kontron-kswitch-d10-mmt-6g-2gs.dts |  94 +++++
>  .../lan966x-kontron-kswitch-d10-mmt-8g.dts    |  39 ++
>  .../dts/lan966x-kontron-kswitch-d10-mmt.dtsi  | 190 ++++++++++
>  arch/arm/boot/dts/lan966x.dtsi                | 353 +++++++++++++++++-
>  5 files changed, 676 insertions(+), 4 deletions(-)
>  create mode 100644 arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dts
>  create mode 100644 arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dts
>  create mode 100644 arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi
> 
> --
> 2.30.2
> 

-- 
/Horatiu
