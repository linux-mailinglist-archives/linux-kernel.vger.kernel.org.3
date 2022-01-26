Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046E749CF87
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 17:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236441AbiAZQWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 11:22:02 -0500
Received: from verein.lst.de ([213.95.11.211]:40637 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236372AbiAZQWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 11:22:01 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3DD1368AFE; Wed, 26 Jan 2022 17:21:58 +0100 (CET)
Date:   Wed, 26 Jan 2022 17:21:57 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     hch@lst.de, konrad@kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, tientzu@chromium.org,
        guozhengkui@vivo.com
Subject: Re: [PATCH 0/3] Some minor SWIOTLB cleanups
Message-ID: <20220126162157.GA31431@lst.de>
References: <cover.1643028164.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1643028164.git.robin.murphy@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to the dma-mapping for-next tree.
