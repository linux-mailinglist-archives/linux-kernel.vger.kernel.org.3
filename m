Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4428048139C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 14:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236837AbhL2Nll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 08:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236824AbhL2Nlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 08:41:40 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A88EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 05:41:40 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id k66-20020a1ca145000000b00345fa984108so6058871wme.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 05:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0sGuVmkqcH8hqgemqd7PHlIrPM8GyFTLiClr4fPPrQs=;
        b=eVXzUs+9uKQllccSC9k7JblZyT8q+/GfLSVoTSqb8IbL2xYLKpWAW8eTzcIoRXsI87
         PMjWiyeroKcHyui79FBzYnF+uytpQ6+x9FO6tOiT71LsXFt9mfR83daQOzJv5gMuPO/V
         eBf7OKpH/jcY3PgjH7bYXnrCuc8lJDH97pC6L9Bq3Y9i9iSHxHr9n8PU2M5L+MBm37om
         WbF8j91czjEugRsXOzBRi5oX6d3Xa0yhwKJ0+tL+M0SCGth/j1yHTMX4sAfLFPr4HuuZ
         9FVKIZZSymjF1w5L55B7687oMN+dV4t2WrE8tQvkzZoEPMmC8d49XiZSoE9EL0tAO1gf
         GqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0sGuVmkqcH8hqgemqd7PHlIrPM8GyFTLiClr4fPPrQs=;
        b=WLKdUdVoS1rsWlJbj7PwvVIQDNdwO8yLvZllNdolZA9W2g2T9mpwYNlMASIdHYrlTr
         Ct+IhTDgRLjD1v/jeZiCEXi+8YcgH7efoNLAyca9StyNyWgAsfbRpRsJfTwzVLWRUCwF
         OXCufjTxK+vFoZ/jQm1xtsifaXY5jSrewcIZY+f6DTZLmOj/RBRwv98dTwCJsji4i29S
         sUwZVWGDokLmS7bDjn1dzorELuAA5hgvLPeIZ9opr/asvhgkar8k6PcjSdgA3824DjO9
         5wPwqCBCdhXr9XYJtYUmOReHvl/Ybko4MwJA+2Fp90XlFlOawX5D5cadWR9RgRwBnxY9
         iyag==
X-Gm-Message-State: AOAM533FrSVeu5J0Dpyjlj0fH8EJ1FxbUwCW3Q0geVhtT31dcj7U2ubb
        tH2c8n1UEs3kaivRTU/XR56WcA==
X-Google-Smtp-Source: ABdhPJweRhmciXELIK/wZnyvBXVLSw7bJ70rfv0efmo6XGQY9yuoxpMJiRSU34SZwo3wFc6oHuX5XA==
X-Received: by 2002:a05:600c:214:: with SMTP id 20mr21832175wmi.84.1640785298900;
        Wed, 29 Dec 2021 05:41:38 -0800 (PST)
Received: from google.com ([2.31.167.18])
        by smtp.gmail.com with ESMTPSA id f6sm26112107wmq.6.2021.12.29.05.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 05:41:38 -0800 (PST)
Date:   Wed, 29 Dec 2021 13:41:36 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] mfd: ntxec: Change return type of ntxec_reg8 from __be16
 to u16
Message-ID: <YcxlkGwonpypwRtW@google.com>
References: <20211218152553.744615-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211218152553.744615-1-j.neuschaefer@gmx.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Dec 2021, Jonathan Neuschäfer wrote:

> Register values in NTXEC are big-endian on the I2C bus, but the regmap
> subsystem handles the conversion between CPU-endian and big-endian data
> internally. ntxec_reg8 should thus return u16, not __be16.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  include/linux/mfd/ntxec.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
