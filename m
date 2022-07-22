Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44F757E195
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 14:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234605AbiGVMsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 08:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiGVMsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 08:48:06 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADE397A33;
        Fri, 22 Jul 2022 05:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658494085; x=1690030085;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SlbI3YoffkAc0xkVCuanBN99ne2tbCxFNSGgTOw0Jqg=;
  b=t8paMzPL6n9xV6+V9P5NEh4w0a+GGc3iqUWD2A5gWWlUcUtMq8RhCr7J
   VOStY13Vrj9td/a+SLm5qPTFJJz4IXMNwn7KAcusmje9oOPKrn45/z/wU
   GEXXE4i4OBMd0fU0h6tAIr9PPGhUIu3VekQEy6vrGaSJCiqsDAYdhlV2D
   10Oa6DxS1ILw5EZcNrOzzSvTrthtIQYi/vreBITShzJfEDZvTpy9k7HGG
   SJGEIW6CHEmRUgkz0GcbD3pOttdVj5tBLiQhKmhPlNjO1Vtg5Cu4tCyIX
   seUa2JhkRyy+dOpXwgE4EZ/e+qPU8ds/mVp7b1cnDNnhlpzeT5RY4xyEM
   g==;
X-IronPort-AV: E=Sophos;i="5.93,185,1654585200"; 
   d="scan'208";a="183324445"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jul 2022 05:48:04 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 22 Jul 2022 05:48:04 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 22 Jul 2022 05:48:04 -0700
Date:   Fri, 22 Jul 2022 14:52:13 +0200
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <arnd@arndb.de>, <olof@lixom.net>, <soc@kernel.org>,
        <UNGLinuxDriver@microchip.com>, <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: at91: add lan966 pcb8309 board
Message-ID: <20220722125213.ihz3sccjddikqyq6@soft-dev3-1.localhost>
References: <20220720194904.2025384-1-horatiu.vultur@microchip.com>
 <20220720194904.2025384-2-horatiu.vultur@microchip.com>
 <d66aae55-1615-1bbc-4f56-2b4806635db4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <d66aae55-1615-1bbc-4f56-2b4806635db4@linaro.org>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 07/21/2022 08:46, Krzysztof Kozlowski wrote:
> 
> On 20/07/2022 21:49, Horatiu Vultur wrote:
> > Add documentation for Microchip LAN9662 PCB8309.
> >
> > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> > ---
> >  Documentation/devicetree/bindings/arm/atmel-at91.yaml | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> > index 4e495e03264b..9dc9ad81193a 100644
> > --- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> > +++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> > @@ -169,6 +169,12 @@ properties:
> >            - const: microchip,lan9662
> >            - const: microchip,lan966
> >
> > +      - description: Microchip LAN9662 PCB8309 Evaluation Board.
> > +        items:
> > +          - const: microchip,lan9662-pcb8309
> 
> This and other lan9662 boards should be just an enum. You grow the file
> needlessly... Unless it is clear preference of maintainer. Other boards
> follow normal enum approach, so it seems there is no such preference.

I can see your point. I will change it in the next version.

> 
> 
> Best regards,
> Krzysztof

-- 
/Horatiu
