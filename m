Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E9951E8E1
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 19:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446715AbiEGRVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 13:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236727AbiEGRVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 13:21:02 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11067252AC
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 10:17:15 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id x52so8792090pfu.11
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 10:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zcHkq7Z+HmvKF6gDJoeWVBEq6PpKSlua9VyCrGBrNug=;
        b=GjWSvxXhIMGBPTEjL5DhQomq3+0Uvjx+ZIhnk1uTW92+3Qs6M16EG0OQ5civp+kN3d
         JPEQxlnIIiQRUpO8cw9IEsNoQHED3Lor/DZ+jHE4NEbfBlpwH6GQ2b2Ww13x6PF26V12
         XaiBkEBnGjUD57W3GU2iPtfZlR8RSyaM5C1Mg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zcHkq7Z+HmvKF6gDJoeWVBEq6PpKSlua9VyCrGBrNug=;
        b=odpPb31ob9bNK6cBcYrTYcudCoxw63NRgUcjOyjatP7FGjmLLhqZmfnKuFlSjryG76
         k4PD8PbAQJsNFfui3aioqB84HzmQb5o8+EIfUTMJ230HGiF5lnEPvgpxoIN6yyMYyKCe
         Hi0U/B5l39KgBXae2FHoOLFFUzkT7NvTMxxqVZMCV/dnz04CcqrDku2NrZU18aYcHLkN
         693ljZbJtWZdz6eTzurn+lA36+FkeKItequbcXREjC7S1P4aEFgRKl4T06TmoDE34RsD
         jNvt5XQFbZe44SfU/x9YjiZmuLHehh2n2tw//3SFcmYAYF0TGAsq8RJiOqC47GXh2r23
         9jNw==
X-Gm-Message-State: AOAM531nSe9urzOW/VsiIw3vyoN6H/8rQ6AdsVOFQ5f1OvObd8pvC1Zm
        nykVBUaf5zXZzsbHJGg20pvsCg==
X-Google-Smtp-Source: ABdhPJx8wRMOwUjq3i4XoPQJmwsK8VR2o/+sB8G62ZiqVAXD+6bm6CqD8s00lg67uSdPJJI9+i74aQ==
X-Received: by 2002:a63:4423:0:b0:3c6:6b6d:107c with SMTP id r35-20020a634423000000b003c66b6d107cmr4124266pga.428.1651943834584;
        Sat, 07 May 2022 10:17:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y1-20020aa79e01000000b0050dc7628175sm5501500pfq.79.2022.05.07.10.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 10:17:14 -0700 (PDT)
Date:   Sat, 7 May 2022 10:17:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: linux-next: manual merge of the kspp tree with the char-misc tree
Message-ID: <202205071016.28C970A6C@keescook>
References: <20220505172010.19545e84@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505172010.19545e84@canb.auug.org.au>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 05:20:10PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the kspp tree got a conflict in:
> 
>   drivers/misc/lkdtm/stackleak.c
> 
> between commit:
> 
>   73f62e60d80c ("lkdtm: Move crashtype definitions into each category")
> 
> from the char-misc tree and commit:
> 
>   c393c0b98d75 ("lkdtm/stackleak: prevent unexpected stack usage")
> 
> from the kspp tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc drivers/misc/lkdtm/stackleak.c
> index 210c84dfe1d2,52800583fd05..000000000000
> --- a/drivers/misc/lkdtm/stackleak.c
> +++ b/drivers/misc/lkdtm/stackleak.c
> @@@ -81,11 -115,11 +115,20 @@@ out
>   	}
>   }
>   
>  -void lkdtm_STACKLEAK_ERASING(void)
> ++static void lkdtm_STACKLEAK_ERASING(void)
> + {
> + 	unsigned long flags;
> + 
> + 	local_irq_save(flags);
> + 	check_stackleak_irqoff();
> + 	local_irq_restore(flags);
> + }
> ++
>  +static struct crashtype crashtypes[] = {
>  +	CRASHTYPE(STACKLEAK_ERASING),
>  +};
>  +
>  +struct crashtype_category stackleak_crashtypes = {
>  +	.crashtypes = crashtypes,
>  +	.len	    = ARRAY_SIZE(crashtypes),
>  +};

Thanks! This looks correct to me.


-- 
Kees Cook
