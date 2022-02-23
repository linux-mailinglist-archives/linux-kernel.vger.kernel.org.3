Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2214C0CA1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 07:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238424AbiBWGhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 01:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbiBWGhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 01:37:07 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF73F62E6;
        Tue, 22 Feb 2022 22:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/iX0wAICLVMEM1N1QRmtagYvAxCkv3rP8cMN2xrU/F0=; b=1LSr7rAmQ8gLIePxkwSjmV52zI
        XxP3kWpPZm1/Ue2ppNdJud+IF3UugAVr8sazajGI9MK1YPeWEFbPVj+tHDjbGjiWeI1DEn43JFOm5
        kzpXI8vFDze19m1HGhImheK14zjFW2ESUV6xf9yVntJ5gB65BjhRNrQ66MCfkjyIqcFZtySp67xYG
        8Oeo0T5B28wYJObsGTz2dkUGXWpYRjo5CVp6A75OQNMMmtUJMefGhUdJBRknxp23/LwLchfBhZ1na
        RAxXD+FYJNRPAfXGpipRMirKlxOqANGEniZWMh/trLFa+bkaL5qxp9qf8aHyzfkymn8Ilg0Tj8Okc
        DEixtwzA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMlGJ-00CzV0-8q; Wed, 23 Feb 2022 06:36:31 +0000
Date:   Tue, 22 Feb 2022 22:36:31 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, joro@8bytes.org,
        will@kernel.org, robh+dt@kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/9] gpu: host1x: Add context bus
Message-ID: <YhXV7x+MzE6yQ4J8@infradead.org>
References: <20220218113952.3077606-1-mperttunen@nvidia.com>
 <20220218113952.3077606-3-mperttunen@nvidia.com>
 <YhUNiHiYdQfxJybk@infradead.org>
 <c0dee650-df1c-4fad-aa97-fb9eab03f3a2@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0dee650-df1c-4fad-aa97-fb9eab03f3a2@arm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 09:30:30PM +0000, Robin Murphy wrote:
> > But the pattern that this copies in arm_smmu_bus_init is really
> > ugly.  I think we need to figure out a way todo that without having
> > to export all the low-level bus types.
> 
> Yup, as it happens that was the first step on my mission :)
> 
> https://gitlab.arm.com/linux-arm/linux-rm/-/commits/iommu/bus
> 
> Still a way to go with the main meat of that work, though, so I was figuring
> this could probably land as-is and I'll sweep it up in due course.

Yes, that part looks very nice.  It would be great to get that merged
ASAP.
