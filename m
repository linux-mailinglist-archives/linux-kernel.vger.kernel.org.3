Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE31569BFB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 09:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbiGGHnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 03:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbiGGHnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 03:43:33 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49E020BD9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 00:43:31 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 7D622423; Thu,  7 Jul 2022 09:43:29 +0200 (CEST)
Date:   Thu, 7 Jul 2022 09:43:28 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Will Deacon <will@kernel.org>
Cc:     yf.wang@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
        Yong Wu <Yong.Wu@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        wsd_upstream@mediatek.com, Libo Kang <Libo.Kang@mediatek.com>,
        Ning Li <ning.li@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v12 0/2] iommu/mediatek: TTBR up to 35bit support
Message-ID: <YsaOoI0rcKKVuJPd@8bytes.org>
References: <20220630092927.24925-1-yf.wang@mediatek.com>
 <20220706115028.GC2403@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706115028.GC2403@willie-the-truck>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 12:50:31PM +0100, Will Deacon wrote:
> On Thu, Jun 30, 2022 at 05:29:24PM +0800, yf.wang@mediatek.com wrote:
> > This patchset adds MediaTek TTBR up to 35bit support for single normal zone.
> > 
> > Changes in v12:
> > - Update [PATCH 1/2]: remove GENMASK(31, 7)
> > - Update [PATCH 2/2]: remove MMU_PT_ADDR_MASK definition.
> 
> For both patches:
> 
> Acked-by: Will Deacon <will@kernel.org>
> 
> Joerg -- please can you pick these up for 5.20?

Applied to arm/mediatek, thanks.
