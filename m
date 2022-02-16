Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443AE4B8282
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 09:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbiBPIFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 03:05:39 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbiBPIFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 03:05:33 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24178225D37;
        Wed, 16 Feb 2022 00:05:20 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21G85CJB089471;
        Wed, 16 Feb 2022 02:05:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1644998712;
        bh=3UQwduVUZ+q8wif62BV/grOjAvJhZ7t6eekjdb8k+us=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=dtmziO/5CXQ6QOxqCyUs6sD0TFQNQpbhjo/LSvPWpzGLinggT8s98SI/eZuOyNZyv
         eVD1vamxdgNHt5jlxOvjJ6YPKv69bdqsyhfxvCXWOB9Lp2Qnjo8+Owt1LIvAjYvL29
         xy7DErcybvNB1BFZbR7+Wv2XSm6NyROSkVUHAxOM=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21G85Cgo055891
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Feb 2022 02:05:12 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 16
 Feb 2022 02:05:12 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 16 Feb 2022 02:05:12 -0600
Received: from [10.250.148.139] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21G8571R087433;
        Wed, 16 Feb 2022 02:05:08 -0600
Message-ID: <a575a328-fb88-5d39-3769-b4c2c4060b47@ti.com>
Date:   Wed, 16 Feb 2022 13:35:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [EXTERNAL] Re: [PATCH v4 1/2] remoteproc: Introduce
 deny_sysfs_ops flag
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <kishon@ti.com>, <vigneshr@ti.com>, <s-anna@ti.com>,
        <bjorn.andersson@linaro.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20220209090342.13220-1-p-mohan@ti.com>
 <20220209090342.13220-2-p-mohan@ti.com> <20220210184802.GB3603040@p14s>
From:   Puranjay Mohan <p-mohan@ti.com>
In-Reply-To: <20220210184802.GB3603040@p14s>
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

Hi Mathieu,

On 11/02/22 00:18, Mathieu Poirier wrote:
> Hi Puranjay,
> 
> On Wed, Feb 09, 2022 at 02:33:41PM +0530, Puranjay Mohan wrote:
>> The remoteproc framework provides sysfs interfaces for changing
>> the firmware name and for starting/stopping a remote processor
>> through the sysfs files 'state' and 'firmware'. The 'recovery'
>> sysfs file can also be used similarly to control the error recovery
>> state machine of a remoteproc. These interfaces are currently
>> allowed irrespective of how the remoteprocs were booted (like
>> remoteproc self auto-boot, remoteproc client-driven boot etc).
>> These interfaces can adversely affect a remoteproc and its clients
>> especially when a remoteproc is being controlled by a remoteproc
>> client driver(s). Also, not all remoteproc drivers may want to
>> support the sysfs interfaces by default.
>>
>> Add support to deny the sysfs state/firmware/recovery change by
>> introducing a state flag 'deny_sysfs_ops' that the individual
>> remoteproc drivers can set based on their usage needs. The default
>> behavior is to allow the sysfs operations as before.
>>
>> Implement attribute_group->is_visible() to hide the sysfs
>> state/firmware/recovery entries when deny_sysfs_ops flag is set.
>>
>> Signed-off-by: Puranjay Mohan <p-mohan@ti.com>
>> ---
>> Changes in v3->v4:
>> Use mode = 0444 in rproc_is_visible() to make the sysfs entries
>> read-only when the deny_sysfs_ops flag is set.
>> ---
>>  drivers/remoteproc/remoteproc_sysfs.c | 18 +++++++++++++++++-
>>  include/linux/remoteproc.h            |  2 ++
>>  2 files changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
>> index ea8b89f97d7b..da2d0eecfa44 100644
>> --- a/drivers/remoteproc/remoteproc_sysfs.c
>> +++ b/drivers/remoteproc/remoteproc_sysfs.c
>> @@ -230,6 +230,21 @@ static ssize_t name_show(struct device *dev, struct device_attribute *attr,
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
>> +	if (rproc->deny_sysfs_ops && (attr == &dev_attr_recovery.attr ||
>> +				      attr == &dev_attr_firmware.attr ||
>> +				      attr == &dev_attr_state.attr))
> 
> I was wondering if we should also add coredump to this group to make it an all
> or nothing option (name is already read only).

I have sent a v5 where I have added coredump to this.

> 
>> +		mode = 0444;
> 
> Much better.
> 
>> +
>> +	return mode;
>> +}
>> +
>>  static struct attribute *rproc_attrs[] = {
>>  	&dev_attr_coredump.attr,
>>  	&dev_attr_recovery.attr,
>> @@ -240,7 +255,8 @@ static struct attribute *rproc_attrs[] = {
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
>> index e0600e1e5c17..3849c66ce38f 100644
>> --- a/include/linux/remoteproc.h
>> +++ b/include/linux/remoteproc.h
>> @@ -523,6 +523,7 @@ struct rproc_dump_segment {
>>   * @table_sz: size of @cached_table
>>   * @has_iommu: flag to indicate if remote processor is behind an MMU
>>   * @auto_boot: flag to indicate if remote processor should be auto-started
>> + * @deny_sysfs_ops: flag to not permit sysfs operations on state, firmware and recovery
>>   * @dump_segments: list of segments in the firmware
>>   * @nb_vdev: number of vdev currently handled by rproc
>>   * @elf_class: firmware ELF class
>> @@ -562,6 +563,7 @@ struct rproc {
>>  	size_t table_sz;
>>  	bool has_iommu;
>>  	bool auto_boot;
>> +	bool deny_sysfs_ops;
> 
> Wouldn't "sysfs_read_only" make more sense?

I agree, I have renamed it to sysfs_read_only in v5 patch

> 
> 
> With or without the above and for this set:
> 
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Thanks.
Puranjay Mohan

> 
>>  	struct list_head dump_segments;
>>  	int nb_vdev;
>>  	u8 elf_class;
>> -- 
>> 2.17.1
>>
