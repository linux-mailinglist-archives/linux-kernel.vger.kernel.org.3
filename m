Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686CE598D8C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 22:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345479AbiHRUPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 16:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345914AbiHRUOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 16:14:43 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D39CB5E7;
        Thu, 18 Aug 2022 13:14:02 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id jm11so2395933plb.13;
        Thu, 18 Aug 2022 13:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=egYSJNbQxtbIjtuZxTLb7Op2z9efDIBz0CVG82pd35Q=;
        b=OrdgxQZHf0g36dqgz8oBTc9Pw5flV5lUnAKO+L/BXl1IbHMz6Y0SdtGaYvkVBINho4
         lDQxJFuriCNhvRWKDJNhT68uzk2DPMhppFWOYNcSIqRtXgQ007eDkXLtc+jww6Lj5KLD
         bi5Hl0bUgFcwQCWbAGu7DenppWIMcGBnYco7S8QPnPoDXHha8aQzzDXNw1MH45MtU5YD
         h79Ex5qk3hBSkTCq5yMPSmY4oysetZiE+lOLmlZG0IiY73TIsd5bixD5Ch64z4MmscdV
         7xJE0+dTV8j1ZGcn7S3l71FVgayPZcdCrd1NjyNiOIJhXeHyVtH+Ok8VxHPO6GsW1++T
         q1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=egYSJNbQxtbIjtuZxTLb7Op2z9efDIBz0CVG82pd35Q=;
        b=RLE+omWKLqZU1kiF1oKN0jXPYrYf+X3C+PFVXDU5LIicpP6m5L+3c5vetN9Jxn28Ls
         dpQSw27C3gdcCn2NYTpmEgE1IubqgVW9hyx8SMFwY8LBM2yuu0QJv2wNF0FF3A0Q6eg/
         FA3lCUAg4kDDaUQlB6yckvnqrtvBn7Xt6LLHj2ldH6tFZqVmYAETT9/xTb1v4WG/YoSv
         KnqzD9kStnlTJWWUDoVzcVreBCtot73sH2dPvjsAyndsGofDVFrbYPwf0iov9DsugTsQ
         j4BwwOPlC6sH5ZtilECeiPt4layNNxOO/r1lyxVN0Sq8ZOKZ0oJAsCxFB3AgstzCUO9Y
         dVqQ==
X-Gm-Message-State: ACgBeo0VRBv4ln+k2cNfhOVOkNK9RovyIuMy82PARqvRdJXr1RxW2YLR
        gvq1OZ8mz3CeR9J3fDP4hvE=
X-Google-Smtp-Source: AA6agR4k9h5ht6adNQ4cG6aZIayrOdx0qxU/jk7nZlcuvmViw6faXm9ppDtDbTHN6V4LU/YdyEvwDA==
X-Received: by 2002:a17:90b:4653:b0:1f3:1ce3:2cb with SMTP id jw19-20020a17090b465300b001f31ce302cbmr10134904pjb.176.1660853641591;
        Thu, 18 Aug 2022 13:14:01 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n3-20020aa79843000000b0052dd7d0ad04sm2058779pfq.88.2022.08.18.13.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 13:14:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 18 Aug 2022 13:13:59 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eliav Farber <farbere@amazon.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, talel@amazon.com, hhhawa@amazon.com,
        jonnyc@amazon.com, hanochu@amazon.com, ronenk@amazon.com,
        itamark@amazon.com, shellykz@amazon.com, shorer@amazon.com,
        amitlavi@amazon.com, almogbs@amazon.com, dwmw@amazon.co.uk,
        rtanwar@maxlinear.com
Subject: Re: [PATCH v2 11/16] hwmon: (mr75203) add protection for negative
 voltage value
Message-ID: <20220818201359.GA3430651@roeck-us.net>
References: <20220817054321.6519-1-farbere@amazon.com>
 <20220817054321.6519-12-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817054321.6519-12-farbere@amazon.com>
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

On Wed, Aug 17, 2022 at 05:43:16AM +0000, Eliav Farber wrote:
> This change makes sure the returned voltage vlaue is 0 or positive.
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---
>  drivers/hwmon/mr75203.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
> index 24a00339cfd8..e3191f590167 100644
> --- a/drivers/hwmon/mr75203.c
> +++ b/drivers/hwmon/mr75203.c
> @@ -218,6 +218,13 @@ static int pvt_read_in(struct device *dev, u32 attr, int channel, long *val)
>  			return ret;
>  
>  		n &= SAMPLE_DATA_MSK;
> +
> +		/* Voltage can't be negative */

Who says, and what does that mean ? Under which conditions would
the value be negative, and why would that be a problem / bug ?
After all, negative voltages do exist.

Guenter

> +		if (PVT_N_CONST * n < PVT_R_CONST) {
> +			*val = 0;
> +			return 0;
> +		}
> +
>  		/* Convert the N bitstream count into voltage */
>  		*val = pvt->vd[channel].pre_scaler;
>  		*val *= (PVT_N_CONST * n - PVT_R_CONST);
