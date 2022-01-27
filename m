Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF92949DA9F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 07:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236702AbiA0G3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 01:29:11 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:56104 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbiA0G3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 01:29:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 767C9618A2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 06:29:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB1CC340E4;
        Thu, 27 Jan 2022 06:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643264949;
        bh=/Cfch5JGfw17vv85ScEIPAxMXPLRcI9Qj2bUvQxiDgw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RbzRWEmxUZ/OSO0L5BKoEjtOEivEZle/gKQbgcPAhqt1QwcLDo5BhNeHr4etKnlf7
         GkZwUbV5Hso9cob4/fdLQumXlAqLMJvBgrba0+MHvztmbnznLh/x+KR+o5FfQqg7gb
         YNM0serlcToyNxyCUNJeNRsZB//YqRbAuZX49CHc=
Date:   Thu, 27 Jan 2022 07:29:01 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Aleksa =?utf-8?B?VnXEjWtvdmnEhw==?= <aleksav013@gmail.com>
Cc:     salah.triki@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: dio: Fixed coding style issues
Message-ID: <YfI7rZrYn4liKuPB@kroah.com>
References: <20220126195341.5154-1-aleksav013@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220126195341.5154-1-aleksav013@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 08:53:41PM +0100, Aleksa Vučković wrote:
> Converting tabs to spaces, placing braces on the appropriate lines.
> Deleting unwanted spaces at the end of the lines.
> 
> Signed-off-by: Aleksa Vučković <aleksav013@gmail.com>
> ---
>  drivers/dio/dio.c | 137 +++++++++++++++++++++++-----------------------
>  1 file changed, 67 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/dio/dio.c b/drivers/dio/dio.c
> index 4c06c93c93d3..e693612b305c 100644
> --- a/drivers/dio/dio.c
> +++ b/drivers/dio/dio.c
> @@ -2,27 +2,27 @@
>  /* Code to support devices on the DIO and DIO-II bus
>   * Copyright (C) 05/1998 Peter Maydell <pmaydell@chiark.greenend.org.uk>
>   * Copyright (C) 2004 Jochen Friedrich <jochen@scram.de>
> - * 
> + *
>   * This code has basically these routines at the moment:
>   * int dio_find(u_int deviceid)
>   *    Search the list of DIO devices and return the select code
>   *    of the next unconfigured device found that matches the given device ID.
>   *    Note that the deviceid parameter should be the encoded ID.
> - *    This means that framebuffers should pass it as 
> + *    This means that framebuffers should pass it as
>   *    DIO_ENCODE_ID(DIO_ID_FBUFFER,DIO_ID2_TOPCAT)
>   *    (or whatever); everybody else just uses DIO_ID_FOOBAR.
>   * unsigned long dio_scodetophysaddr(int scode)
>   *    Return the physical address corresponding to the given select code.
>   * int dio_scodetoipl(int scode)
> - *    Every DIO card has a fixed interrupt priority level. This function 
> + *    Every DIO card has a fixed interrupt priority level. This function
>   *    returns it, whatever it is.
>   * const char *dio_scodetoname(int scode)
> - *    Return a character string describing this board [might be "" if 
> + *    Return a character string describing this board [might be "" if
>   *    not CONFIG_DIO_CONSTANTS]
>   * void dio_config_board(int scode)     mark board as configured in the list
>   * void dio_unconfig_board(int scode)   mark board as no longer configured
>   *
> - * This file is based on the way the Amiga port handles Zorro II cards, 
> + * This file is based on the way the Amiga port handles Zorro II cards,
>   * although we aren't so complicated...
>   */
>  #include <linux/module.h>
> @@ -52,38 +52,36 @@ struct dio_bus dio_bus = {
>  /* We associate each numeric ID with an appropriate descriptive string
>   * using a constant array of these structs.
>   * FIXME: we should be able to arrange to throw away most of the strings
> - * using the initdata stuff. Then we wouldn't need to worry about 
> + * using the initdata stuff. Then we wouldn't need to worry about
>   * carrying them around...
> - * I think we do this by copying them into newly kmalloc()ed memory and 
> + * I think we do this by copying them into newly kmalloc()ed memory and
>   * marking the names[] array as .initdata ?
>   */
> -struct dioname
> -{
> -        int id;
> -        const char *name;
> +struct dioname {
> +	int id;
> +	const char *name;
>  };
>  
>  /* useful macro */
>  #define DIONAME(x) { DIO_ID_##x, DIO_DESC_##x }
> -#define DIOFBNAME(x) { DIO_ENCODE_ID( DIO_ID_FBUFFER, DIO_ID2_##x), DIO_DESC2_##x }
> -
> -static struct dioname names[] = 
> -{
> -        DIONAME(DCA0), DIONAME(DCA0REM), DIONAME(DCA1), DIONAME(DCA1REM),
> -        DIONAME(DCM), DIONAME(DCMREM),
> -        DIONAME(LAN),
> -        DIONAME(FHPIB), DIONAME(NHPIB),
> -        DIONAME(SCSI0), DIONAME(SCSI1), DIONAME(SCSI2), DIONAME(SCSI3),
> -        DIONAME(FBUFFER),
> -        DIONAME(PARALLEL), DIONAME(VME), DIONAME(DCL), DIONAME(DCLREM),
> -        DIONAME(MISC0), DIONAME(MISC1), DIONAME(MISC2), DIONAME(MISC3),
> -        DIONAME(MISC4), DIONAME(MISC5), DIONAME(MISC6), DIONAME(MISC7),
> -        DIONAME(MISC8), DIONAME(MISC9), DIONAME(MISC10), DIONAME(MISC11), 
> -        DIONAME(MISC12), DIONAME(MISC13),
> -        DIOFBNAME(GATORBOX), DIOFBNAME(TOPCAT), DIOFBNAME(RENAISSANCE),
> -        DIOFBNAME(LRCATSEYE), DIOFBNAME(HRCCATSEYE), DIOFBNAME(HRMCATSEYE),
> -        DIOFBNAME(DAVINCI), DIOFBNAME(XXXCATSEYE), DIOFBNAME(HYPERION),
> -        DIOFBNAME(XGENESIS), DIOFBNAME(TIGER), DIOFBNAME(YGENESIS)   
> +#define DIOFBNAME(x) { DIO_ENCODE_ID(DIO_ID_FBUFFER, DIO_ID2_##x), DIO_DESC2_##x }
> +
> +static struct dioname names[] = {
> +	DIONAME(DCA0), DIONAME(DCA0REM), DIONAME(DCA1), DIONAME(DCA1REM),
> +	DIONAME(DCM), DIONAME(DCMREM),
> +	DIONAME(LAN),
> +	DIONAME(FHPIB), DIONAME(NHPIB),
> +	DIONAME(SCSI0), DIONAME(SCSI1), DIONAME(SCSI2), DIONAME(SCSI3),
> +	DIONAME(FBUFFER),
> +	DIONAME(PARALLEL), DIONAME(VME), DIONAME(DCL), DIONAME(DCLREM),
> +	DIONAME(MISC0), DIONAME(MISC1), DIONAME(MISC2), DIONAME(MISC3),
> +	DIONAME(MISC4), DIONAME(MISC5), DIONAME(MISC6), DIONAME(MISC7),
> +	DIONAME(MISC8), DIONAME(MISC9), DIONAME(MISC10), DIONAME(MISC11),
> +	DIONAME(MISC12), DIONAME(MISC13),
> +	DIOFBNAME(GATORBOX), DIOFBNAME(TOPCAT), DIOFBNAME(RENAISSANCE),
> +	DIOFBNAME(LRCATSEYE), DIOFBNAME(HRCCATSEYE), DIOFBNAME(HRMCATSEYE),
> +	DIOFBNAME(DAVINCI), DIOFBNAME(XXXCATSEYE), DIOFBNAME(HYPERION),
> +	DIOFBNAME(XGENESIS), DIOFBNAME(TIGER), DIOFBNAME(YGENESIS)
>  };
>  
>  #undef DIONAME
> @@ -94,13 +92,13 @@ static const char unknowndioname[]
>  
>  static const char *dio_getname(int id)
>  {
> -        /* return pointer to a constant string describing the board with given ID */
> +	/* return pointer to a constant string describing the board with given ID */
>  	unsigned int i;
>  	for (i = 0; i < ARRAY_SIZE(names); i++)
> -                if (names[i].id == id) 
> -                        return names[i].name;
> +		if (names[i].id == id)
> +			return names[i].name;
>  
> -        return unknowndioname;
> +	return unknowndioname;
>  }
>  
>  #else
> @@ -122,10 +120,10 @@ int __init dio_find(int deviceid)
>  		void *va;
>  		unsigned long pa;
>  
> -                if (DIO_SCINHOLE(scode))
> -                        continue;
> +		if (DIO_SCINHOLE(scode))
> +			continue;
>  
> -                pa = dio_scodetophysaddr(scode);
> +		pa = dio_scodetophysaddr(scode);
>  
>  		if (!pa)
>  			continue;
> @@ -139,15 +137,15 @@ int __init dio_find(int deviceid)
>  				(unsigned char *)va + DIO_IDOFF, 1)) {
>  			if (scode >= DIOII_SCBASE)
>  				iounmap(va);
> -                        continue;             /* no board present at that select code */
> +			continue;	     /* no board present at that select code */
>  		}
>  
>  		prid = DIO_ID(va);
>  
> -                if (DIO_NEEDSSECID(prid)) {
> -                        secid = DIO_SECID(va);
> -                        id = DIO_ENCODE_ID(prid, secid);
> -                } else
> +		if (DIO_NEEDSSECID(prid)) {
> +			secid = DIO_SECID(va);
> +			id = DIO_ENCODE_ID(prid, secid);
> +		} else
>  			id = prid;
>  
>  		if (id == deviceid) {
> @@ -175,7 +173,7 @@ static int __init dio_init(void)
>  
>          printk(KERN_INFO "Scanning for DIO devices...\n");
>  
> -	/* Initialize the DIO bus */ 
> +	/* Initialize the DIO bus */
>  	INIT_LIST_HEAD(&dio_bus.devices);
>  	dev_set_name(&dio_bus.dev, "dio");
>  	error = device_register(&dio_bus.dev);
> @@ -190,14 +188,13 @@ static int __init dio_init(void)
>  		request_resource(&iomem_resource, &dio_bus.resources[i]);
>  
>  	/* Register all devices */
> -        for (scode = 0; scode < DIO_SCMAX; ++scode)
> -        {
> -                u_char prid, secid = 0;        /* primary, secondary ID bytes */
> -                u_char *va;
> +	for (scode = 0; scode < DIO_SCMAX; ++scode) {
> +		u_char prid, secid = 0;	/* primary, secondary ID bytes */
> +		u_char *va;
>  		unsigned long pa;
> -                
> -                if (DIO_SCINHOLE(scode))
> -                        continue;
> +
> +		if (DIO_SCINHOLE(scode))
> +			continue;
>  
>  		pa = dio_scodetophysaddr(scode);
>  
> @@ -213,10 +210,10 @@ static int __init dio_init(void)
>  				(unsigned char *)va + DIO_IDOFF, 1)) {
>  			if (scode >= DIOII_SCBASE)
>  				iounmap(va);
> -                        continue;              /* no board present at that select code */
> +			continue;	      /* no board present at that select code */
>  		}
>  
> -                /* Found a board, allocate it an entry in the list */
> +		/* Found a board, allocate it an entry in the list */
>  		dev = kzalloc(sizeof(struct dio_dev), GFP_KERNEL);
>  		if (!dev)
>  			return -ENOMEM;
> @@ -229,19 +226,19 @@ static int __init dio_init(void)
>  		dev->resource.end = pa + DIO_SIZE(scode, va);
>  		dev_set_name(&dev->dev, "%02x", scode);
>  
> -                /* read the ID byte(s) and encode if necessary. */
> +		/* read the ID byte(s) and encode if necessary. */
>  		prid = DIO_ID(va);
>  
> -                if (DIO_NEEDSSECID(prid)) {
> -                        secid = DIO_SECID(va);
> -                        dev->id = DIO_ENCODE_ID(prid, secid);
> -                } else
> -                        dev->id = prid;
> +		if (DIO_NEEDSSECID(prid)) {
> +			secid = DIO_SECID(va);
> +			dev->id = DIO_ENCODE_ID(prid, secid);
> +		} else
> +			dev->id = prid;
>  
> -                dev->ipl = DIO_IPL(va);
> -                strcpy(dev->name,dio_getname(dev->id));
> +		dev->ipl = DIO_IPL(va);
> +		strcpy(dev->name, dio_getname(dev->id));
>                  printk(KERN_INFO "select code %3d: ipl %d: ID %02X", dev->scode, dev->ipl, prid);
> -                if (DIO_NEEDSSECID(prid))
> +		if (DIO_NEEDSSECID(prid))
>                          printk(":%02X", secid);
>                  printk(": %s\n", dev->name);
>  
> @@ -256,7 +253,7 @@ static int __init dio_init(void)
>  		error = dio_create_sysfs_dev_files(dev);
>  		if (error)
>  			dev_err(&dev->dev, "Error creating sysfs files\n");
> -        }
> +	}
>  	return 0;
>  }
>  
> @@ -267,12 +264,12 @@ subsys_initcall(dio_init);
>   */
>  unsigned long dio_scodetophysaddr(int scode)
>  {
> -        if (scode >= DIOII_SCBASE) {
> -                return (DIOII_BASE + (scode - 132) * DIOII_DEVSIZE);
> -        } else if (scode > DIO_SCMAX || scode < 0)
> -                return 0;
> -        else if (DIO_SCINHOLE(scode))
> -                return 0;
> -
> -        return (DIO_BASE + scode * DIO_DEVSIZE);
> +	if (scode >= DIOII_SCBASE)
> +		return (DIOII_BASE + (scode - 132) * DIOII_DEVSIZE);
> +	else if (scode > DIO_SCMAX || scode < 0)
> +		return 0;
> +	else if (DIO_SCINHOLE(scode))
> +		return 0;
> +
> +	return (DIO_BASE + scode * DIO_DEVSIZE);
>  }
> -- 
> 2.35.0
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
