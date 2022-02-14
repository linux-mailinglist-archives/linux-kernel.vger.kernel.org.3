Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B194B4F6C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351702AbiBNLxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:53:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235729AbiBNLxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:53:03 -0500
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15478C35
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 03:52:56 -0800 (PST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id BE7412FB; Mon, 14 Feb 2022 12:52:54 +0100 (CET)
Date:   Mon, 14 Feb 2022 12:52:53 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        daniel.m.jordan@oracle.com, Jon.Grimm@amd.com, wei.huang2@amd.com,
        terry.bowman@amd.com
Subject: Re: [PATCH] iommu/amd: Fix I/O page table memory leak
Message-ID: <YgpClRRdOR/1DXJE@8bytes.org>
References: <20220210154745.11524-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210154745.11524-1-suravee.suthikulpanit@amd.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 09:47:45AM -0600, Suravee Suthikulpanit wrote:
> The current logic updates the I/O page table mode for the domain
> before calling the logic to free memory used for the page table.
> This results in IOMMU page table memory leak, and can be observed
> when launching VM w/ pass-through devices.
> 
> Fix by freeing the memory used for page table before updating the mode.
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Reported-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> Tested-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Fixes: e42ba0633064 ("iommu/amd: Restructure code for freeing page table")
> Link: https://lore.kernel.org/all/20220118194720.urjgi73b7c3tq2o6@oracle.com/
> ---
>  drivers/iommu/amd/io_pgtable.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Applied, thanks.

