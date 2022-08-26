Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97F75A2303
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 10:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343620AbiHZI3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 04:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245244AbiHZI3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 04:29:21 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC1FD4F66;
        Fri, 26 Aug 2022 01:29:20 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MDXwS5dCwzlVjT;
        Fri, 26 Aug 2022 16:26:00 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 26 Aug 2022 16:29:17 +0800
Received: from [10.67.110.237] (10.67.110.237) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 26 Aug 2022 16:29:16 +0800
Subject: Re: [PATCH v3 0/4] ARM: Convert to ARCH_STACKWALK
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     <linux@armlinux.org.uk>, <mark.rutland@arm.com>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <arnd@arndb.de>, <rostedt@goodmis.org>,
        <nick.hawkins@hpe.com>, <john@phrozen.org>, <mhiramat@kernel.org>,
        <ast@kernel.org>, <linyujun809@huawei.com>,
        <ndesaulniers@google.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <rmk+kernel@armlinux.org.uk>, <ardb@kernel.org>, <will@kernel.org>,
        <broonie@kernel.org>
References: <20220727040022.139387-1-lihuafei1@huawei.com>
 <13e8c9ba-c5ec-a231-5493-3255e1ef9db8@huawei.com>
 <CACRpkda=csAw1wZj_Uwpb1B32BBHAin8=rQVXQ0c6TwnTWJSXA@mail.gmail.com>
From:   Li Huafei <lihuafei1@huawei.com>
Message-ID: <54f2a18a-6c1c-4492-5e35-9908b876cf61@huawei.com>
Date:   Fri, 26 Aug 2022 16:29:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CACRpkda=csAw1wZj_Uwpb1B32BBHAin8=rQVXQ0c6TwnTWJSXA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.237]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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



On 2022/8/25 21:00, Linus Walleij wrote:
> On Thu, Aug 18, 2022 at 11:16 AM Li Huafei <lihuafei1@huawei.com> wrote:
> 
>> Hi Russell，
>>
>> Do you have any more comments on this patch set? Can you add this patch
>> set to your patch tracker? Thanks!
> 
> I would rebase the patch on v6.0-rc1 and resend then you can add it
> to Russell's patch tracker yourself, it's not very hard to use, there is
> good documentation for how to use it:
> https://www.arm.linux.org.uk/developer/patches/
> 

It's done. Thank you for the tip.

Thanks,
Huafei

> Yours,
> Linus Walleij
> .
> 
