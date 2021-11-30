Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08EFC4629E3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 02:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236805AbhK3BoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 20:44:11 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:55756 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229779AbhK3BoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 20:44:08 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UyoPEMz_1638236446;
Received: from 30.21.164.33(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UyoPEMz_1638236446)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 30 Nov 2021 09:40:47 +0800
Message-ID: <ccb002e0-7ea6-5289-0f01-48f1a23eaf46@linux.alibaba.com>
Date:   Tue, 30 Nov 2021 09:41:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [BUG] hugetlbfs: Fix issue of preallocation of gigantic pages
 can't work
To:     Zhenguo Yao <yaozhenguo1@gmail.com>, mike.kravetz@oracle.com,
        akpm@linux-foundation.org, mlevitsk@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20211129133803.15653-1-yaozhenguo1@gmail.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20211129133803.15653-1-yaozhenguo1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2021/11/29 21:38, Zhenguo Yao wrote:
> Preallocation of gigantic pages can't work bacause of commit:b5389086ad7b
> (hugetlbfs: extend the definition of hugepages parameter to support node
> allocation). When nid is NUMA_NO_NODE(-1), alloc_bootmem_huge_page will
> always return without doing allocation. Fix this by adding more check.
> 
> Signed-off-by: Zhenguo Yao <yaozhenguo1@gmail.com>

You should add a fixes tag, otherwise LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Fixes: b5389086ad7b ("hugetlbfs: extend the definition of hugepages 
parameter to support node allocation")
