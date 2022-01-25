Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA19449B465
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 13:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573679AbiAYMy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 07:54:57 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4510 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390573AbiAYMwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 07:52:13 -0500
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JjmvS2y5yz686cr;
        Tue, 25 Jan 2022 20:51:48 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Tue, 25 Jan 2022 13:52:10 +0100
Received: from [10.47.95.36] (10.47.95.36) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 25 Jan
 2022 12:52:09 +0000
Subject: Re: [PATCHv3 0/4] perf tools: Add support for user defined metric
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Joe Mario <jmario@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "liuqi (BA)" <liuqi115@huawei.com>,
        Guangbin Huang <huangguangbin2@huawei.com>,
        Zhangshaokun <zhangshaokun@hisilicon.com>,
        "irogers@google.com" <irogers@google.com>
References: <20200511205307.3107775-1-jolsa@kernel.org>
 <2e2da73a-7085-b488-4764-705adbff70cc@huawei.com>
 <0DF6E63D-C359-4D81-8F87-A64D30D75BCA@gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <8c806fa8-d248-940c-d7f7-51a636e988e1@huawei.com>
Date:   Tue, 25 Jan 2022 12:51:37 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <0DF6E63D-C359-4D81-8F87-A64D30D75BCA@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.95.36]
X-ClientProxiedBy: lhreml744-chm.china.huawei.com (10.201.108.194) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/2022 12:41, Arnaldo Carvalho de Melo wrote:
>> On 11/05/2020 21:53, Jiri Olsa wrote:
>>
>> +
>>
>> Hi jirka,
>>
>> Did you a plan to continue to work? I don't think that this support was
>> ever merged.
>>
>> We have a requirement to be able to tune parameters of metrics, and
>> support here seems suitable.
> John,
> 
> 

Hi Arnaldo,

> Have you tried to apply that series to see if it still applies?

It doesn't apply on v5.17-rc1 (which is same as you acme perf/core branch).

Anyway, from checking this old thread, it seems that further changes 
were going to be added.

Thanks,
John
