Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A002466128
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 11:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345752AbhLBKKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 05:10:25 -0500
Received: from foss.arm.com ([217.140.110.172]:60986 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356798AbhLBKKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 05:10:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77CDF142F;
        Thu,  2 Dec 2021 02:06:51 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.65.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A503D3F7D7;
        Thu,  2 Dec 2021 02:06:49 -0800 (PST)
Date:   Thu, 2 Dec 2021 10:06:47 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        chinwen.chang@mediatek.com, nicholas.tang@mediatek.com,
        james.hsu@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] arm64: update PAC description for kernel
Message-ID: <Yaiat4ee0igTZDB5@FVFF77S0Q05N>
References: <20211201034014.20048-1-Kuan-Ying.Lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201034014.20048-1-Kuan-Ying.Lee@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 11:40:10AM +0800, Kuan-Ying Lee wrote:
> Remove the paragraph which has nothing to do with the kernel and
> add PAC description related to kernel.
> 
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>

This looks good to me.

Catalin/Will, did you want to pick this, or do you want Jonathan to do so?

Mark.

> ---
> v1 -> v2:
>   - Remove compiler option description
>   - Add PAC description for kernel
> 
>  Documentation/arm64/pointer-authentication.rst | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/arm64/pointer-authentication.rst b/Documentation/arm64/pointer-authentication.rst
> index f127666ea3a8..e5dad2e40aa8 100644
> --- a/Documentation/arm64/pointer-authentication.rst
> +++ b/Documentation/arm64/pointer-authentication.rst
> @@ -53,11 +53,10 @@ The number of bits that the PAC occupies in a pointer is 55 minus the
>  virtual address size configured by the kernel. For example, with a
>  virtual address size of 48, the PAC is 7 bits wide.
>  
> -Recent versions of GCC can compile code with APIAKey-based return
> -address protection when passed the -msign-return-address option. This
> -uses instructions in the HINT space (unless -march=armv8.3-a or higher
> -is also passed), and such code can run on systems without the pointer
> -authentication extension.
> +When ARM64_PTR_AUTH_KERNEL is selected, the kernel will be compiled
> +with HINT space pointer authentication instructions protecting
> +function returns. Kernels built with this option will work on hardware
> +with or without pointer authentication support.
>  
>  In addition to exec(), keys can also be reinitialized to random values
>  using the PR_PAC_RESET_KEYS prctl. A bitmask of PR_PAC_APIAKEY,
> -- 
> 2.18.0
> 
