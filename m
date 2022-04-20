Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3604A507F3D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 04:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359094AbiDTC6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 22:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359082AbiDTC6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 22:58:05 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C21165BC
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 19:55:20 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id r10so618289pfh.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 19:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x+0BkD90lSyJDZ+2FE+F3s3K1NpvSXBebMgeO2N/Frg=;
        b=Hfmk01lC9jeqEsouKixV0+yDRgrE5Fn2IlceBrZTVoWNuI6yeRyqhxoOz7EUwRS38d
         LCZSzTzzyII4PS4IloyZ7eJjfDCzH1vjh9WpiVHL1Zj4twoIdTH4ht5UW8YxbAKhnFL3
         sBr18LYtGGnmXA6KHl3FRPOtx23EiM2vOgAhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x+0BkD90lSyJDZ+2FE+F3s3K1NpvSXBebMgeO2N/Frg=;
        b=5dRGEdh6kitkfFi+vZ572WqdYVxE1k4FbYl1WkPNgfjSCPWOg+uiFW6WZKCUVGprC7
         m2EYVZYXAwY0lR+JQGG87B6kpNxSJijhakahjbi2uKhjKHloboHAUOWpMbweiiWu4FRB
         Jd5Ai5rSMw6r0zfCQkAlLiHWY+wa/Ia1IZhpgbRsSWuB52VN/OOWiGYC9AoB7U0ZzBt/
         JPlbIvo4TyGnyk0vjSSJjp1NDGZZiame+xV67LLhedbttEWHLdBExlrAHoglbricMcUt
         KF7OOz/c5K+tPJOhbWks8fnWFrS6KNL4coMdEDOTYe/a1sSl3AU8OYLCFx/udQ944d4s
         Tm1g==
X-Gm-Message-State: AOAM532+a0firnea/nZLLNd0abgVR2ncDTUTb7xlFGFiaHQHQyQEjPo0
        nVAQhL0OQYYGFFGWJigZjTaJ3g==
X-Google-Smtp-Source: ABdhPJztKHnzJt1bTQU7FWsNgVa3dAiH27NdueMZxHr+rgwVvS/3gVFDs06sMa+/DGDJRY29bePZEw==
X-Received: by 2002:a63:6501:0:b0:39d:a2fc:1522 with SMTP id z1-20020a636501000000b0039da2fc1522mr16907859pgb.91.1650423320193;
        Tue, 19 Apr 2022 19:55:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g15-20020a63be4f000000b0039934531e95sm17484198pgo.18.2022.04.19.19.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 19:55:19 -0700 (PDT)
Date:   Tue, 19 Apr 2022 19:55:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     joao@overdrivepizza.com
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        peterz@infradead.org, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, samitolvanen@google.com,
        mark.rutland@arm.com, hjl.tools@gmail.com,
        alyssa.milburn@linux.intel.com, ndesaulniers@google.com,
        gabriel.gomes@linux.intel.com, rick.p.edgecombe@intel.com
Subject: Re: [RFC PATCH 11/11] driver/int3400_thermal: Fix prototype matching
Message-ID: <202204191946.2843CF71@keescook>
References: <20220420004241.2093-1-joao@overdrivepizza.com>
 <20220420004241.2093-12-joao@overdrivepizza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420004241.2093-12-joao@overdrivepizza.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 05:42:41PM -0700, joao@overdrivepizza.com wrote:
> From: Joao Moreira <joao@overdrivepizza.com>
> 
> The function attr_dev_show directly invokes functions from drivers
> expecting an specific prototype. The driver for int3400_thermal
> implements the given show function using a different prototype than what
> is expected. This violates the prototype-based fine-grained CFI policy.
> 
> Make the function prototype compliant and cast the respective assignement
> so it can be properly user together with fine-grained CFI.

Does this trip on regular CFI? See below, but this all looks correct to
me in the original code.

> (FWIIW, there should be a less ugly patch for this, but I don't know
> enough about the touched source code).
> 
> Signed-off-by: Joao Moreira <joao@overdrivepizza.com>
> ---
>  .../thermal/intel/int340x_thermal/int3400_thermal.c    | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> index 4954800b9850..4bd95a2016b7 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> @@ -311,12 +311,13 @@ static int int3400_thermal_get_uuids(struct int3400_thermal_priv *priv)
>  	return result;
>  }
>  
> -static ssize_t odvp_show(struct kobject *kobj, struct kobj_attribute *attr,
> +static ssize_t odvp_show(struct device *kobj, struct device_attribute *attr,
>  			 char *buf)
>  {
> +	struct kobj_attribute *kattr = (struct kobj_attribute *) attr;
>  	struct odvp_attr *odvp_attr;
>  
> -	odvp_attr = container_of(attr, struct odvp_attr, attr);
> +	odvp_attr = container_of(kattr, struct odvp_attr, attr);
>  
>  	return sprintf(buf, "%d\n", odvp_attr->priv->odvp[odvp_attr->odvp]);
>  }
> @@ -388,7 +389,10 @@ static int evaluate_odvp(struct int3400_thermal_priv *priv)
>  				goto out_err;
>  			}
>  			odvp->attr.attr.mode = 0444;

Eww, this function has a masked "odvp" variable here. One should be
likely renamed.

But anyway, odvp is:

struct odvp_attr {
        int odvp;
        struct int3400_thermal_priv *priv;
        struct kobj_attribute attr;
};

The original code looks correct to me (besides the masked variable
name). kobj_attribute is part of odvp, the odvp_show callback has the
correct prototype, and performs the correct container_of() to get
odvp_attr.

Where/why is the mismatch happening?

-Kees

> -			odvp->attr.show = odvp_show;
> +			odvp->attr.show = (ssize_t (*)
> +					(struct kobject *,
> +					 struct kobj_attribute *,
> +					 char *)) odvp_show;
>  			odvp->attr.store = NULL;
>  			ret = sysfs_create_file(&priv->pdev->dev.kobj,
>  						&odvp->attr.attr);
> -- 
> 2.35.1
> 

-- 
Kees Cook
