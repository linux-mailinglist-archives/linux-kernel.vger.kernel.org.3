Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C7D476B57
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 09:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234655AbhLPICt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 03:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbhLPICs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 03:02:48 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F29C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 00:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zeVgdZekYVoCGoOE4CcwJQVXY4jKJylsxXTQbazh+cE=; b=an6HXGxmAx1lVJmu2Y3Kix0OAZ
        HNpsqt7EP9RrYvtl97awiKnppOtpZjZNNuZ0N60kHHqe9PxYfe05lpd/JCekTOmpvzp23mHtnYxzx
        pLD48v92RM40acXVUJgzWKXxzb7WoCCkWt/JsZSQozXyrtvxo8rBRPL8VffUtbJepW6RTxhIcXPPZ
        nX9g4s+q93ka0UqgxtMgqGtz3wj+3s2jV5NrLkkmv+Cxc18M5J0jJqlhcKEklUUgE+Ux35VNoxFL4
        oyQrQwavtZ76NGW+9/DYjS1Fvjaa37pYDB3DIC+I6F2HK32CJ+GF3aXV+GByJTTufHGonBSRKaEh1
        ok4CSTyw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxlit-0042S8-0Y; Thu, 16 Dec 2021 08:02:43 +0000
Date:   Thu, 16 Dec 2021 00:02:42 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH v2 05/11] iommu/iova: Squash flush_cb abstraction
Message-ID: <Ybryoh61+htoulPN@infradead.org>
References: <cover.1639157090.git.robin.murphy@arm.com>
 <6326303c396e28fd3b9ed89d82673dfcf159b8c6.1639157090.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6326303c396e28fd3b9ed89d82673dfcf159b8c6.1639157090.git.robin.murphy@arm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -147,7 +142,7 @@ struct iova *reserve_iova(struct iova_domain *iovad, unsigned long pfn_lo,
>  	unsigned long pfn_hi);
>  void init_iova_domain(struct iova_domain *iovad, unsigned long granule,
>  	unsigned long start_pfn);
> -int init_iova_flush_queue(struct iova_domain *iovad, iova_flush_cb flush_cb);
> +int init_iova_flush_queue(struct iova_domain *iovad, struct iommu_domain *fq_domain);

Overly long line here.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
