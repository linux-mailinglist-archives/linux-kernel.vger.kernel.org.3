Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E594C40D6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 10:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238740AbiBYJBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 04:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbiBYJBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 04:01:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CFA235338
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 01:01:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9073E61CDE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 09:01:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92021C340F1;
        Fri, 25 Feb 2022 09:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645779668;
        bh=vrv1RPmPuA5wxi40zAhhHwbfUznT5MJ6l1l1typKQu4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zOEUJEUmPDu7A1MsA3kCOzeMMpoOVwnsRMt7OxAqs8lhU/bnIbSYoR9hSmHBTn3L1
         FEI395tCBA7NTkcOi4YMSneGRckQ3fgD/DWaI2khsDIxM1C68hOtVmlDPm1txyBw7r
         ENCyyMUifSPGoO4e6CPRbRI1fodhXzfynHqxxpQk=
Date:   Fri, 25 Feb 2022 10:01:05 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Samuel =?iso-8859-1?Q?Sj=F6berg?= <info@samuelsjoberg.se>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] staging: rts5208: fix Lines should not end with a '('.
Message-ID: <Yhia0QoJTT9IB2UW@kroah.com>
References: <20220221214344.5895-1-info@samuelsjoberg.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220221214344.5895-1-info@samuelsjoberg.se>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 10:43:44PM +0100, Samuel Sjöberg wrote:
> Fix the following error reported by checkpatch.pl:
> 
> CHECK: Lines should not end with a '('
> +                                       retval = ms_transfer_tpc(
> 
> Signed-off-by: Samuel Sjöberg <info@samuelsjoberg.se>
> ---
> Changes in v2:
>   - Fixed subject line and commit message.
> 
>  drivers/staging/rts5208/ms.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/rts5208/ms.c b/drivers/staging/rts5208/ms.c
> index 2a6fab5c117a..14449f8afad5 100644
> --- a/drivers/staging/rts5208/ms.c
> +++ b/drivers/staging/rts5208/ms.c
> @@ -1749,11 +1749,10 @@ static int ms_copy_page(struct rtsx_chip *chip, u16 old_blk, u16 new_blk,
>  
>  				for (rty_cnt = 0; rty_cnt < MS_MAX_RETRY_COUNT;
>  				     rty_cnt++) {
> -					retval = ms_transfer_tpc(
> -						chip,
> -						MS_TM_NORMAL_WRITE,
> -						WRITE_PAGE_DATA,
> -						0, NO_WAIT_INT);
> +					retval = ms_transfer_tpc(chip,
> +								 MS_TM_NORMAL_WRITE,
> +								 WRITE_PAGE_DATA,
> +								 0, NO_WAIT_INT);
>  					if (retval == STATUS_SUCCESS)
>  						break;
>  				}
> -- 
> 2.35.1
> 

This change never ended up on the mailing list for some reason :(

Please fix up and resend.

thanks,

greg k-h
