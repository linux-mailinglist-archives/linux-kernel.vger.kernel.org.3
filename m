Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4CB462A4F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 03:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237421AbhK3CXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 21:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbhK3CXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 21:23:22 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D045EC061574;
        Mon, 29 Nov 2021 18:20:03 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id w6-20020a9d77c6000000b0055e804fa524so28184714otl.3;
        Mon, 29 Nov 2021 18:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C+xyUhITd9hMveij7HHXygIBOls6mAExEb6UxhOFF6c=;
        b=fR36kPvfVrgNn5CSIpSQ49OFFhADTbIt6wbu8DWNa5OzYhSxIeACvbJNV7vc6UuOY9
         BQONcqv09bt+AQem0IANG9PtvEui0LlDGNJF/q0pxgxGt0fDumESxhhBIBHkzCg01DuN
         gVPw0BiSmWPjZp94gU0IO5v3oWR7vaeaadaDyvd1T1eCxBWZl+7zhrEhtZutmrayvz2R
         wPxnHqWjifD3SmkXuvXiWHJw7Sjq41tEvZ9Qi3LUwpA63gntaj455M7qLHddx1WwDqUn
         tDkEkf9WcgnBpJpQ23XDrDDQfBtLqBNvNjBEELER+VCcaIPYnp+EapivAV0W0lnQri+l
         Q8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=C+xyUhITd9hMveij7HHXygIBOls6mAExEb6UxhOFF6c=;
        b=olEPnERTTNTZ9eowel1yb8mh40yNyJsw1I+GTIEye0kg7A4lT9TTzQjwemZoujs8fk
         nANODrp+nFxvKvbG6QU6RQwVUSOIOXtggjrNjR18cXqptL/W38OBRglY3GsaFe3/xEZ8
         mz24j+i7FngXylHvuqTnq2+KTG+riTmMBSAXXGVtROt4C+yETRHUJm/scqyyq79xstLE
         6bzPP0NCacEvBmnrAJecmFo4nT5MDM9U7GzCo67EyrNHO9p1YALOYovtnd5VDkOa/Ij3
         8N9r9HovZAcNIUKWpDKWl3zyNxIYb8UeFcLIgawm2gkCfAGtbqMz2uOTXttWAXSguExy
         dXNw==
X-Gm-Message-State: AOAM533l7IgX/4hgK+Slb2bwWSbY/UygmrJNainipNHCBJDaSW1jmlLW
        H9CyfIvTgsbRWurIinPR13Nh5r7BJ5s=
X-Google-Smtp-Source: ABdhPJyuvJuXbXhGnQB7FQi4aYt9q/wxImcjYLgxqeZdeewXFkrddkyjxHegzRuhuanusp+im9qWwg==
X-Received: by 2002:a05:6830:2082:: with SMTP id y2mr47241041otq.15.1638238802795;
        Mon, 29 Nov 2021 18:20:02 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g1sm2517650ooq.2.2021.11.29.18.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 18:20:02 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 29 Nov 2021 18:20:00 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     David Mosberger-Tang <davidm@egauge.net>
Cc:     Navin Sankar Velliangiri <navin@linumiz.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (sht4x) Add device tree match table
Message-ID: <20211130022000.GA21721@roeck-us.net>
References: <20211121160637.2312106-1-davidm@egauge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211121160637.2312106-1-davidm@egauge.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 21, 2021 at 04:07:02PM +0000, David Mosberger-Tang wrote:
> This patch enables automatic loading of the sht4x module via a device
> tree table entry.
> 
> Signed-off-by: David Mosberger-Tang <davidm@egauge.net>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/sht4x.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/hwmon/sht4x.c b/drivers/hwmon/sht4x.c
> index 3415d7a0e0fc..6e53d81e32d4 100644
> --- a/drivers/hwmon/sht4x.c
> +++ b/drivers/hwmon/sht4x.c
> @@ -281,9 +281,16 @@ static const struct i2c_device_id sht4x_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, sht4x_id);
>  
> +static const struct of_device_id sht4x_of_match[] = {
> +	{ .compatible = "sensirion,sht4x" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, sht4x_of_match);
> +
>  static struct i2c_driver sht4x_driver = {
>  	.driver = {
>  		.name = "sht4x",
> +		.of_match_table = sht4x_of_match
>  	},
>  	.probe		= sht4x_probe,
>  	.id_table	= sht4x_id,
