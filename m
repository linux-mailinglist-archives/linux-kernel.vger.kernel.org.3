Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC5E5165D8
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 18:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351791AbiEAQzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 12:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352637AbiEAQyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 12:54:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33D3389A
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 09:50:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F75760F66
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 16:50:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1297C385B8;
        Sun,  1 May 2022 16:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651423856;
        bh=UuPQPRcvBuddGzSocSImJOFLMKh6Eo2G60SPZFrwkNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w89X2i2TMjGSP1sxQHqZXDqXHB+K/P5Ujffts5b0+GogSQzuVGYa4GpAPV+MhRa8R
         bV5igw3FSqRSuQPQQNswJ7bqQ7Iu3B6IzY+XFJyEoH6fw5ujIBsS4IFsKb7uhHXJ/b
         2nsld1fYKst9MoTQfnoSr+yB6K00gfCBp3jUa+aQ=
Date:   Sun, 1 May 2022 18:50:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: vt6655: Rename function CARDbGetCurrentTSF
Message-ID: <Ym66R9hpFgRikNx7@kroah.com>
References: <cover.1651422181.git.philipp.g.hortmann@gmail.com>
 <1f38006d7eb18426a2336b7666d385021bf81faf.1651422181.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f38006d7eb18426a2336b7666d385021bf81faf.1651422181.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 01, 2022 at 06:37:05PM +0200, Philipp Hortmann wrote:
> The name of the function uses CamelCase which
> is not accepted by checkpatch.pl
> 
> Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
> ---
>  drivers/staging/vt6655/card.c        | 10 +++++-----
>  drivers/staging/vt6655/card.h        |  2 +-
>  drivers/staging/vt6655/device_main.c |  2 +-
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
> index ec6fd185d3fd..d1dfd96e13b7 100644
> --- a/drivers/staging/vt6655/card.c
> +++ b/drivers/staging/vt6655/card.c
> @@ -11,7 +11,7 @@
>   *      CARDbAddBasicRate - Add to BasicRateSet
>   *      CARDbIsOFDMinBasicRate - Check if any OFDM rate is in BasicRateSet
>   *      CARDqGetTSFOffset - Calculate TSFOffset
> - *      CARDbGetCurrentTSF - Read Current NIC TSF counter
> + *      card_get_current_tsf - Read Current NIC TSF counter
>   *      CARDqGetNextTBTT - Calculate Next Beacon TSF counter
>   *      CARDvSetFirstNextTBTT - Set NIC Beacon time
>   *      CARDvUpdateNextTBTT - Sync. NIC Beacon time
> @@ -288,7 +288,7 @@ bool CARDbUpdateTSF(struct vnt_private *priv, unsigned char byRxRate,
>  	u64 local_tsf;
>  	u64 qwTSFOffset = 0;
>  
> -	CARDbGetCurrentTSF(priv, &local_tsf);
> +	card_get_current_tsf(priv, &local_tsf);

Why is the value being passed as a reference and the error value (if
any), is not checked at all?

Shouldn't this just return the value as it obviously must always work?
(retorical question, something is wrong here...)

And this is a horrible global function name, can you prefix it with the
driver name to give us a chance to keep the global namespace sane?
vt6655_get_current_tsf() would be better.

thanks,

greg k-h
