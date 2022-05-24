Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146FA532095
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 04:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbiEXCDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 22:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiEXCDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 22:03:13 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64707CDC3
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 19:03:11 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L6csJ459PzjX0c;
        Tue, 24 May 2022 10:02:28 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 24 May 2022 10:03:10 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 24 May 2022 10:03:09 +0800
Message-ID: <c89a11b3-99e6-edbe-ae23-36038b7e3a07@huawei.com>
Date:   Tue, 24 May 2022 10:03:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v3 1/6] ARM: mm: kill unused runtime hook arch_iounmap()
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>
CC:     <will@kernel.org>, <akpm@linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <hch@infradead.org>, <arnd@arndb.de>, <anshuman.khandual@arm.com>
References: <20220519082552.117736-1-wangkefeng.wang@huawei.com>
 <20220519082552.117736-2-wangkefeng.wang@huawei.com>
 <Yoezpw2AE5GT6CyP@arm.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <Yoezpw2AE5GT6CyP@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/5/20 23:28, Catalin Marinas wrote:
> Hi Russell,
>
> On Thu, May 19, 2022 at 04:25:47PM +0800, Kefeng Wang wrote:
>> Since the following commits,
>>
>> v5.4
>>    commit 59d3ae9a5bf6 ("ARM: remove Intel iop33x and iop13xx support")
>> v5.11
>>    commit 3e3f354bc383 ("ARM: remove ebsa110 platform")
>>
>> The runtime hook arch_iounmap() on ARM is useless, kill arch_iounmap()
>> and __iounmap(), and the naming of arch_iounmap will be used in
>> GENERIC_IOREMAP with the later patch.
>>
>> Cc: Russell King <linux@armlinux.org.uk>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Probably too late for this merging window but are you ok for this patch
> to go in via the arm64 tree (together with the rest of the series)?
>
> Alternatively it could go into your patch system and hopefully land in
> 5.19 so that we can take the rest for 5.20.
Russell, should I send it to patch system or let Catalin take it?
>
> Thanks.
>
