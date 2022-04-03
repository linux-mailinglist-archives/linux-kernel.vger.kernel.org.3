Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C7D4F08DF
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 13:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356778AbiDCLFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 07:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243942AbiDCLFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 07:05:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5566131538
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 04:03:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E717660FA6
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 11:03:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E9DC340F0;
        Sun,  3 Apr 2022 11:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648983790;
        bh=i9WuKYjXIN//5i/LViA/z2Vq2IGT86C/asfjRXyaKzU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VoIlYi44agkIabG5JwZAkW/ISqxL9RIOkh0VPituq8hATrvyaFgfLimz9VoBw+sK3
         P7aNmU8F95wVrF1a78PSUARiWSOA/nXP3nFLJhP4sBcSxpWt3iTsF1m9bP63CFh8DJ
         98yyVNMX1I60yUJMHhUjAQu/8nrnbKocWL0H3KdU=
Date:   Sun, 3 Apr 2022 13:03:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH 3/3] staging: rtl8723bs: remove redundant else branches
Message-ID: <Ykl+5reEIg31WHyy@kroah.com>
References: <cover.1648817213.git.sevinj.aghayeva@gmail.com>
 <8d745122cd10f5db59393b1bff09e6a73e88640b.1648817213.git.sevinj.aghayeva@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d745122cd10f5db59393b1bff09e6a73e88640b.1648817213.git.sevinj.aghayeva@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 09:02:47AM -0400, Sevinj Aghayeva wrote:
> Adhere to Linux kernel coding style.
> 
> Reported by checkpatch:
> 
> WARNING: else is not generally useful after a break or return
> 
> Signed-off-by: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 63 +++++++++----------
>  1 file changed, 30 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> index 81e4b1bf68f6..b80d9061f5a5 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> @@ -907,10 +907,9 @@ unsigned int OnAuthClient(struct adapter *padapter, union recv_frame *precv_fram
>  			set_link_timer(pmlmeext, REAUTH_TO);
>  
>  			return _SUCCESS;
> -		} else {
> -			/*  open system */
> -			go2asoc = 1;
>  		}
> +		/*  open system */
> +		go2asoc = 1;
>  	} else if (seq == 4) {
>  		if (pmlmeinfo->auth_algo == dot11AuthAlgrthm_Shared)
>  			go2asoc = 1;
> @@ -1502,32 +1501,32 @@ unsigned int OnDeAuth(struct adapter *padapter, union recv_frame *precv_frame)
>  
>  
>  		return _SUCCESS;
> -	} else {
> -		int	ignore_received_deauth = 0;
> -
> -		/* 	Commented by Albert 20130604 */
> -		/* 	Before sending the auth frame to start the STA/GC mode connection with AP/GO, */
> -		/* 	we will send the deauth first. */
> -		/* 	However, the Win8.1 with BRCM Wi-Fi will send the deauth with reason code 6 to us after receieving our deauth. */
> -		/* 	Added the following code to avoid this case. */
> -		if ((pmlmeinfo->state & WIFI_FW_AUTH_STATE) ||
> -			(pmlmeinfo->state & WIFI_FW_ASSOC_STATE)) {
> -			if (reason == WLAN_REASON_CLASS2_FRAME_FROM_NONAUTH_STA) {
> -				ignore_received_deauth = 1;
> -			} else if (reason == WLAN_REASON_PREV_AUTH_NOT_VALID) {
> -				/*  TODO: 802.11r */
> -				ignore_received_deauth = 1;
> -			}
> +	}
> +	int	ignore_received_deauth = 0;
> +
> +	/* 	Commented by Albert 20130604 */
> +	/* 	Before sending the auth frame to start the STA/GC mode connection with AP/GO, */
> +	/* 	we will send the deauth first. */
> +	/* 	However, the Win8.1 with BRCM Wi-Fi will send the deauth with reason code 6 to us after receieving our deauth. */
> +	/* 	Added the following code to avoid this case. */
> +	if ((pmlmeinfo->state & WIFI_FW_AUTH_STATE) ||
> +		(pmlmeinfo->state & WIFI_FW_ASSOC_STATE)) {

Very odd indentation :(

