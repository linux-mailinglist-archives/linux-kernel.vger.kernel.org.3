Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6172D5AEF19
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239605AbiIFPjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbiIFPiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:38:22 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D96C9F0CF;
        Tue,  6 Sep 2022 07:47:53 -0700 (PDT)
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MMSnJ5CDFz67Cvm;
        Tue,  6 Sep 2022 22:43:48 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 16:47:50 +0200
Received: from [10.126.175.248] (10.126.175.248) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 15:47:49 +0100
Message-ID: <0f73ba23-b892-035a-10f0-384e77b71040@huawei.com>
Date:   Tue, 6 Sep 2022 15:47:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] perf vendor events: Update events for Neoverse E1
To:     Robin Murphy <robin.murphy@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Nick Forrington <nick.forrington@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        "Will Deacon" <will@kernel.org>, James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20220905153020.1792-1-nick.forrington@arm.com>
 <YxdGFAYHeO/j5uJF@kernel.org>
 <496f98ce-a0c4-9587-853c-9ba05323523a@huawei.com>
 <caaf43aa-6c36-b263-30ba-7a4d3edd4e20@arm.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <caaf43aa-6c36-b263-30ba-7a4d3edd4e20@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.175.248]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2022 15:36, Robin Murphy wrote:
>>
>> This looks the same as an a65 event. And more similar cases below, at 
>> a glance.
> 
> According to Anandtech, E1 is to A65 what N1 is to A76, and if they say 
> so then it must be true :)

That would make life easier :)

And even if only the events are the same, then they are the same core 
from pmu-events PoV.

thanks,
John
