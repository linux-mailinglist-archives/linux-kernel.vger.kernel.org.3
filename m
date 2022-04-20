Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA35508D69
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380673AbiDTQga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380677AbiDTQgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:36:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB3F45ACD
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 09:33:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0F2261A15
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 16:33:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B218C385A1;
        Wed, 20 Apr 2022 16:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650472412;
        bh=3gwS24bB34KTAmVZROiegu+rn3qGs5bkKsOicKSeKh4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i6piH7xtk3s1u5xbdcgvgatfLteKpA9aG0lQenXdczXqlblSBY1h5DpkS7EJHwuzi
         9EoGKtzLb5ifOdLj/XGFALrKpGVD96byHKTStXnaN2DAbS32fYqV/HFlJAjZZeDnWw
         mSyo1xq5pJxz9gXlohDikrpK67osDQ6d+fjG67Ww=
Date:   Wed, 20 Apr 2022 18:33:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jaehee Park <jhpark1013@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev, Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: [PATCH v3 1/7] staging: r8188eu: remove unused member
 free_bss_buf
Message-ID: <YmA12QUKhueVTOfC@kroah.com>
References: <cover.1650392020.git.jhpark1013@gmail.com>
 <3c5a510938ac395a13bb09c0de1868cce8ca3dd8.1650392020.git.jhpark1013@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c5a510938ac395a13bb09c0de1868cce8ca3dd8.1650392020.git.jhpark1013@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 02:19:32PM -0400, Jaehee Park wrote:
> The free_bss_buf member of pmlmepriv is unused. Remove all related
> lines.
> 
> Suggested-by: Pavel Skripkin <paskripkin@gmail.com>
> Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
> ---
>  drivers/staging/r8188eu/include/rtw_mlme.h |  1 -
>  drivers/staging/r8188eu/core/rtw_mlme.c    | 21 +--------------------
>  2 files changed, 1 insertion(+), 21 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/include/rtw_mlme.h b/drivers/staging/r8188eu/include/rtw_mlme.h
> index 1dc1fbf049af..0f03ac43079c 100644
> --- a/drivers/staging/r8188eu/include/rtw_mlme.h
> +++ b/drivers/staging/r8188eu/include/rtw_mlme.h
> @@ -319,7 +319,6 @@ struct mlme_priv {
>  	struct list_head *pscanned;
>  	struct __queue free_bss_pool;
>  	struct __queue scanned_queue;
> -	u8 *free_bss_buf;
>  	u8	key_mask; /* use to restore wep key after hal_init */
>  	u32	num_of_scanned;
>  
> diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
> index 3e9882f89f76..8af11626a3e7 100644
> --- a/drivers/staging/r8188eu/core/rtw_mlme.c
> +++ b/drivers/staging/r8188eu/core/rtw_mlme.c
> @@ -33,8 +33,7 @@ u8 rtw_to_roaming(struct adapter *adapter)
>  static int _rtw_init_mlme_priv(struct adapter *padapter)
>  {
>  	int	i;
> -	u8	*pbuf;
> -	struct wlan_network	*pnetwork;
> +	struct wlan_network	*pnetwork = NULL;

Why did you add this line?  It caused the real error to be ignored that
the compiler was trying to tell you :(

