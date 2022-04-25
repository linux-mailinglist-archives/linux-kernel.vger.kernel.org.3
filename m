Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925A750D8E9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 07:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241332AbiDYFoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 01:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241318AbiDYFoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 01:44:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC9AF12ABA
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 22:41:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B52A1FB;
        Sun, 24 Apr 2022 22:41:05 -0700 (PDT)
Received: from [10.163.40.250] (unknown [10.163.40.250])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABF7A3F774;
        Sun, 24 Apr 2022 22:40:55 -0700 (PDT)
Message-ID: <1ad261fc-4eb0-21f4-2f6b-11696cd5c1c3@arm.com>
Date:   Mon, 25 Apr 2022 11:11:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH -next v5 4/5] arm64: mm: add support for page table check
Content-Language: en-US
To:     Tong Tiangen <tongtiangen@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Guohanjun <guohanjun@huawei.com>
References: <20220421082042.1167967-1-tongtiangen@huawei.com>
 <20220421082042.1167967-5-tongtiangen@huawei.com>
 <89ec03a9-5fee-7f4f-d189-67eb2aad24a3@arm.com>
 <c64e2159-d560-b560-f37e-4594692d88e1@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <c64e2159-d560-b560-f37e-4594692d88e1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/24/22 09:44, Tong Tiangen wrote:
> 
> 
> 在 2022/4/22 14:45, Anshuman Khandual 写道:
>> Please change the subject line as
>>
>> arm64/mm: Enable ARCH_SUPPORTS_PAGE_TABLE_CHECK
>>
>> OR
>>
>> arm64/mm: Subscribe ARCH_SUPPORTS_PAGE_TABLE_CHECK
>>
>> On 4/21/22 13:50, Tong Tiangen wrote:
>>> From: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>
>>> As commit d283d422c6c4 ("x86: mm: add x86_64 support for page table
>>> check"), add some necessary page table check hooks into routines that
>>> modify user page tables.
>>
>> Please make the commit message comprehensive, which should include
>>
>> - Enabling ARCH_SUPPORTS_PAGE_TABLE_CHECK on arm64
>> - Adding all additional page table helpers required for PAGE_TABLE_CHECK
>> - Instrumenting existing page table helpers with page table check hooks
>>
> 
> Good suggestion, if i need to do a new version for some other reason i think it should be described more comprehensivel


This series needs revision to accommodate earlier comments.
