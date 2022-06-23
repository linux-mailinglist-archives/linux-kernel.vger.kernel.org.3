Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131C35572A0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 07:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiFWFmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 01:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiFWFmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 01:42:16 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3275B3A5FB;
        Wed, 22 Jun 2022 22:42:15 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 853FE68AA6; Thu, 23 Jun 2022 07:42:11 +0200 (CEST)
Date:   Thu, 23 Jun 2022 07:42:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
        bjorn.andersson@linaro.org, robin.murphy@arm.com,
        m.szyprowski@samsung.com, matthias.bgg@gmail.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, yj.chiang@mediatek.com
Subject: Re: [PATCH 0/2] dma-mapping, remoteproc: Fix dma_mem leak after
 rproc_shutdown
Message-ID: <20220623054211.GA12408@lst.de>
References: <20220422062436.14384-1-mark-pk.tsai@mediatek.com> <20220423174650.GA29219@lst.de> <20220622162540.GA1606016@p14s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622162540.GA1606016@p14s>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 10:25:40AM -0600, Mathieu Poirier wrote:
> On Sat, Apr 23, 2022 at 07:46:50PM +0200, Christoph Hellwig wrote:
> > Sigh.  In theory drivers should never declare coherent memory like
> > this, and there has been some work to fix remoteproc in that regard.
> > 
> > But I guess until that is merged we'll need somthing like this fix.
> 
> Should I take this in the remoteproc tree?  If so, can I get an RB?

Reluctantly-Acked-by: Christoph Hellwig <hch@lst.de>
