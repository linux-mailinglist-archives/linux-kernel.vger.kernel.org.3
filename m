Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0DA562D3D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 09:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235822AbiGAH4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 03:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235964AbiGAH41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 03:56:27 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6C76EEA3;
        Fri,  1 Jul 2022 00:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656662179; x=1688198179;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IW2niVQ2UcbjnbUSjGOaN61cl4Co/uIRe6R1KVuPrnE=;
  b=n2RGqctpNS6pRsh0Eg1wUhp9stlO/5WCmkjc9yw9LBf+gI39ttefQMv4
   03xDanwIxupd4ovCrypaj8Rx1Mz/VJgEIMLboRNuRo/G5Y1sO4hOtAlEj
   ElH+W98c03fWjinBbcDcmMfb/5QVCVSiasTYHYXGUROqr6cPtm6MOKNYw
   yrCnqaAiZ+OgOSXsGJgzpLIWWy+MLUy8U7FLTe3NtYcJyM3OKHq+kJQbj
   V5vMeXPCM1IdxJzK+y0Jiad1XLqaPsjuj8LWzP8uRLSACpWk3m+2IxwAE
   b5CNQZsaicGTkuHLCHpirKi2hw57XCh5TNhTfZSNZ+wZEEkAJYUHh6PZI
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="165968461"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Jul 2022 00:56:18 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 1 Jul 2022 00:56:18 -0700
Received: from [10.12.72.20] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 1 Jul 2022 00:56:15 -0700
Message-ID: <6cb515bc-163d-8d92-f35b-f79690797efd@microchip.com>
Date:   Fri, 1 Jul 2022 09:56:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] dt-bindings: spi: convert spi_atmel to json-schema
Content-Language: en-US
To:     Conor Dooley - M52691 <Conor.Dooley@microchip.com>,
        Rob Herring <robh@kernel.org>,
        Sergiu Moga - M68701 <Sergiu.Moga@microchip.com>
CC:     Claudiu Beznea - M18063 <Claudiu.Beznea@microchip.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        UNGLinuxDriver <UNGLinuxDriver@microchip.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        Kavyasree Kotagiri - I30978 
        <Kavyasree.Kotagiri@microchip.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20220629125804.137099-1-sergiu.moga@microchip.com>
 <1656542219.625404.1042476.nullmailer@robh.at.kernel.org>
 <8191d9e3-88e9-c8fb-2544-d25d3a93d0a8@microchip.com>
 <a85357c2-a2f6-472e-50a8-2dcf41217ac1@microchip.com>
 <671850a1-8a87-b15b-c776-c0dbbc9de38e@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <671850a1-8a87-b15b-c776-c0dbbc9de38e@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/07/2022 at 09:50, Conor Dooley - M52691 wrote:
> On 01/07/2022 08:41, Nicolas Ferre wrote:
>> Hi Conor,
>>
>> On 30/06/2022 at 00:45, Conor Dooley - M52691 wrote:
>>> On 29/06/2022 23:36, Rob Herring wrote:
>>>> On Wed, 29 Jun 2022 15:58:04 +0300, Sergiu Moga wrote:
>>>>> Convert SPI binding for Atmel/Microchip SoCs to Device Tree Schema
>>>>> format.
>>>>>
>>>>> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
>>>>> ---
>>>>>    .../devicetree/bindings/spi/atmel,spi.yaml    | 82 +++++++++++++++++++
>>>>>    .../devicetree/bindings/spi/spi_atmel.txt     | 36 --------
>>>>>    2 files changed, 82 insertions(+), 36 deletions(-)
>>>>>    create mode 100644 Documentation/devicetree/bindings/spi/atmel,spi.yaml
>>>>>    delete mode 100644 Documentation/devicetree/bindings/spi/spi_atmel.txt
>>>>>
>>>>
>>>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>>>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>>>
>>>> yamllint warnings/errors:
>>>>
>>>> dtschema/dtc warnings/errors:
>>>> Documentation/devicetree/bindings/spi/atmel,spi.example.dtb:0:0: /example-0/spi@fffcc000/mmc@0: failed to match any schema with compatible: ['mmc-spi-slot']
>>>
>>> My conversion of this should be in -next right?
>>
>> Aren't you talking about
>> Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml or Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
>> rather than atmel,spi.yaml ?
> 
> Nope, I converted mmc-spi-slot :)
> And I checked, it is in -next 226e09de0acd ("dt-bindings: mmc:
> convert mmc-spi-slot to yaml"))
> Was just pointing out that this error from the bot is not really
> a problem.

Ah, all right Conor. Thanks for the info.

Best regards,
   Nicolas

-- 
Nicolas Ferre
