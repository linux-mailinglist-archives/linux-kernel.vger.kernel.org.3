Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C77504DF3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 10:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237122AbiDRIix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 04:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236403AbiDRIiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 04:38:50 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819A6E0EB
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 01:36:12 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KhgFK40KPzFq2h;
        Mon, 18 Apr 2022 16:33:41 +0800 (CST)
Received: from [10.174.179.110] (10.174.179.110) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 18 Apr 2022 16:36:10 +0800
Message-ID: <f029c7e9-492a-e4ec-922f-e86c2db144a5@huawei.com>
Date:   Mon, 18 Apr 2022 16:36:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] ARM: fix the incorrect value of sp in __die()
Content-Language: en-US
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
CC:     <ardb@kernel.org>, <arnd@arndb.de>, <linus.walleij@linaro.org>,
        <akpm@linux-foundation.org>, <ebiederm@xmission.com>,
        <wangkefeng.wang@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220418034516.521046-1-songyuanzheng@huawei.com>
 <Yl0bNhQwwnclGKKX@shell.armlinux.org.uk>
From:   songyuanzheng <songyuanzheng@huawei.com>
In-Reply-To: <Yl0bNhQwwnclGKKX@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.110]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your reply.

I didn't fully understand these code, please ignore this patch.

Thanks.

On 2022/4/18 16:03, Russell King (Oracle) wrote:
> Insufficient stack space to handle exception!
> Task stack:     [0xf09dc000..0xf09de000]
> IRQ stack:      [0xf0800000..0xf0802000]
> Overflow stack: [0xc210e000..0xc210f000]
> Internal error: kernel stack overflow: 0 [#1] SMP ARM
> Modules linked in:
> CPU: 0 PID: 81 Comm: sh Not tainted 5.18.0-rc3 #4
> Hardware name: ARM-Versatile Express
> PC is at mmioset+0x20/0xa8
> LR is at recursive_loop+0x34/0x9c
> pc : [<c0777080>]    lr : [<c0a90c6c>]    psr: 20000013
> sp : f09dbf48  ip : f09dbf4c  fp : 00219644
> ...
> Stack: (0xf09dbf48 to 0xf09de000)
