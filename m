Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B9956A629
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 16:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236180AbiGGOuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 10:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236169AbiGGOtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 10:49:45 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5928745064;
        Thu,  7 Jul 2022 07:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657205361; x=1688741361;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TEUKuQx9USOP2T+nvEZZr/kxzSMyhTyJTrEOtEoTws0=;
  b=wz9ba9gCsVfGfotE/0D0G+cO8XDiqfj5CTa6hP+0aQBLbAattdLOx7jn
   cJHy8DjRyhVXsHKCAzRkCd6MSRZAOaavHpGtEyGrXZrhAXba1WL8kA5a6
   4tcfkaidFSCIjQpjGLCbAZR/Kl+m6MfmzeBdxkuM2lBzxAUDy0B+U2uaM
   axwaod8FdLpz9gKDU8nTfejWlFF/j5vobhxJtzBJpvk2Hs5MirLT3tPy1
   bOu2/SlZGdnpFHzZSGPUW2+rBsYbkLS6bvng4qlPe6kEq4BTXTrmNyYgU
   cDFuuUmrcJ2dYwUAD5kYF9eeHqjiUttgU8sOR+p3FSCotf1z6fmAk7I2a
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="171177345"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Jul 2022 07:49:20 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 7 Jul 2022 07:49:20 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 7 Jul 2022 07:49:18 -0700
Message-ID: <269587dd-c7ba-ee12-8be0-51c9a795a36a@microchip.com>
Date:   Thu, 7 Jul 2022 16:49:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] dt-binding: sound: Convert atmel pdmic to json-schema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <Ryan.Wanner@microchip.com>, <Claudiu.Beznea@microchip.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20220705162142.17558-1-Ryan.Wanner@microchip.com>
 <8d71000b-e9d7-3586-5421-36a1fb367b5e@linaro.org>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <8d71000b-e9d7-3586-5421-36a1fb367b5e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof, Mark,

On 05/07/2022 at 19:56, Krzysztof Kozlowski wrote:
> On 05/07/2022 18:21, Ryan.Wanner@microchip.com wrote:
>> From: Ryan Wanner <Ryan.Wanner@microchip.com>
>>
>> Convert Atmel PDMIC devicetree binding to json-schema.
>> Change file naming to match json-schema naming.
>>
>> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
>> ---
>>   .../bindings/sound/atmel,sama5d2-pdmic.yaml   | 104 ++++++++++++++++++
>>   .../devicetree/bindings/sound/atmel-pdmic.txt |  55 ---------
> 
> You need to send the patches to proper folks with proper subject prefix.
> Use get_maintainers.pl for the first and `git log --oneline --` for the
> second.

Just to let you know that Codrin who was in charge of audio is not with 
Microchip anymore. We'll change the MAINTAINERS file soon so that it's 
clearer for everyone.
Anyway, we'll make sure to add Mark and Liam to the list.

Best regards,
   Nicolas

>>   2 files changed, 104 insertions(+), 55 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/sound/atmel,sama5d2-pdmic.yaml
>>   delete mode 100644 Documentation/devicetree/bindings/sound/atmel-pdmic.txt

[..]


-- 
Nicolas Ferre
