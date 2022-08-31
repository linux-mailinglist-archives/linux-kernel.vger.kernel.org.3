Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6E45A7535
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 06:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiHaEjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 00:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiHaEjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 00:39:43 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3AEAB051;
        Tue, 30 Aug 2022 21:39:42 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MHWc94m1kznTs6;
        Wed, 31 Aug 2022 12:37:13 +0800 (CST)
Received: from [10.174.178.165] (10.174.178.165) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 31 Aug 2022 12:39:37 +0800
Subject: Re: [PATCH -next 1/4] spi: mockup: Add SPI controller testing driver
To:     Mark Brown <broonie@kernel.org>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
References: <20220826144341.532265-1-weiyongjun1@huawei.com>
 <20220826144341.532265-2-weiyongjun1@huawei.com>
 <Yw5g8zalllhRxd9Z@sirena.org.uk>
From:   "weiyongjun (A)" <weiyongjun1@huawei.com>
Message-ID: <3ec5a47c-ec72-328c-cc69-bb84190f3c1e@huawei.com>
Date:   Wed, 31 Aug 2022 12:39:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <Yw5g8zalllhRxd9Z@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.165]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/8/31 3:11, Mark Brown wrote:
> On Fri, Aug 26, 2022 at 02:43:38PM +0000, Wei Yongjun wrote:
> 
>> @@ -0,0 +1,221 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * SPI controller Testing Driver
>> + *
>> + * Copyright(c) 2022 Huawei Technologies Co., Ltd.
>> + */
> 
> Please make the entire comment a C++ one so things look more
> intentional.
> 
>> +	master = spi_alloc_master(&pdev->dev, sizeof(struct mockup_spi));
>> +	if (!master) {
>> +		pr_err("failed to alloc spi master\n");
>> +		return -ENOMEM;
>> +	}
> 
> Please use the new _controller() API, we're trying to remove the
> use of outdated terminology.
> 


Will fix them in next version.

Thanks,
Wei Yongjun
