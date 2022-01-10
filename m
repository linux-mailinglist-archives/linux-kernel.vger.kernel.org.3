Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C0E4897C5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 12:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244902AbiAJLoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 06:44:32 -0500
Received: from foss.arm.com ([217.140.110.172]:33258 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244960AbiAJLnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 06:43:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DAD6106F;
        Mon, 10 Jan 2022 03:43:07 -0800 (PST)
Received: from [10.163.72.167] (unknown [10.163.72.167])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 60A313F5A1;
        Mon, 10 Jan 2022 03:43:04 -0800 (PST)
Subject: Re: [PATCH] mm: Generalize ARCH_HAS_FILTER_PGPROT
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-mm@kvack.org, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <1641796896-16960-1-git-send-email-anshuman.khandual@arm.com>
 <YdwP40C8Zu8s2Az0@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <de9ce5d0-04f0-74c5-a65c-814acedb5d46@arm.com>
Date:   Mon, 10 Jan 2022 17:13:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YdwP40C8Zu8s2Az0@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/10/22 4:22 PM, Catalin Marinas wrote:
> On Mon, Jan 10, 2022 at 12:11:36PM +0530, Anshuman Khandual wrote:
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 5c2ccb85f2ef..d9594e05fddb 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -328,9 +328,6 @@ config GENERIC_CALIBRATE_DELAY
>>  config ARCH_HAS_CPU_RELAX
>>  	def_bool y
>>  
>> -config ARCH_HAS_FILTER_PGPROT
>> -	def_bool y
> 
> Aren't you missing a select for x86?
> 

It already gets unconditionally selected in arch/x86/Kconfig.
