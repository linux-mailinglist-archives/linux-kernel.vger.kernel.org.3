Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74E19476B52
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 09:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234646AbhLPIBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 03:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234645AbhLPIBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 03:01:42 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3308C06173E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 00:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=YzlBkgx7rcNh5GJlFq5a2HHx7S
        MMgW3TApZtpf4wRa955dhHnRSSlXuH3TskfAMAPySyw/esJy9QGoPtXIkhpjntKOyKK6gG0jqaqe6
        Yp7W8WGvuWlz+FSeeSzivUlGFd8ghF5qU8Oc25ZuCfghvpy/g7JO9KlZl9lHOzelp7KVQH9mmE0NP
        XX0Q/DsgxcMXPxaG4dC4HirkT4acbMal6qhxcLu3+tOtjKw05Sd05gf8mnMSG+cdzMojiAXqXFbc6
        HY0f+3ecClOu+nvrD2h2b1eByIy2aNJYUHqyB93Kby8oUT8ehaTCTRCFK90zjLzPkQZgw0J8bOCqx
        bhvwgq6w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxlhp-0042FS-AT; Thu, 16 Dec 2021 08:01:37 +0000
Date:   Thu, 16 Dec 2021 00:01:37 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, Mikko Perttunen <mperttunen@nvidia.com>,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 03/11] drm/tegra: vic: Fix DMA API misuse
Message-ID: <YbryYWbijSjphCbC@infradead.org>
References: <cover.1639157090.git.robin.murphy@arm.com>
 <6b86f6e530b504a5eee864af10e2ae1570d7b645.1639157090.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b86f6e530b504a5eee864af10e2ae1570d7b645.1639157090.git.robin.murphy@arm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
