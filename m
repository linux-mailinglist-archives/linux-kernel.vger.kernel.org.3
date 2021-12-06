Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA9D469591
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 13:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243041AbhLFMXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 07:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242984AbhLFMXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 07:23:45 -0500
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070A4C061746;
        Mon,  6 Dec 2021 04:20:17 -0800 (PST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id D790C396; Mon,  6 Dec 2021 13:20:13 +0100 (CET)
Date:   Mon, 6 Dec 2021 13:20:02 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        iommu@lists.linux-foundation.org, dri-devel@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, will@kernel.org
Subject: Re: [PATCH 1/9] gpu: host1x: Add missing DMA API include
Message-ID: <Ya3/8mlWkBZiGi7m@8bytes.org>
References: <cover.1637671820.git.robin.murphy@arm.com>
 <d7bc49bfda25a7ea19dc574f8e212cd9e42bf2e2.1637671820.git.robin.murphy@arm.com>
 <0dfb2ee7-e6ec-f085-ed16-650e646d24d7@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dfb2ee7-e6ec-f085-ed16-650e646d24d7@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Wed, Nov 24, 2021 at 02:05:15PM +0000, Robin Murphy wrote:
> Bah, seems like tegra-vic needs the same treatment too, but wasn't in my
> local config. Should I squash that into a respin of this patch on the
> grounds of being vaguely related, or would you prefer it separate?

In case this fix gets queued in the iommu-tree too, please put it all in
one patch.

Thanks,

	Joerg
