Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA3C469560
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 13:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242854AbhLFMHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 07:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242845AbhLFMHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 07:07:36 -0500
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B330C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 04:04:08 -0800 (PST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id DCCD3396; Mon,  6 Dec 2021 13:04:06 +0100 (CET)
Date:   Mon, 6 Dec 2021 13:04:05 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     Sven Peter <sven@svenpeter.dev>, Will Deacon <will@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/io-pgtable-arm: Fix table descriptor paddr
 formatting
Message-ID: <Ya38NRG7K/+Atovr@8bytes.org>
References: <20211120031343.88034-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211120031343.88034-1-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2021 at 12:13:43PM +0900, Hector Martin wrote:
>  drivers/iommu/io-pgtable-arm.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Applied, thanks.
