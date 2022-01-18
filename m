Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09EA74929F8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 16:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346114AbiARP7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 10:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346095AbiARP7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 10:59:00 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C72CC06161C;
        Tue, 18 Jan 2022 07:59:00 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id i7-20020a9d68c7000000b0059396529af8so18087113oto.4;
        Tue, 18 Jan 2022 07:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6zBK9Ap0MPjjgj20gZD2ZZPJ47JigEwNp1b7g+RZyNk=;
        b=ewamlKh/o6u6/IdyzYPLbpttc9ObpKVou5F73R+/LRh8Bd9dRriL+7mtG22yIlrKzy
         6wRS2zq6NKJelgOkZLvg5LzWnxOamM6c69ep+vW/KeHS2Vbq1gAE7t0wNFYFi1loU0z8
         23T42Y4HWJpk5p+CO9/AD6sJMh5Ucxq5NyeL6GLaW9MbMjweMtAw6x8FEBiNLvTCkIEK
         J6J3HXOVcUclVrZHxx+J0LUbo9eneats9edQJ4i49XbR+uc58j17gEBchNJqo9/26Tsq
         4dbbEHu/7yLJw6HFLWWLEMaRYH40lD4HpWwj24RBk7iD8c4N0laHIR+HT1xpHf/nP4ve
         eUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=6zBK9Ap0MPjjgj20gZD2ZZPJ47JigEwNp1b7g+RZyNk=;
        b=TCEz1pBxAjfMEPh4lzX3VXlcbS7NU8CgPkcuvZZk9G8PvSKOSC/cRv7+EN7qz9NCD9
         rK0BJpTtaBNiKEy0zoEC6LXZmKu1P7nw7RaS24noWQrYCCXZzCxD7gBVnLFCh5kgWJd7
         Baar+iUixwKcM7l+gk/aNrEa+1H2Kso0lh0GBlUZd2VxyHhMBaGEylXMSarz45xHzlMY
         DQ6j8906m6cQGrLhgwSoa2qNYF8t40LU0lWdA6uTmHqRfHbsexOb4bHugD3ylwRuoxUc
         M64hFB1xNBWOw6zXCw2SmpSvdI29d26hETA3hAUxrJjeQtacBB3LkdJz+Z0JTFTFsWPx
         q//w==
X-Gm-Message-State: AOAM533H4gNpTzOHwtQXVJrN1ss5thxhyj+cI9keLLem21Hhk5d/K69U
        6nYjxN5+O6TfT7oFc950QJ8+xqW7vMM=
X-Google-Smtp-Source: ABdhPJwYvko+oWvGn29Y6w7HoXmhnCowumyb0cXX9LyGbqM9Y/Trvqz2CrsLfveJQLFpRhBp6GC55w==
X-Received: by 2002:a9d:4718:: with SMTP id a24mr19922023otf.381.1642521539721;
        Tue, 18 Jan 2022 07:58:59 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n19sm7003095otq.11.2022.01.18.07.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 07:58:59 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 18 Jan 2022 07:58:57 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Marcello Sylvester Bauer <sylv@sylv.io>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/4] pmbus: remove trailing whitespaces
Message-ID: <20220118155857.GA4114390@roeck-us.net>
References: <cover.1642434222.git.sylv@sylv.io>
 <c984b88b136a1cde16ce52c5f818886653b0f84a.1642434222.git.sylv@sylv.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c984b88b136a1cde16ce52c5f818886653b0f84a.1642434222.git.sylv@sylv.io>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 05:12:49PM +0100, Marcello Sylvester Bauer wrote:
> Fix checkpatch issues by removing trailing whitespaces in Kconfig.
> 
> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>

Applied, after updating Kconfig file. No need to resend.

> ---
>  drivers/hwmon/pmbus/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index 41f6cbf96d3b..c96f7b7338bd 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -189,8 +189,8 @@ config SENSORS_LTC2978_REGULATOR
>  	depends on SENSORS_LTC2978 && REGULATOR
>  	help
>  	  If you say yes here you get regulator support for Linear Technology
> -	  LTC3880, LTC3883, LTC3884, LTC3886, LTC3887, LTC3889, LTC7880, 
> -	  LTM4644, LTM4675, LTM4676, LTM4677, LTM4678, LTM4680, LTM4686, 
> +	  LTC3880, LTC3883, LTC3884, LTC3886, LTC3887, LTC3889, LTC7880,
> +	  LTM4644, LTM4675, LTM4676, LTM4677, LTM4678, LTM4680, LTM4686,
>  	  and LTM4700.
>  
>  config SENSORS_LTC3815
