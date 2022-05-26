Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600FA534E6B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 13:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347249AbiEZLpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 07:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346563AbiEZLoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 07:44:20 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D3FC5DAF
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:44:05 -0700 (PDT)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L85bj1g0gz67wr8;
        Thu, 26 May 2022 19:40:49 +0800 (CST)
Received: from lhreml741-chm.china.huawei.com (10.201.108.191) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Thu, 26 May 2022 13:44:02 +0200
Received: from [10.199.170.112] (10.199.170.112) by
 lhreml741-chm.china.huawei.com (10.201.108.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 26 May 2022 12:43:49 +0100
Message-ID: <378cead0-7d2e-2fcd-6113-2059b9446bbc@huawei.com>
Date:   Thu, 26 May 2022 14:43:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2] coresight: etm4x: Add Support for HiSilicon ETM device
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        "liuqi (BA)" <liuqi115@huawei.com>, Linuxarm <linuxarm@huawei.com>,
        <gregkh@linuxfoundation.org>, <mathieu.poirier@linaro.org>,
        <mike.leach@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Alexey Budankov <alexey.budankov@huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        <abudankov@huawei.com>
References: <1597323562-3706-1-git-send-email-liuqi115@huawei.com>
 <853b6d52-da86-1c06-3604-3085ece331a4@huawei.com>
 <5dd1bd83-232a-07e4-8fde-e4f6cd0e5b8c@huawei.com>
 <93b92859-2229-8766-09d2-df16e1ebd4e8@huawei.com>
 <50c25ce8-15bc-80a8-59dc-a20571a6460a@huawei.com>
 <13ee708e-17a7-7e0d-7d24-827c3786f007@huawei.com>
 <f43d759d-dc07-e2cd-6865-32a91d8c4096@arm.com>
From:   Alexei Budankov <abudankov@huawei.com>
In-Reply-To: <f43d759d-dc07-e2cd-6865-32a91d8c4096@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.199.170.112]
X-ClientProxiedBy: saopeml500003.china.huawei.com (7.184.65.141) To
 lhreml741-chm.china.huawei.com (10.201.108.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On 26.05.2022 12:59, Suzuki K Poulose wrote:
> Hi
> 
> 
> 
> On 26/05/2022 09:00, Alexei Budankov wrote:
>> Hi,
>>
>> On 26.05.2022 10:47, liuqi (BA) wrote:
>>>
>>>
>>> On 2022/5/26 15:23, Alexei Budankov wrote:
>>>> Hi Qi,
>>>>
>> <SNIP>
>>>>
>>>> Look like our server firmware should be upgraded, right?
>>>
>>> Yes, seems firmware should be upgraded first, and then you could test ETM device :)
>>
>> I would appreciate if you could share some links to upgrade bits and docs, if possible,
>> so we could use it to perform the upgrade.
> 
> Does your system use ACPI based firmware ? If that is

Not sure about it yet.

> the case, we do not have the support for ETM with system instructions
> at the moment. Anshuman is currently working on addressing
> this.

Thanks for clarification. Good to know.

Thanks,
Alexei

> 
> Cheers
> Suzuki
> 
>>
>> Thanks, > Alexei
>>
> 
> .
