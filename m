Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B97058A7D2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 10:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240436AbiHEIL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 04:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235691AbiHEILY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 04:11:24 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535D92AE0;
        Fri,  5 Aug 2022 01:11:21 -0700 (PDT)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LzdXK2SPmz67Cr0;
        Fri,  5 Aug 2022 16:08:49 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Fri, 5 Aug 2022 10:11:19 +0200
Received: from [10.126.170.142] (10.126.170.142) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2375.24; Fri, 5 Aug 2022 09:11:18 +0100
Message-ID: <ea108115-f2dd-5767-1f86-34cdfdedc2a5@huawei.com>
Date:   Fri, 5 Aug 2022 09:11:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 00/17] Compress the pmu_event tables
From:   John Garry <john.garry@huawei.com>
To:     Ian Rogers <irogers@google.com>
CC:     Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>,
        "Mike Leach" <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        "Zhengjun Xing" <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
References: <20220729074351.138260-1-irogers@google.com>
 <d8356ddc-56e7-7324-5330-ff2bd54bcba4@huawei.com>
 <CAP-5=fV0CMpBGkNOBMRjbdZfdw1mQjrDhLVG38jLtpsdWXtQ_Q@mail.gmail.com>
 <3d0c1ec0-42ec-8c51-743b-5d93cabb53fb@huawei.com>
In-Reply-To: <3d0c1ec0-42ec-8c51-743b-5d93cabb53fb@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.170.142]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2022 10:08, John Garry wrote:
> 
> 
>> we can ignore the costs of the strings as
>> they should be fully shared, especially for BDW-DE.
> 
> Are you sure about this? I did not think that the compiler would have 
> the intelligence to try to share strings. That is the basis of the size 
> optimisation which I was proposing (that the compiler would not share 
> strings).

JFYI, I am finding that all identical strings are shared, which is good.

Thanks,
John
