Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6873F48C0E1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 10:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352028AbiALJTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 04:19:17 -0500
Received: from ewsoutbound.kpnmail.nl ([195.121.94.169]:59836 "EHLO
        ewsoutbound.kpnmail.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352017AbiALJTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 04:19:13 -0500
X-KPN-MessageId: 1af97a8a-7388-11ec-9abf-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id 1af97a8a-7388-11ec-9abf-005056abad63;
        Wed, 12 Jan 2022 10:14:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xs4all.nl; s=xs4all01;
        h=content-type:from:to:subject:mime-version:date:message-id;
        bh=80Xnuf+/iThcpJBNS69S+oVOZJ7jCREkb8kOHXYk2IA=;
        b=Ej/7+cC8LTgFiDitvgmUmwXVA/tIkgEKCvae6wC+93S4deu7R21JBChzLjoT0fkyF7vJSKCBJB1Tk
         MUCQBE7H/0TzeEdy32jf9evYakBJocNIYeQfCVfCJLUCZn0VawB9G1nIpoCZ1pja5ClkwmDUMgFiP/
         6G0gWLZmFdH4mldi7UmvbneDHu2dsJs1zw4JA2IXNL0BwSZ3Gmk8abnMf636BgThf22Eoep5uLynmA
         NuatjZOBC0Ey/n+L8hALjp+9yEGTdNDBHs/BsgixjseAx1hFkAD/CKwqe1XqMH6NX+BTn1/LDM/eKy
         b5MYBW+W+cPtoTxNi0Agh0Z0wuAhAqA==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|gPLfQ92tDz6icZdQ+RlXbyM+FItrIh6mTcmPjecTzkpQsZeWXXp+GoBeROtLzyQ
 crZ1LSVI+VgE3j7TOrYye5g==
X-Originating-IP: 193.91.129.219
Received: from [192.168.2.10] (cdb815bc1.dhcp.as2116.net [193.91.129.219])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id b206e82d-7388-11ec-83ab-005056ab1411;
        Wed, 12 Jan 2022 10:19:08 +0100 (CET)
Message-ID: <e5165aa9-4622-72dc-22dd-1077648d7cbf@xs4all.nl>
Date:   Wed, 12 Jan 2022 10:19:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.1
Subject: Re: [PATCH] media: i2c: remove unneeded variable
Content-Language: en-US
To:     cgel.zte@gmail.com, djrscally@gmail.com
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220112091718.668278-1-deng.changcheng@zte.com.cn>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20220112091718.668278-1-deng.changcheng@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/2022 10:17, cgel.zte@gmail.com wrote:
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
> 
> Remove unneeded variable used to store return value.

Please add the driver name in the subject prefix! Why is that so hard to
remember?

Regards,

	Hans

> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
> ---
>  drivers/media/i2c/ov5693.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/i2c/ov5693.c b/drivers/media/i2c/ov5693.c
> index 2784fcf67f3b..a55910f6283a 100644
> --- a/drivers/media/i2c/ov5693.c
> +++ b/drivers/media/i2c/ov5693.c
> @@ -950,7 +950,6 @@ static int ov5693_set_fmt(struct v4l2_subdev *sd,
>  	unsigned int width, height;
>  	unsigned int hblank;
>  	int exposure_max;
> -	int ret = 0;
>  
>  	crop = __ov5693_get_pad_crop(ov5693, state, format->pad, format->which);
>  
> @@ -982,7 +981,7 @@ static int ov5693_set_fmt(struct v4l2_subdev *sd,
>  	format->format = *fmt;
>  
>  	if (format->which == V4L2_SUBDEV_FORMAT_TRY)
> -		return ret;
> +		return 0;
>  
>  	mutex_lock(&ov5693->lock);
>  
> @@ -1012,7 +1011,7 @@ static int ov5693_set_fmt(struct v4l2_subdev *sd,
>  				     exposure_max));
>  
>  	mutex_unlock(&ov5693->lock);
> -	return ret;
> +	return 0;
>  }
>  
>  static int ov5693_get_selection(struct v4l2_subdev *sd,

