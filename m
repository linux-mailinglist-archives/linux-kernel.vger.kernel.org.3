Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA1D4B9908
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 07:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235272AbiBQGOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 01:14:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiBQGOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 01:14:37 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E1D2A2284;
        Wed, 16 Feb 2022 22:14:22 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21H6EEYB041371;
        Thu, 17 Feb 2022 00:14:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645078454;
        bh=aLTZogrRpGo1Uu1bmA0UH4iVsPcFR2kuNZvj/aRW3Vw=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=F/+dQ9QTp4akMJ1cLEPJNXKg8PQKf3YgHg3DagIEJRct/7EB9Rw47liR/2UljsxwQ
         5aAdBAyaw1YvJjw9lYOUfRorlAG3S7rCC3PTcOwKQ6nSMYQE9OXV4rBAeNC4DlyoU5
         V7K3FNQpZHPHJNUR3FwdJOXk1h5JDVUijRWIsNls=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21H6EErd104575
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Feb 2022 00:14:14 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 17
 Feb 2022 00:14:14 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 17 Feb 2022 00:14:13 -0600
Received: from [10.250.233.253] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21H6E5NJ116873;
        Thu, 17 Feb 2022 00:14:06 -0600
Message-ID: <bd3149df-3c24-7287-03ef-4efb700dd51b@ti.com>
Date:   Thu, 17 Feb 2022 11:44:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 1/2] remoteproc: Introduce sysfs_read_only flag
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <kishon@ti.com>, <vigneshr@ti.com>, <s-anna@ti.com>,
        <mathieu.poirier@linaro.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20220216081224.9956-1-p-mohan@ti.com>
 <20220216081224.9956-2-p-mohan@ti.com> <Yg1Y1dtT9CjZTxgW@yoga>
From:   Puranjay Mohan <p-mohan@ti.com>
In-Reply-To: <Yg1Y1dtT9CjZTxgW@yoga>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 17/02/22 01:34, Bjorn Andersson wrote:
> On Wed 16 Feb 02:12 CST 2022, Puranjay Mohan wrote:
> 
>> The remoteproc framework provides sysfs interfaces for changing
>> the firmware name and for starting/stopping a remote processor
>> through the sysfs files 'state' and 'firmware'. The 'coredump'
>> file is used to set the coredump configuration. The 'recovery'
>> sysfs file can also be used similarly to control the error recovery
>> state machine of a remoteproc. These interfaces are currently
>> allowed irrespective of how the remoteprocs were booted (like
>> remoteproc self auto-boot, remoteproc client-driven boot etc).
>> These interfaces can adversely affect a remoteproc and its clients
>> especially when a remoteproc is being controlled by a remoteproc
>> client driver(s). Also, not all remoteproc drivers may want to
>> support the sysfs interfaces by default.
>>
>> Add support to make the remoteproc sysfs files read only by
>> introducing a state flag 'sysfs_read_only' that the individual
>> remoteproc drivers can set based on their usage needs. The default
>> behavior is to allow the sysfs operations as before.
>>
>> Implement attribute_group->is_visible() to make the sysfs
>> entries read only when 'sysfs_read_only' flag is set.
>>
>> Signed-off-by: Puranjay Mohan <p-mohan@ti.com>
>> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>> ---
>> Changes in v4->v5:
>> Rename deny_sysfs_ops to sysfs_read_only.
>> Make coredump readonly with other files.
>>
>> Changes in v3->v4:
>> Use mode = 0444 in rproc_is_visible() to make the sysfs entries
>> read-only when the deny_sysfs_ops flag is set.
>> ---
>>  drivers/remoteproc/remoteproc_sysfs.c | 19 ++++++++++++++++++-
>>  include/linux/remoteproc.h            |  2 ++
>>  2 files changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
>> index ea8b89f97d7b..abf0cd05d5e1 100644
>> --- a/drivers/remoteproc/remoteproc_sysfs.c
>> +++ b/drivers/remoteproc/remoteproc_sysfs.c
>> @@ -230,6 +230,22 @@ static ssize_t name_show(struct device *dev, struct device_attribute *attr,
>>  }
>>  static DEVICE_ATTR_RO(name);
>>  
>> +static umode_t rproc_is_visible(struct kobject *kobj, struct attribute *attr,
>> +				int n)
>> +{
>> +	struct device *dev = kobj_to_dev(kobj);
>> +	struct rproc *rproc = to_rproc(dev);
>> +	umode_t mode = attr->mode;
>> +
>> +	if (rproc->sysfs_read_only && (attr == &dev_attr_recovery.attr ||
>> +				       attr == &dev_attr_firmware.attr ||
>> +				       attr == &dev_attr_state.attr ||
>> +				       attr == &dev_attr_coredump.attr))
>> +		mode = 0444;
> 
> Change looks good now, but just to make sure, you actually care about
> the content of these files for the Wakup M3? Read-only vs hiding them...

Yes, it is useful for debugging purposes, hence making it read-only is
the correct approach.

Also, I will be re-sending PRU remoteproc consumer API patch series[1]
that depends on this change.

[1]https://patchwork.kernel.org/project/linux-remoteproc/cover/20201216165239.2744-1-grzegorz.jaszczyk@linaro.org/

Thanks,
Puranjay Mohan

> 
> regards,
> Bjorn
> 
>> +
>> +	return mode;
>> +}
>> +
>>  static struct attribute *rproc_attrs[] = {
>>  	&dev_attr_coredump.attr,
>>  	&dev_attr_recovery.attr,
>> @@ -240,7 +256,8 @@ static struct attribute *rproc_attrs[] = {
>>  };
>>  
>>  static const struct attribute_group rproc_devgroup = {
>> -	.attrs = rproc_attrs
>> +	.attrs = rproc_attrs,
>> +	.is_visible = rproc_is_visible,
>>  };
>>  
>>  static const struct attribute_group *rproc_devgroups[] = {
>> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
>> index e0600e1e5c17..93a1d0050fbc 100644
>> --- a/include/linux/remoteproc.h
>> +++ b/include/linux/remoteproc.h
>> @@ -523,6 +523,7 @@ struct rproc_dump_segment {
>>   * @table_sz: size of @cached_table
>>   * @has_iommu: flag to indicate if remote processor is behind an MMU
>>   * @auto_boot: flag to indicate if remote processor should be auto-started
>> + * @sysfs_read_only: flag to make remoteproc sysfs files read only
>>   * @dump_segments: list of segments in the firmware
>>   * @nb_vdev: number of vdev currently handled by rproc
>>   * @elf_class: firmware ELF class
>> @@ -562,6 +563,7 @@ struct rproc {
>>  	size_t table_sz;
>>  	bool has_iommu;
>>  	bool auto_boot;
>> +	bool sysfs_read_only;
>>  	struct list_head dump_segments;
>>  	int nb_vdev;
>>  	u8 elf_class;
>> -- 
>> 2.17.1
>>
