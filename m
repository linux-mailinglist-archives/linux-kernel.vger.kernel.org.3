Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA57646956C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 13:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242909AbhLFMKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 07:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237534AbhLFMKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 07:10:50 -0500
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037F2C061746;
        Mon,  6 Dec 2021 04:07:22 -0800 (PST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 63B843FC; Mon,  6 Dec 2021 13:07:20 +0100 (CET)
Date:   Mon, 6 Dec 2021 13:07:19 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Janne Grunau <j@jannau.net>,
        Hector Martin <marcan@marcan.st>,
        Robin Murphy <robin.murphy@arm.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/4] iommu: M1 Pro/Max DART support
Message-ID: <Ya389/JeUcDzBWlk@8bytes.org>
References: <20211117211509.28066-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117211509.28066-1-sven@svenpeter.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sven,

On Wed, Nov 17, 2021 at 10:15:05PM +0100, Sven Peter wrote:
> Sven Peter (4):
>   dt-bindings: iommu: dart: add t6000 compatible
>   iommu/io-pgtable: Add DART subpage protection support
>   iommu/io-pgtable: Add DART PTE support for t6000
>   iommu: dart: Support t6000 variant

Looks good to me, will apply it when Robin had a chance to look at the
io-pgtable changes.

Thanks,

	Joerg
