Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9802B4F6CC3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235592AbiDFVdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236394AbiDFVcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:32:43 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1543C4DF68;
        Wed,  6 Apr 2022 13:42:39 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id d5so6116516lfj.9;
        Wed, 06 Apr 2022 13:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UGUKe+fVZFxZQzTOphz49PEUUizHIiQQsmFGAgYjpYQ=;
        b=g3fVYaX0duKw+V3+mawCW/zLQS2mDlDjmZFhyZFS6Yrrar/63VZXRIP8xeinwZ25tJ
         QBQ42BtrMKqra3yeKvS8yZjzhnR0ZGIu4uOGl/7BiQwsOClrvy4fqhz5QPWDcp0g4bnX
         zQuvG+JJfOxCR707BJmraYOi10MO6s/OA8hvgAlrTRg6Pfe3TLCctWebBhGDloFU90+k
         YKoWrBG2X7CxIoEA3HaNP78BOH5BmJYmz6QEu7VqiOvnO9iWMpF/bGUVEzD8nNFK2T3j
         3yx66wW0zmIEPqMqa+mIV2tUhB4yxzx0AIJBodTF9MuMwXQzdKNjNSwJGLjCKeOiVyB4
         IwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UGUKe+fVZFxZQzTOphz49PEUUizHIiQQsmFGAgYjpYQ=;
        b=bjy7BHhnOOYZG38Cd5oeWYdv1elDZbb1lxU40QwsL7q1P3AKax0Xoz4eSmtkfatyjl
         uHmmHqrvD68w1UkmX5dMgzAD+QObojPNdUccvamLqHL7T/sfuzSZsehtfHkunUd0sJzv
         Z70NAm0OqDlZHibnLdcTp+iodwxiprzWa7EU0Ezn2IEQzr/K02PGq/6gOtgaO3qlCs8d
         Yl+dz8JyOD5YMvPV/oC23NHEdCWQpv2J9iRTGFl8kDAoOBjY6uhHV74QF25itZStaqpU
         v2VKAhYsQbiZooueCUOLYSFwNJ9nC0dbse+1W8VgoKkOLswRerdE/xruWUJdMQOeusJ4
         oGjw==
X-Gm-Message-State: AOAM530Apnef60jHVjfoHuqytnk4A9HsFdVzbQLpr33CGV6zdJYkNT/R
        wADrcnealHOQih8HS611DT4=
X-Google-Smtp-Source: ABdhPJzCcl06fhgqpxN7tO17B1Vsov1sVQ+hKk+/sWPvBx0Gxq2jgq3xijVAUI6ah0SFlfEL/PtjHw==
X-Received: by 2002:a05:6512:3ba8:b0:44a:31b7:6325 with SMTP id g40-20020a0565123ba800b0044a31b76325mr7253191lfv.443.1649277757177;
        Wed, 06 Apr 2022 13:42:37 -0700 (PDT)
Received: from mobilestation ([95.79.134.149])
        by smtp.gmail.com with ESMTPSA id f23-20020a2e9e97000000b0024921bcf06bsm1757102ljk.57.2022.04.06.13.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 13:42:36 -0700 (PDT)
Date:   Wed, 6 Apr 2022 23:42:34 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 04/21] ata: libahci_platform: Convert to using handy
 devm-ioremap methods
Message-ID: <20220406204234.lc32bzg5magqvpva@mobilestation>
References: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
 <20220324001628.13028-5-Sergey.Semin@baikalelectronics.ru>
 <ff109d7a-e308-3ce0-b7aa-0905e101e5fd@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff109d7a-e308-3ce0-b7aa-0905e101e5fd@opensource.wdc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 10:11:09AM +0900, Damien Le Moal wrote:
> On 3/24/22 09:16, Serge Semin wrote:
> > Currently the IOMEM AHCI registers space is mapped by means of the
> > two functions invocation: platform_get_resource() is used to get the very
> > first memory resource and devm_ioremap_resource() is called to remap that
> > resource. Device-managed kernel API provides a handy wrapper to perform
> > the same in single function call: devm_platform_ioremap_resource().
> 
> > 
> > While at it seeing many AHCI platform drivers rely on having the AHCI CSR
> > space marked with "ahci" name let's first try to find and remap the CSR
> > IO-mem with that name and only if it fails fallback to getting the very
> > first registers space platform resource.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > ---
> >  drivers/ata/libahci_platform.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> > index 1bd2f1686239..8eabbb5f208c 100644
> > --- a/drivers/ata/libahci_platform.c
> > +++ b/drivers/ata/libahci_platform.c
> > @@ -404,11 +404,13 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
> >  
> >  	devres_add(dev, hpriv);
> >  
> > -	hpriv->mmio = devm_ioremap_resource(dev,
> > -			      platform_get_resource(pdev, IORESOURCE_MEM, 0));
> > +	hpriv->mmio = devm_platform_ioremap_resource_byname(pdev, "ahci");
> 

> See __devm_ioremap_resource(): if there is no resource named "ahci" found,
> then this will print an error message ("invalid resource\n"). That may
> confuse users as this error message was not present before. So you may
> want to change this code to something like this:

Right. I should have checked that the method can print an error
message in the log. Thanks for the heads-up. I'll fix the patch as you
suggest. It's a pity there is no an alternative with "_optional"
semantics though.

-Sergey

> 
> /*
>  * If the DT provided an "ahci" named resource, use it. Otherwise,
>  * fallback to using the default first resource for the device node.
>  */
> if (platform_get_resource_byname(pdev, IORESOURCE_MEM, "ahci"))
> 	hpriv->mmio = devm_platform_ioremap_resource_byname(pdev, "ahci");
> else
> 	hpriv->mmio = devm_platform_ioremap_resource(pdev, 0);
> if (IS_ERR(hpriv->mmio)) {
> 	rc = PTR_ERR(hpriv->mmio);
> 	goto err_out;
> }
> 
> >  	if (IS_ERR(hpriv->mmio)) {
> > -		rc = PTR_ERR(hpriv->mmio);
> > -		goto err_out;
> > +		hpriv->mmio = devm_platform_ioremap_resource(pdev, 0);
> > +		if (IS_ERR(hpriv->mmio)) {
> > +			rc = PTR_ERR(hpriv->mmio);
> > +			goto err_out;
> > +		}
> >  	}
> >  
> >  	for (i = 0; i < AHCI_MAX_CLKS; i++) {
> 
> 
> -- 
> Damien Le Moal
> Western Digital Research
