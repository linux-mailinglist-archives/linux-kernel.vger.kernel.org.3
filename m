Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB954864D1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 14:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239196AbiAFNBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 08:01:42 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:57539 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232971AbiAFNBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 08:01:40 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V16880g_1641474096;
Received: from 30.15.242.178(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0V16880g_1641474096)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 06 Jan 2022 21:01:37 +0800
Message-ID: <a9ca235a-1324-9c76-953c-16295f8ce3b8@linux.alibaba.com>
Date:   Thu, 6 Jan 2022 21:02:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] mm/damon: Remove redundant page validation
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, dan.carpenter@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220106114047.6595-1-sj@kernel.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20220106114047.6595-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi SeongJae,

On 1/6/2022 7:40 PM, SeongJae Park wrote:
> Hi Baolin,
> 
> 
> Thank you always for your great contribution!  As always, trivial comments
> below.
> 
> On Thu, 6 Jan 2022 18:40:11 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
> 
>> It will never get a NULL page by pte_page(), thus remove the redundant
>> page validation to fix below Smatch static checker warning.
> 
> I guess the issue has reported in the open place[1], right?  I think it would
> be better to add the link in this commit message, so that future readers can
> read and learn from your discussion in the mail thread.
> 
> [1] https://lore.kernel.org/linux-mm/20220106091200.GA14564@kili/

OK.

> 
>>
>> mm/damon/vaddr.c:405 damon_hugetlb_mkold()
>> warn: 'page' can't be NULL.
> 
> Sorry for continuously obsessing about this trivial and personal taste, but...
> Could you please indent quoting blocks like above (hopefully with 4 spaces)?
> That makes the message much easier to read for me, and I'd like to keep the
> commit messages for DAMON consistent and easy to read, at least for me.

Sure, I will keep the rule of DAMON in mind.

Andrew, could you help to change the commit message format as SeongJae 
suggested when you apply this patch? Thanks.

> 
> Other than that,
> 
> Reviewed-by: SeongJae Park <sj@kernel.org>

Thanks.
