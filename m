Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E3B46B895
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 11:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234921AbhLGKS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 05:18:27 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:19875 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhLGKS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 05:18:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1638872096; x=1670408096;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Bo9IYL4ZSYRCBcfdD1wFpX2LdtkM98KISonDXEfcFbE=;
  b=1e2twhaLiu2uK77sl4qykKtRhxhYNngtlqLw7eWXT1FC09bp+rYryEKA
   VkfT+RcWI86/5J228bR2/3PYDVaxTrxNIjZWhEzijciikrbAE4NqSwaZZ
   Y0cY7VVehRFy9TETe3R5GNPhkMdZ4XygzGlMvuHV6CZwhZKYxLMRhPOvP
   F7Mw2sNxcRrViD96bzKA79uAsZSG1FTMfC4JdTcnyRfiLB1Pg+OMIV0AV
   KyezyO5uCtrqYPcfNCq5Dr+qRph7vxit3ep2WIRNqsc/JVkdzSFrrzAID
   bURU+ILIEoQNnl9sQhTkNhdBuv+mPw2//aVdz7ciyc9kkoEQw1rk2XLjv
   A==;
IronPort-SDR: Ct9G3iLqJ3ea57o09sbbcmculpE4mZ8xstdTdzWaK1YnmGXTs/AsJuWEP6dI75FAznhgEUO/Dw
 2VNiz/LoCZFE1RcazShTme6leRnjYJ/ajGmN0dqwzsfKkQBJO9Ma3qQmBiG4t4UbpSMeGGXiTK
 /94jj+gWN2wR+lff0rx4Z9QipsG6CXlBs3jYujIGubIIBuVivZm++VeiX+rYlhAuYZ35oA76sY
 j3/p3PF4ZU7d+XaCKgTCpzSaM4wURvVXbPQcoNy4aeWlSSBHv+4jShdMjDSziVza82RAU7uVjj
 OjpOibU0cOJusIGV/7CjxNET
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="145783939"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Dec 2021 03:14:56 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 7 Dec 2021 03:14:55 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Tue, 7 Dec 2021 03:14:52 -0700
Subject: Re: [PATCH] dt-bindings: watchdog: atmel: Add missing 'interrupts'
 property
To:     Rob Herring <robh@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        <linux-watchdog@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20211206174045.2294873-1-robh@kernel.org>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <b6944a02-ba13-2a0d-6ed4-7b1330348d68@microchip.com>
Date:   Tue, 7 Dec 2021 11:14:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211206174045.2294873-1-robh@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2021 at 18:40, Rob Herring wrote:
> With 'unevaluatedProperties' support implemented, the atmel,sama5d4-wdt
> example has the following warning:
> 
> /home/rob/proj/git/linux-dt/.build-arm64/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.example.dt.yaml: watchdog@fc068640: Unevaluated properties are not allowed ('interrupts' was unexpected)
> 
> Document the missing 'interrupts' property.
> 
> Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks for the fix Rob!
Best regards,
   Nicolas

> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
> Cc: Eugen Hristev <eugen.hristev@microchip.com>
> Cc: linux-watchdog@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   .../devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml        | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml b/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml
> index 9856cd76c28d..a9635c03761c 100644
> --- a/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml
> @@ -22,6 +22,9 @@ properties:
>     reg:
>       maxItems: 1
> 
> +  interrupts:
> +    maxItems: 1
> +
>     atmel,watchdog-type:
>       $ref: /schemas/types.yaml#/definitions/string
>       description: should be hardware or software.
> --
> 2.32.0
> 


-- 
Nicolas Ferre
