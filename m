Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D044C4F7895
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 10:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242549AbiDGIBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 04:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242554AbiDGIBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 04:01:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDF011CF68
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 00:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fBAouhGMrAo4DR21FYAu/hvO6g8bk7dvXwun6YXeuSE=; b=Smgn4MBYQqPfCENKlpEWrjQHKW
        gfvj1P3sx4Vmhf2Fzh+x3284suy6km700wOok3jPpwxks7KLHgPB0G98v/T9P2OGObvDNL7yhJSDg
        K9v7vfqJnGH5VwuprEkGR4tdW7aNbWqOJhrIcnez3erz7etFn31uBEgPl3J3QTcFmSssf68wkzmkE
        rHLUB17PgGec6f1gzgHv5FMuBkCh+rAT4raH/a97uGj7gWG1YZPPNi0euyxFWOSs2ldCoRebdnqZ2
        pvr+DLyThl5MHFgE7YW3DwZxb1NqO2dlWQwCnmtng1Tv1eLWc+qz6XK235F7NhVPvdfdAyH47AjTE
        YjbDYTiQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncN2d-00AB66-8g; Thu, 07 Apr 2022 07:58:55 +0000
Date:   Thu, 7 Apr 2022 00:58:55 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "Hegde, Vasant" <Vasant.Hegde@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] iommu/amd: Enable swiotlb in all cases
Message-ID: <Yk6Zv8ubRmQMPPcX@infradead.org>
References: <20220404204723.9767-1-mario.limonciello@amd.com>
 <20220404204723.9767-2-mario.limonciello@amd.com>
 <YkvGwMlrv8JKjHJQ@infradead.org>
 <BL1PR12MB5157E55F2F469E66B46157CDE2E79@BL1PR12MB5157.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR12MB5157E55F2F469E66B46157CDE2E79@BL1PR12MB5157.namprd12.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 05:04:52PM +0000, Limonciello, Mario wrote:
> Considering before this fix effectively swiotlb was turned off on most AMD
> systems, when this is picked up I think y'all should consider to add a:
> 
> Cc: stable@vger.kernel.org # 5.11+

Agreed.  I think this is for Joerg to pick up, and I'd love to see it
picked up soon as I'll have to rebase my

"cleanup swiotlb initialization" series on top of it.
