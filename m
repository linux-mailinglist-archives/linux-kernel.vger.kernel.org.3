Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCEFC4F47AE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359353AbiDEVPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444550AbiDEPlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:41:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0375AF8EE6
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 07:05:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF3ABB81DD6
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 14:05:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD7CC385A6;
        Tue,  5 Apr 2022 14:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649167543;
        bh=Mm6htJ9QXhibJuptol/3kgU+rb9dRyr5kKvhCP6Pey8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g2hVE6drCRXDZpJo5aLZ3PO7bKakIRz5fw4e83rgXNb5uBxju8zGTTiUzRTH8lgS9
         Iq7ghmIJuzpN8xeZbxYgpMTOlppvJEhiAOIxGukPf9nC17SKRcnEAsccOLHkjL+iQe
         blc/mkonzw/Fp5HSjjQlmAf2RhNlOO9+KVcsdO3Q=
Date:   Tue, 5 Apr 2022 16:05:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH 4/5] staging: rtl8723bs: fix indentation
Message-ID: <YkxMtPimZLxAlkgg@kroah.com>
References: <cover.1649128267.git.sevinj.aghayeva@gmail.com>
 <3bb9687a1057619334d95832f803c9b8d7e7fa63.1649128267.git.sevinj.aghayeva@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bb9687a1057619334d95832f803c9b8d7e7fa63.1649128267.git.sevinj.aghayeva@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 11:16:11PM -0400, Sevinj Aghayeva wrote:
> Adhere to Linux kernel coding style.
> 
> Reported by checkpatch:
> 
> WARNING: suspect code indent for conditional statements
> 
> Signed-off-by: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> index c06be65b45cf..5eddff488f27 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> @@ -5145,9 +5145,9 @@ void link_timer_hdl(struct timer_list *t)
>  		if (++pmlmeinfo->reauth_count > REAUTH_LIMIT) {
>  			/* if (pmlmeinfo->auth_algo != dot11AuthAlgrthm_Auto) */
>  			/*  */
> -				pmlmeinfo->state = 0;
> -				report_join_res(padapter, -1);
> -				return;
> +			pmlmeinfo->state = 0;
> +			report_join_res(padapter, -1);
> +			return;
>  			/*  */
>  			/* else */
>  			/*  */

Please remove these comments around here at the same time, as the
indentation did make sense with those there, but now it's really messy.

thanks,

greg k-h
