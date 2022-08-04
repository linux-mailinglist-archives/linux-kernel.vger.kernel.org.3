Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C15589A80
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 12:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbiHDKfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 06:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232471AbiHDKf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 06:35:28 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1A0FD28
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 03:35:26 -0700 (PDT)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Lz4l34tRkz67Nl1;
        Thu,  4 Aug 2022 18:31:11 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 4 Aug 2022 12:35:24 +0200
Received: from [10.195.34.58] (10.195.34.58) by lhrpeml500003.china.huawei.com
 (7.191.162.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 4 Aug
 2022 11:35:23 +0100
Message-ID: <dba4385e-87ef-01ee-af59-6daade4a9a24@huawei.com>
Date:   Thu, 4 Aug 2022 11:35:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: soundwire qcom slimbus dependency (was Re: [PATCH 0/2] arm64
 defconfig: Get faddr2line working)
To:     Arnd Bergmann <arnd@arndb.de>, Jonathan Marek <jonathan@marek.ca>
CC:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Olof Johansson <olof@lixom.net>, "SoC Team" <soc@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>
References: <1658681004-132191-1-git-send-email-john.garry@huawei.com>
 <CAK8P3a0umWWic6LAzxXJ7BACYVE--m-wbynh7Z8F+pGoUBxGTA@mail.gmail.com>
 <25237c44-ebc4-fc9a-7c6f-3e990f968038@huawei.com>
 <CAK8P3a2+0EwSJ=fRBL2JCGypJRL-qE4rEiXYnJbqhZ=weethdQ@mail.gmail.com>
 <b39bf8c4-c702-8f49-12aa-d3ac05889b80@huawei.com>
 <CAK8P3a0w+_MLOjJAKMENe6MYvBcXWXSir47Hz34WbtdEeAmaBw@mail.gmail.com>
 <4d010f40-6c4c-32c7-2772-1bbfa02c03b7@linaro.org>
 <CAK8P3a38uGGGLA4b2bi=v8cV6-dH5yEcvBYcwr5ChzkwMTX9_Q@mail.gmail.com>
 <966a62da-52b6-1789-13d6-5fe06b62c7fe@marek.ca>
 <CAK8P3a2HGYJZvcXM+9fROys5A6c40zFWD2qATT4xssSJf6hRfQ@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <CAK8P3a2HGYJZvcXM+9fROys5A6c40zFWD2qATT4xssSJf6hRfQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.34.58]
X-ClientProxiedBy: lhreml744-chm.china.huawei.com (10.201.108.194) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2022 13:03, Arnd Bergmann wrote:
> On Thu, Jul 28, 2022 at 1:57 PM Jonathan Marek <jonathan@marek.ca> wrote:
>> On 7/28/22 5:09 AM, Arnd Bergmann wrote:
>>> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
>>> index 22b706350ead..f65c7737c2db 100644
>>> --- a/drivers/soundwire/qcom.c
>>> +++ b/drivers/soundwire/qcom.c
>>> @@ -1289,11 +1289,7 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>>>           data = of_device_get_match_data(dev);
>>>           ctrl->rows_index = sdw_find_row_index(data->default_rows);
>>>           ctrl->cols_index = sdw_find_col_index(data->default_cols);
>>> -#if IS_REACHABLE(CONFIG_SLIMBUS)
>>> -       if (dev->parent->bus == &slimbus_bus) {
>>> -#else
>>> -       if (false) {
>>> -#endif
>>> +       if (IS_ENABLED(CONFIG_SLIMBUS) && dev->parent->bus == &slimbus_bus) {
>>>                   ctrl->reg_read = qcom_swrm_ahb_reg_read;
>>>                   ctrl->reg_write = qcom_swrm_ahb_reg_write;
>>>                   ctrl->regmap = dev_get_regmap(dev->parent, NULL);
>>>
>>
>> This relies on the compiler optimizing out the reference to slimbus_bus,
>> which doesn't exist in the CONFIG_SLIMBUS=n case (not tested, but I
>> think this means an O0 build will fail?).
> 
> That is correct: We rely on this everywhere in the kernel, which is why
> it is impossible to build kernels with -O0.
> 

Was there any patch sent to fix/improve this? I could not see any. Or 
any plan to do so?

Thanks,
John
