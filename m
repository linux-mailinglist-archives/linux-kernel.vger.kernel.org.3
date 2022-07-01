Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B030F562CDA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 09:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235222AbiGAHl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 03:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiGAHly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 03:41:54 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CF11409D;
        Fri,  1 Jul 2022 00:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656661312; x=1688197312;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6+6Lv6Z81pEXaBMjGbvAZKSh8w+AukCkGPMgazAg30o=;
  b=qGgi7AnXE0ZZbdIBZ7A2lgwCrm95/7a5QMlu2RrFBBTguHvgekEvHs1j
   vAhkJOaaxtHFwOVGHgwkhPUUeWIPzn+WmYFU8KoLzIfFVwB5uCSnts/Ps
   r1tAAWyrvmzVC5SnP5KMBJEeSr7sEs7x7+sfr8prL34NfyKgslPc9kf3q
   LdagReElTpF+4g5safl3oYJtdThUzUjIFlVps0rIax6UsT4pl0jpKHVHY
   mkPdmA+PDAC5QOrIcgXhZodSRkhKRvnjVKCIUKtmgWzD68vBBDghrWBo4
   P8ZAUyulvPjVnzB3G3orfMnTcHQme/eF5KbDu3tzl2kExPle8J97UDame
   g==;
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="180328294"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Jul 2022 00:41:52 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 1 Jul 2022 00:41:51 -0700
Received: from [10.12.72.20] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 1 Jul 2022 00:41:49 -0700
Message-ID: <a85357c2-a2f6-472e-50a8-2dcf41217ac1@microchip.com>
Date:   Fri, 1 Jul 2022 09:41:48 +0200
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
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <8191d9e3-88e9-c8fb-2544-d25d3a93d0a8@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On 30/06/2022 at 00:45, Conor Dooley - M52691 wrote:
> On 29/06/2022 23:36, Rob Herring wrote:
>> On Wed, 29 Jun 2022 15:58:04 +0300, Sergiu Moga wrote:
>>> Convert SPI binding for Atmel/Microchip SoCs to Device Tree Schema
>>> format.
>>>
>>> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
>>> ---
>>>   .../devicetree/bindings/spi/atmel,spi.yaml    | 82 +++++++++++++++++++
>>>   .../devicetree/bindings/spi/spi_atmel.txt     | 36 --------
>>>   2 files changed, 82 insertions(+), 36 deletions(-)
>>>   create mode 100644 Documentation/devicetree/bindings/spi/atmel,spi.yaml
>>>   delete mode 100644 Documentation/devicetree/bindings/spi/spi_atmel.txt
>>>
>>
>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>
>> yamllint warnings/errors:
>>
>> dtschema/dtc warnings/errors:
>> Documentation/devicetree/bindings/spi/atmel,spi.example.dtb:0:0: /example-0/spi@fffcc000/mmc@0: failed to match any schema with compatible: ['mmc-spi-slot']
> 
> My conversion of this should be in -next right?

Aren't you talking about
Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml or 
Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
rather than atmel,spi.yaml ?

> Is this just an incorrect base for the bot, or am I missing
> something?

[..]

Regards,
   Nicolas


-- 
Nicolas Ferre
