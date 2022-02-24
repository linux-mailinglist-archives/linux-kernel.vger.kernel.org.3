Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7791C4C3098
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbiBXP5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236684AbiBXP5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:57:07 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B50CBC1C;
        Thu, 24 Feb 2022 07:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645718197; x=1677254197;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=n6pr0cu3VN6p2h9F5Q0h3H6YltMPTU+Ogr3c4MyROG8=;
  b=UE+h5+FJi/KQ4+sOjr9J/yTFdZR9KWdJU7vQceIcUENN9nXFDrZwCYRd
   TTjsYpUiKY9SXLX7p+8IQ1jR3NAct5y0GSvD2SQ0l1HFZM4lZUcVO/SIt
   w2zEFpDxIW5g0TJg6+0AZ9BypynwhEgYIItW8OWH20tClSW53bfyulXO2
   R1FkDoDDQFNGnBUHXCWNSDz3lcd7mdYJD9e0v/jVR2Jmb6I6tRtJuRjF0
   gyhtW1BL4LonKTWfm4ka7F8kb9Z+xXmmzxS6a6RyggPweyCooZw2MhLAx
   5CPneEKYP06MXLjInb78QW6qduntCzaBKiXQCiaYePzd5ozgsDRcrQTZV
   A==;
X-IronPort-AV: E=Sophos;i="5.90,134,1643698800"; 
   d="scan'208";a="163514224"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Feb 2022 08:56:36 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 24 Feb 2022 08:56:36 -0700
Received: from [10.12.73.51] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 24 Feb 2022 08:56:34 -0700
Message-ID: <b95304a9-5fbd-61c1-9a62-1bfa1cf53848@microchip.com>
Date:   Thu, 24 Feb 2022 16:56:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] dt-bindings: arm: at91: add Kontron's new KSwitches
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
References: <20220210131817.484922-1-michael@walle.cc>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20220210131817.484922-1-michael@walle.cc>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2022 at 14:18, Michael Walle wrote:
> The Kontron KSwitch D10 MMT series ethernet switches features a LAN9668
> SoC with either 8 copper ports or 6 copper port and two SFP cages.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Taken in at91-dt branch for reaching 5.18 via arm-soc tree.

Thanks for your patch!
Best regards,
   Nicolas

> ---
> changes since v1:
>   - just use one entry with an enum, thanks Krzysztof
> 
>   Documentation/devicetree/bindings/arm/atmel-at91.yaml | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> index c612e1f48dba..9d46ff78739f 100644
> --- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> +++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> @@ -174,6 +174,15 @@ properties:
>             - const: microchip,lan9668
>             - const: microchip,lan966
> 
> +      - description: Kontron KSwitch D10 MMT series
> +        items:
> +          - enum:
> +              - kontron,kswitch-d10-mmt-8g
> +              - kontron,kswitch-d10-mmt-6g-2gs
> +          - const: kontron,s1921
> +          - const: microchip,lan9668
> +          - const: microchip,lan966
> +
>         - items:
>             - enum:
>                 - atmel,sams70j19
> --
> 2.30.2
> 


-- 
Nicolas Ferre
