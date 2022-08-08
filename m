Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A418358C982
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 15:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242767AbiHHNcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 09:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235935AbiHHNcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 09:32:02 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B145160D0;
        Mon,  8 Aug 2022 06:32:01 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id p14-20020a17090a74ce00b001f4d04492faso9063963pjl.4;
        Mon, 08 Aug 2022 06:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=Twt5AD2s3wv06COKI4ppJ5TzEYgSWLqtu15XcAMR+Hw=;
        b=OjqdWuCYE4QWCOKC0YabaJ1QMf0iCkaw/TeDCmt1mw2rqDwWFz3z7wwDNVYimgP4Ua
         ++B421ajFBk9w9J2ImuQvzx9ISUHdlsrZm36djDbIvj2OFMbCLvcI2/aDdQ2VDQ+qV6G
         +ri+uwKydgcDqP6CbZBlz4lKM4qZen9gt0at17uolMNZJkdKVEff+/sF6VSJqA5E4/oo
         NRASVPirtpeAnIJr0ZJmShbWLu+pcFuTbwHzd2/xu5j6ybcZ9D7XMF9tyWTWes+1RJFU
         PG7hnkTtXYR5RPW5dNK+Qbdjc1h6sk5sZi6HwJ9BPpIdm20kcJZ79nLkIWtiyftvyrpb
         BNhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=Twt5AD2s3wv06COKI4ppJ5TzEYgSWLqtu15XcAMR+Hw=;
        b=mSXFQajCZ2DVAkjpw6HYTzcoF410FpJhvlF3Bff3HTlMPWz9MKwY8C+kiv+02NETW/
         W4AoGYO9Q/D3hGmhzvk1dn3589BbLSf49hImAmM6B9DYA2DZw4uG7wWcIkqwUjb4uUn6
         2yMS8XunxuGeCPKHLrjyDR1zOYMcD2s1zLwFidyew0fUsIUbu/BFDKA2xOn1777rMZ5F
         3PzbT2K1L6XwyazEob5yQDVcO3ZG9KhmZTg/RnO4myWrMLcP2g2Aa/OVf8sFYkmVfOMr
         oRsuvvLaw0li/l58jJoUyBqifgCQ5/mcvw4KvnCQD+y/JdP96DdsOIAYRhALltIUOgd/
         aDkQ==
X-Gm-Message-State: ACgBeo1J+/8N438lh8P8N/IBaAXebEonYHwDRCOepiyolCCP0Ln74BEl
        EZkODmWZkGAhL0tcoPvGymk=
X-Google-Smtp-Source: AA6agR5WkDCG5f08dZwZC2PzYuaRCljA53v/T/tZObY+GtDg3eeCL51brPMq+XuMzMwY6ckPGV3WBw==
X-Received: by 2002:a17:90a:f016:b0:1f4:e30c:188d with SMTP id bt22-20020a17090af01600b001f4e30c188dmr29056783pjb.60.1659965521217;
        Mon, 08 Aug 2022 06:32:01 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id im22-20020a170902bb1600b0016dcc381bbasm8678396plb.144.2022.08.08.06.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 06:31:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 8 Aug 2022 06:31:58 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: w83977f_wdt: Fix comment typo
Message-ID: <20220808133158.GB2347272@roeck-us.net>
References: <20220802201109.6843-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802201109.6843-1-wangborong@cdjrlc.com>
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

On Wed, Aug 03, 2022 at 04:11:09AM +0800, Jason Wang wrote:
> The double `we' is duplicated in the comment, remove one.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/w83977f_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/w83977f_wdt.c b/drivers/watchdog/w83977f_wdt.c
> index fd64ae77780a..31bf21ceaf48 100644
> --- a/drivers/watchdog/w83977f_wdt.c
> +++ b/drivers/watchdog/w83977f_wdt.c
> @@ -321,7 +321,7 @@ static int wdt_release(struct inode *inode, struct file *file)
>   *      @ppos: pointer to the position to write. No seeks allowed
>   *
>   *      A write to a watchdog device is defined as a keepalive signal. Any
> - *      write of data will do, as we we don't define content meaning.
> + *      write of data will do, as we don't define content meaning.
>   */
>  
>  static ssize_t wdt_write(struct file *file, const char __user *buf,
> -- 
> 2.35.1
> 
> 
