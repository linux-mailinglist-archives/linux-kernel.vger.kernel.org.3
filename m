Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0BA247B6F1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 02:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbhLUBlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 20:41:35 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:16841 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbhLUBle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 20:41:34 -0500
Received: from dggeme762-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JHzgH5X0Vz91rV;
        Tue, 21 Dec 2021 09:40:43 +0800 (CST)
Received: from [10.67.110.176] (10.67.110.176) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Tue, 21 Dec 2021 09:41:32 +0800
Subject: Re: [PATCH -next 0/3] replace open coded VA->PA calculation
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        SoC Team <soc@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <gongruiqi1@huawei.com>, <wangweiyang2@huawei.com>
References: <20211218085843.212497-1-cuigaosheng1@huawei.com>
 <CAK8P3a1-0u4VCCfgc7tjmnANM0yr7oUrQX2y-ZSVvZHDN191BQ@mail.gmail.com>
From:   cuigaosheng <cuigaosheng1@huawei.com>
Message-ID: <dfc25b22-2f66-4404-66c4-44c9c8c3bab4@huawei.com>
Date:   Tue, 21 Dec 2021 09:41:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1-0u4VCCfgc7tjmnANM0yr7oUrQX2y-ZSVvZHDN191BQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.176]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I could apply them directly with the maintainer Acks, but I don't understand
> the significance of you sending them now. Is something broken without the
> three patches? Are these the only ones missing from Ard's original series,
> or is this preparation? Would you expect the patches to get backported to
> stable kernels?

Thanks for your reply.

This is preparation work for arm32 kaslr,and I want to continue to improve
the solution based on the work of Ard. These patches are relatively
independent, so I submit these patches first.

Gaosheng.

在 2021/12/20 23:39, Arnd Bergmann 写道:
> On Sat, Dec 18, 2021 at 9:58 AM Gaosheng Cui <cuigaosheng1@huawei.com> wrote:
>> These patches replace an open coded calculation to obtain the physical
>> address of a far symbol with a call to the new ldr_l etc macro, and they
>> belong to the kaslr patch set of arm32.
>>
>> Reference: https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=arm-kaslr-latest
>>
>> Ard Biesheuvel (3):
>>    arm-soc: exynos: replace open coded VA->PA conversions
>>    arm-soc: mvebu: replace open coded VA->PA conversion
>>    arm-soc: various: replace open coded VA->PA calculation
> Usually these patches should go through the respective platform
> maintainer trees,
> and from there into the soc tree, but time is a little short here.
>
> I could apply them directly with the maintainer Acks, but I don't understand
> the significance of you sending them now. Is something broken without the
> three patches? Are these the only ones missing from Ard's original series,
> or is this preparation? Would you expect the patches to get backported to
> stable kernels?
>
>         Arnd
> .
