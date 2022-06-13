Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C2C54841B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 12:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbiFMKF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 06:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiFMKF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 06:05:56 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AEEDBD;
        Mon, 13 Jun 2022 03:05:56 -0700 (PDT)
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LM6c82yFFz68B2P;
        Mon, 13 Jun 2022 18:04:24 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 12:05:54 +0200
Received: from [10.195.33.253] (10.195.33.253) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 11:05:53 +0100
Message-ID: <2955958b-4982-42bc-7c68-82cd23462b35@huawei.com>
Date:   Mon, 13 Jun 2022 11:09:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] perf vendor events arm64: Arm Cortex-A78C and X1C
To:     Nick Forrington <nick.forrington@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <acme@kernel.org>
CC:     Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>,
        "Mike Leach" <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20220610174459.615995-1-nick.forrington@arm.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220610174459.615995-1-nick.forrington@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.33.253]
X-ClientProxiedBy: lhreml746-chm.china.huawei.com (10.201.108.196) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/2022 18:44, Nick Forrington wrote:
> Add PMU events for the Arm Cortex-A78C and Arm Cortex-X1C CPUs.
> 
> Events for Arm Cortex-A78C match those for Arm Cortex-A78.
> Events for Arm Cortex-X1C match those for Arm Cortex- X1.
> 
> As such, this is just a mapfile change.
> 
> Main ID Register (MIDR) and event data is sourced from the corresponding
> Arm Technical Reference Manuals:
> 
> Arm Cortex-A78C
> https://developer.arm.com/documentation/102226/
> 
> Arm Cortex-X1C
> https://developer.arm.com/documentation/101968/
> 
> Signed-off-by: Nick Forrington<nick.forrington@arm.com>

Reviewed-by: John Garry <john.garry@huawei.com>
