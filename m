Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC6A574F8F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239360AbiGNNrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbiGNNru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:47:50 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC96552FD4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657806468; x=1689342468;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AFzPUK74au9OtbfeCfSIohfALjgWpW0rt9c6En1xLCM=;
  b=BQcA3mhkY7refZiVBcnV+et3R52tmJGR+QFG6p6BuGPDhWLEJp1ljnt7
   FmqqhZEb8BRYhmdvSa2tUdg5ZX82w+b8s5mUO4OjNW49CdhFWQSktn3v6
   RFJ7nk2LPyf/iaV+gi7HJ/mE1HcRMkpuEbf3zew5O+7Oh7YcYk1hVfeYf
   c=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 14 Jul 2022 06:47:48 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 06:47:48 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Jul 2022 06:47:48 -0700
Received: from [10.110.120.249] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 14 Jul
 2022 06:47:47 -0700
Message-ID: <63cedfce-34bb-ed63-3871-75a6c3dd5d73@quicinc.com>
Date:   Thu, 14 Jul 2022 06:47:46 -0700
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
From:   Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
In-Reply-To: <00f0c9d480ef5a414f1c34492661bd9e@walle.cc>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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

On 7/14/2022 12:41 AM, Michael Walle wrote:
> Hi,
> 
> Am 2022-07-13 23:01, schrieb Jae Hyun Yoo:
>> On 7/13/2022 7:32 AM, Michael Walle wrote:
>>> Am 2022-07-13 16:26, schrieb Jae Hyun Yoo:
>>>>>> +    { "w25q512nwq", INFO(0xef6020, 0, 64 * 1024, 1024)
>>>>>
>>>>> Please use INFO(0xef6020, 0, 0, 0) and test wether it will still
>>>>> work correctly. We will then be able to convert it to SNOR_ID3()
>>>>> later.
>>>>
>>>> Tested it but it doesn't work with INFO(0xef6020, 0, 0, 0). I'll keep
>>>> it as is.
>>>
>>> Can you please look into this? I'd expect this to work if the SFDP
>>> tables are correct because all this should come from the tables.
>>> You can look at /sys/kernel/debug/spi-nor/spi0.0/params and see
>>> what is changing there.
>>
>> I tested it again but result is still the same. I can check the parsed
>> info like below if I use INFO(0xef6020, 0, 64 * 1024, 1024) but I can't
>> even check the debugfs info if I use INFO(0xef6020, 0, 0, 0) since it
>> doesn't boot at all. I think, this patch should go as is and the size
>> parsing issue could be fixed using a separate fix.
> 
> What does "doesn't boot at all" mean? Are there any kernel startup
> messages?

I'm sharing the error messages below.

[    0.748594] spi-nor spi0.0: w25q512nwq (65536 Kbytes)
[    0.865216] spi-aspeed-smc 1e620000.spi: CE0 read buswidth:4 [0x406c0741]
[    0.872833] ------------[ cut here ]------------
[    0.877984] WARNING: CPU: 1 PID: 1 at drivers/mtd/mtdcore.c:583 
add_mtd_device+0x28c/0x53c
[    0.887237] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 
5.15.43-AUTOINC-dirty-23801a6 #1
[    0.896076] Hardware name: Generic DT based system
[    0.901421] Backtrace:
[    0.904152] [<809722a8>] (dump_backtrace) from [<809724a0>] 
(show_stack+0x20/0x24)
[    0.912622]  r7:00000247 r6:00000009 r5:60000013 r4:80b2c980
[    0.918933] [<80972480>] (show_stack) from [<8097d318>] 
(dump_stack_lvl+0x48/0x54)
[    0.927384] [<8097d2d0>] (dump_stack_lvl) from [<8097d33c>] 
(dump_stack+0x18/0x1c)
[    0.935842]  r5:806464dc r4:80b7b538
[    0.939825] [<8097d324>] (dump_stack) from [<801216ac>] 
(__warn+0xf8/0x154)
[    0.947606] [<801215b4>] (__warn) from [<80972b90>] 
(warn_slowpath_fmt+0x84/0xe4)
[    0.955970]  r7:806464dc r6:00000247 r5:80b7b538 r4:81074000
[    0.962281] [<80972b10>] (warn_slowpath_fmt) from [<806464dc>] 
(add_mtd_device+0x28c/0x53c)
[    0.971618]  r10:bd7eece8 r9:813e1138 r8:00000000 r7:81074000 
r6:bd7eeccc r5:813e1040
[    0.980354]  r4:813e1040
[    0.983173] [<80646250>] (add_mtd_device) from [<80646810>] 
(mtd_device_parse_register+0x84/0x2e4)
[    0.993187]  r10:bd7eece8 r9:81074000 r8:00000000 r7:00000000 
r6:00000000 r5:00000000
[    1.001923]  r4:813e1040
[    1.004742] [<8064678c>] (mtd_device_parse_register) from 
[<80652240>] (spi_nor_probe+0x28c/0x2d8)
[    1.014758]  r9:81074000 r8:00000000 r7:00000000 r6:04000000 
r5:00000000 r4:813e1040
[    1.023396] [<80651fb4>] (spi_nor_probe) from [<80677e38>] 
(spi_mem_probe+0x78/0x9c)
[    1.032052]  r9:bd7eece8 r8:00000000 r7:81339800 r6:80d84b3c 
r5:813e3c00 r4:812a75c0
[    1.040690] [<80677dc0>] (spi_mem_probe) from [<806711ac>] 
(spi_probe+0x94/0xbc)
[    1.048957]  r7:813e3c00 r6:80d84b2c r5:813e3c00 r4:00000000
[    1.055267] [<80671118>] (spi_probe) from [<805ee98c>] 
(really_probe+0x1d8/0x46c)
[    1.063632]  r7:813e3c00 r6:80d84b3c r5:00000000 r4:813e3c00
[    1.069943] [<805ee7b4>] (really_probe) from [<805eed48>] 
(__driver_probe_device+0x128/0x204)
[    1.079468]  r6:81075bcc r5:80d84b3c r4:813e3c00
[    1.084615] [<805eec20>] (__driver_probe_device) from [<805eee68>] 
(driver_probe_device+0x44/0xd4)
[    1.094627]  r9:bd7eece8 r8:00000000 r7:813e3c00 r6:81075bcc 
r5:80deec7c r4:80deeb70
[    1.103265] [<805eee24>] (driver_probe_device) from [<805ef07c>] 
(__device_attach_driver+0xa4/0x13c)
[    1.113470]  r9:bd7eece8 r8:00000001 r7:813e3c00 r6:81075bcc 
r5:80d84b3c r4:00000001
[    1.122109] [<805eefd8>] (__device_attach_driver) from [<805eca0c>] 
(bus_for_each_drv+0xa0/0xe4)
[    1.131925]  r7:805eefd8 r6:81074000 r5:81075bcc r4:00000000
[    1.138235] [<805ec96c>] (bus_for_each_drv) from [<805ef3a8>] 
(__device_attach+0xd4/0x1c8)
[    1.147470]  r7:813e3c44 r6:80d84e9c r5:81074000 r4:813e3c00
[    1.153781] [<805ef2d4>] (__device_attach) from [<805ef864>] 
(device_initial_probe+0x1c/0x20)
[    1.163307]  r8:80deeb44 r7:81339800 r6:80d84e9c r5:813e3c00 r4:813e3c00
[    1.170782] [<805ef848>] (device_initial_probe) from [<805ecc1c>] 
(bus_probe_device+0x94/0x9c)
[    1.180401] [<805ecb88>] (bus_probe_device) from [<805eaa50>] 
(device_add+0x400/0x9c4)
[    1.189246]  r7:81339800 r6:81074000 r5:00000000 r4:813e3c00
[    1.195556] [<805ea650>] (device_add) from [<8067655c>] 
(__spi_add_device+0x74/0x148)
[    1.204306]  r10:bd7eeccc r9:80b6209c r8:80b83eb0 r7:81150c10 
r6:813e3c00 r5:81339800
[    1.213041]  r4:00000000
[    1.215861] [<806764e8>] (__spi_add_device) from [<80676698>] 
(spi_add_device+0x68/0x98)
[    1.224901]  r7:bd7eed30 r6:00000000 r5:813e3c00 r4:81339a0c
[    1.231212] [<80676630>] (spi_add_device) from [<80677230>] 
(spi_register_controller+0x8bc/0xc20)
[    1.241122]  r5:813e3c00 r4:81339800
[    1.245106] [<80676974>] (spi_register_controller) from [<806775b8>] 
(devm_spi_register_controller+0x24/0x60)
[    1.256184]  r10:812a3880 r9:80a56ae4 r8:81150c10 r7:81150c00 
r6:81150c10 r5:81339800
[    1.264919]  r4:81339800
[    1.267739] [<80677594>] (devm_spi_register_controller) from 
[<80679990>] (aspeed_spi_probe+0x184/0x230)
[    1.278332]  r7:81150c00 r6:00000000 r5:81339b80 r4:81339800
[    1.284642] [<8067980c>] (aspeed_spi_probe) from [<805f12e4>] 
(platform_probe+0x6c/0xc0)
[    1.293687]  r10:00000000 r9:00000000 r8:00000000 r7:81150c10 
r6:80d85e4c r5:81150c10
[    1.302423]  r4:00000000 r3:8067980c
[    1.306407] [<805f1278>] (platform_probe) from [<805ee98c>] 
(really_probe+0x1d8/0x46c)
[    1.315254]  r7:81150c10 r6:80d85e4c r5:00000000 r4:81150c10
[    1.321564] [<805ee7b4>] (really_probe) from [<805eed48>] 
(__driver_probe_device+0x128/0x204)
[    1.331089]  r6:80d85e4c r5:80d85e4c r4:81150c10
[    1.336236] [<805eec20>] (__driver_probe_device) from [<805eee68>] 
(driver_probe_device+0x44/0xd4)
[    1.346248]  r9:00000000 r8:00000000 r7:81150c10 r6:80d85e4c 
r5:80deec7c r4:80deeb70
[    1.354886] [<805eee24>] (driver_probe_device) from [<805ef1b8>] 
(__driver_attach+0xa4/0x1c0)
[    1.364414]  r9:00000000 r8:81075ee4 r7:00000000 r6:80d85e4c 
r5:81150c54 r4:81150c10
[    1.373052] [<805ef114>] (__driver_attach) from [<805ec4e4>] 
(bus_for_each_dev+0x94/0xd4)
[    1.382188]  r7:00000000 r6:81074000 r5:805ef114 r4:80d85e4c
[    1.388499] [<805ec450>] (bus_for_each_dev) from [<805ef93c>] 
(driver_attach+0x2c/0x30)
[    1.397442]  r7:80d7f088 r6:00000000 r5:813a5000 r4:80d85e4c
[    1.403753] [<805ef910>] (driver_attach) from [<805ece88>] 
(bus_add_driver+0x120/0x200)
[    1.412692] [<805ecd68>] (bus_add_driver) from [<805f03b4>] 
(driver_register+0x98/0x128)
[    1.421733]  r7:80dc9000 r6:81074000 r5:00000000 r4:80d85e4c
[    1.428044] [<805f031c>] (driver_register) from [<805f26bc>] 
(__platform_driver_register+0x2c/0x34)
[    1.438151]  r5:8124e940 r4:80c23fdc
[    1.442135] [<805f2690>] (__platform_driver_register) from 
[<80c24000>] (aspeed_spi_driver_init+0x24/0x28)
[    1.452922] [<80c23fdc>] (aspeed_spi_driver_init) from [<80c01650>] 
(do_one_initcall+0xa4/0x1a0)
[    1.462739] [<80c015ac>] (do_one_initcall) from [<80c01988>] 
(kernel_init_freeable+0x1d8/0x230)
[    1.472461]  r9:80c4485c r8:80c4483c r7:80dc9000 r6:00000006 
r5:8124e940 r4:80c6b118
[    1.481100] [<80c017b0>] (kernel_init_freeable) from [<8097db0c>] 
(kernel_init+0x20/0x138)
[    1.490340]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 
r6:00000000 r5:8097daec
[    1.499075]  r4:00000000
[    1.501894] [<8097daec>] (kernel_init) from [<80100130>] 
(ret_from_fork+0x14/0x24)
[    1.510352] Exception stack(0x81075fb0 to 0x81075ff8)
[    1.515993] 5fa0:                                     00000000 
00000000 00000000 00000000
[    1.525122] 5fc0: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
[    1.534250] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    1.541630]  r5:8097daec r4:00000000
[    1.545654] ---[ end trace 90aead4c9c23f630 ]---
[    1.550828] spi-nor: probe of spi0.0 failed with error -22
[    1.557724] spi-nor spi0.1: w25q512nwm (65536 Kbytes)
[    1.674226] spi-aspeed-smc 1e620000.spi: CE1 read buswidth:4 [0x406c0741]

> Just to be sure, you have PARSE_SFDP set, right?

Yea, right.

> The entry should be (skipping OTP to make sure that isn't
> the problem here):
> { "w25q512nwq", INFO(0xef6020, 0, 0, 0) PARSE_SFDP }

I tested it also but I'm seeing the same error message pattern.

Thanks,

Jae

> -michael
