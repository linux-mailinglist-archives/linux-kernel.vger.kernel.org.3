Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC6448D09A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 04:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbiAMDDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 22:03:06 -0500
Received: from foss.arm.com ([217.140.110.172]:38288 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231833AbiAMDDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 22:03:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E435D6E;
        Wed, 12 Jan 2022 19:03:05 -0800 (PST)
Received: from [10.163.65.170] (unknown [10.163.65.170])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 75A0A3F766;
        Wed, 12 Jan 2022 19:03:02 -0800 (PST)
Subject: Re: [PATCH 1/2] arm64: Add Cortex-X2 CPU part definition
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1641980099-20315-1-git-send-email-anshuman.khandual@arm.com>
 <1641980099-20315-2-git-send-email-anshuman.khandual@arm.com>
 <CAK8P3a1cDF=jEVGchU8LNBdjdtROmHHHpebOASreR=WOuZ4Z1A@mail.gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <00e28671-8d3a-f789-91c4-109814792a07@arm.com>
Date:   Thu, 13 Jan 2022 08:33:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1cDF=jEVGchU8LNBdjdtROmHHHpebOASreR=WOuZ4Z1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/12/22 4:20 PM, Arnd Bergmann wrote:
> On Wed, Jan 12, 2022 at 10:34 AM Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
>>
>> Add the CPU Partnumbers for the new Arm designs.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Suzuki Poulose <suzuki.poulose@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  arch/arm64/include/asm/cputype.h | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
>> index 19b8441aa8f2..657eeb06c784 100644
>> --- a/arch/arm64/include/asm/cputype.h
>> +++ b/arch/arm64/include/asm/cputype.h
>> @@ -74,6 +74,7 @@
>>  #define ARM_CPU_PART_NEOVERSE_N1       0xD0C
>>  #define ARM_CPU_PART_CORTEX_A77                0xD0D
>>  #define ARM_CPU_PART_CORTEX_A710       0xD47
>> +#define ARM_CPU_PART_CORTEX_X2         0xD48
>>  #define ARM_CPU_PART_NEOVERSE_N2       0xD49
> 
> No objections to the patch, but would it be possible to just add all the missing
> ones here to the degree that they are known already? I don't see any entries for
> Cortex-A34, Cortex-A65AE, Cortex-A78, Cortex-A78C, Cortex-A78AE,
> Neoverse-E1, Neoverse-V1, Cortex-X1, Cortex-X2, Cortex-A510, Cortex-A710
> and Cortex-R82 among the Arm-designed cores that can run Linux, and there
> are probably others that I missed going through the list.

Hi Arnd,

IIUC the part numbers are enumerated here only if there is an errata
applicable for them which needs to be detected at boot. I am not sure
whether all cpu versions that can run Linux, needs to be defined here.
But then I might be missing something.

- Anshuman

> 
>         Arnd
> 
