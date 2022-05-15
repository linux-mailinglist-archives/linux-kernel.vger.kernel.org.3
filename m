Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6A052797A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 21:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238516AbiEOTZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 15:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiEOTZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 15:25:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEFE6558;
        Sun, 15 May 2022 12:25:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35DCC60F72;
        Sun, 15 May 2022 19:25:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F9BFC385B8;
        Sun, 15 May 2022 19:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652642753;
        bh=RFTP1/aXg2gz8WWSzFegDcI5lIwB0N/pGEC7mYi4n6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aeXVZIwgboyVHJ/1800mrADW20haf/6qzf0O+55fMAuSq3fscTyhmuerAyTrwKkGg
         rG6dVYKN5I0vmL2lfHcEdMzWvCH6FSaxQwa/R/2zOsN8hG+youCKbNbNNe8i78fu3w
         D1gPEY+8Kza8XDrwU6Bq1+3hUB7SL2nv8eCkS3COk57JcAI+fzbxbF7yAcKso58WAf
         YFYk9rJOSypeb8rkewxQ9wbGA5E+QAmDzuYc1DPGFEDlAr95LxCkmh45TblmOkUduY
         WaoRNbmZ+VDqY750I7Xw3DTToyG2GJwM3EAJkVo3kJ0ksH4s/zTtZ1jCuWgCQUuvae
         Yo9rqcTFQes+g==
Date:   Sun, 15 May 2022 12:25:52 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] xfs: Remove duplicate include
Message-ID: <YoFTwGLupUVjzQve@magnolia>
References: <20220515131140.31281-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220515131140.31281-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 15, 2022 at 09:11:40PM +0800, Jiapeng Chong wrote:
> Clean up the following includecheck warning:
> 
> ./fs/xfs/xfs_attr_item.c: xfs_inode.h is included more than once.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

LGTM
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_attr_item.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_attr_item.c b/fs/xfs/xfs_attr_item.c
> index e8ac88d9fd14..bf9a01b083b8 100644
> --- a/fs/xfs/xfs_attr_item.c
> +++ b/fs/xfs/xfs_attr_item.c
> @@ -22,7 +22,6 @@
>  #include "xfs_attr.h"
>  #include "xfs_attr_item.h"
>  #include "xfs_trace.h"
> -#include "xfs_inode.h"
>  #include "xfs_trans_space.h"
>  #include "xfs_errortag.h"
>  #include "xfs_error.h"
> -- 
> 2.20.1.7.g153144c
> 
