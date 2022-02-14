Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC514B4FAD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 13:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245362AbiBNMJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 07:09:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiBNMJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:09:17 -0500
X-Greylist: delayed 537 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Feb 2022 04:09:09 PST
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B2E4889C;
        Mon, 14 Feb 2022 04:09:09 -0800 (PST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 23FD82FB; Mon, 14 Feb 2022 13:00:10 +0100 (CET)
Date:   Mon, 14 Feb 2022 13:00:09 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org
Subject: Re: [PATCH] IOMMU: Intel: DMAR: Replace acpi_bus_get_device()
Message-ID: <YgpESSz6XaVcYnaQ@8bytes.org>
References: <1807113.tdWV9SEqCh@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1807113.tdWV9SEqCh@kreacher>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 07:11:40PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Replace acpi_bus_get_device() that is going to be dropped with
> acpi_fetch_acpi_dev().
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/iommu/intel/dmar.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied with adjusted subject, thanks Rafael.

