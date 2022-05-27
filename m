Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C13535759
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 03:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbiE0Bek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 21:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbiE0Beg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 21:34:36 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B3362BDE
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 18:34:34 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VEUq88P_1653615271;
Received: from 30.32.82.202(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VEUq88P_1653615271)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 27 May 2022 09:34:32 +0800
Message-ID: <d6f64c75-053d-57e0-a997-176758523d9e@linux.alibaba.com>
Date:   Fri, 27 May 2022 09:34:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] mm/hugetlb: Remove unnecessary
 huge_ptep_set_access_flags() in hugetlb_mcopy_atomic_pte()
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        mike.kravetz@oracle.com, akpm@linux-foundation.org,
        songmuchun@bytedance.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <7cd55152c1a00910afda570d1543a97198b3665b.1653468078.git.baolin.wang@linux.alibaba.com>
 <428c7c69-6ac1-51d5-7c26-5f31de61a909@arm.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <428c7c69-6ac1-51d5-7c26-5f31de61a909@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/26/2022 3:01 PM, Anshuman Khandual wrote:
> 
> 
> On 5/25/22 15:56, Baolin Wang wrote:
>> There is no need to update the hugetlb access flags after just setting the
>> hugetlb page table entry by set_huge_pte_at(), since the page table entry
>> value has no changes. Thus remove the unnecessary huge_ptep_set_access_flags()
> 
> WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
> #9:
> value has no changes. Thus remove the unnecessary huge_ptep_set_access_flags()
> 
> total: 0 errors, 1 warnings, 8 lines checked

Sure, will remove checkpatch warning in next verion.

> 
>> in hugetlb_mcopy_atomic_pte().
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> 
> Otherwise LGTM,
> 
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

Thanks. Also thanks to Muchun and Mike for reviewing.
