Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A37E4A711A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 13:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344231AbiBBMyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 07:54:46 -0500
Received: from meesny.iki.fi ([195.140.195.201]:59698 "EHLO meesny.iki.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233535AbiBBMyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 07:54:44 -0500
Received: from hillosipuli.retiisi.eu (89-27-103-169.bb.dnainternet.fi [89.27.103.169])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id 8A1D020071;
        Wed,  2 Feb 2022 14:54:41 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1643806481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r0d4BfzJzIMCEfZztp3eu1A5yIM0C5PoqgkaW6Z2irY=;
        b=uXrnP+GMBJuGqTlrLjB9mmbOk4ge/M6EfvCji15Qm4PTyvn759Eurn8HihI8Er/4KPQstC
        d0mYB4/0GuUgwvEgpS86A1/g6qgSIeXk6xalC0CLQpV403uSt1wGzxEF21hq/4AaO36iN5
        KPcE9NEtygFWOd12RY9CvT919OSX1Ik=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 0DCCB634C90;
        Wed,  2 Feb 2022 14:54:41 +0200 (EET)
Date:   Wed, 2 Feb 2022 14:54:40 +0200
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Luiz Sampaio <sampaio.ime@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH 12/31] media: v4l2-core: changing LED_* from enum
 led_brightness to actual value
Message-ID: <Yfp/EF3oR594Dt3Y@valkosipuli.retiisi.eu>
References: <20220121165436.30956-1-sampaio.ime@gmail.com>
 <20220121165436.30956-13-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121165436.30956-13-sampaio.ime@gmail.com>
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1643806481; a=rsa-sha256; cv=none;
        b=GtQ7mwoVUP78Eum5wzMBrwemADqkdKB176xlcTsMF/P6ARxEy6+PGvdSukdIfTHztiSXsB
        XbF5KhBB7lTwWk2qTmlWv7EWEJrVEnicxrSxhwXJfDaDadBJjmnOYvScblydM5w6ckcr9G
        /5Qb3B8Z+vgj9KNpWKzzwhjmfZLKkaE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1643806481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r0d4BfzJzIMCEfZztp3eu1A5yIM0C5PoqgkaW6Z2irY=;
        b=u0RH96fY2diP2meBBTiWuYa5odtkzGAz8H3ohPRN3mYdqRK9WCelApZoNN3K0IRDy/zCeu
        Z9B3VEGlVfD7CCYNKul3xpor/s/d8Ijj5uBBdeTBzc4HAOjCmtuqBleb6ABIUGvy6ErsBH
        3OiO2wQ7neqFTCQqF8g5Qh1VNIM2dec=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luiz,

On Fri, Jan 21, 2022 at 01:54:17PM -0300, Luiz Sampaio wrote:
> The enum led_brightness, which contains the declaration of LED_OFF,
> LED_ON, LED_HALF and LED_FULL is obsolete, as the led class now supports
> max_brightness.

The set appears to be missing the Signed-off-by: line, at least in the
three patches cc'd to the linux-media list.

With this fixed, for this patch:

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

> ---
>  drivers/media/v4l2-core/v4l2-flash-led-class.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-flash-led-class.c b/drivers/media/v4l2-core/v4l2-flash-led-class.c
> index e70e128ccc9c..a47ac654c9f4 100644
> --- a/drivers/media/v4l2-core/v4l2-flash-led-class.c
> +++ b/drivers/media/v4l2-core/v4l2-flash-led-class.c
> @@ -234,11 +234,11 @@ static int v4l2_flash_s_ctrl(struct v4l2_ctrl *c)
>  	case V4L2_CID_FLASH_LED_MODE:
>  		switch (c->val) {
>  		case V4L2_FLASH_LED_MODE_NONE:
> -			led_set_brightness_sync(led_cdev, LED_OFF);
> +			led_set_brightness_sync(led_cdev, 0);
>  			return led_set_flash_strobe(fled_cdev, false);
>  		case V4L2_FLASH_LED_MODE_FLASH:
>  			/* Turn the torch LED off */
> -			led_set_brightness_sync(led_cdev, LED_OFF);
> +			led_set_brightness_sync(led_cdev, 0);
>  			if (ctrls[STROBE_SOURCE]) {
>  				external_strobe = (ctrls[STROBE_SOURCE]->val ==
>  					V4L2_FLASH_STROBE_SOURCE_EXTERNAL);

-- 
Regards,

Sakari Ailus
