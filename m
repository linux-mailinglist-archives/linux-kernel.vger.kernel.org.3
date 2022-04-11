Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8794FB5EA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 10:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343737AbiDKIYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 04:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343734AbiDKIYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 04:24:45 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A0F3E5D4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 01:22:30 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KcMGs2wHtzFphR;
        Mon, 11 Apr 2022 16:20:05 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 11 Apr 2022 16:22:28 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2375.24; Mon, 11 Apr 2022 16:22:28 +0800
Message-ID: <2cf40b17-6315-bd5d-ba05-33f025c292d2@huawei.com>
Date:   Mon, 11 Apr 2022 16:22:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 resend 3/3] arm64: mm: Cleanup useless parameters in
 zone_sizes_init()
Content-Language: en-US
To:     Vijay Balakrishna <vijayb@linux.microsoft.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <f.fainelli@gmail.com>
References: <20220331074055.125824-1-wangkefeng.wang@huawei.com>
 <20220331074055.125824-4-wangkefeng.wang@huawei.com>
 <28b9ca3e-83d8-ea4b-1f27-d23c2d29424f@linux.microsoft.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <28b9ca3e-83d8-ea4b-1f27-d23c2d29424f@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggeme701-chm.china.huawei.com (10.1.199.97) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/4/2 1:05, Vijay Balakrishna wrote:
>
>
> On 3/31/2022 12:40 AM, Kefeng Wang wrote:
>> Directly use max_pfn for max and no one use min, kill them.
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>
> Looks good.  Reference to dma32_phys_limit in zone_sizes_init() 
> depends on what you do with my comment [1].
>
> [1] 
> https://lore.kernel.org/all/69c1e722-33ea-95cf-de84-aed3022cb042@linux.microsoft.com/
Ok， will drop dma32_phys_limit and directly use max_zone_phys(32).
>
> Reviewed-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
>
Thanks.
