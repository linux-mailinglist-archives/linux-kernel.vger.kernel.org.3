Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7DC46C1C9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 18:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240013AbhLGRe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 12:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhLGRe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 12:34:27 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D81C061574;
        Tue,  7 Dec 2021 09:30:56 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id p2-20020a4adfc2000000b002c2676904fdso5603008ood.13;
        Tue, 07 Dec 2021 09:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UfRFcZhTqwVLVt7r2zueC/pU4lBh0hExXO/ZORo48wQ=;
        b=owALHfLYmXossbIFvZDrUvt/Rivjzm1yU1ECHuCrg8uTANH2C+BbYxOMFrDmaceRyP
         PNALtgmYczTPG4KqhsKYOkhCFRfPvp65jXNeeoUJp778fcE93b9uLmQehgNtEB/Katdl
         9IM973tgVDhBfW0ATYwvf4SAp3uRH3se6A27oEN4fGjkI+7XdR5SAfMgP727kk7sQeBQ
         oLduWw3VyAdJZmRMgXpulqB52pPbi3EVR+qfRMN2ElVZyyYI4dADkUX9pzbthshY3ayE
         He7MrQOUIvsMXFlNg84Zm/pIFNsnLnJ4nrhVAYzF6EhNHNtat/YJVl6T5LFmbZd2V7bG
         bmug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=UfRFcZhTqwVLVt7r2zueC/pU4lBh0hExXO/ZORo48wQ=;
        b=UYsnBNQYq+l/28M3lk1O0VEDQPagNlwhfrO/QtYubEOKy9PZ8RRiokEvfPjFnvLSqi
         dSFeTcu/9DY+Bx31v9RvvNnmbleQ8y8zISNmpezH1PAt3jZ6FT57sdPne3paYbDebWb9
         KzBo28LvVnvn/WX9PIsXzp++ftZlvr0372WX4mlVL0DEBIputjNetkf5fzhit5wKmL2U
         5AAuZbkOwCpSWH7dy7CyRbaGss0h/MyVDKJUR73I9NLhiArddVhHJngjQ7gt4dXdHP+W
         1deIW8DoM8EygkQeohMHmUwiLOZXQqoI/1Iq8HMR696huETT+ot2Ragt0i2cpV1IWDp/
         XCIw==
X-Gm-Message-State: AOAM530qr8MVFVwK1qGHQf1uwEcjF/iaTu3cQEW0TM7XXdBEuCtyfEVE
        a3RCr6zwg6apxlgT2m7lDWSYa1WZ4yY=
X-Google-Smtp-Source: ABdhPJwIc0LVN4/MQdUZjJdvbi1VBFbGaJdglcFbSsjW5Rcqb43m1YoJc3mtk3uGKYJ9qrw43LmsJA==
X-Received: by 2002:a05:6820:445:: with SMTP id p5mr27603951oou.9.1638898256014;
        Tue, 07 Dec 2021 09:30:56 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h1sm36907otq.45.2021.12.07.09.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 09:30:55 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 7 Dec 2021 09:30:54 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (adm1031): Remove redundant assignment to
 variable range
Message-ID: <20211207173054.GA657431@roeck-us.net>
References: <20211204233155.55454-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211204233155.55454-1-colin.i.king@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 04, 2021 at 11:31:55PM +0000, Colin Ian King wrote:
> Variable range is being initialized with a value that is never read, it
> is being re-assigned in the next statement. The assignment is redundant,
> remove it and initialize range using the second assigned value. Clean up
> the formatting too by adding missing spaces.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/adm1031.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/adm1031.c b/drivers/hwmon/adm1031.c
> index 257ec53ae723..ac841fa3a369 100644
> --- a/drivers/hwmon/adm1031.c
> +++ b/drivers/hwmon/adm1031.c
> @@ -242,9 +242,8 @@ static int FAN_TO_REG(int reg, int div)
>  static int AUTO_TEMP_MAX_TO_REG(int val, int reg, int pwm)
>  {
>  	int ret;
> -	int range = val - AUTO_TEMP_MIN_FROM_REG(reg);
> +	int range = ((val - AUTO_TEMP_MIN_FROM_REG(reg)) * 10) / (16 - pwm);
>  
> -	range = ((val - AUTO_TEMP_MIN_FROM_REG(reg))*10)/(16 - pwm);
>  	ret = ((reg & 0xf8) |
>  	       (range < 10000 ? 0 :
>  		range < 20000 ? 1 :
