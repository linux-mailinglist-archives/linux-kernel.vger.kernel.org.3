Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD16492D19
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 19:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347901AbiARSRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 13:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347872AbiARSRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 13:17:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8158C061574;
        Tue, 18 Jan 2022 10:17:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66DC561504;
        Tue, 18 Jan 2022 18:17:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7629C340E0;
        Tue, 18 Jan 2022 18:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642529854;
        bh=iJ0MdH5QslLk5DaTZSJY1trQkw+gM14Ryth70aQ9KG0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a5MW+3QtPPeXs6UHQMvUPf655LsQM8V7tw0//kUyOZ9vL9gMBxEsQjcVxMVLKytmD
         auZ/JKlo/Mh8vF/3RW6/ZJA4dmQ4XxAjMiPzMPNPtknNrBzVSAUzG7q0MkBW/mZasm
         1YF4oe/XHCa8tmSBEq/oh62JomUvkG27MSYuIcDdE3gafJSiEA4lPR39RKkiFLaGNE
         Bd+i9KJINRUznZsQsLBK1QJcPEley8Dh/GwLtDeyacjZO9CbT3quYmZE7/RrtViYDT
         W9uS9/ajgsTdJKr5T75L8GroPRiB7QFWLNsndrc4/LfotS4JDbHDroofw8JnUNvXNu
         OBtljZopaaIrA==
Date:   Tue, 18 Jan 2022 10:17:34 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the xfs tree with Linus' tree
Message-ID: <20220118181734.GC13540@magnolia>
References: <20220118093041.7d964a13@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118093041.7d964a13@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 09:30:41AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the xfs tree got a conflict in:
> 
>   fs/xfs/xfs_ioctl.c
> 
> between commit:
> 
>   983d8e60f508 ("xfs: map unwritten blocks in XFS_IOC_{ALLOC,FREE}SP just like fallocate")
> 
> from Linus' tree and commit:
> 
>   4d1b97f9ce7c ("xfs: kill the XFS_IOC_{ALLOC,FREE}SP* ioctls")
> 
> from the xfs tree.
> 
> I fixed it up (the latter removed the code modified by the former, so I
> did that) and can carry the fix as necessary. This is now fixed as far as
> linux-next is concerned, but any non trivial conflicts should be mentioned
> to your upstream maintainer when your tree is submitted for merging.
> You may also want to consider cooperating with the maintainer of the
> conflicting tree to minimise any particularly complex conflicts.

Ok, thanks!  The resolution you picked (delete xfs_ioc_space regardless
of its contents) is exactly what I was expecting.

--D

> 
> -- 
> Cheers,
> Stephen Rothwell


