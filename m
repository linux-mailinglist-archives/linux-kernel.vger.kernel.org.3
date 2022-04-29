Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA1D514855
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 13:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358549AbiD2Ljs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 07:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239276AbiD2Lir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 07:38:47 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32C588796
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 04:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651232129; x=1682768129;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pWWBYUIfbNL6pVdVQ9Id6I9rWKUkU4jATV2T05bb6xg=;
  b=F4OmPC/3ptqyAWAq9/w/GPH6hKflLTOarjkiFeSQ9WtPdCYhQtarnyHw
   ZT4INByf1Gpk45/BYnfzTKx53jWBsKJIdcq1xHFhaLKxZkgl22FyEaE96
   s/9bcLPGReQqwBf9+dm8SroOJNDG3M/Bl06JIDR+4CTHzG3EKyxHUxf18
   g=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 29 Apr 2022 04:35:28 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 04:35:28 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 29 Apr 2022 04:35:27 -0700
Received: from [10.216.46.40] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 29 Apr
 2022 04:35:22 -0700
Message-ID: <cb5ed4e9-86ab-4df3-9ae6-f9d907f949d8@quicinc.com>
Date:   Fri, 29 Apr 2022 17:05:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH V8] mtd: spi-nor: winbond: add support for W25Q512NW-IM
Content-Language: en-US
To:     <Tudor.Ambarus@microchip.com>, <p.yadav@ti.com>
CC:     <michael@walle.cc>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <quic_asutoshd@quicinc.com>,
        <quic_rampraka@quicinc.com>, <quic_pragalla@quicinc.com>,
        <quic_sartgarg@quicinc.com>, <quic_nitirawa@quicinc.com>,
        <quic_sayalil@quicinc.com>
References: <1648191975-1366-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <20220419042742.qqfj6wurpxxqhr6l@ti.com>
 <4324bf7f-e397-7510-96a2-5a309e30d76c@microchip.com>
From:   "Sajida Bhanu (Temp)" <quic_c_sbhanu@quicinc.com>
In-Reply-To: <4324bf7f-e397-7510-96a2-5a309e30d76c@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the review.

Please find the inline comments.

Thanks,
Sajida

On 4/19/2022 1:02 PM, Tudor.Ambarus@microchip.com wrote:

> On 4/19/22 07:27, Pratyush Yadav wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On 25/03/22 12:36PM, Shaik Sajida Bhanu wrote:
>>> Add support for winbond W25Q512NW-IM chip.
>>>
>>> Below are the tests done:
>>>
>>> 1. Verified flashing binary image on spi card using flashrom tool.
>>> 2. Verified OTP support, below are the test results:
>>>
>>>   localhost / # cat
>>>   /sys/bus/platform/devices/soc\@0/88dc000.spi/spi_master/spi16/
>>>   spi16.0/spi-nor/jedec_id
>>>   ef8020
>>>
>>>   localhost / # cat
>>>   /sys/bus/platform/devices/soc\@0/88dc000.spi/spi_master/spi16/
>>>   spi16.0/spi-nor/manufacturer
>>>   winbond
>>>
>>>   localhost / # cat
>>>   /sys/bus/platform/devices/soc\@0/88dc000.spi/spi_master/spi16/
>>>   spi16.0/spi-nor/partname
>>>   w25q512nwm
>>>
>>>   localhost / # hexdump
>>>   /sys/bus/platform/devices/soc\@0/88dc000.spi/spi_master/sp
>>>   i16/spi16.0/spi-nor/sfdp
>>>   0000000 4653 5044 0106 ff01 0600 1001 0080 ff00
>>>   0000010 0084 0201 00d0 ff00 ffff ffff ffff ffff
>>>   0000020 6800 6c65 6f6c 7720 726f 646c ffff ffff
>>>   0000030 ffff ffff ffff ffff ffff ffff ffff ffff
>>>   *
>>>   0000080 20e5 fffb ffff 1fff eb44 6b08 3b08 bb42
>>>   0000090 fffe ffff ffff 0000 ffff eb40 200c 520f
>>>   00000a0 d810 0000 0233 00a6 e781 d914 63e9 3376
>>>   00000b0 757a 757a bdf7 5cd5 f719 ff5d 70e9 a5f9
>>>   00000c0 ffff ffff ffff ffff ffff ffff ffff ffff
>>>   00000d0 0aff fff0 ff21 ffdc
>>>   00000d8
>>>
>>>   localhost / # md5sum
>>>   /sys/bus/platform/devices/soc\@0/88dc000.spi/spi_master/spi
>>>   16/spi16.0/spi-nor/sfdp
>>>   106d89d6c049110bc94c01517cb4ce24
>>>   /sys/bus/platform/devices/soc@0/88dc000.spi/
>>>   spi_master/spi16/spi16.0/spi-nor/sfdp
>>>
>>> 3. Tested flash lock, below are the test results (looks like the lock is
>>>   not working as expected, so when we do lock the whole card and tried to
>>>   write, write was successful without any errors.)
>> What should we do with this then? Drop the locking support? Or is there
>> something wrong/missing in SPI NOR core that needs to be fixed first so
>> locking for this flash works?
>>
> If the locking isn't working for this flash, please drop the locking flags
> until you identify the problem and fix it.
Okay for now dropping locking flag.
>>>   localhost ~ # flash_lock -i /dev/mtd0
>>>   Device: /dev/mtd0
>>>   Start: 0
>>>   Len: 0x4000000
>>>   Lock status: locked
>>>   Return code: 1
>>>   localhost ~ # mtd_debug erase /dev/mtd0 0x400000 4096
>>>   Erased 4096 bytes from address 0x00400000 in flash
>>>   localhost ~ # mtd_debug read /dev/mtd0 0x400000 4096
>>>   temp
>>>   Copied 4096 bytes from address 0x00400000 in flash
>>>   to temp
>>>   localhost ~ # mtd_debug write /dev/mtd0 0x400000
>>>   4096 temp
>>>   Copied 4096 bytes from temp to address 0x00400000
>>>   in flash
>>>   localhost ~ # flash_lock -u /dev/mtd0
>>>   localhost ~ # flash_lock -i /dev/mtd0
>>>   Device: /dev/mtd0
>>>   Start: 0
>>>   Len: 0x4000000
>>>   Lock status: unlocked
>>>   Return code: 0
>>>   localhost ~ # mtd_debug erase /dev/mtd0 0x400000 4096
>>>   Erased 4096 bytes from address 0x00400000 in flash
>>>   localhost ~ # mtd_debug read /dev/mtd0 0x400000
>>>   4096 tempCopied 4096 bytes from address 0x00400000 in
>>>   flash to temp
>>>   localhost ~ # mtd_debug write /dev/mtd0 0x400000 4096 temp
>>>   Copied 4096 bytes from temp to address 0x00400000 in flash
>>>   localhost ~ #
>>>
>>> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
>>> Reviewed-by: Doug Anderson <dianders@chromium.org>
>>> Reviewed-by: Michael Walle <michael@walle.cc>
>> [...]
>>
>> --
>> Regards,
>> Pratyush Yadav
>> Texas Instruments Inc.
