Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBEA49D986
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 05:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbiA0EHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 23:07:12 -0500
Received: from foss.arm.com ([217.140.110.172]:33326 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbiA0EHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 23:07:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C3C41FB;
        Wed, 26 Jan 2022 20:07:09 -0800 (PST)
Received: from [10.163.42.218] (unknown [10.163.42.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 658B53F7D8;
        Wed, 26 Jan 2022 20:07:07 -0800 (PST)
Subject: Re: [RFC V1 02/31] mm/mmap: Clarify protection_map[] indices
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
References: <1643029028-12710-1-git-send-email-anshuman.khandual@arm.com>
 <1643029028-12710-3-git-send-email-anshuman.khandual@arm.com>
 <YfD1WFmlFYLkaJ/A@infradead.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <1e06189a-7d69-7d6c-b9b4-3740604c371b@arm.com>
Date:   Thu, 27 Jan 2022 09:37:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YfD1WFmlFYLkaJ/A@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/26/22 12:46 PM, Christoph Hellwig wrote:
>> +	[VM_NONE]				= __P000,
>> +	[VM_READ]				= __P001,
>> +	[VM_WRITE]				= __P010,
>> +	[VM_READ|VM_WRITE]			= __P011,
>> +	[VM_EXEC]				= __P100,
>> +	[VM_EXEC|VM_READ]			= __P101,
>> +	[VM_EXEC|VM_WRITE]			= __P110,
>> +	[VM_EXEC|VM_READ|VM_WRITE]		= __P111,
>> +	[VM_SHARED]				= __S000,
>> +	[VM_SHARED|VM_READ]			= __S001,
>> +	[VM_SHARED|VM_WRITE]			= __S010,
>> +	[VM_SHARED|VM_READ|VM_WRITE]		= __S011,
>> +	[VM_SHARED|VM_EXEC]			= __S100,
>> +	[VM_SHARED|VM_READ|VM_EXEC]		= __S101,
>> +	[VM_SHARED|VM_WRITE|VM_EXEC]		= __S110,
>> +	[VM_SHARED|VM_READ|VM_WRITE|VM_EXEC]	= __S111
> 
> Please add whitespaces around the | operators.

Sure, will add.

> 
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
