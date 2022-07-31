Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F31585FC8
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 18:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237533AbiGaQXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 12:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235943AbiGaQXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 12:23:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10899DEEF;
        Sun, 31 Jul 2022 09:23:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A105060F42;
        Sun, 31 Jul 2022 16:23:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D81C433D6;
        Sun, 31 Jul 2022 16:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659284589;
        bh=HsdsdEfTtmF6MTUSGc1t/9iW2TbWDia9Kl4W40DD3l8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UVbeyHcLklV8VT4PWo5qXVkgPOxgm0PcGNBx0Ko/ViBqgVmgG313mAe8a9Kpr8Fy/
         0UqGMDY3cuREIySw0jyXiG5nw61MkrQNYgjzhS0gstDc+2eoKw0po88WXQRFVenPR6
         XvnaX1I7UtZzJaHPiP3LV+3TCspQNBbUNs6R05BJg9JvCBZfI6W6uUF+sPa4iXqJMi
         j7g9Bk/CbiF3NZ+9dcrANT9r9JCj/KcyEGTKVvK8l9zM7w8WAMljoDcLbCdFSNUGZ7
         s8n1LMtK2yd93RMILc4hKr1OOmm52G2Ni2tDBlwIhVsDQY4p/UbtEheFe5XwP40P/X
         cnGz4vNfZGSzQ==
Date:   Sun, 31 Jul 2022 09:23:08 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     studentxswpy@163.com
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hacash Robot <hacashRobot@santino.com>
Subject: Re: [PATCH -next] xfs: delete extra space and tab in blank line
Message-ID: <YuasbFHWfWiXPUJM@magnolia>
References: <20220730092959.3103627-1-studentxswpy@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220730092959.3103627-1-studentxswpy@163.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 30, 2022 at 05:29:59PM +0800, studentxswpy@163.com wrote:
> From: Xie Shaowen <studentxswpy@163.com>
> 
> delete extra space and tab in blank line, there is no functional change.
> 
> Reported-by: Hacash Robot <hacashRobot@santino.com>
> Signed-off-by: Xie Shaowen <studentxswpy@163.com>

The last hunk doesn't apply, but fmeh, whatever.
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_extfree_item.c | 12 ++++++------
>  fs/xfs/xfs_log.c          |  4 ++--
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/xfs/xfs_extfree_item.c b/fs/xfs/xfs_extfree_item.c
> index 765be054dffe..08b0c8b553fc 100644
> --- a/fs/xfs/xfs_extfree_item.c
> +++ b/fs/xfs/xfs_extfree_item.c
> @@ -187,12 +187,12 @@ xfs_efi_copy_format(xfs_log_iovec_t *buf, xfs_efi_log_format_t *dst_efi_fmt)
>  {
>  	xfs_efi_log_format_t *src_efi_fmt = buf->i_addr;
>  	uint i;
> -	uint len = sizeof(xfs_efi_log_format_t) + 
> -		(src_efi_fmt->efi_nextents - 1) * sizeof(xfs_extent_t);  
> -	uint len32 = sizeof(xfs_efi_log_format_32_t) + 
> -		(src_efi_fmt->efi_nextents - 1) * sizeof(xfs_extent_32_t);  
> -	uint len64 = sizeof(xfs_efi_log_format_64_t) + 
> -		(src_efi_fmt->efi_nextents - 1) * sizeof(xfs_extent_64_t);  
> +	uint len = sizeof(xfs_efi_log_format_t) +
> +		(src_efi_fmt->efi_nextents - 1) * sizeof(xfs_extent_t);
> +	uint len32 = sizeof(xfs_efi_log_format_32_t) +
> +		(src_efi_fmt->efi_nextents - 1) * sizeof(xfs_extent_32_t);
> +	uint len64 = sizeof(xfs_efi_log_format_64_t) +
> +		(src_efi_fmt->efi_nextents - 1) * sizeof(xfs_extent_64_t);
>  
>  	if (buf->i_len == len) {
>  		memcpy((char *)dst_efi_fmt, (char*)src_efi_fmt, len);
> diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
> index ae904b21e9cc..6f661fadb755 100644
> --- a/fs/xfs/xfs_log.c
> +++ b/fs/xfs/xfs_log.c
> @@ -2000,7 +2000,7 @@ xlog_calc_iclog_size(
>  }
>  
>  /*
> - * Flush out the in-core log (iclog) to the on-disk log in an asynchronous 
> + * Flush out the in-core log (iclog) to the on-disk log in an asynchronous
>   * fashion.  Previously, we should have moved the current iclog
>   * ptr in the log to point to the next available iclog.  This allows further
>   * write to continue while this code syncs out an iclog ready to go.
> @@ -2042,7 +2042,7 @@ xlog_sync(
>  	xlog_grant_add_space(log, &log->l_write_head.grant, roundoff);
>  
>  	/* put cycle number in every block */
> -	xlog_pack_data(log, iclog, roundoff); 
> +	xlog_pack_data(log, iclog, roundoff);
>  
>  	/* real byte length */
>  	size = iclog->ic_offset;
> -- 
> 2.25.1
> 
