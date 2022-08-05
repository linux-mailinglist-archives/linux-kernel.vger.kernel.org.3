Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F106158A6CD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 09:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239940AbiHEHMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 03:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240394AbiHEHLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 03:11:51 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 66E2975399;
        Fri,  5 Aug 2022 00:11:45 -0700 (PDT)
Received: from [10.20.42.22] (unknown [10.20.42.22])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9BxsM+pwuxieZUHAA--.27536S3;
        Fri, 05 Aug 2022 15:11:37 +0800 (CST)
Subject: Re: [PATCH] ACPI / scan: Support multiple dma windows with different
 offsets
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     guohanjun@huawei.com, sudeep.holla@arm.com, rafael@kernel.org,
        lenb@kernel.org, robert.moore@intel.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        robin.murphy@arm.com
References: <1659255431-22796-1-git-send-email-lvjianmin@loongson.cn>
 <e12706ef-70de-08b6-ada0-818d03b8c2f5@loongson.cn>
 <YuvJLxa5zsMj1pGf@lpieralisi>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <02cac528-7c8e-a107-05f4-93e5f1633f56@loongson.cn>
Date:   Fri, 5 Aug 2022 15:11:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <YuvJLxa5zsMj1pGf@lpieralisi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9BxsM+pwuxieZUHAA--.27536S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Gw4fXrWkCryrZFyxCryrXrb_yoWxAw1rp3
        WkGF15GF42qrWDWr48Zrs093WYv3s0kr1xurW8G3sak3sF9r17JF4UCryj9as5ArWDCr4I
        vF4DKFWfuF45tFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvGb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
        AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
        6F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI
        0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkIecxEwVCm-wCF04k2
        0xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26ryrJr1UJwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAI
        cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa
        73UjIFyTuYvjxUqEoXUUUUU
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/8/4 下午9:27, Lorenzo Pieralisi wrote:
> [+Robin]
> 
> On Thu, Aug 04, 2022 at 05:59:23PM +0800, Jianmin Lv wrote:
>> Hi, all
>>
>> Can anybody help to review the patch, or I missed somebody else?
> 
> I will review the patch - added Robin since it affects the DMA
> ranges handling.
> 
> Lorenzo
> 

Ok, thanks.


>> Thanks!
>>
>> On 2022/7/31 下午4:17, Jianmin Lv wrote:
>>> For DT, of_dma_get_range returns bus_dma_region typed dma regions,
>>> which makes multiple dma windows with different offset available
>>> for translation between dma address and cpu address.
>>>
>>> But for ACPI, acpi_dma_get_range doesn't return similar dma regions,
>>> causing no path for setting dev->dma_range_map conveniently. So the
>>> patch changes acpi_dma_get_range and returns bus_dma_region typed
>>> dma regions according to of_dma_get_range.
>>>
>>> After changing acpi_dma_get_range, original part of internal code
>>> only available for ARM is moved to acpi_arch_dma_setup for remaining
>>> unchanged.
>>>
>>> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
>>>
>>> diff --git a/drivers/acpi/arm64/dma.c b/drivers/acpi/arm64/dma.c
>>> index f16739a..840f918 100644
>>> --- a/drivers/acpi/arm64/dma.c
>>> +++ b/drivers/acpi/arm64/dma.c
>>> @@ -9,6 +9,7 @@ void acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
>>>    	int ret;
>>>    	u64 end, mask;
>>>    	u64 dmaaddr = 0, size = 0, offset = 0;
>>> +	const struct bus_dma_region *map = NULL;
>>>    	/*
>>>    	 * If @dev is expected to be DMA-capable then the bus code that created
>>> @@ -26,10 +27,37 @@ void acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
>>>    	else
>>>    		size = 1ULL << 32;
>>> -	ret = acpi_dma_get_range(dev, &dmaaddr, &offset, &size);
>>> +	ret = acpi_dma_get_range(dev, &map);
>>>    	if (ret == -ENODEV)
>>>    		ret = iort_dma_get_ranges(dev, &size);
>>>    	if (!ret) {
>>> +		const struct bus_dma_region *r = map;
>>> +		u64 len, dma_start, dma_end = 0;
>>> +
>>> +		/* determine the overall bounds of all dma regions */
>>> +		for (dma_start = U64_MAX; r->size; r++) {
>>> +			if (offset && r->offset != offset) {
>>> +				dev_warn(dev, "Can't handle multiple windows with different offsets\n");
>>> +				return;
>>> +			}
>>> +			offset = r->offset;
>>> +
>>> +			/* Take lower and upper limits */
>>> +			if (r->dma_start < dma_start)
>>> +				dma_start = r->dma_start;
>>> +			if (r->dma_start + r->size - 1 > dma_end)
>>> +				dma_end = r->dma_start + r->size - 1;
>>> +		}
>>> +
>>> +		if (dma_start >= dma_end) {
>>> +			dev_dbg(dev, "Invalid DMA regions configuration\n");
>>> +			return;
>>> +		}
>>> +
>>> +		dmaaddr = dma_start;
>>> +		len = dma_end - dma_start;
>>> +		size = max(len, len + 1);
>>> +
>>>    		/*
>>>    		 * Limit coherent and dma mask based on size retrieved from
>>>    		 * firmware.
>>> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
>>> index 762b61f..8961b51 100644
>>> --- a/drivers/acpi/scan.c
>>> +++ b/drivers/acpi/scan.c
>>> @@ -20,6 +20,7 @@
>>>    #include <linux/platform_data/x86/apple.h>
>>>    #include <linux/pgtable.h>
>>>    #include <linux/crc32.h>
>>> +#include <linux/dma-direct.h>
>>>    #include "internal.h"
>>> @@ -1492,15 +1493,15 @@ enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev)
>>>     *
>>>     * Return 0 on success, < 0 on failure.
>>>     */
>>> -int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
>>> -		       u64 *size)
>>> +int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map)
>>>    {
>>>    	struct acpi_device *adev;
>>>    	LIST_HEAD(list);
>>>    	struct resource_entry *rentry;
>>>    	int ret;
>>>    	struct device *dma_dev = dev;
>>> -	u64 len, dma_start = U64_MAX, dma_end = 0, dma_offset = 0;
>>> +	int num_ranges = 0;
>>> +	struct bus_dma_region *r;
>>>    	/*
>>>    	 * Walk the device tree chasing an ACPI companion with a _DMA
>>> @@ -1525,31 +1526,31 @@ int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
>>>    	ret = acpi_dev_get_dma_resources(adev, &list);
>>>    	if (ret > 0) {
>>> +		list_for_each_entry(rentry, &list, node)
>>> +			num_ranges++;
>>> +
>>> +		r = kcalloc(num_ranges + 1, sizeof(*r), GFP_KERNEL);
>>> +		if (!r) {
>>> +			ret = -ENOMEM;
>>> +			goto out;
>>> +		}
>>> +
>>> +		*map = r;
>>> +
>>>    		list_for_each_entry(rentry, &list, node) {
>>> -			if (dma_offset && rentry->offset != dma_offset) {
>>> +			if (rentry->res->start >= rentry->res->end) {
>>>    				ret = -EINVAL;
>>> -				dev_warn(dma_dev, "Can't handle multiple windows with different offsets\n");
>>> +				dev_dbg(dma_dev, "Invalid DMA regions configuration\n");
>>>    				goto out;
>>>    			}
>>> -			dma_offset = rentry->offset;
>>> -
>>> -			/* Take lower and upper limits */
>>> -			if (rentry->res->start < dma_start)
>>> -				dma_start = rentry->res->start;
>>> -			if (rentry->res->end > dma_end)
>>> -				dma_end = rentry->res->end;
>>> -		}
>>> -		if (dma_start >= dma_end) {
>>> -			ret = -EINVAL;
>>> -			dev_dbg(dma_dev, "Invalid DMA regions configuration\n");
>>> -			goto out;
>>> +			r->cpu_start = rentry->res->start;
>>> +			r->dma_start = rentry->res->start - rentry->offset;
>>> +			r->size = rentry->res->end - rentry->res->start + 1;
>>> +			r->offset = rentry->offset;
>>> +			r++;
>>>    		}
>>> -		*dma_addr = dma_start - dma_offset;
>>> -		len = dma_end - dma_start;
>>> -		*size = max(len, len + 1);
>>> -		*offset = dma_offset;
>>>    	}
>>>     out:
>>>    	acpi_dev_free_resource_list(&list);
>>> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
>>> index 0dc1ea0b..e106073 100644
>>> --- a/include/acpi/acpi_bus.h
>>> +++ b/include/acpi/acpi_bus.h
>>> @@ -611,8 +611,7 @@ struct acpi_pci_root {
>>>    int acpi_iommu_fwspec_init(struct device *dev, u32 id,
>>>    			   struct fwnode_handle *fwnode,
>>>    			   const struct iommu_ops *ops);
>>> -int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
>>> -		       u64 *size);
>>> +int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map);
>>>    int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
>>>    			   const u32 *input_id);
>>>    static inline int acpi_dma_configure(struct device *dev,
>>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>>> index 44975c1..f806092 100644
>>> --- a/include/linux/acpi.h
>>> +++ b/include/linux/acpi.h
>>> @@ -974,8 +974,7 @@ static inline enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev)
>>>    	return DEV_DMA_NOT_SUPPORTED;
>>>    }
>>> -static inline int acpi_dma_get_range(struct device *dev, u64 *dma_addr,
>>> -				     u64 *offset, u64 *size)
>>> +static inline int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map)
>>>    {
>>>    	return -ENODEV;
>>>    }
>>>
>>

