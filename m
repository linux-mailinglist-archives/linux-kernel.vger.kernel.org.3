Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00CD9484419
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 16:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbiADPDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 10:03:12 -0500
Received: from verein.lst.de ([213.95.11.211]:50295 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234597AbiADPDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:03:11 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id B659568AFE; Tue,  4 Jan 2022 16:03:07 +0100 (CET)
Date:   Tue, 4 Jan 2022 16:03:07 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Tianyu Lan <ltykernel@gmail.com>, m.szyprowski@samsung.com,
        robin.murphy@arm.com, michael.h.kelley@microsoft.com,
        kys@microsoft.com, Tianyu Lan <Tianyu.Lan@microsoft.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, brijesh.singh@amd.com, konrad.wilk@oracle.com,
        hch@lst.de, parri.andrea@gmail.com, thomas.lendacky@amd.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] Swiotlb: Add CONFIG_HAS_IOMEM check around memremap()
 in the swiotlb_mem_remap()
Message-ID: <20220104150307.GA23792@lst.de>
References: <20211231165640.1245751-1-ltykernel@gmail.com> <YdKrxgnpT0Dc0t2T@infradead.org> <20220104145155.hm7j5byhddn4zhb2@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104145155.hm7j5byhddn4zhb2@liuwe-devbox-debian-v2>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 02:51:55PM +0000, Wei Liu wrote:
> > Please stub out all of swiotlb_mem_remap instead of the ifdef inside the
> > function.
> 
> Does this look okay to you?

Yes, thanks!
