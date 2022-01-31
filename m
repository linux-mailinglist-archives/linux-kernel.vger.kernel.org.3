Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDD3B4A4AF7
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 16:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379885AbiAaPuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 10:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245390AbiAaPuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 10:50:20 -0500
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC65C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 07:50:19 -0800 (PST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 268E24DC; Mon, 31 Jan 2022 16:50:18 +0100 (CET)
Date:   Mon, 31 Jan 2022 16:50:16 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     John Garry <john.garry@huawei.com>
Cc:     will@kernel.org, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: Fix some W=1 warnings
Message-ID: <YfgFOLz79Gmvl5U9@8bytes.org>
References: <1643366673-26803-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1643366673-26803-1-git-send-email-john.garry@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 06:44:33PM +0800, John Garry wrote:
> The code is mostly free of W=1 warning, so fix the following:
> 
> drivers/iommu/iommu.c:996: warning: expecting prototype for iommu_group_for_each_dev(). Prototype was for __iommu_group_for_each_dev() instead
> drivers/iommu/iommu.c:3048: warning: Function parameter or member 'drvdata' not described in 'iommu_sva_bind_device'
> drivers/iommu/ioasid.c:354: warning: Function parameter or member 'ioasid' not described in 'ioasid_get'
> drivers/iommu/omap-iommu.c:1098: warning: expecting prototype for omap_iommu_suspend_prepare(). Prototype was for omap_iommu_prepare() instead
> 
> Signed-off-by: John Garry <john.garry@huawei.com>

Applied, thanks.

