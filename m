Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07EC3573540
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 13:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235136AbiGMLV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 07:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbiGMLVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 07:21:55 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1763B102061;
        Wed, 13 Jul 2022 04:21:54 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LjZrj1ZQmzhZ99;
        Wed, 13 Jul 2022 19:19:17 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Jul 2022 19:21:52 +0800
Received: from [10.67.110.237] (10.67.110.237) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Jul 2022 19:21:51 +0800
Subject: Re: [PATCH 4/5] ARM: stacktrace: Make stack walk callback consistent
 with generic code
To:     Mark Brown <broonie@kernel.org>
CC:     <linux@armlinux.org.uk>, <rmk+kernel@armlinux.org.uk>,
        <ardb@kernel.org>, <will@kernel.org>, <mark.rutland@arm.com>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <arnd@arndb.de>, <linus.walleij@linaro.org>,
        <rostedt@goodmis.org>, <nick.hawkins@hpe.com>, <john@phrozen.org>,
        <mhiramat@kernel.org>, <ast@kernel.org>, <linyujun809@huawei.com>,
        <ndesaulniers@google.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
References: <20220712021527.109921-1-lihuafei1@huawei.com>
 <20220712021527.109921-5-lihuafei1@huawei.com>
 <Ys14cMm0n6EqS/cQ@sirena.org.uk>
From:   Li Huafei <lihuafei1@huawei.com>
Message-ID: <cbdd6276-4e5c-e983-6b1a-b43863cce9a9@huawei.com>
Date:   Wed, 13 Jul 2022 19:21:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <Ys14cMm0n6EqS/cQ@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.67.110.237]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/7/12 21:34, Mark Brown wrote:
> On Tue, Jul 12, 2022 at 10:15:26AM +0800, Li Huafei wrote:
>
>> In order to use generic arch_stack_walk() code, make stack walk callback
>> consistent with it.
> It might be useful to say what the changes are here, if nothing else
> that makes it easier to review and confirm that the changes are doing
> what you intend them to.  See my conversion for arm64 for an example.


Thanks for the advice. I've looked at the commit:

   baa2cd417053 ("arm64: stacktrace: Make stack walk callback consistent 
with generic code")

The description is very clear. It describes the change in detail and
gives a reason for making that change a separate commit. The same
description applies to the current changes, so I took the commit message
directly, just made the s/arm64/ARM/ changes, and updated to v2:

https://lore.kernel.org/lkml/20220713110020.85511-1-lihuafei1@huawei.com/


> The actual changes here seem OK though
>
> Reviewed-by: Mark Brown <broonie@kernel.org>

Thanks for the review!


Thanks,

Huafei

