Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A127473F5F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 10:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbhLNJ1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 04:27:33 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:29130 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbhLNJ1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 04:27:32 -0500
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JCtHg4BHXz1DJjB;
        Tue, 14 Dec 2021 17:24:31 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 14 Dec 2021 17:27:29 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 14 Dec 2021 17:27:28 +0800
Subject: Re: [PATCH v17 01/10] x86: kdump: replace the hard-coded alignment
 with macro CRASH_ALIGN
To:     Borislav Petkov <bp@alien8.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        <kexec@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        <devicetree@vger.kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>
References: <20211210065533.2023-1-thunder.leizhen@huawei.com>
 <20211210065533.2023-2-thunder.leizhen@huawei.com> <Ybek4VRr8RaLM7kD@zn.tnic>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <e96d3f88-7f33-5c83-9fdc-5d4180287ea7@huawei.com>
Date:   Tue, 14 Dec 2021 17:27:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <Ybek4VRr8RaLM7kD@zn.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/12/14 3:54, Borislav Petkov wrote:
>> Subject: Re: [PATCH v17 01/10] x86: kdump: replace the hard-coded alignment with macro CRASH_ALIGN
> 
>>From Documentation/process/maintainer-tip.rst:
> 
> "Patch subject
>  ^^^^^^^^^^^^^
> 
> The tip tree preferred format for patch subject prefixes is
> 'subsys/component:', e.g. 'x86/apic:', 'x86/mm/fault:', 'sched/fair:',
> 'genirq/core:'. Please do not use file names or complete file paths as
> prefix. 'git log path/to/file' should give you a reasonable hint in most
> cases.
> 
> The condensed patch description in the subject line should start with a
> uppercase letter and should be written in imperative tone."
> 
> Please fix 1-5 for your next submission.

OK. I will update them.

> 
> Thx.
> 
