Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72D8A4898C3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 13:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245617AbiAJMka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 07:40:30 -0500
Received: from ewsoutbound.kpnmail.nl ([195.121.94.170]:20312 "EHLO
        ewsoutbound.kpnmail.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245599AbiAJMkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 07:40:22 -0500
X-KPN-MessageId: 49c0b24c-7212-11ec-8a6e-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id 49c0b24c-7212-11ec-8a6e-005056ab378f;
        Mon, 10 Jan 2022 13:39:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xs4all.nl; s=xs4all01;
        h=content-type:from:to:subject:mime-version:date:message-id;
        bh=5bMvCXASKVUJLOZ8Tc7NVRK0U2of//0ULKMbwnyU91A=;
        b=ehH/GN/kyFMCE8IIQxXjHKRptC1r/ZCkBkgxvKY97sovIdrzejseAd30AmsmfZqfo9ZB2neE4N5R3
         S+yzRT2RSUDZfHlGcuAr24uZ5obngEsbSouKbfCOAjGJcbx7rfSVFa7DmTAGOw+ket3gxQ2szYIJ+k
         cmBW09uJjYXD1rM41J8ttVvMy1/Pc8j8vVsrUyT3FFEJrjOaFFpCuyiaqXDj2he0sYIroN8ty0sjIP
         QzlgTesSpWvcXOJbXWRzKQuZbQemhZemQvsc8T8+ParuGM0iNh6u1qhavWxZkhyPbx4jo9XEMBe5gH
         R3dtqGqsFA9l0eFuaJ9xoFn28JBN9QQ==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|Xf5pKF5m1O9e2CiYNT2VVG6YzuaVBHwd1lVNDxGKvFrlhBUpl4amJaY4S6UDNQM
 4RQwK09gBcHa9ZiggfpaPXg==
X-Originating-IP: 193.91.129.219
Received: from [192.168.2.10] (cdb815bc1.dhcp.as2116.net [193.91.129.219])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id 76943686-7212-11ec-b76f-005056ab7584;
        Mon, 10 Jan 2022 13:40:17 +0100 (CET)
Message-ID: <8d40e5a1-d50e-6814-ea51-fd6e1fc9e956@xs4all.nl>
Date:   Mon, 10 Jan 2022 13:40:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.1
Subject: Re: [PATCH platform-next] media/platform: remove redundant bpp
 variable
Content-Language: en-US
To:     cgel.zte@gmail.com, prabhakar.csengg@gmail.com
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20211215060339.441820-1-chi.minghao@zte.com.cn>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20211215060339.441820-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Minghao Chi,

Please mention the driver in the subject, so: 'media/platform/am437x:'

Also your Signed-off-by email differs from the one you posted from, please
keep them the same.

Regards,

	Hans

On 15/12/2021 07:03, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Return value directly instead of taking this in another
> redundant variable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  drivers/media/platform/am437x/am437x-vpfe.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/platform/am437x/am437x-vpfe.c b/drivers/media/platform/am437x/am437x-vpfe.c
> index 2dfae9bc0bba..dc3ef0708f14 100644
> --- a/drivers/media/platform/am437x/am437x-vpfe.c
> +++ b/drivers/media/platform/am437x/am437x-vpfe.c
> @@ -143,13 +143,12 @@ static unsigned int __get_bytesperpixel(struct vpfe_device *vpfe,
>  {
>  	struct vpfe_subdev_info *sdinfo = vpfe->current_subdev;
>  	unsigned int bus_width = sdinfo->vpfe_param.bus_width;
> -	u32 bpp, bus_width_bytes, clocksperpixel;
> +	u32 bus_width_bytes, clocksperpixel;
>  
>  	bus_width_bytes = ALIGN(bus_width, 8) >> 3;
>  	clocksperpixel = DIV_ROUND_UP(fmt->bitsperpixel, bus_width);
> -	bpp = clocksperpixel * bus_width_bytes;
>  
> -	return bpp;
> +	return clocksperpixel * bus_width_bytes;
>  }
>  
>  /*  Print Four-character-code (FOURCC) */

