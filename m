Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D17E517BEA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 04:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiECCXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 22:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiECCXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 22:23:39 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A2127CD8
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 19:20:08 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VC4WVWf_1651544404;
Received: from 192.168.31.179(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0VC4WVWf_1651544404)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 03 May 2022 10:20:06 +0800
Message-ID: <b1fe7b84-6d27-e42e-4c89-b5ac5f648c4b@linux.alibaba.com>
Date:   Tue, 3 May 2022 10:20:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:100.0)
 Gecko/20100101 Thunderbird/100.0
Subject: Re: [PATCH 2/3] mm/damon/sysfs: support fixed virtual address ranges
 monitoring
Content-Language: en-US
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, linux-damon@amazon.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220502161810.134199-1-sj@kernel.org>
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
In-Reply-To: <20220502161810.134199-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.5 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/3/22 12:18 AM, SeongJae Park wrote:
> Hi Rongwei,
> 
> On Mon, 2 May 2022 15:56:58 +0800 Rongwei Wang <rongwei.wang@linux.alibaba.com> wrote:
> 
>> Hi, SeongJae
>>
>> I had read and tested your patchset these days. It works.
> 
> Thank you for the tests! :D
> 
>> It seems that these patches only fix the issue about init_regions in
>> DAMON-sysfs, but not fix in DAMON-dbgfs? maybe I missing something.
>>
>> If so, do you have any plan to fix this bug in dbgfs? Actually, what I
>> want to say is that I ready a patch for solving the init_regions related
>> bug in dbgfs these days. I not sure if you're interested in it.
> 
> The plan is to freeze DAMON debugfs interface after DAMON sysfs interface is
> merged, and then entirely remove it after next LTS kernel.  It was mentioned in
> the sysfs interface patchset as below:
> https://lore.kernel.org/linux-mm/20220228081314.5770-1-sj@kernel.org/
> 
>      Future Plan of DAMON_DBGFS Deprecation
>      ======================================
>      
>      Once this patchset is merged, DAMON_DBGFS development will be frozen.  That is,
>      we will maintain it to work as is now so that no users will be break.  But, it
>      will not be extended to provide any new feature of DAMON.  The support will be
>      continued only until next LTS release.  After that, we will drop DAMON_DBGFS.
> 
> The plan was also shared in the kernel doc as below[1], but maybe it was too
> small to read, or ambiguous.  Sorry if it was the case.
> 
>      debugfs interface. This is almost identical to sysfs interface. This will
>      be _removed_ after next LTS kernel is released, so users should move to the
>      sysfs interface.
Hi, SeongJae

Thanks, for telling me the doc!
It seems that I have to update my datop. New sysfs interface has changed 
too much.

Anyway, Thanks! :)

> 
> [1] https://docs.kernel.org/admin-guide/mm/damon/usage.html#debugfs-interface
> 
> So, I don't have a big interest at extending DAMON debugfs for fvaddr.  That
> said, of course we could discuss more if you really need it.  If so, please let
> me know.
> 
> 
> Thanks,
> SJ
> 
>>
>> Best Regards,
>> Rongwei
>>
