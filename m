Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6C24CB839
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 09:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbiCCIBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 03:01:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbiCCIBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 03:01:08 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294BC1688EB;
        Thu,  3 Mar 2022 00:00:20 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 22380CJ0096549;
        Thu, 3 Mar 2022 02:00:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1646294412;
        bh=cUfnBSa5Y6H8tD7pfJUnVu2gf9wOMmbuMF7hXOj/rLM=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=FJOojwEbdjEIzmTEGlhn4FQV/tCuAiekPplalBRd2gJiXgIp/RoXyIajvMXcjvMRm
         mlw1ofsus+dBEa+x4iItMi2uRwidlfWlJbc9rLs7K0aZKIREXs10iu+MN5n6izHDGi
         7Jcf/93JvWjaJF8iDCxNDyvEc9la6+c4IJhBucXc=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 22380Cjf073496
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Mar 2022 02:00:12 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 3
 Mar 2022 02:00:12 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 3 Mar 2022 02:00:12 -0600
Received: from [10.250.233.98] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 223808Cq049411;
        Thu, 3 Mar 2022 02:00:09 -0600
Message-ID: <869aa1ad-e3ed-cd0b-ab5e-a4b7d1d23311@ti.com>
Date:   Thu, 3 Mar 2022 13:30:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [EXTERNAL] Re: [PATCH v5 1/2] remoteproc: Introduce
 sysfs_read_only flag
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     <vigneshr@ti.com>, <s-anna@ti.com>, <mathieu.poirier@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20220216081224.9956-1-p-mohan@ti.com>
 <20220216081224.9956-2-p-mohan@ti.com>
 <0d44d73f-d882-83db-9cf2-09f7cdc91ab2@ti.com> <Yg80gABeszDDN/m6@ripper>
From:   Puranjay Mohan <p-mohan@ti.com>
In-Reply-To: <Yg80gABeszDDN/m6@ripper>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,
Hi Mathieu,

When is this series expected to be applied?

I am going to post another series titled "PRU Consumer API".
One patch from that series depends on this "Introduce sysfs_read_only
flag" patch.

Please let me know so I can rebase and post that series.

Thanks,
Puranjay Mohan

On 18/02/22 11:24, Bjorn Andersson wrote:
> On Thu 17 Feb 21:00 PST 2022, Kishon Vijay Abraham I wrote:
> 
>>
>>
>> On 16/02/22 1:42 pm, Puranjay Mohan wrote:
>>> The remoteproc framework provides sysfs interfaces for changing
>>> the firmware name and for starting/stopping a remote processor
>>> through the sysfs files 'state' and 'firmware'. The 'coredump'
>>> file is used to set the coredump configuration. The 'recovery'
>>> sysfs file can also be used similarly to control the error recovery
>>> state machine of a remoteproc. These interfaces are currently
>>> allowed irrespective of how the remoteprocs were booted (like
>>> remoteproc self auto-boot, remoteproc client-driven boot etc).
>>> These interfaces can adversely affect a remoteproc and its clients
>>> especially when a remoteproc is being controlled by a remoteproc
>>> client driver(s). Also, not all remoteproc drivers may want to
>>> support the sysfs interfaces by default.
>>>
>>> Add support to make the remoteproc sysfs files read only by
>>> introducing a state flag 'sysfs_read_only' that the individual
>>> remoteproc drivers can set based on their usage needs. The default
>>> behavior is to allow the sysfs operations as before.
>>>
>>> Implement attribute_group->is_visible() to make the sysfs
>>> entries read only when 'sysfs_read_only' flag is set.
>>>
>>> Signed-off-by: Puranjay Mohan <p-mohan@ti.com>
>>> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>>> ---
>>> Changes in v4->v5:
>>> Rename deny_sysfs_ops to sysfs_read_only.
>>> Make coredump readonly with other files.
>>>
>>> Changes in v3->v4:
>>> Use mode = 0444 in rproc_is_visible() to make the sysfs entries
>>> read-only when the deny_sysfs_ops flag is set.
>>> ---
>>>  drivers/remoteproc/remoteproc_sysfs.c | 19 ++++++++++++++++++-
>>>  include/linux/remoteproc.h            |  2 ++
>>>  2 files changed, 20 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
>>> index ea8b89f97d7b..abf0cd05d5e1 100644
>>> --- a/drivers/remoteproc/remoteproc_sysfs.c
>>> +++ b/drivers/remoteproc/remoteproc_sysfs.c
>>> @@ -230,6 +230,22 @@ static ssize_t name_show(struct device *dev, struct device_attribute *attr,
>>>  }
>>>  static DEVICE_ATTR_RO(name);
>>>  
>>> +static umode_t rproc_is_visible(struct kobject *kobj, struct attribute *attr,
>>> +				int n)
>>> +{
>>> +	struct device *dev = kobj_to_dev(kobj);
>>> +	struct rproc *rproc = to_rproc(dev);
>>> +	umode_t mode = attr->mode;
>>> +
>>> +	if (rproc->sysfs_read_only && (attr == &dev_attr_recovery.attr ||
>>> +				       attr == &dev_attr_firmware.attr ||
>>> +				       attr == &dev_attr_state.attr ||
>>> +				       attr == &dev_attr_coredump.attr))
>>> +		mode = 0444;
>>
>> Nitpick: use S_IRUGO instead of 0444.
>>
> 
> Thanks for the suggestion Kishon, but I like 0444, it has direct meaning
> to me.
> 
> So unless there's some directive to use S_I*** throughout the kernel I
> would prefer this.
> 
> Regards,
> Bjorn
> 
>> Thanks,
>> Kishon
>>> +
>>> +	return mode;
>>> +}
>>> +
>>>  static struct attribute *rproc_attrs[] = {
>>>  	&dev_attr_coredump.attr,
>>>  	&dev_attr_recovery.attr,
>>> @@ -240,7 +256,8 @@ static struct attribute *rproc_attrs[] = {
>>>  };
>>>  
>>>  static const struct attribute_group rproc_devgroup = {
>>> -	.attrs = rproc_attrs
>>> +	.attrs = rproc_attrs,
>>> +	.is_visible = rproc_is_visible,
>>>  };
>>>  
>>>  static const struct attribute_group *rproc_devgroups[] = {
>>> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
>>> index e0600e1e5c17..93a1d0050fbc 100644
>>> --- a/include/linux/remoteproc.h
>>> +++ b/include/linux/remoteproc.h
>>> @@ -523,6 +523,7 @@ struct rproc_dump_segment {
>>>   * @table_sz: size of @cached_table
>>>   * @has_iommu: flag to indicate if remote processor is behind an MMU
>>>   * @auto_boot: flag to indicate if remote processor should be auto-started
>>> + * @sysfs_read_only: flag to make remoteproc sysfs files read only
>>>   * @dump_segments: list of segments in the firmware
>>>   * @nb_vdev: number of vdev currently handled by rproc
>>>   * @elf_class: firmware ELF class
>>> @@ -562,6 +563,7 @@ struct rproc {
>>>  	size_t table_sz;
>>>  	bool has_iommu;
>>>  	bool auto_boot;
>>> +	bool sysfs_read_only;
>>>  	struct list_head dump_segments;
>>>  	int nb_vdev;
>>>  	u8 elf_class;
>>>
