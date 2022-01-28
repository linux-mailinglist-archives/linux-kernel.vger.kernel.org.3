Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA4E49F85B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 12:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237343AbiA1LdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 06:33:00 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4544 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236647AbiA1Lc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 06:32:57 -0500
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JlZvw5n9Sz67w0f;
        Fri, 28 Jan 2022 19:28:28 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 28 Jan 2022 12:32:53 +0100
Received: from [10.47.26.192] (10.47.26.192) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 28 Jan
 2022 11:32:52 +0000
Subject: Re: [PATCH] iommu/iova: Separate out rcache init
To:     Robin Murphy <robin.murphy@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>
CC:     "xieyongji@bytedance.com" <xieyongji@bytedance.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linuxarm <linuxarm@huawei.com>
References: <1643205319-51669-1-git-send-email-john.garry@huawei.com>
 <ee4593b8-cdf6-935a-0eaf-48a8bfeae912@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <5ac3a678-3126-edd9-cb23-72c05f3dcd34@huawei.com>
Date:   Fri, 28 Jan 2022 11:32:16 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <ee4593b8-cdf6-935a-0eaf-48a8bfeae912@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.26.192]
X-ClientProxiedBy: lhreml713-chm.china.huawei.com (10.201.108.64) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/2022 17:00, Robin Murphy wrote:
> As above, I vote for just forward-declaring the free routine in iova.c
> and keeping it entirely private.

BTW, speaking of forward declarations, it's possible to remove all the 
forward declarations in iova.c now that the FQ code is gone - but with a 
good bit of rearranging. However I am not sure how much people care 
about that or whether the code layout is sane...
