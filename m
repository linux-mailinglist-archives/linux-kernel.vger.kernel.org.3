Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450BB5687BB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 14:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbiGFMDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 08:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbiGFMDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 08:03:50 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473166584
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 05:03:48 -0700 (PDT)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LdJ673vf3z6H7lp;
        Wed,  6 Jul 2022 20:01:03 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Wed, 6 Jul 2022 14:03:45 +0200
Received: from [10.126.171.66] (10.126.171.66) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 6 Jul 2022 13:03:44 +0100
Message-ID: <5ab934ff-0b16-0b55-e0f1-36366cd33e84@huawei.com>
Date:   Wed, 6 Jul 2022 13:03:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH RESEND v5 1/5] iommu: Refactor iommu_group_store_type()
To:     Will Deacon <will@kernel.org>
CC:     <joro@8bytes.org>, <robin.murphy@arm.com>, <mst@redhat.com>,
        <jasowang@redhat.com>, <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        <chenxiang66@hisilicon.com>, <thunder.leizhen@huawei.com>,
        <jean-philippe@linaro.org>, <linuxarm@huawei.com>
References: <1649071634-188535-1-git-send-email-john.garry@huawei.com>
 <1649071634-188535-2-git-send-email-john.garry@huawei.com>
 <20220706120059.GE2403@willie-the-truck>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220706120059.GE2403@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.171.66]
X-ClientProxiedBy: lhreml732-chm.china.huawei.com (10.201.108.83) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2022 13:00, Will Deacon wrote:
> On Mon, Apr 04, 2022 at 07:27:10PM +0800, John Garry wrote:
>> Function iommu_group_store_type() supports changing the default domain
>> of an IOMMU group.
>>
>> Many conditions need to be satisfied and steps taken for this action to be
>> successful.
>>
>> Satisfying these conditions and steps will be required for setting other
>> IOMMU group attributes, so factor into a common part and a part specific
>> to update the IOMMU group attribute.
>>
>> No functional change intended.
>>
>> Some code comments are tidied up also.
>>
>> Signed-off-by: John Garry<john.garry@huawei.com>
>> ---
>>   drivers/iommu/iommu.c | 96 ++++++++++++++++++++++++++++---------------
>>   1 file changed, 62 insertions(+), 34 deletions(-)
> Acked-by: Will Deacon<will@kernel.org>
> 

Thanks, but currently I have no plans to progress this series, in favour 
of this 
https://lore.kernel.org/linux-iommu/1656590892-42307-1-git-send-email-john.garry@huawei.com/T/#me0e806913050c95f6e6ba2c7f7d96d51ce191204

cheers

