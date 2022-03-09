Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C424D36AC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbiCIRUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 12:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236561AbiCIRT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 12:19:58 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCCBB6D24
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 09:18:27 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id lj8-20020a17090b344800b001bfaa46bca3so2780490pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 09:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OBZNfdb0rOh/QNiMQYP2Ffyh/ZYEjvezxZHi4C7c6KA=;
        b=SA2vwAWbPVZA0LRge06Mro26X3HpXs7nY8GKzGYpdr2IhpqxaendCtWBWdsumuVd8B
         Lp0tIO5ctR3cNw6rO/0g8ic9fhlrFvIfHdy4jADLmcot4aVAZS0NPSqhSzt9owocMKhH
         berCNUutDuoAW6OgMF1pzjIaGb61oxf42Y8iQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OBZNfdb0rOh/QNiMQYP2Ffyh/ZYEjvezxZHi4C7c6KA=;
        b=CR358wGjd/6UeKWdwORtomjpO8LmyDZWGHJHiUDa1+SYFMPo/VuJoQiblMm4SBB3Ke
         6I3fKOZE3op6xaQHOQ18oNEH9yfaBujV14vhIBO6f0pN5Wd60dK/tsuWNFkQ1Kqqk4mA
         3A4O4cSZq+AMMz1U3Fy/7GUmF60Xl5HNuGzow2dTpOKUb9SUdLSHPnrF7liw9dEfW8Ri
         pfeKW3JrNSx4m9fcnsqh2XBZYy59zSmkrU595xQ+QLI2aTbqqavgFuq5XFiGnxMoxfba
         H8HIF6TSvaEJVI+EnL01SmYtADEo1nq412u2XXyPLXGhYR1deFTf+Psw1ZAcHBsFDlQE
         DQHQ==
X-Gm-Message-State: AOAM531pAgmWkK+/6LfpG2kFAD8WxLSiFPaSTjLKSmvpJp0d+utCYrRf
        lbG2PbY3BYnYq9Ika+Q3Jhpiag==
X-Google-Smtp-Source: ABdhPJxwt+DDh9/qxiRl/Ey1QKAVbRzRrqzId+GeGnd77ardBj/tW0msJwGZPfuIeGmgd9/kjKJW6A==
X-Received: by 2002:a17:903:22c6:b0:151:da97:5a81 with SMTP id y6-20020a17090322c600b00151da975a81mr635316plg.135.1646846307239;
        Wed, 09 Mar 2022 09:18:27 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j11-20020a63230b000000b00372a08b584asm2863158pgj.47.2022.03.09.09.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 09:18:26 -0800 (PST)
Date:   Wed, 9 Mar 2022 09:18:26 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Gross <markgross@kernel.org>,
        Mark Pearson <markpearson@lenovo.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the kspp tree
Message-ID: <202203090918.A993715E6@keescook>
References: <20220309211029.0c766cac@canb.auug.org.au>
 <202203090847.81E8862@keescook>
 <0d4cdbbb-993b-55f3-355a-e0826ab45f46@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d4cdbbb-993b-55f3-355a-e0826ab45f46@redhat.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 05:58:56PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 3/9/22 17:52, Kees Cook wrote:
> > On Wed, Mar 09, 2022 at 09:10:29PM +1100, Stephen Rothwell wrote:
> >> Hi all,
> >>
> >> After merging the kspp tree, today's linux-next build (x86_64
> >> allmodconfig) failed like this:
> >>
> >> In file included from include/linux/bitops.h:33,
> >>                  from include/linux/kernel.h:22,
> >>                  from drivers/platform/x86/thinkpad_acpi.c:37:
> >> drivers/platform/x86/thinkpad_acpi.c: In function 'tpacpi_dytc_profile_init':
> >> arch/x86/include/asm/bitops.h:207:22: error: array subscript 'long unsigned int[0]' is partly outside array bounds of 'int[1]' [-Werror=array-bounds]
> >>   207 |                 (addr[nr >> _BITOPS_LONG_SHIFT])) != 0;
> >>       |                 ~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> drivers/platform/x86/thinkpad_acpi.c:10385:18: note: while referencing 'output'
> >> 10385 |         int err, output;
> >>       |                  ^~~~~~
> >>
> >> Actually the test_bit() in line 10409.
> >>
> >> Caused by commit
> >>
> >>   e1c21608e3cf ("platform/x86: thinkpad_acpi: Add PSC mode support")
> >>
> >> from the drivers-x86 tree interacting with the enablement of
> >> -Werror=array-bounds.
> >>
> >> I have reverted that commit for today.
> 
> Thank you.
> 
> > Looking at https://lore.kernel.org/all/20220225182505.7234-1-markpearson@lenovo.com/
> > 
> > The problem is with the cast of "int output" to "unsigned long". Past
> > fixes have either made the variable unsigned long, or adding a new
> > variable and removal of casts. e.g. this pseudo-patch:
> > 
> > +	unsigned long bits;
> > 
> > 	...
> > +	bits = output;
> > -	if (test_bit(DYTC_FC_MMC, (void *)&output)) { /* MMC MODE */
> > +	if (test_bit(DYTC_FC_MMC, &bits)) { /* MMC MODE */
> > 
> > ...
> > 
> > -	} else if (test_bit(DYTC_FC_PSC, (void *)&output)) { /*PSC MODE */
> > +	} else if (test_bit(DYTC_FC_PSC, &bits)) { /*PSC MODE */
> 
> Right I was just preparing a patch for this, I've gone with:
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index 7016c7fc3440..c476a78599d6 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -10399,7 +10399,7 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
>  	if (err)
>  		return err;
>  
> -	if (test_bit(DYTC_FC_MMC, (void *)&output)) { /* MMC MODE */
> +	if (output & BIT(DYTC_FC_MMC)) { /* MMC MODE */
>  		dytc_profile_available = DYTC_FUNCMODE_MMC;
>  
>  		/*
> @@ -10412,7 +10412,7 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
>  			if (!err && ((output & DYTC_ERR_MASK) == DYTC_ERR_SUCCESS))
>  				dytc_mmc_get_available = true;
>  		}
> -	} else if (test_bit(DYTC_FC_PSC, (void *)&output)) { /*PSC MODE */
> +	} else if (output & BIT(DYTC_FC_PSC)) { /* PSC MODE */
>  		dytc_profile_available = DYTC_FUNCMODE_PSC;
>  	} else {
>  		dbg_printk(TPACPI_DBG_INIT, "No DYTC support available\n");
> 
> I'll push this to the drivers-x86 tree for-next branch.

Ah yeah. Heh, that's much simpler. :)

-- 
Kees Cook
