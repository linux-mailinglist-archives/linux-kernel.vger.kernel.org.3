Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9022854C2DE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 09:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243477AbiFOHsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 03:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243507AbiFOHsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 03:48:08 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47E727B22
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 00:48:04 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LNHRd1chpz1KB3H;
        Wed, 15 Jun 2022 15:46:05 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 15 Jun 2022 15:48:02 +0800
Subject: Re: [PATCH 5/7] mm/khugepaged: use helper macro __ATTR_RW
To:     Zach O'Keefe <zokeefe@google.com>
CC:     <akpm@linux-foundation.org>, <aarcange@redhat.com>,
        <willy@infradead.org>, <vbabka@suse.cz>, <dhowells@redhat.com>,
        <neilb@suse.de>, <apopple@nvidia.com>, <david@redhat.com>,
        <surenb@google.com>, <peterx@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220611084731.55155-1-linmiaohe@huawei.com>
 <20220611084731.55155-6-linmiaohe@huawei.com> <Yqkn65gGKfQE1Lg1@google.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <c40ba4b2-706e-8e74-7fee-f0f31d38a1ff@huawei.com>
Date:   Wed, 15 Jun 2022 15:48:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <Yqkn65gGKfQE1Lg1@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/15 8:29, Zach O'Keefe wrote:
> On 11 Jun 16:47, Miaohe Lin wrote:
>> Use helper macro __ATTR_RW to define the khugepaged attributes. Minor
>> readability improvement.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/khugepaged.c | 37 +++++++++++++++----------------------
>>  1 file changed, 15 insertions(+), 22 deletions(-)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 8e6fad7c7bd9..142e26e4bdbf 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -147,8 +147,7 @@ static ssize_t scan_sleep_millisecs_store(struct kobject *kobj,
>>  	return count;
>>  }
>>  static struct kobj_attribute scan_sleep_millisecs_attr =
>> -	__ATTR(scan_sleep_millisecs, 0644, scan_sleep_millisecs_show,
>> -	       scan_sleep_millisecs_store);
>> +	__ATTR_RW(scan_sleep_millisecs);
>>  
>>  static ssize_t alloc_sleep_millisecs_show(struct kobject *kobj,
>>  					  struct kobj_attribute *attr,
>> @@ -175,8 +174,7 @@ static ssize_t alloc_sleep_millisecs_store(struct kobject *kobj,
>>  	return count;
>>  }
>>  static struct kobj_attribute alloc_sleep_millisecs_attr =
>> -	__ATTR(alloc_sleep_millisecs, 0644, alloc_sleep_millisecs_show,
>> -	       alloc_sleep_millisecs_store);
>> +	__ATTR_RW(alloc_sleep_millisecs);
>>  
>>  static ssize_t pages_to_scan_show(struct kobject *kobj,
>>  				  struct kobj_attribute *attr,
>> @@ -200,8 +198,7 @@ static ssize_t pages_to_scan_store(struct kobject *kobj,
>>  	return count;
>>  }
>>  static struct kobj_attribute pages_to_scan_attr =
>> -	__ATTR(pages_to_scan, 0644, pages_to_scan_show,
>> -	       pages_to_scan_store);
>> +	__ATTR_RW(pages_to_scan);
>>  
>>  static ssize_t pages_collapsed_show(struct kobject *kobj,
>>  				    struct kobj_attribute *attr,
>> @@ -221,13 +218,13 @@ static ssize_t full_scans_show(struct kobject *kobj,
>>  static struct kobj_attribute full_scans_attr =
>>  	__ATTR_RO(full_scans);
>>  
>> -static ssize_t khugepaged_defrag_show(struct kobject *kobj,
>> +static ssize_t defrag_show(struct kobject *kobj,
>>  				      struct kobj_attribute *attr, char *buf)
>>  {
>>  	return single_hugepage_flag_show(kobj, attr, buf,
>>  					 TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG);
>>  }
>> -static ssize_t khugepaged_defrag_store(struct kobject *kobj,
>> +static ssize_t defrag_store(struct kobject *kobj,
>>  				       struct kobj_attribute *attr,
>>  				       const char *buf, size_t count)
>>  {
>> @@ -235,8 +232,7 @@ static ssize_t khugepaged_defrag_store(struct kobject *kobj,
>>  				 TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG);
>>  }
>>  static struct kobj_attribute khugepaged_defrag_attr =
>> -	__ATTR(defrag, 0644, khugepaged_defrag_show,
>> -	       khugepaged_defrag_store);
>> +	__ATTR_RW(defrag);
>>  
>>  /*
>>   * max_ptes_none controls if khugepaged should collapse hugepages over
>> @@ -246,13 +242,13 @@ static struct kobj_attribute khugepaged_defrag_attr =
>>   * runs. Increasing max_ptes_none will instead potentially reduce the
>>   * free memory in the system during the khugepaged scan.
>>   */
>> -static ssize_t khugepaged_max_ptes_none_show(struct kobject *kobj,
>> +static ssize_t max_ptes_none_show(struct kobject *kobj,
>>  					     struct kobj_attribute *attr,
>>  					     char *buf)
>>  {
>>  	return sysfs_emit(buf, "%u\n", khugepaged_max_ptes_none);
>>  }
>> -static ssize_t khugepaged_max_ptes_none_store(struct kobject *kobj,
>> +static ssize_t max_ptes_none_store(struct kobject *kobj,
>>  					      struct kobj_attribute *attr,
>>  					      const char *buf, size_t count)
>>  {
>> @@ -268,17 +264,16 @@ static ssize_t khugepaged_max_ptes_none_store(struct kobject *kobj,
>>  	return count;
>>  }
>>  static struct kobj_attribute khugepaged_max_ptes_none_attr =
>> -	__ATTR(max_ptes_none, 0644, khugepaged_max_ptes_none_show,
>> -	       khugepaged_max_ptes_none_store);
>> +	__ATTR_RW(max_ptes_none);
>>  
>> -static ssize_t khugepaged_max_ptes_swap_show(struct kobject *kobj,
>> +static ssize_t max_ptes_swap_show(struct kobject *kobj,
>>  					     struct kobj_attribute *attr,
>>  					     char *buf)
>>  {
>>  	return sysfs_emit(buf, "%u\n", khugepaged_max_ptes_swap);
>>  }
>>  
>> -static ssize_t khugepaged_max_ptes_swap_store(struct kobject *kobj,
>> +static ssize_t max_ptes_swap_store(struct kobject *kobj,
>>  					      struct kobj_attribute *attr,
>>  					      const char *buf, size_t count)
>>  {
>> @@ -295,17 +290,16 @@ static ssize_t khugepaged_max_ptes_swap_store(struct kobject *kobj,
>>  }
>>  
>>  static struct kobj_attribute khugepaged_max_ptes_swap_attr =
>> -	__ATTR(max_ptes_swap, 0644, khugepaged_max_ptes_swap_show,
>> -	       khugepaged_max_ptes_swap_store);
>> +	__ATTR_RW(max_ptes_swap);
>>  
>> -static ssize_t khugepaged_max_ptes_shared_show(struct kobject *kobj,
>> +static ssize_t max_ptes_shared_show(struct kobject *kobj,
>>  					       struct kobj_attribute *attr,
>>  					       char *buf)
>>  {
>>  	return sysfs_emit(buf, "%u\n", khugepaged_max_ptes_shared);
>>  }
>>  
>> -static ssize_t khugepaged_max_ptes_shared_store(struct kobject *kobj,
>> +static ssize_t max_ptes_shared_store(struct kobject *kobj,
>>  					      struct kobj_attribute *attr,
>>  					      const char *buf, size_t count)
>>  {
>> @@ -322,8 +316,7 @@ static ssize_t khugepaged_max_ptes_shared_store(struct kobject *kobj,
>>  }
>>  
>>  static struct kobj_attribute khugepaged_max_ptes_shared_attr =
>> -	__ATTR(max_ptes_shared, 0644, khugepaged_max_ptes_shared_show,
>> -	       khugepaged_max_ptes_shared_store);
>> +	__ATTR_RW(max_ptes_shared);
>>  
>>  static struct attribute *khugepaged_attr[] = {
>>  	&khugepaged_defrag_attr.attr,
>> -- 
>> 2.23.0
>>
>>
> 
> For function names that changed, can we align args that don't fit on opening
> line with the opening brace?

Sorry, I forgot to fit on opening line with the opening brace and checkpatch.pl didn't
complain about it. Will fix these and similar case in another thread. Many thanks for
your review and comment!

> 
> Thanks,
> Zach
> .
> 

