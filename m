Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177B4586319
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 05:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238760AbiHADd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 23:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiHADdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 23:33:25 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A153D114;
        Sun, 31 Jul 2022 20:33:23 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2713X22I050303;
        Sun, 31 Jul 2022 22:33:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1659324782;
        bh=7B069uNIbizG2Scyb7mJP42slsILM1cjLIHQt/v7SUw=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=wrUhdqh4r7+wfsrQJvKz1GBqjboNkZ1H/Mnemnr63/YIQWeK9Bk6xLoJNxzt40g4r
         jP3ALc2VEMWhUZRukbBk1cTLljwk2eA3P8NHiD8vOFZ+edLUFvB8JUcASn1cyxGsyv
         Ebs0DrOHQaZC+E3hm5vMhuz3xqaJ0Fzt/u0Al+yM=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2713X2Wp022620
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 31 Jul 2022 22:33:02 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sun, 31
 Jul 2022 22:33:01 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Sun, 31 Jul 2022 22:33:01 -0500
Received: from [172.24.157.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2713WuJj091250;
        Sun, 31 Jul 2022 22:32:57 -0500
Message-ID: <ffe8a97d-0c79-c08f-7cfa-83eb6bbc2d39@ti.com>
Date:   Mon, 1 Aug 2022 09:02:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH 4/8] drm/tidss: Add support for Dual Link LVDS Bus Format
Content-Language: en-US
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
CC:     Nishanth Menon <nm@ti.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        David Airlie <airlied@linux.ie>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        DRI Development List <dri-devel@lists.freedesktop.org>,
        Darren Etheridge <detheridge@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jyri Sarha <jyri.sarha@iki.fi>, Rahul T R <r-ravikumar@ti.com>,
        Krunal Bhargav <k-bhargav@ti.com>
References: <20220719080845.22122-1-a-bhatia1@ti.com>
 <20220719080845.22122-5-a-bhatia1@ti.com>
 <f2909af1-be23-009b-ba71-34206f099473@ideasonboard.com>
From:   Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <f2909af1-be23-009b-ba71-34206f099473@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28-Jul-22 16:33, Tomi Valkeinen wrote:
> On 19/07/2022 11:08, Aradhya Bhatia wrote:
>> The 2 OLDI TXes in the AM625 SoC can be synced together to output a 2K
>> resolution video.
>>
>> Add support in the driver for the discovery of such a dual mode
>> connection on the OLDI video port, using the values of "ti,oldi-mode"
>> property.
>>
>> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
>> ---
>>   drivers/gpu/drm/tidss/tidss_dispc.c | 39 +++++++++++++++++++++--------
>>   1 file changed, 28 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c 
>> b/drivers/gpu/drm/tidss/tidss_dispc.c
>> index add725fa682b..fb1fdecfc83a 100644
>> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
>> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
>> @@ -853,25 +853,36 @@ void dispc_set_irqenable(struct dispc_device 
>> *dispc, dispc_irq_t mask)
>>       }
>>   }
>> -enum dispc_oldi_mode_reg_val { SPWG_18 = 0, JEIDA_24 = 1, SPWG_24 = 2 };
>> +enum dispc_oldi_mode_reg_val {
>> +    SPWG_18        = 0,
>> +    JEIDA_24    = 1,
>> +    SPWG_24        = 2,
>> +    DL_SPWG_18    = 4,
>> +    DL_JEIDA_24    = 5,
>> +    DL_SPWG_24    = 6,
>> +};
>>   struct dispc_bus_format {
>>       u32 bus_fmt;
>>       u32 data_width;
>>       bool is_oldi_fmt;
>> +    bool is_dual_link;
>>       enum dispc_oldi_mode_reg_val oldi_mode_reg_val;
>>   };
>>   static const struct dispc_bus_format dispc_bus_formats[] = {
>> -    { MEDIA_BUS_FMT_RGB444_1X12,        12, false, 0 },
>> -    { MEDIA_BUS_FMT_RGB565_1X16,        16, false, 0 },
>> -    { MEDIA_BUS_FMT_RGB666_1X18,        18, false, 0 },
>> -    { MEDIA_BUS_FMT_RGB888_1X24,        24, false, 0 },
>> -    { MEDIA_BUS_FMT_RGB101010_1X30,        30, false, 0 },
>> -    { MEDIA_BUS_FMT_RGB121212_1X36,        36, false, 0 },
>> -    { MEDIA_BUS_FMT_RGB666_1X7X3_SPWG,    18, true, SPWG_18 },
>> -    { MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,    24, true, SPWG_24 },
>> -    { MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA,    24, true, JEIDA_24 },
>> +    { MEDIA_BUS_FMT_RGB444_1X12,        12, false, false, 0 },
>> +    { MEDIA_BUS_FMT_RGB565_1X16,        16, false, false, 0 },
>> +    { MEDIA_BUS_FMT_RGB666_1X18,        18, false, false, 0 },
>> +    { MEDIA_BUS_FMT_RGB888_1X24,        24, false, false, 0 },
>> +    { MEDIA_BUS_FMT_RGB101010_1X30,        30, false, false, 0 },
>> +    { MEDIA_BUS_FMT_RGB121212_1X36,        36, false, false, 0 },
>> +    { MEDIA_BUS_FMT_RGB666_1X7X3_SPWG,    18, true, false, SPWG_18 },
>> +    { MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,    24, true, false, SPWG_24 },
>> +    { MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA,    24, true, false, JEIDA_24 },
>> +    { MEDIA_BUS_FMT_RGB666_1X7X3_SPWG,    18, true, true, DL_SPWG_18 },
>> +    { MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,    24, true, true, DL_SPWG_24 },
>> +    { MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA,    24, true, true, 
>> DL_JEIDA_24 },
>>   };
> 
> So the dual link sends two pixels per clock, right? Are there panel or 
> bridge drivers that support this? My initial thought was that it should 
> be a new bus format.
In dual link, we are having 2 OLDI TXes simultaneously send pixels, at a
fraction of the pixel frequency clock. Both the TXes have their own
clock lanes and they are in sync.

At the moment, we are not modeling the OLDI TXes as bridges in the DT,
nor are the drivers for these written. The tidss driver handles the
configuration, as the register is inside the DSS video ports address
space.

The need to add a dual link field in the above patch is there because
the OLDI config registers needs to know so. The output from both the
TXes remains according to the standard bus formats.

Regards
Aradhya
