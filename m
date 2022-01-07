Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3E4487CF2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 20:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbiAGTYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 14:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiAGTYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 14:24:45 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97A5C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 11:24:44 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id 196so5914286pfw.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 11:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QMs6fkUvgPrjBNmbVuzeEIMf/pxNE8LPDDFFuRfaa5Y=;
        b=dCs9HdAqqz6QxAPNLPq8whgVc4oHvxWlnjZ37shwKGAMr9nLlMHGTj32npKCuokJKK
         idNPSZSRGH+nc2ioJAjnp/yxWTM7ATkZ2TMfTlI7vyXrC1mU6oPQBIUjpC02jlA+iTOw
         KbrAJCTT/bPrRAvxOqGuQS1xW3bHeO2vbFjBWifi40D+8J2v5Rt9vuieY4N6QGCgy8vS
         aWdxpFRMQl354PWRrVct4DMvizHyYS/1Vmo9qjqIuaNlW01Q7bE2FZF9t4Fbl9WYHFts
         BG3bILBB0K1lP4jZgUcJmqDYwKxxYAtJdsXFi/N8w/jvnVY3Dh9HHPfouAWPWes9Ljq4
         uoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QMs6fkUvgPrjBNmbVuzeEIMf/pxNE8LPDDFFuRfaa5Y=;
        b=vszWQ3Pg64StfGMeyhtKJ+92OnRGMI2s3fFPny2FYDtZIJaIqW7yni2QcUMKVoPKhn
         bp3lTebfX27W+svii30IqTe6jEwErIihE4nqISnZnMmymLzHadL6JJJ7sPMub06t6nhR
         fb48NZ1FZtsbMJm/jR99ERWdeFREABBIPTuDvbPiaq9mDrmP7vGNuIj9oPHIA1yiuUx/
         GmOiAGrTB1Q6B4goEC2WqhHmPnN0rDzuNx0dpNKBNbyPQB9I8ravSC58pKol/WTgAfTz
         dFBXBK4d3mlxKreuPtPuoV1ZVjrQmt99WP/BJMsfK2yQ01hCe+pN+HdYnXENuLJ7sqxk
         CbMg==
X-Gm-Message-State: AOAM533K0zn5pDwIaPR9/PRmFdZXBtRyDLYehBjVJ3H/P1qzQi9R3Y91
        ZJnQHffkfQcTOOY8cURAo18=
X-Google-Smtp-Source: ABdhPJw9+NE0KP0rvwvLCzBHuz55aXfsGF21CuiFGPHj6dzg+8vwq0rmp3jqYablU9dH/XO+ZgdS2w==
X-Received: by 2002:a05:6a00:1249:b0:4bb:4a31:1e0a with SMTP id u9-20020a056a00124900b004bb4a311e0amr65594800pfi.81.1641583484198;
        Fri, 07 Jan 2022 11:24:44 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id y3sm5968077pjp.55.2022.01.07.11.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 11:24:43 -0800 (PST)
Date:   Sat, 8 Jan 2022 08:24:38 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, realwakka@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: pi433: move get version func to where all
 other functions are
Message-ID: <20220107192438.GB2693@mail.google.com>
References: <20220106201430.GA3416@mail.google.com>
 <20220106213325.GA10767@mail.google.com>
 <20220107085343.GP7674@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107085343.GP7674@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 11:53:44AM +0300, Dan Carpenter wrote:
> On Fri, Jan 07, 2022 at 10:33:25AM +1300, Paulo Miguel Almeida wrote:
> > As a convention for the pi433 driver, all routines that deals with the
> > rf69 chip are defined in the rf69.c file.
> 
> That's some EnterpriseQuality[tm] style guidelines.  It's an over fussy
> rule that just makes the code harder to read for no reason.

EnterpriseQuality[tm] was witty :)

> >  
> >  	/* Ping the chip by reading the version register */
> 
> This comment doesn't make sense now.

you are right, I will change this.

> > -	retval = spi_w8r8(spi, 0x10);
> > -	if (retval < 0)
> > -		return retval;
> > +	retval = rf69_get_version(spi);
> 
> Just say:
> 
> 	retval = rf69_read_reg(spi, REG_VERSION);

atm rf69_read_reg is a static function in rf69.c.

I do agree that this is technically possible to write the code
exactly as you suggested but on the other hand, that would be the only
exception to the rule when considering all other higher-level functions
provided in the rf69.c

are you strongly set on the rf69_read_reg approach or would you 
be open to keep the original approach? (rf69_get_version)

> 	if (retval < 0)
> 		return retval;
> 
> Deleting the error handling was a bad style choice.  Also preserve the
> error code.
>

I just want to double-check if this suggestion is taking into
consideration what was mentioned here:
https://lore.kernel.org/lkml/20220106210134.GB3416@mail.google.com/

If it is, I'm happy to add it back but I just wanted to confirm it
first.

thanks,

Paulo A.
