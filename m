Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0C9580FAD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 11:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237744AbiGZJPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 05:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbiGZJPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 05:15:42 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5C9237EB;
        Tue, 26 Jul 2022 02:15:40 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LsWRx4mlwzgYgW;
        Tue, 26 Jul 2022 17:13:49 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Jul 2022 17:15:04 +0800
Received: from [10.67.110.237] (10.67.110.237) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Jul 2022 17:15:03 +0800
Subject: Re: [PATCH 5/5] ARM: stacktrace: Convert stacktrace to generic
 ARCH_STACKWALK
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     <linux@armlinux.org.uk>, <rmk+kernel@armlinux.org.uk>,
        <ardb@kernel.org>, <will@kernel.org>, <mark.rutland@arm.com>,
        <broonie@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <arnd@arndb.de>,
        <rostedt@goodmis.org>, <nick.hawkins@hpe.com>, <john@phrozen.org>,
        <mhiramat@kernel.org>, <ast@kernel.org>, <linyujun809@huawei.com>,
        <ndesaulniers@google.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
References: <20220712021527.109921-1-lihuafei1@huawei.com>
 <20220712021527.109921-6-lihuafei1@huawei.com>
 <CACRpkdZVxyCsENJQ_-KZBMHjVrYCHzFG2UdCAe=mt_5Ts8_RFw@mail.gmail.com>
From:   Li Huafei <lihuafei1@huawei.com>
Message-ID: <1771ac18-8b6a-46ae-c610-afecb28bd21c@huawei.com>
Date:   Tue, 26 Jul 2022 17:15:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdZVxyCsENJQ_-KZBMHjVrYCHzFG2UdCAe=mt_5Ts8_RFw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.237]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/7/18 17:12, Linus Walleij wrote:
> On Tue, Jul 12, 2022 at 4:19 AM Li Huafei <lihuafei1@huawei.com> wrote:
> 
>> This patch converts ARM stacktrace to the generic ARCH_STACKWALK
>> implemented by commit 214d8ca6ee85 ("stacktrace: Provide common
>> infrastructure").
>>
>> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> 
> Looks good to me:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> What I want to know is if this commit will avoid the problem mentioned
> in review of commit 3? I.e. the generic stackwalk code will make sure we are
> not running the task on another CPU, so that is why we could remove
> that check?
> 

It was explained in commit 3, thank you very much.

Thanks,
Huafei

> Yours,
> Linus Walleij
> .
> 
