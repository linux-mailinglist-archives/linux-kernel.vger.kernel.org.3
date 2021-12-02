Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1046B4660A8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 10:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356581AbhLBJvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 04:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345962AbhLBJvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 04:51:24 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343EAC06174A;
        Thu,  2 Dec 2021 01:48:02 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id i5so58367833wrb.2;
        Thu, 02 Dec 2021 01:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=758P/IaoZ9hWNIWUREsIatDsLPmQd5ti7yap9+rPwpU=;
        b=W1AFEQ2lt6YOQr85juZ57+l9kCo54Y+j9yJB2ofNcyJnG5RTHxSDmxYju4mepX69wi
         cj/xETlibdQw+nh4Rfk+R9M4LeaC0SAObPBhLTYyBZGlZo/24AWYhDdq1TP/9C8VJs9o
         jPGj0izy5OA24X1iE+g0MHSXGmjvejq2IeZtlGTN6YxwvETaA+l/b5Wkq1zig8CGu47Z
         eLn2WKF0yHGkuuceEbPMZbrxKQJYBmaYHVYRMVW1+KZ5ZCVn+WJunSszB/GXsi91nrq+
         TcfsQSD0F+evyC5lrqF7vbDFV2UsnqKhMcue5GyIOvs5qXzhylT1vSe7RrnN0SU1XdFt
         Dv3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=758P/IaoZ9hWNIWUREsIatDsLPmQd5ti7yap9+rPwpU=;
        b=34Z1a/tCEEYZ/bmgweLq5zckpBNxZg/w0E4g3yXcgRPZAZbSTNNGgayihaC7j/ZXTE
         PkDZHcGDgTuIltcTE9ghf8DaWdqNzTCj3cAHAqzASy3sQ1i8EZ8TRXq3Ykqfwd+UEpDH
         I7eE3xoigimPxvztoZO9NFITQtMch/61bfu2ZzcE3cSFdLSiRd5J11Z64ecZHEQmWwM2
         9sTmhAm6q5zgCty2WVvHKSDeIZP8MhVlGhe/P/jOW28PAgjyIrPR0N9R9YALxtM0vW6t
         mMl5xlNo8tMY+501E18vsF1mcFXv0vaGgXDmDBtDgTOcUrlM3G9yBnaehYelwEiedFBl
         f/9w==
X-Gm-Message-State: AOAM5338ruqmswyTSZ8X6bhXm0zWTRkWWGChX1xSmwPGeblx/46QtlW9
        2QhNIsr6HfeKR2ZFqy65e1096wTHNq4=
X-Google-Smtp-Source: ABdhPJwXWoIlJP098/ORKHgYZYKpH+TxKDyd+A2hwBKy3ZXPZ7K/njWuQU5gXOAUss4KHPSBKs9r2Q==
X-Received: by 2002:a5d:648e:: with SMTP id o14mr13065220wri.141.1638438480717;
        Thu, 02 Dec 2021 01:48:00 -0800 (PST)
Received: from [192.168.0.14] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id d1sm2015924wrz.92.2021.12.02.01.48.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 01:48:00 -0800 (PST)
Subject: Re: [PATCH] media: i2c: Fix inconsistent indenting
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1638434358-47417-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <4803fe17-fdce-dbcc-99e7-29e0715dfee9@gmail.com>
Date:   Thu, 2 Dec 2021 09:47:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1638434358-47417-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiapeng


Thanks for catching that

On 02/12/2021 08:39, Jiapeng Chong wrote:
> Eliminate the follow smatch warning:
>
> drivers/media/i2c/ov8865.c:2841 ov8865_get_selection() warn:
> inconsistent indenting.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>


Reviewed-by: Daniel Scally <djrscally@gmail.com>

> ---
>  drivers/media/i2c/ov8865.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/media/i2c/ov8865.c b/drivers/media/i2c/ov8865.c
> index ebdb20d..09ba13f 100644
> --- a/drivers/media/i2c/ov8865.c
> +++ b/drivers/media/i2c/ov8865.c
> @@ -2836,8 +2836,7 @@ static int ov8865_get_selection(struct v4l2_subdev *subdev,
>  	switch (sel->target) {
>  	case V4L2_SEL_TGT_CROP:
>  		mutex_lock(&sensor->mutex);
> -			__ov8865_get_pad_crop(sensor, state, sel->pad,
> -					      sel->which, &sel->r);
> +		__ov8865_get_pad_crop(sensor, state, sel->pad, sel->which, &sel->r);
>  		mutex_unlock(&sensor->mutex);
>  		break;
>  	case V4L2_SEL_TGT_NATIVE_SIZE:
