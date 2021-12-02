Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885F9466580
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 15:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358657AbhLBOoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 09:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbhLBOoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 09:44:08 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629F1C06174A;
        Thu,  2 Dec 2021 06:40:46 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id r26so55808045oiw.5;
        Thu, 02 Dec 2021 06:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JzjMw6Bxg74ODBmRNh64G8wfqH9GoiId/mAlE/vVMDY=;
        b=oZhW11CRVWpdVd7awXzzSqJKsouCjsdhVo+44hQ+g8stK0yY+85tMz4TQX7dls4TX+
         02hVQ1UvbSxyJZ4pwUWQM2Z8CCRnDHhQN99qXCZ0bRgxJYTA7jsrvu7v1NDM74Pm1EKE
         XBErasK5aQk493CGiOIObz1or6flLZQ9iSghKQ03fxYI0gdq/e1PTaAJw48bWVQ/s6jT
         xKAkiSgWUYSAfjWL6x0VAZiEh1871BrXrAepLplNW2WZIy1axxlMgQi1Cd1tWJMfdown
         Hd7Kr9ws2wrw+SzHtYuaZGa6XH1JX3/Y6oSZNzxrXUgSI8uXDceRorxluRF+ZkCRiI0I
         lGVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=JzjMw6Bxg74ODBmRNh64G8wfqH9GoiId/mAlE/vVMDY=;
        b=bnC72yK8wxPI2nN83uOf8H3XoTI8RUEH9dHtPWQoBE3SjE9baCsznW+kppL+y8e7uE
         AcuzXMlvMeCoLNxZ2zMgtxoBzuCf+QfE+n8yXWMnFgUOtcKZ0ScmVc1Ps4rfJENRpmr8
         V/fTqKkwRckMtIzVgvOsbAlu8knYomSdV8TCX1d6ZK50kCjOHnNeBmwf9knR1vXpFGOJ
         Hj//0dF+kLbfpFEfvAz3DgARfNIWCMQxfGAdtmskm9OE7s4No4+2JzDRJbuofPZGEYgK
         TznHz3L/HOCcCUibtfkOZt2vrUjYliycj5mThPnnwBelgW/o+5sCQUwsihxXCjfaVEwQ
         Vv7w==
X-Gm-Message-State: AOAM533Yxg+qzAfh99WQXe/gXqydiQ8JW3TZjpegg8IgDT8FepmiGQ58
        wJqmLyJsgqQDsilZudqeAMI=
X-Google-Smtp-Source: ABdhPJyLWBNRI1o+GL8ue6SURuIQkxXT2NUjFmtnAeYDba7Xcg/6gwo4HrkRVhIH5Gud+60Zq7m7AA==
X-Received: by 2002:aca:3642:: with SMTP id d63mr4515126oia.95.1638456045810;
        Thu, 02 Dec 2021 06:40:45 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w19sm10787oih.44.2021.12.02.06.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 06:40:45 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 2 Dec 2021 06:40:43 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andrej Picej <andrej.picej@norik.com>
Cc:     support.opensource@diasemi.com, linux-watchdog@vger.kernel.org,
        wim@linux-watchdog.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/4] mfd: da9062: make register CONFIG_I writable
Message-ID: <20211202144043.GA828760@roeck-us.net>
References: <20211202093230.3951996-1-andrej.picej@norik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202093230.3951996-1-andrej.picej@norik.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 10:32:27AM +0100, Andrej Picej wrote:
> From: Stefan Christ <s.christ@phytec.de>
> 
> Make the config register CONFIG_I writable to change the watchdog mode.
> 
> Signed-off-by: Stefan Christ <s.christ@phytec.de>
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Chnages in v4:
>  - no changes
> 
> Changes in v3:
>  - no chagnes
> 
> Changes in v2:
>  - no changes
> ---
>  drivers/mfd/da9062-core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
> index 01f8e10dfa55..7041ba53efb4 100644
> --- a/drivers/mfd/da9062-core.c
> +++ b/drivers/mfd/da9062-core.c
> @@ -556,6 +556,7 @@ static const struct regmap_range da9062_aa_writeable_ranges[] = {
>  	regmap_reg_range(DA9062AA_VBUCK3_B, DA9062AA_VBUCK3_B),
>  	regmap_reg_range(DA9062AA_VLDO1_B, DA9062AA_VLDO4_B),
>  	regmap_reg_range(DA9062AA_BBAT_CONT, DA9062AA_BBAT_CONT),
> +	regmap_reg_range(DA9062AA_CONFIG_I, DA9062AA_CONFIG_I),
>  	regmap_reg_range(DA9062AA_GP_ID_0, DA9062AA_GP_ID_19),
>  };
>  
> -- 
> 2.25.1
> 
