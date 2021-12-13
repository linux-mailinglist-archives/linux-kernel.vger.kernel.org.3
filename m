Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22DF1472CA5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 13:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235009AbhLMMzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 07:55:20 -0500
Received: from verein.lst.de ([213.95.11.211]:48243 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231465AbhLMMzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 07:55:19 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 779F668AA6; Mon, 13 Dec 2021 13:55:16 +0100 (CET)
Date:   Mon, 13 Dec 2021 13:55:16 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] dma-direct: Fix dma_direct_use_pool helper
Message-ID: <20211213125516.GA28057@lst.de>
References: <20211213123311.2399611-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213123311.2399611-1-alexander.stein@ew.tq-group.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Alexander,

but this was already fixed 4 days ago.
