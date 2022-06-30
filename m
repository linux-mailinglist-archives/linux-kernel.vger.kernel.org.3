Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08AC7560EA5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 03:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiF3B0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 21:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiF3B0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 21:26:22 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBC624F38
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 18:26:20 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LYLGy0766zkX1X;
        Thu, 30 Jun 2022 09:24:58 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 30 Jun 2022 09:26:18 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 30 Jun 2022 09:26:18 +0800
Message-ID: <8852788c-3a10-ff28-2ff5-f35f5a736d64@huawei.com>
Date:   Thu, 30 Jun 2022 09:26:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] arm64: defconfig: Enable memory hotplug and hotremove
 config
Content-Language: en-US
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220629093524.34801-1-wangkefeng.wang@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20220629093524.34801-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/6/29 17:35, Kefeng Wang wrote:
> Let's enable ACPI_HMAT, ACPI_HOTPLUG_MEMORY, MEMORY_HOTPLUG
> and MEMORY_HOTREMOVE for more test coverage, also there are
> useful for heterogeneous memory scene.
Hi Catalin and Will，is the defconfig patch picked up from you directly，
the changelog shows most of them merged by SoC maintainers, but this
one is some general feature, I don't know who will take it, thanks.
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
> v2: add ACPI_HMAT and update changelog too.
>   arch/arm64/configs/defconfig | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 7d1105343bc2..78add6eefa2b 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -101,6 +101,8 @@ CONFIG_ARM_TEGRA186_CPUFREQ=y
>   CONFIG_ARM_MEDIATEK_CPUFREQ=y
>   CONFIG_QORIQ_CPUFREQ=y
>   CONFIG_ACPI=y
> +CONFIG_ACPI_HOTPLUG_MEMORY=y
> +CONFIG_ACPI_HMAT=y
>   CONFIG_ACPI_APEI=y
>   CONFIG_ACPI_APEI_GHES=y
>   CONFIG_ACPI_APEI_PCIEAER=y
> @@ -125,6 +127,8 @@ CONFIG_SECCOMP=y
>   CONFIG_MODULES=y
>   CONFIG_MODULE_UNLOAD=y
>   # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
> +CONFIG_MEMORY_HOTPLUG=y
> +CONFIG_MEMORY_HOTREMOVE=y
>   CONFIG_KSM=y
>   CONFIG_MEMORY_FAILURE=y
>   CONFIG_TRANSPARENT_HUGEPAGE=y
