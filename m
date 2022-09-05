Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2530F5ACEC5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 11:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236214AbiIEJZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 05:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235585AbiIEJZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 05:25:38 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EF42716E;
        Mon,  5 Sep 2022 02:25:36 -0700 (PDT)
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MLjh014HPz6HHY4;
        Mon,  5 Sep 2022 17:21:36 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Sep 2022 11:25:34 +0200
Received: from [10.195.33.232] (10.195.33.232) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Sep 2022 10:25:33 +0100
Message-ID: <a4d09c42-7303-90cb-61a8-817411faddf2@huawei.com>
Date:   Mon, 5 Sep 2022 10:25:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] perf vendor events: Add missing Neoverse V1 events
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
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
References: <20220901151804.294823-1-nick.forrington@arm.com>
 <c17d8229-6029-3fd6-1ce5-f406962eae8f@huawei.com>
 <6813a737-736d-7e15-a44f-d800ed9248be@arm.com> <YxJYv0IfvmL1BTrX@kernel.org>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <YxJYv0IfvmL1BTrX@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.33.232]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/2022 20:25, Arnaldo Carvalho de Melo wrote:
>> Thanks John, I agree on consistency.
>>
>> I think memory is a better categorisation (for all CPUs), and this is
>> consistent with what I submitted for various Cortex CPUs a while back.
> Were those patches processed or is some still outstanding?
>   
>> I'd be happy to remove the REMOTE_ACCESS change here and update (or not)
>> REMOTE_ACCESS for Neoverse separately.
>>
>>>> Signed-off-by: Nick Forrington<nick.forrington@arm.com>
>>>> ---
>>> Apart from above:
>>> Reviewed-by: John Garry<john.garry@huawei.com>
>> Thanks, Nick
> So, how should we proceed?

To me it would be better to just update the categorization of the 
REMOTE_ACCESS event for all cortex cores separately and just add the 
missing Neoverse v1 events here.

Thanks,
John
