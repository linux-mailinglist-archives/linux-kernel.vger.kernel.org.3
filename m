Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E271A50A1D8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiDUOP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbiDUOPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:15:55 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BBD3A5EA
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:13:05 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id EC0C068C7B; Thu, 21 Apr 2022 16:13:02 +0200 (CEST)
Date:   Thu, 21 Apr 2022 16:13:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     hch@lst.de, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com,
        arnd@kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] More ARM DMA ops cleanup
Message-ID: <20220421141300.GC20492@lst.de>
References: <cover.1650539846.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1650539846.git.robin.murphy@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 12:36:56PM +0100, Robin Murphy wrote:
> Hi all,
> 
> Thanks to Christoph's latest series, I'm reminded that, if we're going
> to give the ARM DMA ops some cleanup this cycle, it's as good a time as
> any to dust off these old patches and add them on top as well. I've
> based these on the arm-dma-direct branch which I assume matches the
> patches posted at [1].

All these do look sensible to me.  But weren't you working on replacing
the ARM iommu dma_ops with dma-іommu anyway?
