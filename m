Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33433572F56
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbiGMHhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiGMHhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:37:35 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C0EE43C3;
        Wed, 13 Jul 2022 00:37:33 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LjTrX6xGjzVfqT;
        Wed, 13 Jul 2022 15:33:48 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Jul 2022 15:37:14 +0800
Received: from [10.174.178.156] (10.174.178.156) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Jul 2022 15:37:13 +0800
Message-ID: <7c4eaa8e-2812-b805-c81b-9964a5cb6b52@huawei.com>
Date:   Wed, 13 Jul 2022 15:37:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH -next] drivers/tty/serial: Add missing
 clk_disable_unprepare()
To:     Florian Fainelli <f.fainelli@gmail.com>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <rjui@broadcom.com>, <sbranden@broadcom.com>,
        <bcm-kernel-feedback-list@broadcom.com>, <nsaenz@kernel.org>,
        <athierry@redhat.com>, <linux-serial@vger.kernel.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <xuqiang36@huawei.com>
References: <20220617025827.130497-1-guomengqi3@huawei.com>
 <ba372c31-f8b8-7987-5f7b-bb7c01b8233f@gmail.com>
From:   "guomengqi (A)" <guomengqi3@huawei.com>
In-Reply-To: <ba372c31-f8b8-7987-5f7b-bb7c01b8233f@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.156]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

Yes I found it's better to use title of same style. I did not pay 
attention to this.

I will send a new version of this patch.

Thank you!

在 2022/7/12 11:35, Florian Fainelli 写道:
>
>
> On 6/16/2022 7:58 PM, 'Guo Mengqi' via BCM-KERNEL-FEEDBACK-LIST,PDL 
> wrote:
>> Add missing clk_disable_unprepare() when get clk rate fails.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Guo Mengqi <guomengqi3@huawei.com>
>
> Looks about right, can we use the same prefix as the majority of other 
> changes:
>
> serial: 8250_bcm2835aux: Add missing clk_disable_unprepare()
>
> and slap a:
>
> Fixes: fcc446c8aa63 ("serial: 8250_bcm2835aux: Add ACPI support")
>
> Thanks!
>
>> ---
>>   drivers/tty/serial/8250/8250_bcm2835aux.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c 
>> b/drivers/tty/serial/8250/8250_bcm2835aux.c
>> index 2a1226a78a0c..21939bb44613 100644
>> --- a/drivers/tty/serial/8250/8250_bcm2835aux.c
>> +++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
>> @@ -166,8 +166,10 @@ static int bcm2835aux_serial_probe(struct 
>> platform_device *pdev)
>>       uartclk = clk_get_rate(data->clk);
>>       if (!uartclk) {
>>           ret = device_property_read_u32(&pdev->dev, 
>> "clock-frequency", &uartclk);
>> -        if (ret)
>> -            return dev_err_probe(&pdev->dev, ret, "could not get clk 
>> rate\n");
>> +        if (ret) {
>> +            dev_err_probe(&pdev->dev, ret, "could not get clk rate\n");
>> +            goto dis_clk;
>> +        }
>>       }
>>         /* the HW-clock divider for bcm2835aux is 8,
>
