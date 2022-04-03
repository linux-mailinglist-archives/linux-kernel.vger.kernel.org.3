Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2024F08DD
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 13:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356713AbiDCLDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 07:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234614AbiDCLDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 07:03:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECC731538
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 04:01:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7FEEB80C0A
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 11:01:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1201BC340F0;
        Sun,  3 Apr 2022 11:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648983713;
        bh=pQ1TJmFzZ56vwkQEI9EHhrO2TSNei/w5QKdyfS8cZgc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q1JCZmCaEHG53Heh87xLbrgw8bfN4DMqlmOkPMcnhNfpoMAuYp5dHFH5dGtrdYrVX
         Z7YFlYpdfI0iTCy7JX/Tu1tfI0Ofc4GnlHiFCPNMqtsBkjTJ4dbgMxZChICRf8RR5E
         L460X6iQ8v/CYsmGaiBlMsOy1MAHWIxAVvdxT2Rw=
Date:   Sun, 3 Apr 2022 13:01:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jaehee Park <jhpark1013@gmail.com>
Cc:     =?iso-8859-1?B?Suly9G1l?= Pouiller <jerome.pouiller@silabs.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: wfx: change variable name to be consistent
Message-ID: <Ykl+ngCtuMIeF+Fw@kroah.com>
References: <20220401145350.GA45053@jaehee-ThinkPad-X1-Extreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401145350.GA45053@jaehee-ThinkPad-X1-Extreme>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 10:53:50AM -0400, Jaehee Park wrote:
> Change variable name to be consistent with the naming conventions.
> ssidlen was changed to ssid_len and ssidie was changed to ssid_ie to be
> consistent. This makes the variables more readable. The other ssid
> names in the code are separated by an underscore. For example,
> bssid_filter and num_of_ssids have the ssid separated from the rest of
> the words with an underscore.
> 
> Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
> ---
>  drivers/staging/wfx/hif_tx.c | 10 +++++-----
>  drivers/staging/wfx/sta.c    | 20 ++++++++++----------
>  2 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/staging/wfx/hif_tx.c b/drivers/staging/wfx/hif_tx.c
> index ae3cc5919dcd..9c653d0e9034 100644
> --- a/drivers/staging/wfx/hif_tx.c
> +++ b/drivers/staging/wfx/hif_tx.c
> @@ -280,7 +280,7 @@ int wfx_hif_stop_scan(struct wfx_vif *wvif)
>  }
>  
>  int wfx_hif_join(struct wfx_vif *wvif, const struct ieee80211_bss_conf *conf,
> -		 struct ieee80211_channel *channel, const u8 *ssid, int ssidlen)
> +		 struct ieee80211_channel *channel, const u8 *ssid, int ssid_len)

This is not really a "coding style" cleanup, it is up to the driver
author how they wish to name these variables.  It is not a requirement
to change them as the orginal names are just fine.

thanks,

greg k-h
