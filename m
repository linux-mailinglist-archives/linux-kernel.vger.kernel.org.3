Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0BA485E86
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 03:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344672AbiAFCT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 21:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbiAFCTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 21:19:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3806C061245;
        Wed,  5 Jan 2022 18:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Jb0syjHpG90vtrcvQMBr8NaCZtixi1quvmjWqPgmKwo=; b=idFiwniAicpO40YAG+sjgcnG7D
        3p75dlba9rRvggAS66G3KyurtPqYnkSjMyuRQpUhDxsDW0qWL0xoJQPlkBjdFZKHyIIKpDh7SIj1r
        NktCifCT42dl/xK8YSEGCiI4PynNT/7i7UidVWLRRsZVySPyIpPix/4B8HHe5rjMZ2b4OaYNzKJlW
        TrAmYw93/9u96/2RhurUnPpA0xXpjG5gtVQNxYhLCM7zCbGqDHJRkFtGtzl+MF0VcfOhjRW8Sal4A
        X8ISLkPXgVLB0av1zX85Igp9yZsJRaUPQ+2Q3dGKAiYfzRHRA02mU2Xy9qOWZdqjT/549m8NKj7/y
        pozQ37ew==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n5IN3-00F5FT-Ii; Thu, 06 Jan 2022 02:19:17 +0000
Message-ID: <20e286d4-25d7-fb6e-31a1-4349c805aae3@infradead.org>
Date:   Wed, 5 Jan 2022 18:19:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: linux-next: Tree for Jan 5 (cpufreq/amd-pstate)
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Huang Rui <ray.huang@amd.com>, linux-pm@vger.kernel.org
References: <20220105191239.26498b30@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220105191239.26498b30@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/5/22 00:12, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20220104:
> 
> The pm tree lost its build failure.
> 

on i386 and x86_64:
# CONFIG_ACPI is not set

In file included from ../drivers/cpufreq/amd-pstate.c:40:0:
../include/acpi/processor.h:226:2: error: unknown type name ‘phys_cpuid_t’
  phys_cpuid_t phys_id; /* CPU hardware ID such as APIC ID for x86 */
  ^~~~~~~~~~~~
../include/acpi/processor.h:355:1: error: unknown type name ‘phys_cpuid_t’; did you mean ‘phys_addr_t’?
 phys_cpuid_t acpi_get_phys_id(acpi_handle, int type, u32 acpi_id);
 ^~~~~~~~~~~~
 phys_addr_t
  CC      drivers/rtc/rtc-rv3029c2.o
../include/acpi/processor.h:356:1: error: unknown type name ‘phys_cpuid_t’; did you mean ‘phys_addr_t’?
 phys_cpuid_t acpi_map_madt_entry(u32 acpi_id);
 ^~~~~~~~~~~~
 phys_addr_t
../include/acpi/processor.h:357:20: error: unknown type name ‘phys_cpuid_t’; did you mean ‘phys_addr_t’?
 int acpi_map_cpuid(phys_cpuid_t phys_id, u32 acpi_id);
                    ^~~~~~~~~~~~
                    phys_addr_t


-- 
~Randy
