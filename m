Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4862C46BB00
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 13:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236332AbhLGM2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 07:28:31 -0500
Received: from meesny.iki.fi ([195.140.195.201]:50278 "EHLO meesny.iki.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231962AbhLGM2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 07:28:30 -0500
Received: from hillosipuli.retiisi.eu (89-27-103-169.bb.dnainternet.fi [89.27.103.169])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id BA20420054;
        Tue,  7 Dec 2021 14:24:53 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1638879893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cas7ci08rTbBx556E3jwiGUlOxjhK3fn+BcQ2dXZit0=;
        b=qVvNEQhngj9h9y/k871Mtr+5SZ8gXL1Pre0QeKnqeOFenRhE7eppRv6eR0ZO3QVlbscHGs
        HzIXSShBd7mqpQr3y/QAw27TE7IuBxiSITKbrVKzaL9UNw+5I29ZhWNT7Kz9Mzpb/LfCgA
        ArppRL9d5mCtzaZaRy7FLAhKLfulWDo=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id E8906634C90;
        Tue,  7 Dec 2021 14:24:52 +0200 (EET)
Date:   Tue, 7 Dec 2021 14:24:52 +0200
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Joe Perches <joe@perches.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] media: i2c: ov8865: Neaten unnecessary indentation
Message-ID: <Ya9SlGo5HZpOXTmZ@valkosipuli.retiisi.eu>
References: <c6189daaac183ddf51da1444c597d8577c1ac416.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6189daaac183ddf51da1444c597d8577c1ac416.camel@perches.com>
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1638879893; a=rsa-sha256; cv=none;
        b=tQj+QrtOXTVsT2T0ySVMtAAPlz4rSLyGImvPjvzuZTw7qk2AnqBm7vY2NnMpz3hiZaPvXe
        q+MYfWHt0u/2n5u+WfkLvqaCtjr3zODKcLugGCIGeH/Mue56IqTMvO45JIOM97HknzG2gM
        QVLyEWW8eLEsbwW5xEgSx0a2kvHV4b4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1638879893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cas7ci08rTbBx556E3jwiGUlOxjhK3fn+BcQ2dXZit0=;
        b=haLON3qhLaYNajGv13pJEm6frwbadAXQzn0FmXetpYg6OGd9jmDKhUCUfMWN4vjJGitW1X
        4dSzh38Y/czYlBfE84pes61k+JhuJ622GNWtDAc4vY3efERlPnatHp9zH/4cUgemejBDjG
        xVzUGYl7jqH0jZlFAqcvtwcry3MMNW0=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe (and Paul),

On Thu, Dec 02, 2021 at 01:06:01AM -0800, Joe Perches wrote:
> Jumping to the start of a labeled else block isn't typical.
> 
> Unindent the code by reversing the test and using a goto instead.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/media/i2c/ov8865.c | 81 +++++++++++++++++++++++-----------------------
>  1 file changed, 41 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/media/i2c/ov8865.c b/drivers/media/i2c/ov8865.c
> index ebdb20d3fe9d8..7ef83a10f586f 100644
> --- a/drivers/media/i2c/ov8865.c
> +++ b/drivers/media/i2c/ov8865.c
> @@ -2396,56 +2396,57 @@ static int ov8865_sensor_init(struct ov8865_sensor *sensor)
>  
>  static int ov8865_sensor_power(struct ov8865_sensor *sensor, bool on)
>  {
> -	/* Keep initialized to zero for disable label. */
> -	int ret = 0;
> +	int ret;
>  
> -	if (on) {
> -		gpiod_set_value_cansleep(sensor->reset, 1);
> -		gpiod_set_value_cansleep(sensor->powerdown, 1);
> +	if (!on) {
> +		ret = 0;
> +		goto disable;
> +	}
>  
> -		ret = regulator_enable(sensor->dovdd);
> -		if (ret) {
> -			dev_err(sensor->dev,
> -				"failed to enable DOVDD regulator\n");
> -			goto disable;

I guess this patch is fine as such but there seems to be a problem in error
handling here: all regulators are disabled if there's a problem enabling
one of them.

Would it be possible to fix this as well?

> -		}
> +	gpiod_set_value_cansleep(sensor->reset, 1);
> +	gpiod_set_value_cansleep(sensor->powerdown, 1);
>  
> -		ret = regulator_enable(sensor->avdd);
> -		if (ret) {
> -			dev_err(sensor->dev,
> -				"failed to enable AVDD regulator\n");
> -			goto disable;
> -		}
> +	ret = regulator_enable(sensor->dovdd);
> +	if (ret) {
> +		dev_err(sensor->dev, "failed to enable DOVDD regulator\n");
> +		goto disable;
> +	}
>  
> -		ret = regulator_enable(sensor->dvdd);
> -		if (ret) {
> -			dev_err(sensor->dev,
> -				"failed to enable DVDD regulator\n");
> -			goto disable;
> -		}
> +	ret = regulator_enable(sensor->avdd);
> +	if (ret) {
> +		dev_err(sensor->dev, "failed to enable AVDD regulator\n");
> +		goto disable;
> +	}
>  
> -		ret = clk_prepare_enable(sensor->extclk);
> -		if (ret) {
> -			dev_err(sensor->dev, "failed to enable EXTCLK clock\n");
> -			goto disable;
> -		}
> +	ret = regulator_enable(sensor->dvdd);
> +	if (ret) {
> +		dev_err(sensor->dev, "failed to enable DVDD regulator\n");
> +		goto disable;
> +	}
> +
> +	ret = clk_prepare_enable(sensor->extclk);
> +	if (ret) {
> +		dev_err(sensor->dev, "failed to enable EXTCLK clock\n");
> +		goto disable;
> +	}
>  
> -		gpiod_set_value_cansleep(sensor->reset, 0);
> -		gpiod_set_value_cansleep(sensor->powerdown, 0);
> +	gpiod_set_value_cansleep(sensor->reset, 0);
> +	gpiod_set_value_cansleep(sensor->powerdown, 0);
> +
> +	/* Time to enter streaming mode according to power timings. */
> +	usleep_range(10000, 12000);
> +
> +	return 0;
>  
> -		/* Time to enter streaming mode according to power timings. */
> -		usleep_range(10000, 12000);
> -	} else {
>  disable:
> -		gpiod_set_value_cansleep(sensor->powerdown, 1);
> -		gpiod_set_value_cansleep(sensor->reset, 1);
> +	gpiod_set_value_cansleep(sensor->powerdown, 1);
> +	gpiod_set_value_cansleep(sensor->reset, 1);
>  
> -		clk_disable_unprepare(sensor->extclk);
> +	clk_disable_unprepare(sensor->extclk);
>  
> -		regulator_disable(sensor->dvdd);
> -		regulator_disable(sensor->avdd);
> -		regulator_disable(sensor->dovdd);
> -	}
> +	regulator_disable(sensor->dvdd);
> +	regulator_disable(sensor->avdd);
> +	regulator_disable(sensor->dovdd);
>  
>  	return ret;
>  }
> 
> 

-- 
Kind regards,

Sakari Ailus
