Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76FF55A1187
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 15:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242199AbiHYNJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 09:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242187AbiHYNJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 09:09:22 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43829A1D09
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 06:09:21 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MD3Cs0gXdzGpWD;
        Thu, 25 Aug 2022 21:07:37 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 25 Aug 2022 21:09:18 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 25 Aug 2022 21:09:17 +0800
Message-ID: <16d83454-341c-8839-25b6-2094e7a35478@huawei.com>
Date:   Thu, 25 Aug 2022 21:09:17 +0800
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
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <Yr2Aj8nr6izMsmmX@arm.com>
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


On 2022/6/30 18:53, Catalin Marinas wrote:
> On Thu, Jun 30, 2022 at 09:26:17AM +0800, Kefeng Wang wrote:
>> On 2022/6/29 17:35, Kefeng Wang wrote:
>>> Let's enable ACPI_HMAT, ACPI_HOTPLUG_MEMORY, MEMORY_HOTPLUG
>>> and MEMORY_HOTREMOVE for more test coverage, also there are
>>> useful for heterogeneous memory scene.
>> Hi Catalin and Will，is the defconfig patch picked up from you directly，
>> the changelog shows most of them merged by SoC maintainers, but this
>> one is some general feature, I don't know who will take it, thanks.
> In general we leave the defconfig patches to the SoC team to avoid
> conflicts as they have a lot more changes. Cc'ing Arnd if he wants to
> pick it up, otherwise it can go through the arm64 tree.
>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> .

Hi  maintainers,  look this patch is missed, could anyone pick it up,

thanks.

