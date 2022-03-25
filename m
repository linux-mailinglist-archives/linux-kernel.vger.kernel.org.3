Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592924E6F87
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 09:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355428AbiCYIk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 04:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243468AbiCYIk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 04:40:26 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6A6517F0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 01:38:52 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220325083850epoutp020e32f7d5ecbb2c3d61024553750cf8ae~fkuvHr1Y72828828288epoutp02H
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 08:38:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220325083850epoutp020e32f7d5ecbb2c3d61024553750cf8ae~fkuvHr1Y72828828288epoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648197530;
        bh=cpqRKnw4M+cOm2YLojXOYAprC75I33+eiDy2xtf4IR4=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=cDuIjQF4WwRFzp+ooZaRDVjA3CL0fya2L+IGqv9oZBpVdAv81DvD9gQwiaYBbcLi7
         lmLhNImzQE/+B37jaRp+HhjYMcDvhoxtH6sF/MOC0S0xwQVd/eckrE/pKaMBWGvLWo
         74euWg/hDlJr4xQzuqaiCNCAuf6UN/rvauZfREoE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220325083848epcas1p21d2933741bec8e8b6472eb554de57ff4~fkuuFsEYv0461204612epcas1p2j;
        Fri, 25 Mar 2022 08:38:48 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.247]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4KPwVH2QTnz4x9QC; Fri, 25 Mar
        2022 08:38:47 +0000 (GMT)
X-AuditID: b6c32a38-929ff700000255ac-c8-623d7f975f23
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        46.08.21932.79F7D326; Fri, 25 Mar 2022 17:38:47 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH 0/8] memblock: introduce memsize showing reserved memory
Reply-To: jaewon31.kim@samsung.com
Sender: Jaewon Kim <jaewon31.kim@samsung.com>
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     Mike Rapoport <rppt@kernel.org>
CC:     "vbabka@suse.cz" <vbabka@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        YongTaek Lee <ytk.lee@samsung.com>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <Yj1zVkryTVoAnxsX@kernel.org>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220325083846epcms1p372559472ceb511cc45d39c110563063a@epcms1p3>
Date:   Fri, 25 Mar 2022 17:38:46 +0900
X-CMS-MailID: 20220325083846epcms1p372559472ceb511cc45d39c110563063a
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGJsWRmVeSWpSXmKPExsWy7bCmru70etskg9mv+SzmrF/DZvHykKZF
        9+aZjBa9718xWVzeNYfN4t6a/6wWR9ZvZ7KY3djHaPF4PbcDp8fOWXfZPTat6mTz2PRpErvH
        iRm/WTz6tqxi9Diz4Ai7x+dNcgHsUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW
        5koKeYm5qbZKLj4Bum6ZOUCHKSmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKzAr0
        ihNzi0vz0vXyUkusDA0MjEyBChOyM67Mf8RY0CZTcf3hZ9YGxj7RLkZODgkBE4lr1+6zgdhC
        AjsYJeY8qexi5ODgFRCU+LtDGCQsLOAj8b5pFjtEiZLE2R9X2CHiuhJN3atZQGw2AW2J9wsm
        sYLYIgLKEt8X72PuYuTiYBZYyiSx4UYTM8QuXokZ7U9ZIGxpie3LtzKC7OIU0JLYPj0KIiwq
        cXP1W3YY+/2x+YwQtohE672zUGMEJR783A0Vl5I4132cCWSMhECExIs96hDhHIn3O+ewQtjm
        Es82tICN5BXwlThy+wTYGBYBVYnXl+dDXeMicfzsUrCRzALyEtvfzmEGGcksoCmxfpc+RImi
        xM7fcxlhHmnY+Jsdnc0swCfx7msPK0x8x7wnTBC2mkTLs69QcRmJv/+esU5gVJqFCOdZSBbP
        Qli8gJF5FaNYakFxbnpqsWGBCTxmk/NzNzGCE6iWxQ7GuW8/6B1iZOJgPMQowcGsJMJ7/7J1
        khBvSmJlVWpRfnxRaU5q8SFGU6CXJzJLiSbnA1N4Xkm8oYmlgYmZkYmFsaWxmZI4b+/U04lC
        AumJJanZqakFqUUwfUwcnFINTBn8Fq/n7GqfbKKT8ur+Id/42xLzKv5Jfl91UkDtJVfhFZPn
        IhxGDGwH+xYbduwLlEhXvm66lW/irNQGtozDn3pePVi45987p8Zi5oen/ayeGsi/t9F1CU+o
        ONza9e7RhOTJGndczN7J3vCpfGgj9SZTbbHQ4gmTrO9/+nz3fFf/6vPr22R2NlQJqa+JquZj
        ucVZ99N/m3pt/991G7ineHeWpvGu99eUy6zn7TLdsWzp2Y396vFX2+o9rDo+mS5/PPuZaWUe
        D/tuv9DYD7/FtZecDW6WU06ROL8ibXXu7/sqs3+vuD3dslMrrraMXWu60d7PAXm25vcTxKID
        RKwSV129+0/S4dXsRq/jbb47lFiKMxINtZiLihMBxp13sSkEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220324065919epcas1p4c79da5f6ec4fa0311409ca24a38785d8
References: <Yj1zVkryTVoAnxsX@kernel.org>
        <20220324070158.22969-1-jaewon31.kim@samsung.com>
        <CGME20220324065919epcas1p4c79da5f6ec4fa0311409ca24a38785d8@epcms1p3>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 
>--------- Original Message ---------
>Sender : Mike Rapoport <rppt@kernel.org>
>Date : 2022-03-25 16:46 (GMT+9)
>Title : Re: [PATCH 0/8] memblock: introduce memsize showing reserved memory
> 
>Hi,
> 
>On Thu, Mar 24, 2022 at 04:01:50PM +0900, Jaewon Kim wrote:
>> Some of memory regions can be reserved for a specific purpose. They are
>> usually defined through reserved-memory in device tree. If only size
>> without address is specified in device tree, the address of the region
>> will be determined at boot time.
>> 
>> We may find the address of the memory regions through booting log, but
>> it does not show all. And it could be hard to catch the very beginning
>> log. The memblock_dump_all shows all memblock status but it does not
>> show region name and its information is difficult to summarize.
>> 
>> This patch introduce a debugfs node, memblock/memsize, to see reserved
>> memory easily.
>> 
>> Here's an example
>> 
>> $ cat debugfs/memblock/memsize
>> 0x0f9000000-0x0fb000000 0x02000000 (   32768 KB )   map reusable linux,cma
>> 0x0b1900000-0x0b1b00000 0x00200000 (    2048 KB ) nomap unusable test1
>> 0x0b0200000-0x0b0400000 0x00200000 (    2048 KB )   map unusable test2
>>  (snipped)
>> 
>> Reserved    :  746924 KB
>>  .kernel    :  137027 KB
>>   .text     :   28158 KB
>>   .rwdata   :    3238 KB
>>   .rodata   :   13468 KB
>>   .bss      :   12570 KB
>>   .etc      :   79593 KB
>>  .unusable  :  609897 KB
>> System      : 3447380 KB
>>  .common    : 3152468 KB
>>  .reusable  :  294912 KB
>> Total       : 4194304 KB (  4096.00 MB )
> 
>Most of this information information is already available at various
>places, like the existing memblock debugfs, /proc/iomem and DT sysfs.
> 
>I don't see why we need yet another debugfs file to expose it.

Hi.
Thank you for your reply.

I don't think existing memblock debugfs or /proc/iomem shows information I want.
They don't show name and actually allocated address and size. And it does not
handle pages freed to buddy allocator after boot.

And which DT sysfs do you mean? If it is /proc/device-tree/reserved-memory, it
shows name and size, but it does not show address for only size defined regions.
It does not recognize the freed pages, either.

Especially I'd like to create a node showing all reserved memory status, their 
total size is same as the physical memory size. This was very useful when I 
compare reserved memory and kernel init time memory between different chipsets,
or between different sw release versions.

Thank you
Jaewon Kim

> 
>> Jaewon Kim (8):
>>   memblock: introduce memsize showing reserved memory
>>   memblock: detect hidden memory hole size
>>   memblock: handle overlapped reserved memory region
>>   memblock: track memblock changed at early param
>>   memblock: track kernel size on memsize
>>   memblock: recognize late free by checking PageReserved
>>   memblock: print memsize summary information
>>   memblock: print kernel internal size
>> 
>>  drivers/of/fdt.c             |  10 +
>>  drivers/of/of_reserved_mem.c |   7 +-
>>  include/linux/memblock.h     |  21 ++
>>  include/linux/mm.h           |   3 +
>>  init/main.c                  |  13 +-
>>  kernel/dma/contiguous.c      |   9 +-
>>  mm/Kconfig                   |   7 +
>>  mm/memblock.c                | 434 ++++++++++++++++++++++++++++++++++-
>>  mm/page_alloc.c              |  15 +-
>>  9 files changed, 506 insertions(+), 13 deletions(-)
>> 
>> -- 
>> 2.17.1
>> 
> 
>-- 
>Sincerely yours,
>Mike.
> 
