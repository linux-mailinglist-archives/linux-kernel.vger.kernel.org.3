Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07505B172D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiIHIeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbiIHIeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:34:09 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7829EE1AAF;
        Thu,  8 Sep 2022 01:34:04 -0700 (PDT)
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MNXNy6Ssvz686DL;
        Thu,  8 Sep 2022 16:29:54 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Sep 2022 10:34:01 +0200
Received: from [10.48.159.66] (10.48.159.66) by lhrpeml500003.china.huawei.com
 (7.191.162.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 8 Sep
 2022 09:34:00 +0100
Message-ID: <e77a66f2-f572-0960-3f6a-68ca9773a719@huawei.com>
Date:   Thu, 8 Sep 2022 09:34:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2] perf vendor events: Update events for Neoverse E1
To:     Nick Forrington <nick.forrington@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <acme@kernel.org>
CC:     Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>,
        "Mike Leach" <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20220907154932.60808-1-nick.forrington@arm.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220907154932.60808-1-nick.forrington@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.159.66]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2022 16:49, Nick Forrington wrote:
> These CPUs contain the same PMU events (as per the Arm Technical
> Reference manuals for Cortex A65 and Neoverse E1)
> 
> This de-duplicates event data, and avoids issues in previous E1 event
> data (not present in A65 data)
> * Missing implementation defined events
> * Inclusion of events that are not implemented:
>    - L1D_CACHE_ALLOCATE
>    - SAMPLE_POP
>    - SAMPLE_FEED
>    - SAMPLE_FILTRATE
>    - SAMPLE_COLLISION
> 
> Signed-off-by: Nick Forrington <nick.forrington@arm.com>

Reviewed-by: John Garry <john.garry@huawei.com>

