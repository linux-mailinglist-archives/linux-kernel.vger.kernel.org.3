Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4F04DBFEC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 08:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbiCQHEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 03:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiCQHEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 03:04:34 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35407520A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 00:03:16 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V7QLPIa_1647500592;
Received: from B-X3VXMD6M-2058.local(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0V7QLPIa_1647500592)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 17 Mar 2022 15:03:13 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
Reply-To: xhao@linux.alibaba.com
Subject: Re: [RFC PATCH V1 0/3] mm/damon: Add CMA minotor support
To:     David Hildenbrand <david@redhat.com>, sj@kernel.org
Cc:     rongwei.wang@linux.alibaba.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>
References: <cover.1647378112.git.xhao@linux.alibaba.com>
 <a1e0a9e9-07ef-8d1c-a409-2b4fb12ed553@redhat.com>
Message-ID: <6e6ef9fa-3916-3449-954d-efd63a959019@linux.alibaba.com>
Date:   Thu, 17 Mar 2022 15:03:11 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <a1e0a9e9-07ef-8d1c-a409-2b4fb12ed553@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 3/16/22 11:09 PM, David Hildenbrand wrote:
> On 15.03.22 17:37, Xin Hao wrote:
>
> s/minotor/monitor/
Thanks,  i will fix it.
>
>> The purpose of these patches is to add CMA memory monitoring function.
>> In some memory tight scenarios, it will be a good choice to release more
>> memory by monitoring the CMA memory.
> I'm sorry, but it's hard to figure out what the target use case should
> be. Who will release CMA memory and how? Who will monitor that? What are
> the "some memory tight scenarios"? What's the overall design goal?
I may not be describing exactly what  i mean，My intention is to find out 
how much of the reserved CMA space is actually used and which is unused,
For those that are not used, I understand that they can be released by 
cma_release(). Of course, This is just a little personal thought that I 
think is helpful for saving memory.
>
-- 
Best Regards!
Xin Hao

