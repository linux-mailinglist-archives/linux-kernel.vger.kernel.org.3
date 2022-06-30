Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F16561E26
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 16:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237213AbiF3OhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 10:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235866AbiF3Ogx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 10:36:53 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67E8DFF5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 07:31:21 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id AF95368AA6; Thu, 30 Jun 2022 16:31:16 +0200 (CEST)
Date:   Thu, 30 Jun 2022 16:31:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ren Zhijie <renzhijie2@huawei.com>
Cc:     hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        mathieu.poirier@linaro.org, mark-pk.tsai@mediatek.com,
        iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] dma-mapping: Fix build error unused-value
Message-ID: <20220630143116.GA6198@lst.de>
References: <20220630123528.251181-1-renzhijie2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630123528.251181-1-renzhijie2@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, this looks good with a minor nit below:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Mathieu, can you pick this up through your tree as that is where the
offending commit was merged through?

> Fixes: e61c451476e6("dma-mapping: Add dma_release_coherent_memory to DMA API")

missing space before the opening brace here.
