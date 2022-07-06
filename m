Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F5E5689E9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 15:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbiGFNox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 09:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiGFNow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:44:52 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DA8DEF2;
        Wed,  6 Jul 2022 06:44:51 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 81CAF68AA6; Wed,  6 Jul 2022 15:44:47 +0200 (CEST)
Date:   Wed, 6 Jul 2022 15:44:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     John Garry <john.garry@huawei.com>
Cc:     damien.lemoal@opensource.wdc.com, joro@8bytes.org, will@kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, iommu@lists.linux-foundation.org,
        iommu@lists.linux.dev, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v5 0/5] DMA mapping changes for SCSI core
Message-ID: <20220706134447.GA23753@lst.de>
References: <1656590892-42307-1-git-send-email-john.garry@huawei.com> <b5f80062-e8ef-9597-1b0c-393140950dfb@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5f80062-e8ef-9597-1b0c-393140950dfb@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 02:40:44PM +0100, John Garry wrote:
> On 30/06/2022 13:08, John Garry wrote:
>
> Hi Christoph,
>
> Can you please consider picking up this series? A few things to note 
> beforehand:
>
> - I changed to only apply the mapping limit to SAS hosts in this version. I 
> would need a fresh ack from Martin for those SCSI parts, but wanted to make 
> sure you were ok with it.

Yes, I've mostly been waiting for an ACK from Martin.

> - Damien had some doubt on updating the shost max_sectors as opposed to the 
> per-request queue default, but I think he's ok with it - see patch 4/5

I'm fine either way.
