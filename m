Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715FA4F7ED0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 14:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241666AbiDGMQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 08:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiDGMQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 08:16:33 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2CC251F19
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 05:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=5J22qzPbptskuZayJfKej6e8tE7uHh3t6nAEaJ7FCnI=;
  b=YKE7Y7YaaqumXBVPJ1WIH5ae/9S1ejso8TpRM18/oEgE21JyGDxxwSJe
   4PyncbBHswpigfMixuf/YslHleBxLEME62IkcHliW1DqxbfOFhei1TdRE
   SwC9Zm9OqBjvnIBNhldeV9+d9EE/Fd0zqTpk535COu0jBWPDULO25QU/Q
   4=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,241,1643670000"; 
   d="scan'208";a="30565452"
Received: from unknown (HELO hadrien) ([95.128.147.62])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 14:14:30 +0200
Date:   Thu, 7 Apr 2022 14:14:29 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To:     Mahak Gupta <mahak_g@cs.iitr.ac.in>
cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: rtl8712: fix camel case in function
 r8712_generate_ie
In-Reply-To: <20220407120945.31030-1-mahak_g@cs.iitr.ac.in>
Message-ID: <alpine.DEB.2.22.394.2204071414080.2213@hadrien>
References: <20220407120945.31030-1-mahak_g@cs.iitr.ac.in>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Apr 2022, Mahak Gupta wrote:

> Adhere to linux kernel coding style.
>
> Reported by checkpatch:
>
> CHECK: Avoid CamelCase: <beaconPeriod>

As another patch, you could also adjust the structure field name.

julia

>
> Signed-off-by: Mahak Gupta <mahak_g@cs.iitr.ac.in>
> ---
>  drivers/staging/rtl8712/ieee80211.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/rtl8712/ieee80211.c b/drivers/staging/rtl8712/ieee80211.c
> index f926809b1021..7d8f1a29d18a 100644
> --- a/drivers/staging/rtl8712/ieee80211.c
> +++ b/drivers/staging/rtl8712/ieee80211.c
> @@ -162,13 +162,13 @@ int r8712_generate_ie(struct registry_priv *registrypriv)
>  	uint sz = 0;
>  	struct wlan_bssid_ex *dev_network = &registrypriv->dev_network;
>  	u8 *ie = dev_network->IEs;
> -	u16 beaconPeriod = (u16)dev_network->Configuration.BeaconPeriod;
> +	u16 beacon_period = (u16)dev_network->Configuration.BeaconPeriod;
>
>  	/*timestamp will be inserted by hardware*/
>  	sz += 8;
>  	ie += sz;
>  	/*beacon interval : 2bytes*/
> -	*(__le16 *)ie = cpu_to_le16(beaconPeriod);
> +	*(__le16 *)ie = cpu_to_le16(beacon_period);
>  	sz += 2;
>  	ie += 2;
>  	/*capability info*/
> --
> 2.17.1
>
>
>
