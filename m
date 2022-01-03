Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A317C483640
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 18:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbiACRgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 12:36:44 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:61304 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbiACRgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 12:36:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1641231403; x=1672767403;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=h5ah9bdoR8qY4D5fPSZpio2M1R/z0nwpJzEW1Kpft3g=;
  b=lpWzgE4gVpERlwy4fpPlZRy9y9Vpdvk6imPwm1CGhYSpGlVJaY1MVz6T
   stMVJUSJNtw+wuBcwI2PQ2gkhM2bqGNAK8ZvkDFvJCR/mWA+mIcl5w3UC
   /266g/vj9ggqEQoddrjifiO6GZZ0VnEcyEHMk9qJ7g8+8i5Y9x7mp8b+B
   sLe/dsmBaewbLG888O/fVCqa6z6dD5QtKg9q+PYRO400xp8RJk/izTApf
   obAw9bVyTanfSRlH1hbOeZlwJ7TQgyf646NnFjUAM1T0ajoeo968uPJF+
   /RUy5pFQuGmf3AU8zoeYZhAJVAZM2OA3qO0hPnTHUtwptDQfFtR0HRbHq
   w==;
IronPort-SDR: CIH9jy6NWC10dDiYgkjh4XWTXoeLA6CIxg1PHADCjI3Wr1abyN9jUFB/r8Ct3LVzK1RZzVAvdi
 gKyOtTb8/PS01aVIjCANZVkGW02Owerl/vcyUN/xpeFTw2+umuUZ6TU9ayhymYqdS5fX9oe0XX
 Nf0BaOxACboQQMfYqGzS7L3x88EQqE6u4994y3gE/s3l1AIf4VElf9GEXdixZOrYF2it1bXI5b
 SnIfUlAfU4jdk2bsAknx0OLSiUT0ry2iF6MsMEqKK6wU2wYbMCuksH6TRAVHZ4AnahGrcmRknS
 i2QS8lAwL6gl8/b0t75A67Cu
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="144175926"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Jan 2022 10:36:42 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 3 Jan 2022 10:36:42 -0700
Received: from [10.12.77.169] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Mon, 3 Jan 2022 10:36:37 -0700
Message-ID: <045f43d9-58e5-72a6-10fc-e47d875aeb21@microchip.com>
Date:   Mon, 3 Jan 2022 18:36:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 2/8] dt-bindings: rng: atmel,at91-trng: convert Atmel TRNG
 to dtschema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh@kernel.org>
CC:     Tony Lindgren <tony@atomide.com>, <linux-kernel@vger.kernel.org>,
        "Tomer Maimon" <tmaimon77@gmail.com>,
        Matt Mackall <mpm@selenic.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nishanth Menon <nm@ti.com>,
        Patrick Venture <venture@google.com>,
        <openbmc@lists.ozlabs.org>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        <linux-crypto@vger.kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tali Perry <tali.perry1@gmail.com>,
        <devicetree@vger.kernel.org>,
        Benjamin Fair <benjaminfair@google.com>,
        "Rob Herring" <robh+dt@kernel.org>, Nancy Yuen <yuenn@google.com>,
        "Ludovic Desroches" <ludovic.desroches@microchip.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20211227183251.132525-1-krzysztof.kozlowski@canonical.com>
 <20211227183251.132525-2-krzysztof.kozlowski@canonical.com>
 <1640696040.235226.685116.nullmailer@robh.at.kernel.org>
 <5a3d7233-8ce0-dbb5-aac4-393caadf2a6a@canonical.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <5a3d7233-8ce0-dbb5-aac4-393caadf2a6a@canonical.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/12/2021 at 14:07, Krzysztof Kozlowski wrote:
> On 28/12/2021 13:54, Rob Herring wrote:
>> On Mon, 27 Dec 2021 19:32:45 +0100, Krzysztof Kozlowski wrote:
>>> Convert the Atmel TRNG bindings to DT schema.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>>> ---
>>>   .../bindings/rng/atmel,at91-trng.yaml         | 46 +++++++++++++++++++
>>>   .../devicetree/bindings/rng/atmel-trng.txt    | 16 -------
>>>   2 files changed, 46 insertions(+), 16 deletions(-)
>>>   create mode 100644 Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml
>>>   delete mode 100644 Documentation/devicetree/bindings/rng/atmel-trng.txt
>>>
>>
>> Running 'make dtbs_check' with the schema in this patch gives the
>> following warnings. Consider if they are expected or the schema is
>> incorrect. These may not be new warnings.
>>
>> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
>> This will change in the future.
>>
>> Full log is available here: https://patchwork.ozlabs.org/patch/1573492
>>
>>
>> rng@e2010000: compatible:0: 'microchip,sama7g5-trng' is not one of ['atmel,at91sam9g45-trng', 'microchip,sam9x60-trng']
>>        arch/arm/boot/dts/at91-sama7g5ek.dt.yaml
>>
>> rng@e2010000: compatible: Additional items are not allowed ('atmel,at91sam9g45-trng' was unexpected)
>>        arch/arm/boot/dts/at91-sama7g5ek.dt.yaml
>>
>> rng@e2010000: compatible: ['microchip,sama7g5-trng', 'atmel,at91sam9g45-trng'] is too long
>>        arch/arm/boot/dts/at91-sama7g5ek.dt.yaml
>>
> 
> This patch is only converting the existing bindings, so new compatible
> is not added. The issue reported here is being fixed in the next patch
> (3/8).

Thanks Krzysztof!
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Best regards,
   Nicolas


-- 
Nicolas Ferre
