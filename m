Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C4652A506
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349071AbiEQOge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349142AbiEQOg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:36:29 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB262E9;
        Tue, 17 May 2022 07:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652798187; x=1684334187;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HVPfHtlxBRDzWgbJQqS6BesX8jQgiqWFkyA4yeFc3gI=;
  b=UVieVEOp96d/tbqg2jPSnMJ5juY6icIiJ6QBzceAq03BjcbCFnv1PFkO
   iS/WVghUsvU+5g+JYPzISHSNuhsn2fraaxuy7orlB1JOguZTJD55jWghY
   /7nrNkiQ1wEnPa5dBX4lPi2rW7o/9MLtk/h0qrfUX9mTOIPvzlGK1GxDr
   2RMKy92Qp4JkGvwnpH33OlD3N4Tg7gp+9cP8uGBOJNjGCKaOT0ef1k7M0
   hebBUIwdG/MkmkMDSOC7KAPtINe9dCOV/ip/PTsYJ2/DerIFlOZ9hP1QJ
   KmZ/fLsLG3DUS3kLZ90HdsOTjb3i4+TLAtBo3ysqGsMtzNr6KTOtUv4aM
   A==;
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="173758629"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 May 2022 07:36:25 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 17 May 2022 07:36:25 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 17 May 2022 07:36:20 -0700
Message-ID: <21a16074-9179-f57b-a667-cccddcab6e24@microchip.com>
Date:   Tue, 17 May 2022 16:36:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 5/6] ARM: dts: lan966x: rename pinctrl nodes
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@canonical.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Paul Burton <paulburton@kernel.org>,
        "Quentin Schulz" <quentin.schulz@bootlin.com>,
        Antoine Tenart <atenart@kernel.org>,
        Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
CC:     "David S . Miller" <davem@davemloft.net>,
        <UNGLinuxDriver@microchip.com>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mips@vger.kernel.org>
References: <20220319204628.1759635-1-michael@walle.cc>
 <20220319204628.1759635-6-michael@walle.cc>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20220319204628.1759635-6-michael@walle.cc>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/03/2022 at 21:46, Michael Walle wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> The pinctrl device tree binding will be converted to YAML format. Rename
> the pin nodes so they end with "-pins" to match the schema.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

For the record:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

This patch was taken by Claudiu and sent in the PR targeting 5.19 
arm-soc tree via the at91-dt branch. It's currently in linux-next.

Best regards,
   Nicolas

> ---
>   arch/arm/boot/dts/lan966x-pcb8291.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/lan966x-pcb8291.dts b/arch/arm/boot/dts/lan966x-pcb8291.dts
> index 3281af90ac6d..3c7e3a7d6f14 100644
> --- a/arch/arm/boot/dts/lan966x-pcb8291.dts
> +++ b/arch/arm/boot/dts/lan966x-pcb8291.dts
> @@ -35,7 +35,7 @@ fc3_b_pins: fcb3-spi-pins {
>                  function = "fc3_b";
>          };
> 
> -       can0_b_pins:  can0_b_pins {
> +       can0_b_pins:  can0-b-pins {
>                  /* RX, TX */
>                  pins = "GPIO_35", "GPIO_36";
>                  function = "can0_b";
> --
> 2.30.2
> 


-- 
Nicolas Ferre
