Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47DBF52FEF3
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 21:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345154AbiEUTZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 15:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbiEUTZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 15:25:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440433A73A;
        Sat, 21 May 2022 12:25:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9CB3BB80A28;
        Sat, 21 May 2022 19:25:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F33BC385A5;
        Sat, 21 May 2022 19:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653161138;
        bh=umQJ0S79Q6Znzu67c8gbyXiw118y/yIgf0qPciYSydY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pe2b0L9GjkVeQDemjHRmMDZxf0fZlD8g9jUd8sggftac2rexmqi2X7+kFQoBs3ddV
         YNQTgK+PRI5QpXWKbu+H7XfbKSrm5AY83UtI4sAQ+KvCUYMHsWYcu5Iw252ixBNacn
         k5asoIvN5/YLXxf8+d2R4rGhYCRWN4c1fMmV/MNVIFImnHeLyiuCy38zOD6nL7GDTc
         as4gX4bh+Iepp9fZh6MPrxo/YPdRad+UBxSdLomeX10pdAAPmcudh82WyuXSeO+mVj
         9p9DP2K827wAe3OoW7zvSpn9x+zgxtxDkidy3GuIoZ19T/PKwGaVIyrAi/aa/VdHCv
         0sYSGnQpe7B2w==
Date:   Sat, 21 May 2022 12:25:37 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     kernel-janitors@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: fix typo in comment
Message-ID: <Yok8sSk1kyF/tXFo@magnolia>
References: <20220521111145.81697-72-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521111145.81697-72-Julia.Lawall@inria.fr>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 01:11:22PM +0200, Julia Lawall wrote:
> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> 
> ---
>  fs/xfs/libxfs/xfs_symlink_remote.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_symlink_remote.c b/fs/xfs/libxfs/xfs_symlink_remote.c
> index f0b38f4aba80..8b9bd178a487 100644
> --- a/fs/xfs/libxfs/xfs_symlink_remote.c
> +++ b/fs/xfs/libxfs/xfs_symlink_remote.c
> @@ -213,7 +213,7 @@ xfs_symlink_shortform_verify(
>  
>  	/*
>  	 * Zero length symlinks should never occur in memory as they are
> -	 * never alllowed to exist on disk.
> +	 * never allowed to exist on disk.
>  	 */
>  	if (!size)
>  		return __this_address;
> 
