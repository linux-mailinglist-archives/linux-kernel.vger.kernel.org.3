Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C025749BB29
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 19:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiAYSUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 13:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiAYSTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 13:19:43 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E40C061744;
        Tue, 25 Jan 2022 10:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=GIYgmGVH0pclqYjJ31drSKjl7AYrdZRKN/75y87O6wI=;
        t=1643134783; x=1644344383; b=NxDZ+e374Sr0tVqs3O2XGu1nqugQ6n/53Buw/KIt9EwfiFv
        oNFJBsM57zrjhB9jhfdCAA57ggToEjmCbuIsz79tTdoFed3vogisUTjxHq69C8XDlU2OGAxhs7FAJ
        ii94tr9t1n+RdBlbsIBbbElmIMaLoZ6+XpP+8RuWvdRhTid87QKu2JrUfFpwvVfyMH7D1lEbntJSF
        VoKLiPIU2ASvBdFvZFqJ6jVbvJRJjDZmkKAZW2kLw7QmIbWZDj8KAFpes040Z+TacwxhXBe5a/Xzt
        vAlFfwXc3VMlqXCjNvu3f4Ujic3roITcrINu9NA9ko7qwSVW6qZQMDmcmqsAZ4DA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nCQPs-00AAoO-Bt;
        Tue, 25 Jan 2022 19:19:40 +0100
Message-ID: <10efb4246ce9c76403ac54fa06e8ea3d0d87785e.camel@sipsolutions.net>
Subject: Re: [PATCH] ieee80211: cleanup double word in comment
From:   Johannes Berg <johannes@sipsolutions.net>
To:     trix@redhat.com
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 25 Jan 2022 19:19:39 +0100
In-Reply-To: <20220125180735.1123792-1-trix@redhat.com>
References: <20220125180735.1123792-1-trix@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-01-25 at 10:07 -0800, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Remove the second 'that'.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  include/linux/ieee80211.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
> index 559b6c6449384..5475383936f8b 100644
> --- a/include/linux/ieee80211.h
> +++ b/include/linux/ieee80211.h
> @@ -467,7 +467,7 @@ static inline bool ieee80211_is_data_qos(__le16 fc)
>  static inline bool ieee80211_is_data_present(__le16 fc)
>  {
>  	/*
> -	 * mask with 0x40 and test that that bit is clear to only return true
> +	 * mask with 0x40 and test that bit is clear to only return true
>  	 * for the data-containing substypes.
> 

I don't think it's just a duplicate?

... and (test that) (that bit is clear to ...)

no?

johannes
