Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D41487735
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 12:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238276AbiAGL6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 06:58:34 -0500
Received: from foss.arm.com ([217.140.110.172]:40074 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229624AbiAGL6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 06:58:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18C0413D5;
        Fri,  7 Jan 2022 03:58:32 -0800 (PST)
Received: from [10.57.85.117] (unknown [10.57.85.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 697E33F774;
        Fri,  7 Jan 2022 03:58:30 -0800 (PST)
Message-ID: <fb1fb13b-a685-ccda-f381-6e6919fdb707@arm.com>
Date:   Fri, 7 Jan 2022 11:58:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH V2 4/7] arm64: errata: Add detection for TRBE trace data
 corruption
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        coresight@lists.linaro.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1641517808-5735-1-git-send-email-anshuman.khandual@arm.com>
 <1641517808-5735-5-git-send-email-anshuman.khandual@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1641517808-5735-5-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/2022 01:10, Anshuman Khandual wrote:
> TRBE implementations affected by Arm erratum #1902691 might corrupt trace
> data or deadlock, when it's being written into the memory. So effectively
> TRBE is broken and hence cannot be used to capture trace data. This adds
> a new errata ARM64_ERRATUM_1902691 in arm64 errata framework.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Suzuki Poulose <suzuki.poulose@arm.com>
> Cc: coresight@lists.linaro.org
> Cc: linux-doc@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>   Documentation/arm64/silicon-errata.rst |  2 ++
>   arch/arm64/Kconfig                     | 18 ++++++++++++++++++
>   arch/arm64/kernel/cpu_errata.c         |  9 +++++++++
>   arch/arm64/tools/cpucaps               |  1 +
>   4 files changed, 30 insertions(+)

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
