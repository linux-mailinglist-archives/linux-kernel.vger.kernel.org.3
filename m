Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB108470211
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 14:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236457AbhLJNuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 08:50:52 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4245 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbhLJNuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 08:50:51 -0500
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J9XHC1s4bz67WcM;
        Fri, 10 Dec 2021 21:45:59 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Fri, 10 Dec 2021 14:47:14 +0100
Received: from [10.47.85.63] (10.47.85.63) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 10 Dec
 2021 13:47:13 +0000
Subject: Re: [PATCH v2 2/2] perf vendor events: Rename arm64 arch std event
 files
To:     Andrew Kilroy <andrew.kilroy@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <acme@kernel.org>
CC:     Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20211210123706.7490-1-andrew.kilroy@arm.com>
 <20211210123706.7490-3-andrew.kilroy@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <292d3ee6-c8f8-8155-9c90-e05026ea1f76@huawei.com>
Date:   Fri, 10 Dec 2021 13:46:48 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20211210123706.7490-3-andrew.kilroy@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.85.63]
X-ClientProxiedBy: lhreml716-chm.china.huawei.com (10.201.108.67) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2021 12:37, Andrew Kilroy wrote:
> A previous commit adds pmu events into the files
> 
>    armv8-common-and-microarch.json
>    armv8-recommended.json
> 
> that are actually specified in an armv9 reference supplement, not armv8.
> As such, naming the files with the armv8 prefix seems artificial.
> 
> This patch renames the files to reflect that these two files are for
> arch std events regardless of whether they are defined in armv8 or
> armv9.
> 
> Signed-off-by: Andrew Kilroy<andrew.kilroy@arm.com>

Reviewed-by: John Garry <john.garry@huawei.com>
