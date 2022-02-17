Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B684B9C83
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 10:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238895AbiBQJxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 04:53:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238882AbiBQJxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 04:53:42 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0106BB1A8E;
        Thu, 17 Feb 2022 01:53:27 -0800 (PST)
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JzqrT6W4rz6F8c6;
        Thu, 17 Feb 2022 17:52:57 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Feb 2022 10:53:25 +0100
Received: from [10.47.81.42] (10.47.81.42) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 17 Feb
 2022 09:53:24 +0000
Message-ID: <be4afed9-9739-26cb-b1d5-0529e0f74221@huawei.com>
Date:   Thu, 17 Feb 2022 09:53:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: Test 73 Sig_trap fails on arm64 (was Re: [PATCH] perf test: Test
 73 Sig_trap fails on s390)
To:     Leo Yan <leo.yan@linaro.org>, Dmitry Vyukov <dvyukov@google.com>
CC:     Will Deacon <will@kernel.org>, Marco Elver <elver@google.com>,
        "Thomas Richter" <tmricht@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <acme@kernel.org>, <svens@linux.ibm.com>, <gor@linux.ibm.com>,
        <sumanthk@linux.ibm.com>, <hca@linux.ibm.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <CANpmjNNMWtjcKa961SjEvRbbPXyw5M5SkrXbb3tnyL3_XyniCw@mail.gmail.com>
 <90efb5a9-612a-919e-cf2f-c528692d61e2@huawei.com>
 <20220118091827.GA98966@leoy-ThinkPad-X240s>
 <CANpmjNMPoU+1b1fKFuYDYwisW2YfjQHxGt5hgLp1tioG7C2jmg@mail.gmail.com>
 <20220118124343.GC98966@leoy-ThinkPad-X240s>
 <bfa0af18-04ac-857d-d3d8-ad9290f912c8@huawei.com>
 <06412caf-42e4-5c4b-c9b3-9691075405bd@huawei.com>
 <20220215143459.GB7592@willie-the-truck>
 <8c582e45-0954-a2ea-764a-4dd78a464988@huawei.com>
 <CACT4Y+Z8pKXw=8nwVtdo2W=hu_rBk1ws-Q=7-tBkLGTcD85NaA@mail.gmail.com>
 <20220216131306.GA56419@leoy-ThinkPad-X240s>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220216131306.GA56419@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.81.42]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/02/2022 13:13, Leo Yan wrote:
>> It does and fwiw I am just trying to use it. Things work only on x86 so far.
> So here we have agreement to disable the cases for Arm64/Arm.
> 
> John, since you put much efforts to follow up the issue, I'd like to
> leave decision to you if you want to proceed for patches?  Otherwise,
> I will send patches to disable cases in perf.

Hi Leo,

I'll send later today.

Thanks,
John
