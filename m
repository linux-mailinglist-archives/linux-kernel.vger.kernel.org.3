Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922F257E60A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 19:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235803AbiGVRy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 13:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbiGVRy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 13:54:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B384C53;
        Fri, 22 Jul 2022 10:54:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3FC09B82971;
        Fri, 22 Jul 2022 17:54:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D83D0C341C6;
        Fri, 22 Jul 2022 17:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658512492;
        bh=nft2HdL/uonBQVhBJwBORjT62BBhaURKCj1yN/X2/3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FlpMG34VI4ESDOlX1baBJIpkRmx9Ac65GX32nB6gjmWf9ye3wMH9fkmE2orSSXoTp
         SG810KV3V4T01j82xM5pg7rjWiXbJRDNk3DHhKiwlNIzyl2V9xmWNDxeDdBbK9rcqK
         U9MzuCl8A6Me6wRAXQWRJVqAzxbcAMy3dkB09m4DMTTA9tOtaS+ZaBrEbfUMoru7pz
         m1sxcVIyCEmjzThDaRzF+jBdpWvGs1cSc5Gt1BXWJLx9KImB9fmDC5tj4MEHJKbGDk
         MmWiqXc+YgGEU86mkWxCujHR95nLTltB/A2vJ68K9qjhCSoDJz9ksmlxzJnFRAJV1X
         kkb7b4/BHHuEQ==
Date:   Fri, 22 Jul 2022 10:54:52 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] xfs: Fix typo 'the the' in comment
Message-ID: <YtrkbL4m6f99omFJ@magnolia>
References: <20220722100654.80002-1-slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722100654.80002-1-slark_xiao@163.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 06:06:54PM +0800, Slark Xiao wrote:
> Replace 'the the' with 'the' in the comment.
> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>

Applied, though someone else already beat you to the second chunk.
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/libxfs/xfs_alloc.c | 2 +-
>  fs/xfs/xfs_dquot.c        | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
> index 41557c430cb6..e2bdf089c0a3 100644
> --- a/fs/xfs/libxfs/xfs_alloc.c
> +++ b/fs/xfs/libxfs/xfs_alloc.c
> @@ -84,7 +84,7 @@ xfs_prealloc_blocks(
>  /*
>   * The number of blocks per AG that we withhold from xfs_mod_fdblocks to
>   * guarantee that we can refill the AGFL prior to allocating space in a nearly
> - * full AG.  Although the the space described by the free space btrees, the
> + * full AG.  Although the space described by the free space btrees, the
>   * blocks used by the freesp btrees themselves, and the blocks owned by the
>   * AGFL are counted in the ondisk fdblocks, it's a mistake to let the ondisk
>   * free space in the AG drop so low that the free space btrees cannot refill an
> diff --git a/fs/xfs/xfs_dquot.c b/fs/xfs/xfs_dquot.c
> index 5a6c3c3c4de2..8fb90da89787 100644
> --- a/fs/xfs/xfs_dquot.c
> +++ b/fs/xfs/xfs_dquot.c
> @@ -549,7 +549,7 @@ xfs_dquot_check_type(
>  	 * at the same time.  The non-user quota file can be switched between
>  	 * group and project quota uses depending on the mount options, which
>  	 * means that we can encounter the other type when we try to load quota
> -	 * defaults.  Quotacheck will soon reset the the entire quota file
> +	 * defaults.  Quotacheck will soon reset the entire quota file
>  	 * (including the root dquot) anyway, but don't log scary corruption
>  	 * reports to dmesg.
>  	 */
> -- 
> 2.25.1
> 
