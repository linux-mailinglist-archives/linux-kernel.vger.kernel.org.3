Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC35159F39C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 08:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235026AbiHXGc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 02:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234026AbiHXGc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 02:32:26 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A036D7E83C
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 23:32:24 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MCGSL05SyzGpmK;
        Wed, 24 Aug 2022 14:30:42 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 24 Aug 2022 14:31:50 +0800
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 24 Aug 2022 14:31:49 +0800
Message-ID: <4063da85-b110-4afd-2023-59d4da41c27f@huawei.com>
Date:   Wed, 24 Aug 2022 14:31:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH -next v2 0/2]riscv: some refactorings realted to uaccess
 and extable
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>, <Conor.Dooley@microchip.com>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <wangkefeng.wang@huawei.com>, Guohanjun <guohanjun@huawei.com>
References: <20220815032025.2685516-1-tongtiangen@huawei.com>
From:   Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <20220815032025.2685516-1-tongtiangen@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.234]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi riscv maintainers, kindly ping...

Thanks,
Tong.

在 2022/8/15 11:20, Tong Tiangen 写道:
> This patchset do some refactorings related to riscv's uaccess and extable,
> mainly for the usage of __get/put_user_nocheck() which not distinguish user
> access and kernel access.
> 
> v1 -> v2:
>    According to Conor's suggestion, split into two logically independent
>    patches.
> 
> Tong Tiangen (2):
>    riscv: uaccess: rename __get/put_user_nocheck to __get/put_mem_nocheck
>    riscv: extable: add new extable type EX_TYPE_KACCESS_ERR_ZERO support
> 
>   arch/riscv/include/asm/asm-extable.h |  12 ++
>   arch/riscv/include/asm/uaccess.h     | 162 +++++++++++++--------------
>   arch/riscv/mm/extable.c              |   1 +
>   3 files changed, 94 insertions(+), 81 deletions(-)
> 
