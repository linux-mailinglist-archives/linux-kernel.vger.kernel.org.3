Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFE14AB5B6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 08:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244175AbiBGHSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 02:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242084AbiBGHRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 02:17:11 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304CAC043184
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 23:17:11 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A696E68AFE; Mon,  7 Feb 2022 08:08:49 +0100 (CET)
Date:   Mon, 7 Feb 2022 08:08:49 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 01/10] iommu/vt-d: Move DMAR specific helpers into
 dmar.c
Message-ID: <20220207070849.GA23941@lst.de>
References: <20220207064142.1092846-1-baolu.lu@linux.intel.com> <20220207064142.1092846-2-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207064142.1092846-2-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> --- a/include/linux/dmar.h
> +++ b/include/linux/dmar.h
> @@ -52,6 +52,32 @@ struct dmar_drhd_unit {
>  	struct intel_iommu *iommu;
>  };
>  
> +struct dmar_rmrr_unit {

> +struct dmar_atsr_unit {

> +struct dmar_satc_unit {

What about moving all code that is using the structures to dmar.c 
to keep the definitions local?

