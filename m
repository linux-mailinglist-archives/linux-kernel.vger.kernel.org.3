Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7985738C5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236162AbiGMO00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236363AbiGMO0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:26:20 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB862F390
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 07:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657722379; x=1689258379;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IbkCpoIFWPuvJKPjB7KPAEmXFH8RPqCr5C0gR2+GG2M=;
  b=PRFddPwDkS+FOJhUCvjBAJ5JtDSxtjbU4DB5ibaYGdnyBUBilmVjuuTN
   J4qZnNvgS03+GK2/jq9/6u9acHPHAgwbsijrtCwgw2sE03VB7IJadOrHg
   oYnTfs9xVpgzlbFk635s2UimbYEUjagZCwJ9KYIuXvDWuWkvL67iJBPEW
   0=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 13 Jul 2022 07:26:18 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 07:26:18 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 13 Jul 2022 07:26:18 -0700
Received: from [10.110.120.249] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 13 Jul
 2022 07:26:17 -0700
Message-ID: <a42fbef2-3eff-9e88-233e-a805cfbe2376@quicinc.com>
Date:   Wed, 13 Jul 2022 07:26:12 -0700
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
From:   Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
In-Reply-To: <20220711095042.2095360-1-michael@walle.cc>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On 7/11/2022 2:50 AM, Michael Walle wrote:
> Hi,
> 
>> Add support for Winbond W25Q512NW-IQ/IN
>>
>> datasheet:
>> https://www.winbond.com/resource-files/W25Q512NW%20RevB%2007192021.pdf
> 
> Please add that as a Link: tag before your SoB tag.

Sure, I'll move it using the Link: tag in v2.

>> Test result on AST2600 SoC's SPI controller:
>> $ cat /sys/bus/platform/devices/1e620000.spi/spi_master/spi0/spi0.1/spi-nor/jedec_id
>> ef6020
>>
>> $ cat /sys/bus/platform/devices/1e620000.spi/spi_master/spi0/spi0.1/spi-nor/manufacturer
>> winbond
>>
>> $ cat /sys/bus/platform/devices/1e620000.spi/spi_master/spi0/spi0.1/spi-nor/partname
>> w25q512nwq
>>
>> $ hexdump /sys/bus/platform/devices/1e620000.spi/spi_master/spi0/spi0.1/spi-nor/sfdp
>> 0000000 4653 5044 0106 ff01 0600 1001 0080 ff00
>> 0000010 0084 0201 00d0 ff00 ffff ffff ffff ffff
>> 0000020 ffff ffff ffff ffff ffff ffff ffff ffff
>> *
>> 0000080 20e5 fffb ffff 1fff eb44 6b08 3b08 bb42
>> 0000090 fffe ffff ffff 0000 ffff eb40 200c 520f
>> 00000a0 d810 0000 0233 00a6 e781 d914 63e9 3376
>> 00000b0 757a 757a bdf7 5cd5 f719 ff5d 70e9 a5f9
>> 00000c0 ffff ffff ffff ffff ffff ffff ffff ffff
>> 00000d0 0aff fff0 ff21 ffdc
>> 00000d8
> 
> This information goes below the --- line

I followed the commit 89051ff5dd3bfbdc95c315dc3377fc46dadddc7c but yes,
I'll move this information into the comment section.

>> Signed-off-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
>> ---
>>   drivers/mtd/spi-nor/winbond.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
>> index ffaa24055259..d6f1a3b7267e 100644
>> --- a/drivers/mtd/spi-nor/winbond.c
>> +++ b/drivers/mtd/spi-nor/winbond.c
>> @@ -133,6 +133,9 @@ static const struct flash_info winbond_nor_parts[] = {
>>   	{ "w25m512jv", INFO(0xef7119, 0, 64 * 1024, 1024)
>>   		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_QUAD_READ |
>>   			      SPI_NOR_DUAL_READ) },
>> +	{ "w25q512nwq", INFO(0xef6020, 0, 64 * 1024, 1024)
> 
> Please use INFO(0xef6020, 0, 0, 0) and test wether it will still
> work correctly. We will then be able to convert it to SNOR_ID3()
> later.

Tested it but it doesn't work with INFO(0xef6020, 0, 0, 0). I'll keep
it as is.

>> +		PARSE_SFDP
>> +		OTP_INFO(256, 3, 0x1000, 0x1000) },
> 
> Did you test OTP?

Yes.

$ flash_otp_info -u /dev/mtd0
Number of OTP user blocks on /dev/mtd0: 3
block  0:  offset = 0x0000  size = 256 bytes  [unlocked]
block  1:  offset = 0x0100  size = 256 bytes  [unlocked]
block  2:  offset = 0x0200  size = 256 bytes  [unlocked]
$ flash_otp_dump -u /dev/mtd0 0x2d0
OTP user data for /dev/mtd0
0x02d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0x02e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0x02f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
$ echo -n otp test | flash_otp_write -u /dev/mtd0 0x2d0
Writing OTP user data on /dev/mtd0 at offset 0x2d0
Wrote 8 bytes of OTP user data
$ flash_otp_dump -u /dev/mtd0 0x2d0
OTP user data for /dev/mtd0
0x02d0: 6f 74 70 20 74 65 73 74 ff ff ff ff ff ff ff ff
0x02e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0x02f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
$ flash_otp_erase -u /dev/mtd0 0x200 0x100
$ flash_otp_dump -u /dev/mtd0 0x2d0
OTP user data for /dev/mtd0
0x02d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0x02e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
0x02f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

I'll add it to commit comment section too.

Thanks,

Jae

> -michael
> 
>>   	{ "w25q512nwm", INFO(0xef8020, 0, 64 * 1024, 1024)
>>   		PARSE_SFDP
>>   		OTP_INFO(256, 3, 0x1000, 0x1000) },
>> -- 
>> 2.25.1
> 
