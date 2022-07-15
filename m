Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1145B576AAB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 01:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbiGOX1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 19:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbiGOX0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 19:26:39 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E184595C38
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 16:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657927578; x=1689463578;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QG37sn/8hSWwtSds+7B0I2w1uI3+7ZU187Xi4ep562c=;
  b=uzGSCgRGke5g0aMtsZs/p5Hg+nA4KEhEVOUFlydNrs5zn15XnU3WxUOZ
   hKBwxwdAcewXPBlsEzKswHBTWPtA8uevZ6PSrTL+OLSgk78ptatSpw/Ud
   0IsHDez/kItAuE5Mpw8zrS750WL1+orVc9T+HqA6Ag8xZqzddDLZBZUWY
   E=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 15 Jul 2022 16:26:18 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 16:26:18 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 15 Jul 2022 16:26:17 -0700
Received: from [10.110.97.72] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 15 Jul
 2022 16:26:17 -0700
Message-ID: <0273ed77-73d8-bbd4-4626-4e7f17db74d1@quicinc.com>
Date:   Fri, 15 Jul 2022 16:26:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] mtd: spi-nor: winbond: add support for W25Q512NW-IQ/IN
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>
CC:     <clg@kaod.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <p.yadav@ti.com>,
        <quic_ggregory@quicinc.com>, <quic_jiles@quicinc.com>,
        <tudor.ambarus@microchip.com>
References: <20220710145721.1207157-1-quic_jaehyoo@quicinc.com>
 <20220711095042.2095360-1-michael@walle.cc>
 <a42fbef2-3eff-9e88-233e-a805cfbe2376@quicinc.com>
 <4972a85d04e39ebb7b4a5872f6632c45@walle.cc>
 <2260955b-354d-ceda-cadc-49453bfca3e4@quicinc.com>
 <00f0c9d480ef5a414f1c34492661bd9e@walle.cc>
 <63cedfce-34bb-ed63-3871-75a6c3dd5d73@quicinc.com>
 <6be710bb5c1bf0449e54a54b78f6f7a0@walle.cc>
 <47c01d768ea56edc9a2f9d317af7b495@walle.cc>
 <114fcde6-bdf7-68ee-d031-35a916027aee@quicinc.com>
 <b42cb229-f241-6e29-a138-29023ce316d9@quicinc.com>
 <c628e868-5c73-ca4b-1f99-60cc149806bf@quicinc.com>
 <b00410c825486ec406ed1ae773b11792@walle.cc>
 <2e0f02f3-0e0e-8690-a58e-bb74a21ab63e@quicinc.com>
 <00bdb7304cf479d21b87d4a35e908fb4@walle.cc>
From:   Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
In-Reply-To: <00bdb7304cf479d21b87d4a35e908fb4@walle.cc>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/15/2022 4:20 PM, Michael Walle wrote:
> Hi,
> 
>>> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>>> index ce5d69317d46..a2c8de250e01 100644
>>> --- a/drivers/mtd/spi-nor/core.c
>>> +++ b/drivers/mtd/spi-nor/core.c
>>> @@ -2113,6 +2113,10 @@ spi_nor_select_uniform_erase(struct 
>>> spi_nor_erase_map *map,
>>>
>>>                  tested_erase = &map->erase_type[i];
>>>
>>> +               /* Skip masked erase types. */
>>> +               if (!tested_erase->size)
>>> +                       continue;
>>
>> Yes, it also works. Do you want me to update this patch with adding this
>> fix? Or is it good to go as is so that the INFO table can be replaced
>> with SNOR_ID3 later after the fix is merged?
> 
> Please add this as a separate preceding patch to your original one
> where you add the flash. Keep the INFO(0xef6020, 0, 0, 0). Then we
> will replace it later with the SNOR_ID3().

Sure, I'll submit v3 series including the fix then.

Thanks,
Jae

> Thanks for debugging!
> -michael
