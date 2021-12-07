Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F7046B78F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 10:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbhLGJka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 04:40:30 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4221 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhLGJk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 04:40:29 -0500
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J7Zsz1Vjvz67snD;
        Tue,  7 Dec 2021 17:35:51 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 7 Dec 2021 10:36:57 +0100
Received: from [10.47.82.161] (10.47.82.161) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 7 Dec
 2021 09:36:56 +0000
Subject: Re: [PATCH 2/3] perf vendor events: Fix whitespace
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
References: <20211203123525.31127-1-andrew.kilroy@arm.com>
 <20211203123525.31127-2-andrew.kilroy@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <aabc45c7-cea4-2e8b-bddc-7ea1bd18910f@huawei.com>
Date:   Tue, 7 Dec 2021 09:36:40 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20211203123525.31127-2-andrew.kilroy@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.82.161]
X-ClientProxiedBy: lhreml721-chm.china.huawei.com (10.201.108.72) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/2021 12:35, Andrew Kilroy wrote:
> Correct indentation to 4 spaces, same as the other json files.
> 
> Signed-off-by: Andrew Kilroy<andrew.kilroy@arm.com>

Reviewed-by: John Garry <john.garry@huawei.com>

As an aside,  maybe we should improve the parser to find these inconsistencies in formatting.
