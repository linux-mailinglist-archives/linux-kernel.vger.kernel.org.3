Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7678658526D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 17:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237118AbiG2PYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 11:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237468AbiG2PX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 11:23:59 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B435085FA6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 08:23:40 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id u76so6124817oie.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 08:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4wO1MjeUsCDlwsXxvP/E1eIWCLhJk0oKRDyI5lcSaFI=;
        b=WgESSMakprr85bnAIQPsz93hHqlVj8N5EH6D+DWehMU4PB6BlOaHdBjAkTgO/LJ0Rt
         EEm6Rqosm6t46MPPgz5qOllPMZwC2TnrYVsdSK4VTAxsBocYtfk3hc7mR4iW+atazhhw
         uDDk3khZEOrUq+CH1dHeKhoH6+QSbkYBfTVb9pa3oQk5H6IDBMFv8JYTJF+UVTOvXVlJ
         +mnfFG1b5E682/EDOhbA7SF9QMgYcsFaT8f8u0gyAwfL6979t6yKtlvKATjgfhPgtAtw
         7AwV/iZnBQ7m2870ZxKq/WfbviEeLlfZCzjnt8JZ9T8m9JpnrovfgOvL71Y2P4bRRCgM
         wOqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=4wO1MjeUsCDlwsXxvP/E1eIWCLhJk0oKRDyI5lcSaFI=;
        b=5Jw9+RDwsAakExgWdfJivZZb/lWZC6tDyZF/wL+7HtwiSMJryLBd7SgR0R0QtvxvBe
         hngZau1a8Q1wcLDH+p/5hU+MpJB37Uj3ju+vwrNPWuKYhRRc4wCcb3lvZxo2w1vqtW9a
         GkwUfjswPsP6YkyubpvhmKkJGu65rHqfnE1+XFW8v40QyQjRofzLShBg0zoPGdsgGPp9
         xq8lJjmH0cKsnBBfSLf5+e+034hUJCHXH7zmJ/Te4aK7zFhMOy5pfSvvVQe3itwfAic1
         uZGFCc6+J+Ewb70Na+tzCvDm6G2M09UlFeUuttIZBx4IW+FXP/Ttdn1pYy73GnTIviGU
         +FPQ==
X-Gm-Message-State: AJIora/O4Ho2drD82ooghVm259nOZ8IO5BhbIC83AYwcccNij+wk6mS5
        HnZa1FjnAJ7hU9VD9vVZ5RU0md8ryC08Ew==
X-Google-Smtp-Source: AGRyM1s9mfSHeJiHkYhOkAbabMp3nfsDf8Y8VBHSW1TC3hP58L/6Rs9Y9EPWOom4qOR+6FOm1Op0PQ==
X-Received: by 2002:a05:6808:1201:b0:325:75e1:25a8 with SMTP id a1-20020a056808120100b0032575e125a8mr2048230oil.18.1659108219452;
        Fri, 29 Jul 2022 08:23:39 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g8-20020a9d6208000000b0061cbd18bd18sm1304415otj.45.2022.07.29.08.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 08:23:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 29 Jul 2022 08:23:35 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: Re: [PATCH] openrisc: io: Define iounmap argument as volatile
Message-ID: <20220729152335.GA431060@roeck-us.net>
References: <20220729110726.3635262-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729110726.3635262-1-shorne@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 08:07:25PM +0900, Stafford Horne wrote:
> When OpenRISC enables PCI it allows for more drivers to be compiled
> resulting in exposing the following with -Werror.
> 
>     drivers/video/fbdev/riva/fbdev.c: In function 'rivafb_probe':
>     drivers/video/fbdev/riva/fbdev.c:2062:42: error:
> 	    passing argument 1 of 'iounmap' discards 'volatile' qualifier from pointer target type
> 
>     drivers/video/fbdev/nvidia/nvidia.c: In function 'nvidiafb_probe':
>     drivers/video/fbdev/nvidia/nvidia.c:1414:20: error:
> 	    passing argument 1 of 'iounmap' discards 'volatile' qualifier from pointer target type
> 
>     drivers/scsi/aic7xxx/aic7xxx_osm.c: In function 'ahc_platform_free':
>     drivers/scsi/aic7xxx/aic7xxx_osm.c:1231:41: error:
> 	    passing argument 1 of 'iounmap' discards 'volatile' qualifier from pointer target type
> 
> Most architectures define the iounmap argument to be volatile.  To fix this
> issue we do the same for OpenRISC.  This patch must go before PCI is enabled on
> OpenRISC to avoid any compile failures.
> 
> Link: https://lore.kernel.org/lkml/20220729033728.GA2195022@roeck-us.net/
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Stafford Horne <shorne@gmail.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  arch/openrisc/include/asm/io.h | 2 +-
>  arch/openrisc/mm/ioremap.c     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/openrisc/include/asm/io.h b/arch/openrisc/include/asm/io.h
> index 625ac6ad1205..ee6043a03173 100644
> --- a/arch/openrisc/include/asm/io.h
> +++ b/arch/openrisc/include/asm/io.h
> @@ -31,7 +31,7 @@
>  void __iomem *ioremap(phys_addr_t offset, unsigned long size);
>  
>  #define iounmap iounmap
> -extern void iounmap(void __iomem *addr);
> +extern void iounmap(volatile void __iomem *addr);
>  
>  #include <asm-generic/io.h>
>  
> diff --git a/arch/openrisc/mm/ioremap.c b/arch/openrisc/mm/ioremap.c
> index daae13a76743..8ec0dafecf25 100644
> --- a/arch/openrisc/mm/ioremap.c
> +++ b/arch/openrisc/mm/ioremap.c
> @@ -77,7 +77,7 @@ void __iomem *__ref ioremap(phys_addr_t addr, unsigned long size)
>  }
>  EXPORT_SYMBOL(ioremap);
>  
> -void iounmap(void __iomem *addr)
> +void iounmap(volatile void __iomem *addr)
>  {
>  	/* If the page is from the fixmap pool then we just clear out
>  	 * the fixmap mapping.
> -- 
> 2.37.1
> 
