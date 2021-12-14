Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5D60473C42
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 05:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbhLNE6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 23:58:14 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43056 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhLNE6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 23:58:13 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BE4w2U7077351;
        Mon, 13 Dec 2021 22:58:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1639457882;
        bh=u1SiXyoXvha8kIunLTdYBgkCe3ZZ6evhUXD3rFgFj5k=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=LKabUtzBOZAmPNHxfC8GgOxOhwZJarn54sRKskdLvfPcg+O099FJInNMwz1YBQv7M
         iyoTATn+TQbodDWW0s9LKgtr02PguPhpCJ+BB8FHFWoQ8IH/G1qrJkyfdfAQco9xz8
         UWQe8ZT5W7hf2giboxA7zNfEzvsg3aHcpFeCtVgI=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BE4w2wr002515
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Dec 2021 22:58:02 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 13
 Dec 2021 22:58:01 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 13 Dec 2021 22:58:01 -0600
Received: from [172.24.145.75] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BE4vwXC025119;
        Mon, 13 Dec 2021 22:57:59 -0600
Subject: Re: [PATCH v4] ASoC: dt-bindings: davinci-mcasp: convert McASP
 bindings to yaml schema
To:     Rob Herring <robh@kernel.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <peter.ujfalusi@gmail.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211203120243.24173-1-j-choudhary@ti.com>
 <YbPFjUpDl29f7SQa@robh.at.kernel.org>
From:   Jayesh Choudhary <j-choudhary@ti.com>
Message-ID: <a3a80b4a-6555-9bae-2d39-013f080042eb@ti.com>
Date:   Tue, 14 Dec 2021 10:27:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YbPFjUpDl29f7SQa@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/12/21 2:54 am, Rob Herring wrote:
> On Fri, Dec 03, 2021 at 05:32:43PM +0530, Jayesh Choudhary wrote:
>> Convert the bindings for McASP controllers for TI SOCs from txt
>> to YAML schema.
>>
>> Adds additional properties 'clocks', 'clock-names', 'power-domains',
>> '#sound-dai-cells' and 'port' which were missing from txt file.
>> Removes properties 'sram-size-playback' and 'sram-size-capture'
>> since they are not used.
>> Adds 'dmas' and 'dma-names' in the example which were missing from
>> the txt file.
>> Changes 'interrupts' and 'interrupt-names' from optional to
>> required properties.
>> Changes 'op-mode', 'serial-dir' and 'tdm-slots' to optional properties
>> as they are not needed if the McASP is used only as GPIO.
>>
>> Adds the yaml file in the 'MAINTAINERS' under the heading 'TEXAS
>> INSTRUMENTS ASoC DRIVERS'
>>
>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>> ---

>> +
>> +  tdm-slots:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: number of channels over one serializer
>> +    maxItems: 1
> 
> It's a uint32, so there's always 1 item. Drop.
> 

Will drop it from tdm-slots, tx-num-evt, rx-num-evt and auxclk-fs-ratio
since they are also uint32.

> No constraints? 0-2^32 is valid?

Yes it should be between 2 to 32 as pointed out by Peter.
Will add that.

> 
>> +
>> +
>> +  tx-num-evt:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: configures WFIFO threshold
>> +    maxItems: 1
>> +
>> +  rx-num-evt:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: configures RFIFO threshold
>> +    maxItems: 1
>> +
>> +
>> +  auxclk-fs-ratio:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: ratio of AUCLK and FS rate if applicable
>> +    maxItems: 1
>> +

>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    mcasp0: mcasp0@1d00000 {
> 
> Drop unused labels.

Yeah okay.

> 
>> +      compatible = "ti,da830-mcasp-audio";
>> +      reg = <0x100000 0x3000>;
>> +      reg-names = "mpu";
>> +      interrupts = <82>, <83>;
>> +      interrupt-names = "tx", "rx";
>> +      op-mode = <0>;		/* MCASP_IIS_MODE */
>> +      tdm-slots = <2>;
>> +      dmas = <&main_udmap 0xc400>, <&main_udmap 0x4400>;
>> +      dma-names = "tx", "rx";
>> +      serial-dir = <
>> +          0 0 0 0	/* 0: INACTIVE, 1: TX, 2: RX */
>> +          0 0 0 0
>> +          0 0 0 1
>> +          2 0 0 0 >;
>> +      tx-num-evt = <1>;
>> +      rx-num-evt = <1>;
>> +    };
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 00ad0cb5cb05..3fdf1e23f7d7 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -18855,6 +18855,7 @@ TEXAS INSTRUMENTS ASoC DRIVERS
>>   M:	Peter Ujfalusi <peter.ujfalusi@gmail.com>
>>   L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
>>   S:	Maintained
>> +F:	Documentation/devicetree/bindings/sound/davinci-mcasp-audio.yaml
>>   F:	sound/soc/ti/
>>   
>>   TEXAS INSTRUMENTS' DAC7612 DAC DRIVER
>> -- 
>> 2.17.1
>>
>>
