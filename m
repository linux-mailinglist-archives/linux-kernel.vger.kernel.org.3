Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEA9476B54
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 09:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234645AbhLPICR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 03:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbhLPICQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 03:02:16 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195EDC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 00:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=DiiXT443TeBnZauQS1D5ozS2KE
        XRgjCxvFvetF86B3zKnvG6Cr6tK2W6tGD7JKrwinyVBMEt+sF4aX0JWgslNhd0HL/T6GqY9LPQXhD
        vzn3HexzPnsYwfIH+pLA5yhE9xgz/KnC3dpw1wbn9tTQjRq8L+S7H9mmVr6A2bmguUkJGOgMcToOU
        cw6JOwmFlpeZZUvQWCspdcRe5yAroJpnQsPKBiLCnBfXZe5lke+NuK9CTcYQUKOFN11sSOvtFSmvf
        7aWw2kiar7Vy9AZdz4ghvA2AS2G0WDpqQJjwWFBKRB4pJmMFbHz51O8vnJh/9iIvLl1gM1Zx+XhzP
        SawrPIdA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxliN-0042Mr-L5; Thu, 16 Dec 2021 08:02:11 +0000
Date:   Thu, 16 Dec 2021 00:02:11 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH v2 04/11] iommu/iova: Squash entry_dtor abstraction
Message-ID: <Ybryg/EQ3EyvRRiD@infradead.org>
References: <cover.1639157090.git.robin.murphy@arm.com>
 <223ae26f3f40165008509182474483b10d421534.1639157090.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <223ae26f3f40165008509182474483b10d421534.1639157090.git.robin.murphy@arm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
