Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203505A9847
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234311AbiIANOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbiIANN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:13:57 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353645FF6A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 06:12:37 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MJLvG331kzYd3Q;
        Thu,  1 Sep 2022 21:08:10 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 1 Sep 2022 21:12:35 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 1 Sep 2022 21:12:34 +0800
Message-ID: <0f1cc967-6088-29b8-055e-8bb78e64bce1@huawei.com>
Date:   Thu, 1 Sep 2022 21:12:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] arm64: defconfig: Enable memory hotplug and hotremove
 config
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     <will@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>
References: <20220629093524.34801-1-wangkefeng.wang@huawei.com>
 <8852788c-3a10-ff28-2ff5-f35f5a736d64@huawei.com> <Yr2Aj8nr6izMsmmX@arm.com>
 <16d83454-341c-8839-25b6-2094e7a35478@huawei.com> <YxCLw5P8u1YnyIbV@arm.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <YxCLw5P8u1YnyIbV@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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


On 2022/9/1 18:38, Catalin Marinas wrote:
> On Thu, Aug 25, 2022 at 09:09:17PM +0800, Kefeng Wang wrote:
>> On 2022/6/30 18:53, Catalin Marinas wrote:
>>> On Thu, Jun 30, 2022 at 09:26:17AM +0800, Kefeng Wang wrote:
>>>> On 2022/6/29 17:35, Kefeng Wang wrote:
>>>>> Let's enable ACPI_HMAT, ACPI_HOTPLUG_MEMORY, MEMORY_HOTPLUG
>>>>> and MEMORY_HOTREMOVE for more test coverage, also there are
>>>>> useful for heterogeneous memory scene.
>>>> Hi Catalin and Will，is the defconfig patch picked up from you directly，
>>>> the changelog shows most of them merged by SoC maintainers, but this
>>>> one is some general feature, I don't know who will take it, thanks.
>>> In general we leave the defconfig patches to the SoC team to avoid
>>> conflicts as they have a lot more changes. Cc'ing Arnd if he wants to
>>> pick it up, otherwise it can go through the arm64 tree.
>>>
>>> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>> Hi  maintainers,  look this patch is missed, could anyone pick it up,
> I added it to my list of patches for 6.1. I'll queue it around rc6
> unless Arnd takes it before (and of course, if it won't conflict to the
> other SoC changes to defconfig).
Thanks for letting me know that. if conflict, I could rebase and repost.

