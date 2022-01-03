Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B80A483915
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 00:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbiACXeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 18:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiACXd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 18:33:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B7BC061761;
        Mon,  3 Jan 2022 15:33:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E39D7B81038;
        Mon,  3 Jan 2022 23:33:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96581C36AED;
        Mon,  3 Jan 2022 23:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641252835;
        bh=EuTjU1MAoYDdmQAAXpF124BfbZLRLNueZxxD0jAboOc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hStarHIkfKEJZuOj88canVFS+VSoUqCLakVLBIKoM2+CdkMprtX/xUwOn4WJk9z+k
         GOyjVge68gvj3qeYfV9y4wKIm0fgUwTl/miHFpww2JhcHtqoLxLPYJVTwGxPjTuuIk
         izchTHg3Z8YRceKhw2m4qqKz38NuwlLPiuqtn5vx1ZEqSILP6K+jl3mN7gCFpx29On
         buwbMXfi7uf/VqexTDqWZdi0o3oD4RcMAe9VGVI//k4djdCIIt9EaKgjUCTJUGltgm
         Vo/ymKHPioBQev3d1M4D2g2rBGEhEAenYRiUk68pza5cuLIAKvy+QnyM0UJLGH0lfR
         hcBwrO5T+96Sg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 417955C1717; Mon,  3 Jan 2022 15:33:55 -0800 (PST)
Date:   Mon, 3 Jan 2022 15:33:55 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the rcu tree
Message-ID: <20220103233355.GB4202@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220104083817.32b03d70@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104083817.32b03d70@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 08:38:17AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   946ab1bbf6f0 ("rcu: Use a single ->barrier_lock for all CPUs")
> 
> is missing a Signed-off-by from its committer.

Apologies, will fix on my next rebase.

							Thanx, Paul
