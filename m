Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB8A575DC1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 10:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiGOIqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 04:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiGOIqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 04:46:08 -0400
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD23C814A8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 01:46:07 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 6F10A535; Fri, 15 Jul 2022 10:46:06 +0200 (CEST)
Date:   Fri, 15 Jul 2022 10:46:05 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        robin.murphy@arm.com, vasant.hegde@amd.com, ashish.kalra@amd.com,
        jon.grimm@amd.com
Subject: Re: [PATCH v4 8/9] iommu/amd: Do not support IOMMU_DOMAIN_IDENTITY
 after SNP is enabled
Message-ID: <YtEpTTDGR+5zoEQ1@8bytes.org>
References: <20220713225651.20758-1-suravee.suthikulpanit@amd.com>
 <20220713225651.20758-9-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713225651.20758-9-suravee.suthikulpanit@amd.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 05:56:50PM -0500, Suravee Suthikulpanit wrote:
> +	/*
> +	 * Since DTE[Mode]=0 is prohibited on SNP-enabled system,
> +	 * default to use IOMMU_DOMAIN_DMA[_FQ].
> +	 */
> +	if (WARN_ONCE(amd_iommu_snp_en && (type == IOMMU_DOMAIN_IDENTITY),
> +		      "Cannot allocate identity domain due to SNP\n"))

I removed that WARN_ON_ONCE() here, this is really no condition someone
should worry about.

Regards,

	Joerg


