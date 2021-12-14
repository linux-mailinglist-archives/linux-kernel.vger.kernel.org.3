Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3CFE474861
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 17:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236150AbhLNQjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 11:39:55 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4278 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbhLNQjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 11:39:48 -0500
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JD3rr2f4Rz67YrM;
        Wed, 15 Dec 2021 00:35:24 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 14 Dec 2021 17:39:46 +0100
Received: from [10.47.83.94] (10.47.83.94) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Tue, 14 Dec
 2021 16:39:45 +0000
Subject: Re: [PATCH v2 09/11] iommu/iova: Consolidate flush queue code
To:     Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>,
        <will@kernel.org>
CC:     <iommu@lists.linux-foundation.org>,
        <suravee.suthikulpanit@amd.com>, <baolu.lu@linux.intel.com>,
        <willy@infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <cover.1639157090.git.robin.murphy@arm.com>
 <ea0142c046f89c2f917554988b243b130bd23bd2.1639157090.git.robin.murphy@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <6a7605f8-af54-4547-d108-7fdeda678b6e@huawei.com>
Date:   Tue, 14 Dec 2021 16:39:22 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <ea0142c046f89c2f917554988b243b130bd23bd2.1639157090.git.robin.murphy@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.83.94]
X-ClientProxiedBy: lhreml701-chm.china.huawei.com (10.201.108.50) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2021 17:54, Robin Murphy wrote:
> Squash and simplify some of the freeing code, and move the init
> and free routines down into the rest of the flush queue code to

> obviate the forward declarations.
> 

It would be good to get rid of all of these eventually...

> Signed-off-by: Robin Murphy<robin.murphy@arm.com>
> ---

FWIW:

Reviewed-by: John Garry <john.garry@huawei.com>
