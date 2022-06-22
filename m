Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D51D554A4F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347280AbiFVMsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 08:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243556AbiFVMsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 08:48:14 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF6BB7D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 05:48:13 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 6412E2D0; Wed, 22 Jun 2022 14:48:11 +0200 (CEST)
Date:   Wed, 22 Jun 2022 14:48:10 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Ke Liu <liuke94@huawei.com>
Cc:     will@kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>,
        "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2] iommu: Directly use ida_alloc()/free()
Message-ID: <YrMPiqOr/ApPvu6Y@8bytes.org>
References: <20220608021655.1538087-1-liuke94@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608021655.1538087-1-liuke94@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 02:16:55AM +0000, Ke Liu wrote:
> Use ida_alloc()/ida_free() instead of deprecated
> ida_simple_get()/ida_simple_remove().
> 
> Signed-off-by: Ke Liu <liuke94@huawei.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> v2 subject change to iommu
> ---
>  drivers/iommu/iommu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

