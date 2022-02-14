Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2104B51A0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 14:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349709AbiBNN17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 08:27:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiBNN16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 08:27:58 -0500
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F04A4E39C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 05:27:51 -0800 (PST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id D87802FB; Mon, 14 Feb 2022 14:27:49 +0100 (CET)
Date:   Mon, 14 Feb 2022 14:27:48 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Joerg Roedel <jroedel@suse.de>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Move intel_iommu_ops to header file
Message-ID: <YgpY1IIBkFIxxjbm@8bytes.org>
References: <20220207141240.8253-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207141240.8253-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 04:12:40PM +0200, Andy Shevchenko wrote:
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 69230fd695ea..1036c1900b5c 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -813,6 +813,8 @@ bool context_present(struct context_entry *context);
>  struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
>  					 u8 devfn, int alloc);
>  
> +extern const struct iommu_ops intel_iommu_ops;
> +

The intel_iommu_ops symbol is only used in drivers/iommu/intel, so I
would prefer a header in that directory. But I leave that up to Baolu to
decide.

Thanks,

	Joerg
