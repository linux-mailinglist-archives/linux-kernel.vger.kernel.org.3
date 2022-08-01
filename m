Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D975866B4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 11:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiHAJHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 05:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiHAJHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 05:07:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A92FD26551
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 02:07:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DCDF1515;
        Mon,  1 Aug 2022 02:07:21 -0700 (PDT)
Received: from [10.162.43.6] (unknown [10.162.43.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 278B63F67D;
        Mon,  1 Aug 2022 02:07:17 -0700 (PDT)
Message-ID: <9506bbe9-2cde-3dbf-5dc8-702e0e390bf3@arm.com>
Date:   Mon, 1 Aug 2022 14:37:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] mm/page_ext: remove unused variable in offline_page_ext
Content-Language: en-US
To:     Charan Teja Kalla <quic_charante@quicinc.com>,
        akpm@linux-foundation.org, david@redhat.com, mhocko@suse.com,
        quic_pkondeti@quicinc.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1659330397-11817-1-git-send-email-quic_charante@quicinc.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <1659330397-11817-1-git-send-email-quic_charante@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/1/22 10:36, Charan Teja Kalla wrote:
> Remove unused variable 'nid' in offline_page_ext(). This is not used
> since the page_ext code inception.
> 
> Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>

LGTM

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  mm/page_ext.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/page_ext.c b/mm/page_ext.c
> index 3dc715d..e22a928 100644
> --- a/mm/page_ext.c
> +++ b/mm/page_ext.c
> @@ -336,7 +336,7 @@ static int __meminit online_page_ext(unsigned long start_pfn,
>  }
>  
>  static int __meminit offline_page_ext(unsigned long start_pfn,
> -				unsigned long nr_pages, int nid)
> +				unsigned long nr_pages)
>  {
>  	unsigned long start, end, pfn;
>  
> @@ -362,11 +362,11 @@ static int __meminit page_ext_callback(struct notifier_block *self,
>  		break;
>  	case MEM_OFFLINE:
>  		offline_page_ext(mn->start_pfn,
> -				mn->nr_pages, mn->status_change_nid);
> +				mn->nr_pages);
>  		break;
>  	case MEM_CANCEL_ONLINE:
>  		offline_page_ext(mn->start_pfn,
> -				mn->nr_pages, mn->status_change_nid);
> +				mn->nr_pages);
>  		break;
>  	case MEM_GOING_OFFLINE:
>  		break;
