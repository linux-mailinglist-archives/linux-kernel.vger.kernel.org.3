Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B084446D9A0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 18:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237812AbhLHRbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 12:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237804AbhLHRbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 12:31:02 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A46C0617A1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 09:27:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BBD15CE227C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 17:27:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040C3C00446;
        Wed,  8 Dec 2021 17:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638984446;
        bh=lqbWSxTjq5h0nfPwj+YekiOXt9qpJedy5VZxJJntbss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y0hEJRnnfWShU9xbZCzZR2oAvbYFZ3QgMqGx/hEt9tUWvHY8//Icy5kr3pdvOMXro
         PuA8ULwyWbjne5qTr0AYnN4gu28TWPRnsea8DjZ4wwOT1JVQwv6tVKNDbO6itzMwjp
         2Aok7RStqjFXUtOe4UeC+NAjXs6UWvhmEjNf+ufTkuMiAoct3fY+L0Fow1EABLlh5m
         kfA5Q0/aEciVFGcRDlAv4PdXi0OrpvRX2bEmKTjk5Ha5stIZdx+LLqsZ84DsxDlFEL
         +U6piotWHGcMzPK70srpc2BZ+qxXinBduw+DgkMjXWXOMxAU4d+OLYApv5qbUW9C0Q
         iHQRmVK7CMJoA==
Date:   Wed, 8 Dec 2021 17:27:21 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 1/6] KVM: arm64: pkvm: Fix hyp_pool max order
Message-ID: <20211208172720.GB820@willie-the-truck>
References: <20211208152300.2478542-1-qperret@google.com>
 <20211208152300.2478542-2-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208152300.2478542-2-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 03:22:54PM +0000, Quentin Perret wrote:
> The EL2 page allocator in protected mode maintains a per-pool max order
> value to optimize allocations when the memory region it covers is small.
> However, the max order value is currently under-estimated whenever the
> number of pages in the region is a power of two. Fix the estimation.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kvm/hyp/nvhe/page_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Will Deacon <will@kernel.org>

Will
