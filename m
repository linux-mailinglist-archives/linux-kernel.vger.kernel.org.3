Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F93A4E36F2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 03:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbiCVCwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 22:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235577AbiCVCwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 22:52:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900FC43394;
        Mon, 21 Mar 2022 19:51:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39DBFB81B2B;
        Tue, 22 Mar 2022 02:51:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA03C340E8;
        Tue, 22 Mar 2022 02:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647917471;
        bh=2bRP5Y4GjdyK69yoEGR0c5zmw5oC670YQPme7HBz7aI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RGLUwqZ+K49EIH8om+WKvAR6jxqoIiIw9RR9JZHrdJgXpu8ppQl3VK2c4oUsIUMKQ
         KPIcMzWiVkqoEgR871FYBMKuid/+/fBhMymN0k2ltopdoL6X2oYM0A2FNQT6FUHNHJ
         vDBYd9xELM3oUSr14Cal/lRvCkt1UbEk/xfzEQdr+gtjjCDX0LtWPzVsiCrFaV5gHg
         RePlCJ4QQ/S7Lsyi1Fg+7/+EBYsjR9Zy93mN582+w4vwPnjS35jgPZ4XUGupT4gSod
         QGULjYhgu+Zbqm2aRouXslyvLhOMtIamrHy7dQQvd2pqgqPPQHFGsaHLTT6vv7CW8j
         L4EOHrr8lrzjA==
Date:   Mon, 21 Mar 2022 19:51:11 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] xfs: clean up some inconsistent indenting
Message-ID: <20220322025111.GN8224@magnolia>
References: <20220322001137.96594-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322001137.96594-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 08:11:37AM +0800, Yang Li wrote:
> Eliminate the follow smatch warning:
> fs/xfs/xfs_log.c:3702 xlog_verify_tail_lsn() warn: inconsistent
> indenting
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

https://lore.kernel.org/linux-xfs/20210902233137.GB1826899@dread.disaster.area/
?

--D

> ---
>  fs/xfs/xfs_log.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
> index a8034c0afdf2..5c8843026468 100644
> --- a/fs/xfs/xfs_log.c
> +++ b/fs/xfs/xfs_log.c
> @@ -3699,21 +3699,21 @@ xlog_verify_tail_lsn(
>  	xfs_lsn_t	tail_lsn = be64_to_cpu(iclog->ic_header.h_tail_lsn);
>  	int		blocks;
>  
> -    if (CYCLE_LSN(tail_lsn) == log->l_prev_cycle) {
> -	blocks =
> -	    log->l_logBBsize - (log->l_prev_block - BLOCK_LSN(tail_lsn));
> +	if (CYCLE_LSN(tail_lsn) == log->l_prev_cycle) {
> +		blocks = log->l_logBBsize -
> +			(log->l_prev_block - BLOCK_LSN(tail_lsn));
>  	if (blocks < BTOBB(iclog->ic_offset)+BTOBB(log->l_iclog_hsize))
>  		xfs_emerg(log->l_mp, "%s: ran out of log space", __func__);
> -    } else {
> -	ASSERT(CYCLE_LSN(tail_lsn)+1 == log->l_prev_cycle);
> +	} else {
> +		ASSERT(CYCLE_LSN(tail_lsn)+1 == log->l_prev_cycle);
>  
> -	if (BLOCK_LSN(tail_lsn) == log->l_prev_block)
> -		xfs_emerg(log->l_mp, "%s: tail wrapped", __func__);
> +		if (BLOCK_LSN(tail_lsn) == log->l_prev_block)
> +			xfs_emerg(log->l_mp, "%s: tail wrapped", __func__);
>  
> -	blocks = BLOCK_LSN(tail_lsn) - log->l_prev_block;
> -	if (blocks < BTOBB(iclog->ic_offset) + 1)
> -		xfs_emerg(log->l_mp, "%s: ran out of log space", __func__);
> -    }
> +		blocks = BLOCK_LSN(tail_lsn) - log->l_prev_block;
> +		if (blocks < BTOBB(iclog->ic_offset) + 1)
> +			xfs_emerg(log->l_mp, "%s: ran out of log space", __func__);
> +	}
>  }
>  
>  /*
> -- 
> 2.20.1.7.g153144c
> 
