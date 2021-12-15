Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493CF474F61
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 01:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238572AbhLOAhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 19:37:24 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40702 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbhLOAhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 19:37:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC94DB81DC7;
        Wed, 15 Dec 2021 00:37:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B65C34601;
        Wed, 15 Dec 2021 00:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639528640;
        bh=tbRoBoVUjzbxEi/QcAg5ir+0LKHMUNVHqZzDT1UUT1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R1kAz9+2yWKvd3i3G0IegwyWidCH4hzcXhdlxgdsmdKY1kEqwxj6O/pQkLMl9tSq5
         Naz9fmYMV++H2Cv1dCZXqPhFlEeAEPmtUI61r0LwW3/w+/DWtFz42YL1VfInvIaKPT
         jYbICeauH1lq89kIMItzR8fcW3MyjJk6Y4Zwo/m5JR+XgeddO/AerMolA+a0d7wluN
         nRXa3mnCL3L91oK1ujeUI/kuBApN1zZR377JKA211FHDASpI89XaiUbNV017ivPqcb
         2ueGKvepcq5gHNEnU1RTSxvAWxKPPrWTkixorF1QM99vx1lAfxf6LyGJPFiTGQ34dT
         JgXsxU2WwJp+w==
Date:   Tue, 14 Dec 2021 17:37:16 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     broonie@kernel.org
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Subject: Re: linux-next: Tree for Dec 14
Message-ID: <Ybk4vF68Uhsd/8JH@archlinux-ax161>
References: <20211214223228.1745315-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214223228.1745315-1-broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Tue, Dec 14, 2021 at 10:32:22PM +0000, broonie@kernel.org wrote:
> Hi all,
> 
> News: Releases may or may not happen over the next few days since I'm
> getting a vacciene dose tomorrow.
> 
> Changes since 20211213:
> 
> The drm-intel tree gained a conflict with the drm-intel-fixes tree.
> 
> The dmaengine tree gained a conflict with the dmaengine-fixes tree.
> 
> Non-merge commits (relative to Linus' tree): 6251
>  6873 files changed, 291130 insertions(+), 138903 deletions(-)

Was there a conflict in mm/migrate.c with this release? It looks like
the ptl assignment was dropped in commit fd93c9fe58cc ("Merge branch
'akpm-current/current'") but I do not see that in any of the individual
mm/migrate.c commits. I noticed this because Clang warns now:

mm/migrate.c:347:14: error: variable 'ptl' is uninitialized when used here [-Werror,-Wuninitialized]
        spin_unlock(ptl);
                    ^~~
mm/migrate.c:340:17: note: initialize the variable 'ptl' to silence this warning
        spinlock_t *ptl;
                       ^
                        = NULL
1 error generated.

Cheers,
Nathan
