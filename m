Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F64576A5E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 01:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbiGOXEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 19:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbiGOXEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 19:04:30 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1442A89E9C
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 16:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657926269; x=1689462269;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PqYK+pJsEeTGdedFUyk34TlXrWN6NUmeCGCj0d02tQk=;
  b=GFDD4hWKFQjuCjGgErwx/LFJ72XKvOE3u2St6/PHfZPwk4M7Iw6Fkj/k
   eGGR0QQTEzIUkYFSM31xEIdCdC5qi4+2m5KFX/KnKlClD30zR9L/HcNgV
   cG0ubO8NKatkoj3o03dZdrZSOZShP3xovNZOcqSs93MHQSLsW8v/qEiL3
   w=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 15 Jul 2022 16:04:28 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 16:04:28 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 15 Jul 2022 16:04:28 -0700
Received: from [10.110.97.72] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 15 Jul
 2022 16:04:27 -0700
Message-ID: <4dbc7c90-5192-0c51-5c57-4f1dcfa62ff5@quicinc.com>
Date:   Fri, 15 Jul 2022 16:04:26 -0700
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
 <1ce1ac2fabf7e46e303da01782469355@walle.cc>
From:   Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
In-Reply-To: <1ce1ac2fabf7e46e303da01782469355@walle.cc>
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

On 7/15/2022 3:52 PM, Michael Walle wrote:
> Hi,
> 
> Am 2022-07-15 22:15, schrieb Jae Hyun Yoo:
>> On 7/14/2022 7:30 AM, Jae Hyun Yoo wrote:
>>> On 7/14/2022 7:21 AM, Michael Walle wrote:
>>>> Am 2022-07-14 16:16, schrieb Michael Walle:
>>>>> Am 2022-07-14 15:47, schrieb Jae Hyun Yoo:
>>>>>> On 7/14/2022 12:41 AM, Michael Walle wrote:
>>>>>>> What does "doesn't boot at all" mean? Are there any kernel startup
>>>>>>> messages?
>>>>>>
>>>>>> I'm sharing the error messages below.
>>>>>
>>>>> Thanks.
>>>>>
>>>>>> [    0.748594] spi-nor spi0.0: w25q512nwq (65536 Kbytes)
>>>>>> [    0.865216] spi-aspeed-smc 1e620000.spi: CE0 read buswidth:4 
>>>>>> [0x406c0741]
>>>>>> [    0.872833] ------------[ cut here ]------------
>>>>>> [    0.877984] WARNING: CPU: 1 PID: 1 at drivers/mtd/mtdcore.c:583
>>>>>> add_mtd_device+0x28c/0x53c
>>>>>> [    0.887237] CPU: 1 PID: 1 Comm: swapper/0 Not tainted
>>>>>> 5.15.43-AUTOINC-dirty-23801a6 #1
>>>>>
>>>>> Could you please try it on the latest (vanilla) linux-next?
>>>>
>>>> or spi-nor/next [1] as there are quite a lot of changes. The
>>>> patches shall be based on that.
>>>
>>> Okay. Let me try that. I tested it using 5.15.43 with back-ported
>>> spi-nor patches from the latest. I'll back-port more changes from
>>> the spi-nor/next and will test the INFO(0xef6020, 0, 0, 0) setting
>>> again.
>>
>> I tested the setting again after cherry picking all SPI relating changes
>> from the 'for-next' branch of
>> git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi repository.
> 
> That is not the tree I mentioned in my previous mail. Why do you
> cherry-pick the changes instead of just trying the spi-nor/next
> tree?

I compared it with 
git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git#spi-nor/next 
too. Result is still the same.

>> No luck! It's still making the same warning dump at 'add_mtd_device'
>> since 'mtd->erasesize' is checked as 0.
>>
>> I traced it further to check if the erasesize is properly parsed from
>> the sfdp and checked that erase map seems parsed and initialized
>> correctly in 'spi_nor_parse_bfpt' but problem is, a target
>> mtd->erasesize is not properly selected in 'spi_nor_select_erase' since
>> the 'wanted_size' variable is initialized as sector size of info table
>> so a selected target mtd->erasesize is also 0 so looks like it's the
>> reason why it can't initialize mtd device if we use
>> INFO(0xef6020, 0, 0, 0).
> 
> Have a look at
> https://lore.kernel.org/linux-mtd/20220510140232.3519184-2-michael@walle.cc/ 
> 
> wanted_size can be 0. In this case spi_nor_select_uniform_erase()
> should return the biggest valid erase type. Could you please check that
> (1) spi_nor_select_uniform_erase() return non-NULL
> (2) check what value erase->size has (I guess it should be 64k in your 
> case)
> 
>  From what you tell me erase->size should be zero. If that is the
> case look at spi_nor_parse_bfpt() where the erase sizes are parsed.
> Also take a look at spi_nor_parse_4bait() where the erase types might
> be cleared again.
> 
> I've checked your SFDP data and it contains three valid erase sizes
> and opcodes for 3byte addressing and two valid erase opcodes for 4
> byte addressing. So that looks all good. After all the SFDP parsing
> I expect that you have two valid erase types:
>   - erase size 4096 with erase opcode 21h
>   - erase size 65536 with erase opcode DCh

I checked SFDP is parsed and these three erase sizes are enumerated
in the for loop in spi_nor_select_uniform_erase().

65536
0
4096

>> Also, checked that the mtd->erasesize is set to 4096 if I enable
>> CONFIG_MTD_SPI_NOR_USE_4K_SECTORS so the SPI flash can be initialized
>> with the INFO(0xef6020, 0, 0, 0) setting but, it should cover even
>> when
>> the configuration is not enabled. I think, this patch should go as it
>> is. The erasesize selecting issue could be fixed using a separate
>> patch.
>> Are you still sure that the INFO(0xef6020, 0, 0, 0) works in the
>> latest spi-next?
> 
> I've got two tested-by's with two different flashes, so yes, I'm
> pretty sure it works in principle. It might still be something
> wrong with your flash though.

Yes, I read the thread you are upstreaming currently.
https://lore.kernel.org/all/20220510140232.3519184-1-michael@walle.cc/

Were those tested in CONFIG_MTD_SPI_NOR_USE_4K_SECTORS enabled build?

As I said above, mine also works if I enable the config but we should
make it work without the config, right?

-Jae

> -michael
