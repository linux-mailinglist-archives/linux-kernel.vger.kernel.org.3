Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7288448EBFC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 15:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242023AbiANOtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 09:49:05 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4412 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235613AbiANOtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 09:49:05 -0500
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jb3yS2vrCz67Cp2;
        Fri, 14 Jan 2022 22:46:08 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 14 Jan 2022 15:49:02 +0100
Received: from [10.47.83.126] (10.47.83.126) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 14 Jan
 2022 14:49:01 +0000
Subject: Re: [PATCH] perf util: Fix use after free in metric__new
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>
CC:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        <peterz@infradead.org>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <ak@linux.intel.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211208171113.22089-1-jose.exposito89@gmail.com>
 <CAP-5=fUAR9uSAQGkukqafkoX+jz1fE8f-ziU5WeG59XT53jMWw@mail.gmail.com>
 <YeGNDskRtgpIFmzU@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <44b8de2c-b976-a396-2363-61a014d7e71f@huawei.com>
Date:   Fri, 14 Jan 2022 14:48:35 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <YeGNDskRtgpIFmzU@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.83.126]
X-ClientProxiedBy: lhreml722-chm.china.huawei.com (10.201.108.73) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/01/2022 14:47, Arnaldo Carvalho de Melo wrote:
>>> Addresses-Coverity-ID: 1494000
>>> Signed-off-by: José Expósito<jose.exposito89@gmail.com>
>> Acked-by: Ian Rogers <irogers@google,com>
>>
>> This can only happen in the ENOMEM case, but it is a good fix.
>>
>> Fixes: b85a4d61d302 (perf metric: Allow modifiers on metrics)
> Sorry, I missed this one_as well_, sigh...
> 
> - Arnaldo
>   


Isn't there a v3 out there? Not sure if you noticed...

Cheers
