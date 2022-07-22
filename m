Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1726A57D8C2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 04:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbiGVCqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 22:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiGVCqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 22:46:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3B51706C;
        Thu, 21 Jul 2022 19:46:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A663B8267D;
        Fri, 22 Jul 2022 02:46:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CAA0C3411E;
        Fri, 22 Jul 2022 02:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658458009;
        bh=DMU2aTfUCpJW9cUvpkfGbZpKN9z1rjIONQRzkO+HXAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hLIvhnYt+XSJZ0VbVVJ7oIgmuHHqywnFlQs4ry3kobanp1sih8y99DSuRuhDejpov
         OwqbAJoCVgVlhjU4kVksHNsu5h4BzTlyIw5k0MoTdnRtwBGo11De2DDc/8FzMBGmGA
         0iAI7AGJ5D4RQzSS7CU2/qpalJxjj6G5+yWvKQLs1vKp3o6Kax5Cs6V0hvXE4MPOq9
         mg9L9tIjpf41GKG53axtsMtE442EkiMyySRgohAMhnG/jAPR2iS+CGYBEiFE2YBzmP
         mxja1C++pcRO6yYjYY7p+jQw8eyXd4iNwLF0mr+cJWrayo+L/cwEbO2EvAIhaORhnk
         2KcrtAqPkVkxw==
Date:   Thu, 21 Jul 2022 19:46:48 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Xin Gao <gaoxin@cdjrlc.com>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: Fix comment typo
Message-ID: <YtoPmIgHSxCnRf81@magnolia>
References: <20220722022626.16082-1-gaoxin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722022626.16082-1-gaoxin@cdjrlc.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 10:26:26AM +0800, Xin Gao wrote:
> The double `the' is duplicated in line 552, remove one.
> 
> Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>

Applied, thanks.
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_dquot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
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
> 2.30.2
> 
