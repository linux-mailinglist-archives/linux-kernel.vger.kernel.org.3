Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC69470A3F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 20:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343574AbhLJTYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 14:24:01 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4248 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242768AbhLJTYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 14:24:00 -0500
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J9ggb1zQSz67MYc;
        Sat, 11 Dec 2021 03:19:07 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Fri, 10 Dec 2021 20:20:22 +0100
Received: from [10.47.93.58] (10.47.93.58) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 10 Dec
 2021 19:20:22 +0000
Subject: Re: [PATCH v2 01/11] iommu/iova: Fix race between FQ timeout and
 teardown
To:     Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>,
        <will@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <willy@infradead.org>,
        <linux-mm@kvack.org>, <iommu@lists.linux-foundation.org>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>
References: <cover.1639157090.git.robin.murphy@arm.com>
 <ecea6835baca75b945bd8ecfaa636ff01dabcc1d.1639157090.git.robin.murphy@arm.com>
 <03cbd9c4-0f11-895b-8eb5-1b75bb74d37c@huawei.com>
 <80145652-b9ca-57b5-ad95-ca12d6a25eea@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <8c29534f-ac90-6998-afd7-37b94a3ad3c2@huawei.com>
Date:   Fri, 10 Dec 2021 19:19:56 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <80145652-b9ca-57b5-ad95-ca12d6a25eea@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.93.58]
X-ClientProxiedBy: lhreml723-chm.china.huawei.com (10.201.108.74) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2021 18:13, Robin Murphy wrote:
>>> possible for the timeout to expire just*before*  the del_timer() call
>>
>> super nit: "just*before*  the" - needs a whitespace before "before" :)
> 
> Weird... the original patch file here and the copy received by lore via 
> linux-iommu look fine, gremlins in your MUA or delivery path perhaps?

Right, apologies for that. I did receive it ok, but my replying seemed 
to mangle it. Not sure why..

Thanks,
John
