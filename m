Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB731554D1B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbiFVOc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbiFVOcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:32:24 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1823A71C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:32:23 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C985168AA6; Wed, 22 Jun 2022 16:32:19 +0200 (CEST)
Date:   Wed, 22 Jun 2022 16:32:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Steven Price <steven.price@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH] swiotlb: Remove redundant swiotlb_force
Message-ID: <20220622143219.GA31314@lst.de>
References: <20220622142952.320057-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622142952.320057-1-steven.price@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 03:29:52PM +0100, Steven Price wrote:
> The variable (and enum) was removed in commit c6af2aa9ffc9 ("swiotlb:
> make the swiotlb_init interface more useful") but the declaration was
> left in swiotlb.h. Tidy up by removing the declaration as well.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>

I just applied an identical patch from Dongli Zhang a few hours ago.
