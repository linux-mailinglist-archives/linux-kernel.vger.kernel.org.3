Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550B15AA336
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 00:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbiIAWkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 18:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233250AbiIAWj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 18:39:59 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347C5D6A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 15:39:49 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 213E85FD07;
        Fri,  2 Sep 2022 01:22:42 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1662070962;
        bh=HO7xBMUIZhzpAMOLw60e4MHt1FwNBaKO3t5nHAguTV8=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=PtDTCYLj+LVS507SPWmSj1JK63LIEqUspqyKLGTY8NV5X8ZlLvoLvzwPL08hCPuwX
         rAAJ3c2X6CjIsT9gkju9OcxKmmpXY5C0Vlkv0Z13fl7UouuaRiDsYAm97G8SSTBJEd
         0V1dwudwDldmqGHNdnzXwG3Ea36DCbtULerzhlDbOEdb2D/A14WJKxh5zsSh7pXUrB
         qvlfGhkWZkCZxoFcrpyjA6DFMZQIuIw3PKSOGlug+xwBWmq1xc45YHjKQmoBk3kSWN
         kxM+3LAtQyHrI/H+jel4j7iF85Wh0C4b7LpRXrV9eO9CDOhQ34o+wYtxV9esfcRdhB
         7zilq5RjMmyRQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Fri,  2 Sep 2022 01:22:42 +0300 (MSK)
Date:   Fri, 2 Sep 2022 01:22:41 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 3/3] regmap: trace: Remove unneeded blank lines
Message-ID: <20220901222241.6dh6duaviipsx7bw@Rockosov-MBP>
References: <20220901132336.33234-1-andriy.shevchenko@linux.intel.com>
 <20220901132336.33234-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220901132336.33234-3-andriy.shevchenko@linux.intel.com>
User-Agent: NeoMutt/20220429
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/09/01 19:49:00 #20211246
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 04:23:36PM +0300, Andy Shevchenko wrote:
> There is a few unneeded blank lines in some of event definitions,
> remove them in order to make those definitions consistent with
> the rest.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/base/regmap/trace.h | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/base/regmap/trace.h b/drivers/base/regmap/trace.h
> index a0f83e44a9d1..704e106e5dbd 100644
> --- a/drivers/base/regmap/trace.h
> +++ b/drivers/base/regmap/trace.h
> @@ -41,7 +41,6 @@ DEFINE_EVENT(regmap_reg, regmap_reg_write,
>  		 unsigned int val),
>  
>  	TP_ARGS(map, reg, val)
> -
>  );
>  
>  DEFINE_EVENT(regmap_reg, regmap_reg_read,
> @@ -50,7 +49,6 @@ DEFINE_EVENT(regmap_reg, regmap_reg_read,
>  		 unsigned int val),
>  
>  	TP_ARGS(map, reg, val)
> -
>  );
>  
>  DEFINE_EVENT(regmap_reg, regmap_reg_read_cache,
> @@ -59,7 +57,6 @@ DEFINE_EVENT(regmap_reg, regmap_reg_read_cache,
>  		 unsigned int val),
>  
>  	TP_ARGS(map, reg, val)
> -
>  );
>  
>  DECLARE_EVENT_CLASS(regmap_bulk,
> @@ -199,7 +196,6 @@ DEFINE_EVENT(regmap_bool, regmap_cache_only,
>  	TP_PROTO(struct regmap *map, bool flag),
>  
>  	TP_ARGS(map, flag)
> -
>  );
>  
>  DEFINE_EVENT(regmap_bool, regmap_cache_bypass,
> @@ -207,7 +203,6 @@ DEFINE_EVENT(regmap_bool, regmap_cache_bypass,
>  	TP_PROTO(struct regmap *map, bool flag),
>  
>  	TP_ARGS(map, flag)
> -
>  );
>  
>  DECLARE_EVENT_CLASS(regmap_async,
> @@ -239,7 +234,6 @@ DEFINE_EVENT(regmap_async, regmap_async_io_complete,
>  	TP_PROTO(struct regmap *map),
>  
>  	TP_ARGS(map)
> -
>  );
>  
>  DEFINE_EVENT(regmap_async, regmap_async_complete_start,
> @@ -247,7 +241,6 @@ DEFINE_EVENT(regmap_async, regmap_async_complete_start,
>  	TP_PROTO(struct regmap *map),
>  
>  	TP_ARGS(map)
> -
>  );
>  
>  DEFINE_EVENT(regmap_async, regmap_async_complete_done,
> @@ -255,7 +248,6 @@ DEFINE_EVENT(regmap_async, regmap_async_complete_done,
>  	TP_PROTO(struct regmap *map),
>  
>  	TP_ARGS(map)
> -
>  );
>  
>  TRACE_EVENT(regcache_drop_region,
> -- 
> 2.35.1
> 

Reviewed-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>

-- 
Thank you,
Dmitry
