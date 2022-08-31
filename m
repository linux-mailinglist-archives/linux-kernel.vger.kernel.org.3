Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011075A753F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 06:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiHaEoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 00:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiHaEow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 00:44:52 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BD310A5;
        Tue, 30 Aug 2022 21:44:50 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MHWks58NRzHnXJ;
        Wed, 31 Aug 2022 12:43:01 +0800 (CST)
Received: from [10.174.178.165] (10.174.178.165) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 31 Aug 2022 12:44:48 +0800
Subject: Re: [PATCH -next 3/4] spi: mockup: Add runtime device tree overlay
 interface
To:     Frank Rowand <frowand.list@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
References: <20220826144341.532265-1-weiyongjun1@huawei.com>
 <20220826144341.532265-4-weiyongjun1@huawei.com>
 <Yw3mE1UX1z/fGSBL@sirena.org.uk>
 <7111c94c-a85c-2f51-f94b-ed60080b1717@gmail.com>
From:   "weiyongjun (A)" <weiyongjun1@huawei.com>
Message-ID: <a4a24a54-c864-e5ed-7e17-84b7a55996af@huawei.com>
Date:   Wed, 31 Aug 2022 12:44:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <7111c94c-a85c-2f51-f94b-ed60080b1717@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
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



On 2022/8/31 3:24, Frank Rowand wrote:
> On 8/30/22 05:27, Mark Brown wrote:
>> On Fri, Aug 26, 2022 at 02:43:40PM +0000, Wei Yongjun wrote:
>>
>>> Add a runtime device tree overlay interface for device need dts file.
>>> With it its possible to use device tree overlays without having to use
>>> a per-platform overlay manager.
>>
>> Why would an entirely virtual device like this need to appear in
>> DT?  DT is supposed to be a hardware description and this clearly
>> isn't hardware, nor is it something we're providing to a VM.
> 
> Good point.  Patch 3 seems to not be needed.

Yes, will drop it in next version.

Thanks,
Wei Yongjun
