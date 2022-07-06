Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5EB05686C7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 13:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbiGFLil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 07:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiGFLij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 07:38:39 -0400
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB5114024
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 04:38:38 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 4018F4CC; Wed,  6 Jul 2022 13:38:37 +0200 (CEST)
Date:   Wed, 6 Jul 2022 13:38:36 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Bo Liu <liubo03@inspur.com>
Cc:     will@kernel.org, suravee.suthikulpanit@amd.com,
        iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Handle return of iommu_device_sysfs_add
Message-ID: <YsV0POm9lLEbQyIB@8bytes.org>
References: <20220701062008.6988-1-liubo03@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701062008.6988-1-liubo03@inspur.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 02:20:08AM -0400, Bo Liu wrote:
> As iommu_device_sysfs_add() can fail, we should check the return value.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>
> ---
>  drivers/iommu/amd/init.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Applied, thanks.

