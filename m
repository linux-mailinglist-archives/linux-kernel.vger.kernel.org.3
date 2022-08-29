Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1065A4E8E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiH2Nus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiH2Nup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:50:45 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2B77B782;
        Mon, 29 Aug 2022 06:50:41 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c2so8055906plo.3;
        Mon, 29 Aug 2022 06:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=0hBreP0sFKm76ra4oI39Oq0qexhwJi0T+CU6J4jc94I=;
        b=mnsYgcEgUxpAoiOvyPca6HBWLspzWPiTPLZTcYhY0Bkbh5C330HCnK6cj2RXJJ1lTo
         ohakg23c2DAvDvYeMbDh7CKtX4y0Zbf4wZsnxzzLeJAzHmvO/S1LbPHIs1Tg719dg/vU
         YsmUKtFwqPpFjtYiejgPWaMTKXsdxTvT/rVIf0Hk0Ykl7pcjZw/3We6X4/iJFsgl4R3G
         G1RCjbPFRWyyVDv1WwhfbuBCiKBpDGrCSoAXEVhUAxbmUuAswY7DS91H91x8M2ugMolO
         GJaDwVzNo1/fsJ4LCWdZ8VtadzwEu3pcDgH5JQhDXAh7GrTfwDQiIS6IinAZ+C6b2TvY
         LsoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=0hBreP0sFKm76ra4oI39Oq0qexhwJi0T+CU6J4jc94I=;
        b=gRFOn5qDrBqjYNT/bE+XwL4nRYne/heVbUXmIccHzL/mHNm/2jJTQH5ovr+kR9xq4k
         1S/ZC+mUKYYKHijQDlBEdMJBTSHi7TIgst+nx3e8uQBEPjIaxsYGU+bIG7sHiqJj95zI
         btsyiBiAH5XT3AXG+M2KeAUHvFrgYAgOlRZCopMF6p5eRDu7WgBGTngNt/1iJpKXd94k
         +7YGLRJTEJ4cmcC0T1ADweWsAV3ifNXNoenxbGETWgm8gYKjepZ3cGnW/EvMmgtu0BwN
         UJAqEtQoSdnlFJs2Y0jPuQnRBZWRVG7fEgHEJPfCAkroXHlb/e5APG9u+4JaQyCCmUG1
         DR2w==
X-Gm-Message-State: ACgBeo3Woz9xdcPdAso8k77f6HvZnJhaFIkC1o4cAz+lY8uYAMCAWbTz
        h0759J0B6ZadUy46vhe/+8I=
X-Google-Smtp-Source: AA6agR5yTGFgMhsii6aw0Qs7LKZgtye3AaE2MEPVyvPTmQyaTGHJiVDclwoc5t2Ym61HMGER7CuYAw==
X-Received: by 2002:a17:902:b489:b0:171:5091:d53b with SMTP id y9-20020a170902b48900b001715091d53bmr16947159plr.44.1661781040710;
        Mon, 29 Aug 2022 06:50:40 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x11-20020a65538b000000b0041c3ab14ca1sm6509549pgq.0.2022.08.29.06.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 06:50:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 29 Aug 2022 06:50:39 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     pali@kernel.org, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] hwmon: (dell-smm) Add FW_BUG to SMM warning
 message
Message-ID: <20220829135039.GA37694@roeck-us.net>
References: <20220822174053.8750-1-W_Armin@gmx.de>
 <20220822174053.8750-2-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822174053.8750-2-W_Armin@gmx.de>
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

On Mon, Aug 22, 2022 at 07:40:52PM +0200, Armin Wolf wrote:
> When a SMM call takes very long to execute, then it definitely
> is a firmware bug which should be marked with FW_BUG.
> Also add the number of the buggy SMM call to the warning message
> so BIOS developers, etc immediately know which part of the SMM
> interface is buggy.
> 

I am not going to apply this patch.

It is well known that some of those calls take forever to execute,
and the current limit is just an assumption. This may be a firmware
bug, or it works as expected. We simply don't know, and we can not
declare it to be a firmware bug unless we have confirmation from Dell.

Guenter

> Tested on a Dell Inspiron 3505.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/hwmon/dell-smm-hwmon.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> --
> 2.30.2
> 
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> index 7f8d95dd2717..9cac80358072 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -26,6 +26,7 @@
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/platform_device.h>
> +#include <linux/printk.h>
>  #include <linux/proc_fs.h>
>  #include <linux/seq_file.h>
>  #include <linux/slab.h>
> @@ -198,7 +199,7 @@ static int i8k_smm_func(void *par)
>  		 eax, ebx, regs->eax & 0xffff, carry, duration);
> 
>  	if (duration > DELL_SMM_MAX_DURATION)
> -		pr_warn_once("SMM call took %lld usecs!\n", duration);
> +		pr_warn_once(FW_BUG "SMM call 0x%.4x took %lld usecs!\n", eax, duration);
> 
>  	if (carry || (regs->eax & 0xffff) == 0xffff || regs->eax == eax)
>  		return -EINVAL;
