Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50030488DF5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 02:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbiAJBLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 20:11:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiAJBL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 20:11:29 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCAFC06173F;
        Sun,  9 Jan 2022 17:11:28 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id t204so17175962oie.7;
        Sun, 09 Jan 2022 17:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F6urcwiu2eUOJWSMLNJN+g7iFfO+F3fQ+xSPdkGivsU=;
        b=i1NboyVOoXP7d8zeEGiKH71dQVdT+b3sik2aZQvmr5V4h/yGFicfqYsFIskErXzgGz
         AAu+ZWCixjtM140UQ59LvHcAGpBJvjEBvISFWBRX+uK9p+dpgE4VhiHCos6otcjyQpU4
         fod9Tth3xnd8EGCLLOgPMNc0eefzXbNkljFdEkJ12UWaaJzFuJ1QutUMvuiv63Oh1/M2
         GC1bIdQzLR989luRb1WH6b7+OcnHXzwEhSnLBCsJxVxBzyiaVRS7Us7U9WulnnXfUfnc
         nBeALM9HSMwcyqHxhLZ25Ruh5dzbwKoMTbXGyLjrz2Kbn2KbE/nZ/Fbvy60lnX2Zgake
         E4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=F6urcwiu2eUOJWSMLNJN+g7iFfO+F3fQ+xSPdkGivsU=;
        b=IXJHA85IJmvmS9TnAIlCSZ9AHmHDdIOV/PdxvbL35pVML/jJuM9OP9JA5OvB8IkKLA
         hTnwRL+SB32M4hOTnimIgTXAGxuxf8AO7+ftqx28Eu+iPhuAGr+SPbGPrRQcYVin+LnF
         AFOqAToGyZd/kWsERoSL3/Ppe2TcYIG/7EHksFKxd8oL5d4iZisQS62/LCB1x+wlfIpb
         YM0ls1OQCmZlQYV1ZiZNRSvAXfw8Q56V4zRHudZhwLVJq6NtKg0B5NWOa03JUB6l6d+c
         Fq71xzlcP+zs+WNkiqi3fzyOVw+h6KHYp/54Ah7eKDgtJC23aNo/udAPjY4DkR2gmlnU
         CT7Q==
X-Gm-Message-State: AOAM530WLsnNbWZvik/EaV/GEHAVWUyaC2PX7/3Lo99vtF+5Xd1BA5E5
        8C3ZPGZ/oDYyzl/xkV1dRv8=
X-Google-Smtp-Source: ABdhPJxpbKB5Y78UBzmf/TRkogz4RExWkq7xaURE9tcac2IeGrvBrM4DUofkEAV3vldfVEfqZ52Fug==
X-Received: by 2002:a05:6808:b0e:: with SMTP id s14mr7521871oij.61.1641777088121;
        Sun, 09 Jan 2022 17:11:28 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o145sm1056686ooo.1.2022.01.09.17.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 17:11:27 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 9 Jan 2022 17:11:25 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Aleksandr Mezin <mezin.alexander@gmail.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] hwmon: nzxt-smart2: make array detect_fans_report
 static const
Message-ID: <20220110011125.GA841668@roeck-us.net>
References: <20220109194558.45811-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220109194558.45811-1-colin.i.king@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 09, 2022 at 07:45:58PM +0000, Colin Ian King wrote:
> Don't populate the read-only array detect_fans_report on the stack but
> instead it static const. Also makes the object code a little smaller.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/nzxt-smart2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/nzxt-smart2.c b/drivers/hwmon/nzxt-smart2.c
> index 6e67da766969..dd892ff5a3e8 100644
> --- a/drivers/hwmon/nzxt-smart2.c
> +++ b/drivers/hwmon/nzxt-smart2.c
> @@ -583,7 +583,7 @@ static int set_update_interval(struct drvdata *drvdata, long val)
>  static int init_device(struct drvdata *drvdata, long update_interval)
>  {
>  	int ret;
> -	u8 detect_fans_report[] = {
> +	static const u8 detect_fans_report[] = {
>  		OUTPUT_REPORT_ID_INIT_COMMAND,
>  		INIT_COMMAND_DETECT_FANS,
>  	};
