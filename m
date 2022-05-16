Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47DCB527D3A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 07:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239998AbiEPFyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 01:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbiEPFyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 01:54:31 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D31317E14
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 22:54:29 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 678FB68B05; Mon, 16 May 2022 07:54:25 +0200 (CEST)
Date:   Mon, 16 May 2022 07:54:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ning Sun <ning.sun@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Steve Wahl <steve.wahl@hpe.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] iommu/vt-d: Make intel-iommu.h private
Message-ID: <20220516055425.GB12339@lst.de>
References: <20220514014322.2927339-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220514014322.2927339-1-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 14, 2022 at 09:43:15AM +0800, Lu Baolu wrote:
> Hi folks,
> 
> The include/linux/intel-iommu.h should be private to the Intel IOMMU
> driver. Other drivers or components should interact with the IOMMU
> drivers through the kAPIs provided by the iommu core.
> 
> This series cleanups all includes of intel-iommu.h outside of the Intel
> IOMMU driver and move this header from include/linux to
> drivers/iommu/intel/.
> 
> No functional changes intended. Please help to review and suggest.

Thanks, this was long overdue!

The series looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
