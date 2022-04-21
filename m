Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B6050A2A2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389415AbiDUOiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389500AbiDUOiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:38:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 43453AE40
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:35:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E18AC1515;
        Thu, 21 Apr 2022 07:35:14 -0700 (PDT)
Received: from [10.57.41.251] (unknown [10.57.41.251])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8161A3F73B;
        Thu, 21 Apr 2022 07:35:13 -0700 (PDT)
Message-ID: <665d2b46-c9e2-2543-cad5-9adf022e4bcb@arm.com>
Date:   Thu, 21 Apr 2022 15:35:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 0/3] More ARM DMA ops cleanup
Content-Language: en-GB
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        m.szyprowski@samsung.com, arnd@kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <cover.1650539846.git.robin.murphy@arm.com>
 <20220421141300.GC20492@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220421141300.GC20492@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-21 15:13, Christoph Hellwig wrote:
> On Thu, Apr 21, 2022 at 12:36:56PM +0100, Robin Murphy wrote:
>> Hi all,
>>
>> Thanks to Christoph's latest series, I'm reminded that, if we're going
>> to give the ARM DMA ops some cleanup this cycle, it's as good a time as
>> any to dust off these old patches and add them on top as well. I've
>> based these on the arm-dma-direct branch which I assume matches the
>> patches posted at [1].
> 
> All these do look sensible to me.  But weren't you working on replacing
> the ARM iommu dma_ops with dma-іommu anyway?

Yes, that's somewhat entangled with the IOMMU bus ops stuff, so I'll 
probably get to the point of having to revisit it in a couple of months 
or so. These patches are off the bottom of that stack from my first 
attempt, where the aim was to make the current ops the same shape first 
so that the switch is then easier to reason about (particularly in terms 
of sounding out any issues with the hooking up of dev->dma_coherent, 
although your series will now be taking most of the load off there).

Cheers,
Robin.
