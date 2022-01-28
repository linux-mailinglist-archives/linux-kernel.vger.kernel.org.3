Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D015A49FE75
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350319AbiA1QyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:54:13 -0500
Received: from foss.arm.com ([217.140.110.172]:53998 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245711AbiA1QyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:54:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 610E0113E;
        Fri, 28 Jan 2022 08:54:11 -0800 (PST)
Received: from [10.57.68.47] (unknown [10.57.68.47])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 934F93F793;
        Fri, 28 Jan 2022 08:54:09 -0800 (PST)
Message-ID: <c05c2217-3fc3-63a0-b332-004603315f84@arm.com>
Date:   Fri, 28 Jan 2022 16:54:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] iommu/iova: Separate out rcache init
Content-Language: en-GB
To:     John Garry <john.garry@huawei.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>
Cc:     "xieyongji@bytedance.com" <xieyongji@bytedance.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linuxarm <linuxarm@huawei.com>
References: <1643205319-51669-1-git-send-email-john.garry@huawei.com>
 <ee4593b8-cdf6-935a-0eaf-48a8bfeae912@arm.com>
 <5ac3a678-3126-edd9-cb23-72c05f3dcd34@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <5ac3a678-3126-edd9-cb23-72c05f3dcd34@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-28 11:32, John Garry wrote:
> On 26/01/2022 17:00, Robin Murphy wrote:
>> As above, I vote for just forward-declaring the free routine in iova.c
>> and keeping it entirely private.
> 
> BTW, speaking of forward declarations, it's possible to remove all the 
> forward declarations in iova.c now that the FQ code is gone - but with a 
> good bit of rearranging. However I am not sure how much people care 
> about that or whether the code layout is sane...

Indeed, I was very tempted to raise the question there of whether there 
was any more cleanup or refactoring that could be done to justify 
collecting all the rcache code together at the top of iova.c. But in the 
end I didn't, so my opinion still remains a secret...

Robin.
