Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06065ADB6E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 00:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbiIEWa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 18:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiIEWa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 18:30:56 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE77B5721D;
        Mon,  5 Sep 2022 15:30:54 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id t3so4472756ply.2;
        Mon, 05 Sep 2022 15:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=GwpPK52gty2lVuCMSTyocNI8/6nYJEtP0WerI0I4//E=;
        b=brL28v89EROz4vRPsSnUFxP1NmTWbxhtQpkAXXNMAp8zCy5054+KMW1Omw+GUDg3Nr
         f3RHtqrFUIj3JBJpnvyiAGuXiDRE81rdxUlwM7LWh43R96NpfNroucIPNUtHdcvnOCWW
         BvDxxHnM3npq1G8K33jc/X4yfAGUPMvjOoya173UzBuUERrRN3+waNKzOTJU/FsKqT2M
         o53WtRn1yhcKuInNIATDwq+Mxlcw8YsFgjjir3hgdPZiCxuctCkPa350an5S0r9vxt6M
         nRKpesONRFxiEWwM1lMtSsYuWToeDsKWqVGfyHO7IQeUGjwIWLQelrwzWvm++/8nFAp6
         wHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=GwpPK52gty2lVuCMSTyocNI8/6nYJEtP0WerI0I4//E=;
        b=wGJNE8ToZKTUn0Ubz9KWJ/N2BcHTnm294fT3Ntv3cB75ws8mBYnOm76vIK2GvUn+Kc
         TQVivRid835SJr7HrgiKi62ox1TKtGU4bF+pZ1lpjhr8bDiWyKMRv+z/uMa6nJ2ShNho
         97y335ISpD5OX36X45NdhhkOze50tHzZ4LqoiToHJGlIhixxcQBeDrq5zkUYz2URx/bv
         UrJEctGBJAcyeMGoW+7vrhWoYQkrGtxj8f374fQ5BFI7pgVCMnMxCWlvxMI7DrVWBDkD
         /pGp/Kn1By7tzURFh17i8qBSraudzSaueZaz37/S1RwbKmQ99F7KeErrJyVIuT0zQpH9
         erMg==
X-Gm-Message-State: ACgBeo05e6Sv+6+vdPcdFoiqlZ/JFd3vBGpQBkrYxsl36twLFDIbHXK7
        tphJlDzEREMpXHt9Q5/ivdY=
X-Google-Smtp-Source: AA6agR5/iIyEE5nrF+ndc+fBQLPTZjzK2u4MfRNifsftgyeDIg0735ABwSirpODG9xEu2Nzs7/XCXw==
X-Received: by 2002:a17:902:7fc2:b0:16e:f2f5:3764 with SMTP id t2-20020a1709027fc200b0016ef2f53764mr51381640plb.122.1662417054408;
        Mon, 05 Sep 2022 15:30:54 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u10-20020a62d44a000000b0053653c6b9f9sm8333944pfl.204.2022.09.05.15.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 15:30:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 5 Sep 2022 15:30:52 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, robert.marko@sartura.hr,
        luka.perkov@sartura.hr, jdelvare@suse.com, dev@aboehler.at,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] hwmon: (tps23861) create unique debugfs directory
 per device
Message-ID: <20220905223052.GA3695291@roeck-us.net>
References: <20220905142806.110598-1-mr.nuke.me@gmail.com>
 <20220905142806.110598-3-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905142806.110598-3-mr.nuke.me@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 09:28:06AM -0500, Alexandru Gagniuc wrote:
> On systems with more than one tps23861, creating the debugfs directory
> for additional devices fails with
> 
>     debugfs: Directory 'tps23861' with parent '/' already present!
> 
> To resolve this, include the hwmon device name in the directory name.
> Since the name is unique, this guarantees that the debugfs directory
> is unique.
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>

For my reference:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/hwmon/tps23861.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/tps23861.c b/drivers/hwmon/tps23861.c
> index 0dbd12060b50..3e9df72702c0 100644
> --- a/drivers/hwmon/tps23861.c
> +++ b/drivers/hwmon/tps23861.c
> @@ -503,9 +503,17 @@ static int tps23861_port_status_show(struct seq_file *s, void *data)
>  
>  DEFINE_SHOW_ATTRIBUTE(tps23861_port_status);
>  
> -static void tps23861_init_debugfs(struct tps23861_data *data)
> +static void tps23861_init_debugfs(struct tps23861_data *data,
> +				  struct device *hwmon_dev)
>  {
> -	data->debugfs_dir = debugfs_create_dir(data->client->name, NULL);
> +	const char *debugfs_name;
> +
> +	debugfs_name = devm_kasprintf(&data->client->dev, GFP_KERNEL, "%s-%s",
> +				      data->client->name, dev_name(hwmon_dev));
> +	if (!debugfs_name)
> +		return;
> +
> +	data->debugfs_dir = debugfs_create_dir(debugfs_name, NULL);
>  
>  	debugfs_create_file("port_status",
>  			    0400,
> @@ -554,7 +562,7 @@ static int tps23861_probe(struct i2c_client *client)
>  	if (IS_ERR(hwmon_dev))
>  		return PTR_ERR(hwmon_dev);
>  
> -	tps23861_init_debugfs(data);
> +	tps23861_init_debugfs(data, hwmon_dev);
>  
>  	return 0;
>  }
