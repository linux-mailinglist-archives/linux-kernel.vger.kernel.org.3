Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8434AD799
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358216AbiBHLgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244901AbiBHLVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 06:21:12 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967B9C03FEC0;
        Tue,  8 Feb 2022 03:21:10 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JtL7X0Ry6z1FD30;
        Tue,  8 Feb 2022 19:16:56 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Feb 2022 19:21:05 +0800
CC:     "Zengtao (B)" <prime.zeng@hisilicon.com>,
        "liuqi (BA)" <liuqi115@huawei.com>,
        Zhangshaokun <zhangshaokun@hisilicon.com>,
        Linuxarm <linuxarm@huawei.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH v3 8/8] iommu/arm-smmu-v3: Make default domain type of
 HiSilicon PTT device to identity
To:     John Garry <john.garry@huawei.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "mike.leach@linaro.org" <mike.leach@linaro.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
References: <20220124131118.17887-1-yangyicong@hisilicon.com>
 <20220124131118.17887-9-yangyicong@hisilicon.com>
 <4f6f6e0f-4398-3018-cc35-6aa7ea1305fe@huawei.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <ae45a637-2c67-4126-3007-6829320d5659@huawei.com>
Date:   Tue, 8 Feb 2022 19:21:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <4f6f6e0f-4398-3018-cc35-6aa7ea1305fe@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/2/8 16:05, John Garry wrote:
> On 24/01/2022 13:11, Yicong Yang wrote:
>> The DMA of HiSilicon PTT device can only work with identical
>> mapping. So add a quirk for the device to force the domain
>> passthrough.
> 
> This patch should be earlier in the series, before the PTT driver, and the comment on hisi_ptt_check_iommu_mapping() should mention what is going on here.
> 

ok I'll reorder the serives and modify the comments of hisi_ptt_check_iommu_mapping() like:

/*
 * The DMA of PTT trace can only use direct mapping, due to some
 * hardware restriction. Check whether there is an iommu or the
 * policy of the iommu domain is passthrough, otherwise the trace
 * cannot work.
 *
 * The PTT device is supposed to behind the arm smmu v3, which
 * should have passthrough the device by a quirk. Otherwise user
 * should manually set the iommu domain type to identity through
 * sysfs.
 */

>>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index 6dc6d8b6b368..6f67a2b1dd27 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -2838,6 +2838,21 @@ static int arm_smmu_dev_disable_feature(struct device *dev,
>>       }
>>   }
>>   +#define IS_HISI_PTT_DEVICE(pdev)    ((pdev)->vendor == PCI_VENDOR_ID_HUAWEI && \
>> +                     (pdev)->device == 0xa12e)
> 
> I assume that not all revisions will require this check, right?
> 

For current revisions it's necessary.

>> +
>> +static int arm_smmu_def_domain_type(struct device *dev)
>> +{
>> +    if (dev_is_pci(dev)) {
>> +        struct pci_dev *pdev = to_pci_dev(dev);
>> +
>> +        if (IS_HISI_PTT_DEVICE(pdev))
>> +            return IOMMU_DOMAIN_IDENTITY;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   static struct iommu_ops arm_smmu_ops = {
>>       .capable        = arm_smmu_capable,
>>       .domain_alloc        = arm_smmu_domain_alloc,
>> @@ -2863,6 +2878,7 @@ static struct iommu_ops arm_smmu_ops = {
>>       .sva_unbind        = arm_smmu_sva_unbind,
>>       .sva_get_pasid        = arm_smmu_sva_get_pasid,
>>       .page_response        = arm_smmu_page_response,
>> +    .def_domain_type    = arm_smmu_def_domain_type,
>>       .pgsize_bitmap        = -1UL, /* Restricted during device attach */
>>       .owner            = THIS_MODULE,
>>   };
> 
> .
