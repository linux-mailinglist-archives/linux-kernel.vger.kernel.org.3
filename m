Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B6259B8EC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 08:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbiHVGBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 02:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiHVGBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 02:01:05 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144501F61B;
        Sun, 21 Aug 2022 23:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661148063; x=1692684063;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=06z1Sp4leSqz/xK8Xz8b0aRfqzDx5qUAH0KwCoR1bYk=;
  b=VfkQJ4owSztDk8idF3knm4ahXBhMH5W4KaKuNBncFap8GGFqJB1jX45I
   QkI2hJtUY29pko7zxW3BwxDq1CVg3Jwrr4iAgp8NQLyDGuD7avgJxQ2Mo
   dQD4MSygS4S2hhQ3WHjHCJNEGDLBJ8Z91xs9h8xSJ7hdtgl4ejN/OlVkq
   JuZjspwfxV5MNgXdcbSC/6panPncFz1Os7fb3vaxY2zllo1m5R+0CphRK
   pXhEPzNOw93yFr8d4xqY6OYxYtnZIjwFCXX+UxKW75Qpm9zliPLuISord
   Xq4KKR+g9eN2Gn4evGeNekyUq7RZNd9ajhrt+eRxUx7xAIsxRhS6xu/lZ
   A==;
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="177314448"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Aug 2022 23:01:03 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Sun, 21 Aug 2022 23:00:43 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Sun, 21 Aug 2022 23:00:43 -0700
Date:   Mon, 22 Aug 2022 08:04:56 +0200
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: lan966x-otpc: document Lan966X OTPC
Message-ID: <20220822060456.sl343a3a3uifini7@soft-dev3-1.localhost>
References: <20220818164405.1953698-1-horatiu.vultur@microchip.com>
 <20220818164405.1953698-2-horatiu.vultur@microchip.com>
 <550e652e-4541-c1e6-33a7-d5555f0cb266@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <550e652e-4541-c1e6-33a7-d5555f0cb266@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 08/19/2022 09:52, Krzysztof Kozlowski wrote:

Hi Krzysztof,

> 
> On 18/08/2022 19:44, Horatiu Vultur wrote:
> > Document Lan966x OTP controller.
> >
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: microchip,lan966x-otpc
> 
> No wildcards in compatible (which will also affect the file name as it
> should match the compatible).

Ok, I will replace lan966x with lan966 as the SoC is defined (SOC_LAN966)

> 
> > +      - const: syscon
> 
> Is OTP controller also system controller register region? This is a bit
> odd and looks like hack not to use nvmem subsystem.

That was a copy paste mistake. The OTP controller is not a system
controller register region.

> 
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    otpc: otp@e0021000 {
> > +        compatible = "microchip,lan966x-otpc", "syscon";
> > +        reg = <0xe0021000 0x300>;
> > +    };
> > +
> > +...
> 
> 
> Best regards,
> Krzysztof

-- 
/Horatiu
