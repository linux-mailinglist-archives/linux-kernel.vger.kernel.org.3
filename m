Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3665F48363D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 18:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbiACRf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 12:35:58 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:45364 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiACRf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 12:35:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1641231356; x=1672767356;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=phmkBmK4ComVJcWyRwmHpQFXgeS6G5/2dL4ZaNRfmis=;
  b=Bhyn08EPTpOi5OOYDFHX32YsJ3raH9PfS85yfMzWIPFIjapTBmqV+c7l
   QcgX+IboDvsYe8Yz1nJOHtQsEe3/DJUm8w0yUZgWldUnm2jVeEhoEJjfy
   fqN3R/kZl57XNWr0cE9q9sxK/knQeX5Mh6P3bNBcPJjm8wHFnMUYTyVL/
   WXUrUQ9Q7eXYhWugGMIc2UPu+cLum5kHqqQhPyrh6XxxoAHE2bwsDsbwJ
   wQSQmQFIjm+Yam9/2dqkkgLnQzekLZXT0NAAF4niArHqaCa8Q10qoFL9I
   XSPH+mJYn3x8myObvyXAn1ozdHj5+CUbXiHs4ZvWM6l/jg5AgCrhbAFdg
   w==;
IronPort-SDR: 130TyrA9v3XyUnj1qI61R2b62UlhuKNuXi/5XcUQc8xWUhtJ3H6+waLScudUTIlAQR4AM3Zfok
 JARAOuteHASHs1VvohknmLhH4Mbqfy2CmkO0M1ua/vK/QjGAdA+GWQKaaNn4pLMbdT+wB/Jx4W
 n9O2+wnjyIXg1JC4B5lVyNHS6a61/YbfWTazYATssGCB7+Yu9gdOGA7j2pTD09t/oHpOiM1LTW
 J05mplo6+8zXva1ldxDBGs7y6cgnz7bmDDtZCokdgl6Y7xpa1Qyt0+pPmRSTllVDS0s8Zr+viJ
 KliD4VxkHVvdcKQbdajpbSWD
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="141485881"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Jan 2022 10:35:55 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 3 Jan 2022 10:35:55 -0700
Received: from [10.12.77.169] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Mon, 3 Jan 2022 10:35:51 -0700
Message-ID: <806f614d-4c83-53fa-dd1d-8054bc84d755@microchip.com>
Date:   Mon, 3 Jan 2022 18:35:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 3/8] dt-bindings: rng: atmel,at91-trng: document sama7g5
 TRNG
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        "Tony Lindgren" <tony@atomide.com>, <linux-crypto@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <openbmc@lists.ozlabs.org>
References: <20211227183251.132525-1-krzysztof.kozlowski@canonical.com>
 <20211227183251.132525-3-krzysztof.kozlowski@canonical.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20211227183251.132525-3-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/12/2021 at 19:32, Krzysztof Kozlowski wrote:
> Add compatbile for Microchip sama7g5 TRNG.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

As far as I understand:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks for having taken care of this.
Best regards,
   Nicolas

> ---
>   .../devicetree/bindings/rng/atmel,at91-trng.yaml      | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml b/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml
> index 0324e863dab8..c1527637eb74 100644
> --- a/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml
> +++ b/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml
> @@ -13,9 +13,14 @@ maintainers:
> 
>   properties:
>     compatible:
> -    enum:
> -      - atmel,at91sam9g45-trng
> -      - microchip,sam9x60-trng
> +    oneOf:
> +      - enum:
> +          - atmel,at91sam9g45-trng
> +          - microchip,sam9x60-trng
> +      - items:
> +          - enum:
> +              - microchip,sama7g5-trng
> +          - const: atmel,at91sam9g45-trng
> 
>     clocks:
>       maxItems: 1
> --
> 2.32.0
> 


-- 
Nicolas Ferre
