Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2948F48E15C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 01:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238344AbiANADT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 19:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiANADR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 19:03:17 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6456C061574;
        Thu, 13 Jan 2022 16:03:16 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id t20so5477159wrb.4;
        Thu, 13 Jan 2022 16:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xeb8BB1cpN1nYesO18sPn85Vpoz+RkUXTsIXMMFImvc=;
        b=bLMZ1TqvvLNFvVAVgBDmouUw9sU3HcZxtVRDKZLokvVnf7LMy6D989YTwRX3/PvpLx
         5qu1sv0Qa+T3TWI1qc+Xa85cCue/erI6zAdqqeVtASYLle3zGfop+2SB0IFgw7RFmDRp
         AdoG+lp8zY9PSI6Je/qrmlsOIsNAgDZIztk2eGGJOcpY8yA8zo6bj2DIsa7cXTxv3PRy
         UQSRWEUngwEN48esjSKHabj1A7zQWxlAWHgk2G05mknlbSz7PdRW4nEqfaP2myULtIkI
         4FsniOeGvClqgQEHgHwgCjN8/VxBQvYx0+LiaEutVOyiUmByv1WUg2Ktf24pHvOGX1Q+
         zCtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xeb8BB1cpN1nYesO18sPn85Vpoz+RkUXTsIXMMFImvc=;
        b=eypxsigtMO6dBHoWmgT780UdMnHvLSZA4X23MZGneK44e/1P5gnHfLIoxLc9+Xsz6s
         LE3AobEUhkPeKs/aYCgpmW8GsjkDEa6bqxXsNkKQdD0tRUC4sWZx8iI1JhYyJg03muyJ
         cXX3EbJAoMT8jQ4bB+U20IoCkEkbhcKua74eqrdFPaMgQSL9cA1Q2l8qnBJXAuzA0DGl
         NfMv5kGjFCQ+1XA/4hOby3xCXc0WbOkxfoQLXzl5PQeeTky+OYDn5T+jp18176aE4WxN
         B0PyJuLAdF4G6VmtaAXBDVhsrG9gJr4nxnHgSZIwzZ5fGpFRP5SWdLDKk0KERpSdyBnU
         2Sbg==
X-Gm-Message-State: AOAM531gUjUBPdk0krEvRuKg0f2o9pbK/RKLVjBoGWn3G8qRMqLX1cRa
        bXetksWdYQhF650q7tzRNKA=
X-Google-Smtp-Source: ABdhPJwChFaDLk5S17TPUC+w1V3JwNw7aGSUYFBfiQbfhdUgKRHNTAL3/JRTGnUMNbKROow1Dmhg0A==
X-Received: by 2002:a05:6000:154a:: with SMTP id 10mr6019554wry.9.1642118595582;
        Thu, 13 Jan 2022 16:03:15 -0800 (PST)
Received: from [192.168.0.16] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id i82sm5169740wma.23.2022.01.13.16.03.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 16:03:15 -0800 (PST)
Subject: Re: [PATCH] media: i2c: remove unneeded variable
To:     cgel.zte@gmail.com
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, hverkuil@xs4all.nl
References: <20220112091718.668278-1-deng.changcheng@zte.com.cn>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <ad934c70-171e-61c1-2ec8-85c7a106c656@gmail.com>
Date:   Fri, 14 Jan 2022 00:03:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220112091718.668278-1-deng.changcheng@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On 12/01/2022 09:17, cgel.zte@gmail.com wrote:
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
> 
> Remove unneeded variable used to store return value.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>

Yeah good catch. With Hans' comment about the subject line addressed:

Reviewed-by: Daniel Scally <djrscally@gmail.com>

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
> 
