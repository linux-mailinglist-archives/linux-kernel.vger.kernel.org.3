Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC2614785EC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 09:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbhLQIIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 03:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbhLQIIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 03:08:39 -0500
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B99C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 00:08:39 -0800 (PST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id A4A0436D; Fri, 17 Dec 2021 09:08:37 +0100 (CET)
Date:   Fri, 17 Dec 2021 09:08:36 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Xiang wangx <wangxiang@cdjrlc.com>
Cc:     will@kernel.org, jean-philippe@linaro.org,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/virtio: Fix typo in a comment
Message-ID: <YbxFhHS0OFzGqbqX@8bytes.org>
References: <20211216083302.18049-1-wangxiang@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216083302.18049-1-wangxiang@cdjrlc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 04:33:02PM +0800, Xiang wangx wrote:
> The double `as' in a comment is repeated, thus it should be removed.
> 
> Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
> ---
>  drivers/iommu/virtio-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
