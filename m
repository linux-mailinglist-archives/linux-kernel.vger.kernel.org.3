Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8FF49EB05
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 20:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245543AbiA0Taa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 14:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245159AbiA0Ta2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 14:30:28 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0012C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 11:30:27 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id i65so3624681pfc.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 11:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dWOYPATtta3SdfgRslr7oMkios2Wb3j3k3uYNdhOYiY=;
        b=c/mWkQ8Hp4ytjyUneDZtdPE++lVR8/OQeqj5gNB/I2Qml0Up78DoX0IUj+inwzFxEl
         OozFTElhnAPieleGS47hA0Ak9rK7cWtovuNSioY1ElTMzXs0ilz1pCszroMom/ohP9Ug
         2pMnvKlrt8UixFtSVPCRSzZVKJU8vx98zfOGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dWOYPATtta3SdfgRslr7oMkios2Wb3j3k3uYNdhOYiY=;
        b=AUsETSPR/pNIl3j6PfqL5rusrmm9ZHEnQmcq7ndOJ08b2vOsh7rwd7IBj2Od2eszkZ
         xpiT8g7pjDCLhM4+kFLnJ4W3jc6Jd2smt30b0bi8KGr5+MVWA9MhHYQGPqCcnRVsn5Wq
         +cfy4j0CIL2hVtRZXqqqrcfqAojNlgDmZLETvrNZsI6MelMoWKcX3QlKpBUuI9IJokTg
         kDsbr8fnNe4nI2QkpbjD/HFwxd/oqduRjABTteUfIE7QQFsYyzxNXZqeJB/OMg7FUDJM
         MYEMGg3OB23gg6q5UKGZYuKJYNvHoD5olIVaP69L3r5+ncQZ9FqGxSu2AlSsXqcZWVBj
         gmcQ==
X-Gm-Message-State: AOAM531AvdVu5MazNv0GrRZOeZw0at21RUYYd6Rb5lAekW29Hla0R2UI
        LY97MN2HngQXamFSyhDoaFoarQ==
X-Google-Smtp-Source: ABdhPJwLIL8hEw8EGp0GrNA5MjHrkuxfwQ9CJXvYax6VdRw2/hvUey2KwB202sGRs5P8fKnRdhG94A==
X-Received: by 2002:a63:4a65:: with SMTP id j37mr3870744pgl.542.1643311827138;
        Thu, 27 Jan 2022 11:30:27 -0800 (PST)
Received: from chromium.org (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id s17sm6515445pfk.156.2022.01.27.11.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 11:30:26 -0800 (PST)
Date:   Thu, 27 Jan 2022 19:30:25 +0000
From:   Prashant Malani <pmalani@chromium.org>
To:     "Dustin L. Howett" <dustin@howett.net>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Michael Niksa <michael.niksa@live.com>, swboyd@chromium.org
Subject: Re: [PATCH v2 2/2] platform/chrome: cros_ec_lpcs: reserve the MEC
 LPC I/O ports first
Message-ID: <YfLy0fAw/XnQ7g4R@chromium.org>
References: <20220126180020.15873-1-dustin@howett.net>
 <20220126180020.15873-3-dustin@howett.net>
 <YfLqloFQpF7bURGi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfLqloFQpF7bURGi@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot 1 more minor nit:

On Jan 27 18:55, Prashant Malani wrote:
> Hi Dustin,
> 
> On Jan 26 12:00, Dustin L. Howett wrote:
> > Some ChromeOS EC devices (such as the Framework Laptop) only map I/O
> > ports 0x800-0x807. Making the larger reservation required by the non-MEC
> > LPC (the 0xFF ports for the memory map, and the 0xFF ports for the
> > parameter region) is non-viable on these devices.
> > 
> > Since we probe the MEC EC first, we can get away with a smaller
> > reservation that covers the MEC EC ports. If we fall back to classic
> > LPC, we can grow the reservation to cover the memory map and the
> > parameter region.
> > 
> > This patch also fixes an issue where we would interact with I/O ports
> > 0x800-0x807 without first making a reservation.
(borrowing this from swboyd):
$ git grep "This patch" -- Documentation/process

i.e. don't use "This patch"

> > 
> > Signed-off-by: Dustin L. Howett <dustin@howett.net>
> > ---
> >  drivers/platform/chrome/cros_ec_lpc.c         | 39 ++++++++++++-------
> >  .../linux/platform_data/cros_ec_commands.h    |  4 ++
> >  2 files changed, 30 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
> > index 458eb59db2ff..06fdfe365710 100644
> > --- a/drivers/platform/chrome/cros_ec_lpc.c
> > +++ b/drivers/platform/chrome/cros_ec_lpc.c
> > @@ -341,9 +341,14 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
> >  	u8 buf[2];
> >  	int irq, ret;
> >  
> > -	if (!devm_request_region(dev, EC_LPC_ADDR_MEMMAP, EC_MEMMAP_SIZE,
> > -				 dev_name(dev))) {
> > -		dev_err(dev, "couldn't reserve memmap region\n");
> > +	/*
> > +	 * The Framework Laptop (and possibly other non-ChromeOS devices)
> > +	 * only exposes the eight I/O ports that are required for the Microchip EC.
> > +	 * Requesting a larger reservation will fail.
> > +	 */
> > +	if (!devm_request_region(dev, EC_HOST_CMD_REGION0,
> > +				 EC_HOST_CMD_MEC_REGION_SIZE, dev_name(dev))) {
> > +		dev_err(dev, "couldn't reserve MEC region\n");
> >  		return -EBUSY;
> >  	}
> >  
> > @@ -357,6 +362,12 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
> >  	cros_ec_lpc_ops.write = cros_ec_lpc_mec_write_bytes;
> >  	cros_ec_lpc_ops.read(EC_LPC_ADDR_MEMMAP + EC_MEMMAP_ID, 2, buf);
> >  	if (buf[0] != 'E' || buf[1] != 'C') {
> > +		if (!devm_request_region(dev, EC_LPC_ADDR_MEMMAP, EC_MEMMAP_SIZE,
> > +					 dev_name(dev))) {
> > +			dev_err(dev, "couldn't reserve memmap region\n");
> > +			return -EBUSY;
> > +		}
> > +
> >  		/* Re-assign read/write operations for the non MEC variant */
> >  		cros_ec_lpc_ops.read = cros_ec_lpc_read_bytes;
> >  		cros_ec_lpc_ops.write = cros_ec_lpc_write_bytes;
> > @@ -366,17 +377,19 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
> >  			dev_err(dev, "EC ID not detected\n");
> >  			return -ENODEV;
> >  		}
> > -	}
> >  
> > -	if (!devm_request_region(dev, EC_HOST_CMD_REGION0,
> > -				 EC_HOST_CMD_REGION_SIZE, dev_name(dev))) {
> > -		dev_err(dev, "couldn't reserve region0\n");
> > -		return -EBUSY;
> > -	}
> > -	if (!devm_request_region(dev, EC_HOST_CMD_REGION1,
> > -				 EC_HOST_CMD_REGION_SIZE, dev_name(dev))) {
> > -		dev_err(dev, "couldn't reserve region1\n");
> > -		return -EBUSY;
> > +		/* Reserve the remaining I/O ports required by the non-MEC protocol. */
> > +		if (!devm_request_region(dev, EC_HOST_CMD_REGION0 + EC_HOST_CMD_MEC_REGION_SIZE,
> > +					 EC_HOST_CMD_REGION_SIZE - EC_HOST_CMD_MEC_REGION_SIZE,
> > +					 dev_name(dev))) {
> > +			dev_err(dev, "couldn't reserve remainder of region0\n");
> > +			return -EBUSY;
> > +		}
> > +		if (!devm_request_region(dev, EC_HOST_CMD_REGION1,
> > +					 EC_HOST_CMD_REGION_SIZE, dev_name(dev))) {
> > +			dev_err(dev, "couldn't reserve region1\n");
> > +			return -EBUSY;
> > +		}
> >  	}
> >  
> >  	ec_dev = devm_kzalloc(dev, sizeof(*ec_dev), GFP_KERNEL);
> > diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
> > index 271bd87bff0a..a85b1176e6c0 100644
> > --- a/include/linux/platform_data/cros_ec_commands.h
> > +++ b/include/linux/platform_data/cros_ec_commands.h
> > @@ -55,6 +55,10 @@
> >  #define EC_HOST_CMD_REGION0    0x800
> >  #define EC_HOST_CMD_REGION1    0x880
> >  #define EC_HOST_CMD_REGION_SIZE 0x80
> > +/*
> > + * Other machines report only the region spanned by the Microchip MEC EC.
> > + */
> > +#define EC_HOST_CMD_MEC_REGION_SIZE 0x08
> I can't find this update in the EC code base [1]. Is there any reason
> you are not adding this, or is the change in flight (or in some other
> location)?
> 
> [1] https://chromium.googlesource.com/chromiumos/platform/ec/+/refs/heads/main/include/ec_commands.h
> 
> Thanks,
> 
> -Prashant
