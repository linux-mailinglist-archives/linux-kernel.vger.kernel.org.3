Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0094F5AA337
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 00:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235126AbiIAWkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 18:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbiIAWj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 18:39:59 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E92DA2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 15:39:49 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 8D0C85FD05;
        Fri,  2 Sep 2022 01:22:19 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1662070939;
        bh=8NYQ8TiEoubycwd0qSsig772N0wdowFhknhOlLJw32Q=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=Rqti4u1BU2pWUvB8I7bwcHhiWZ9/5mCy4uFtGE695ggPqEvD2BkVv7rh4ZEfzn74O
         O3vuzVAc/MuSljpoEG+u6uZoPsSmKpSq1T6QoZOM5ujJ4+ZgxdDUP/Ig9VN50X3Pzc
         340a/iKkuKMh/6V3+ztiMZU4hUGQMWmHnYDN6xmUvSdDd8HPmzCbYfQOUL9MOTgh2s
         v1JdHskPJe+Q3Kt6513gwT7QnShnMFZYqc4/FFUPZYYFk6AXYl8WHXjFJI2RP/pSe9
         0ItdquOHRvr5kxivBrXdmA+3/zYGzx9bXQ4VkAgYEcE7BJnKCAv6defBHYiH5UU0d2
         9v4j0R0QfkSIQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Fri,  2 Sep 2022 01:22:19 +0300 (MSK)
Date:   Fri, 2 Sep 2022 01:22:18 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 2/3] regmap: trace: Remove explicit castings
Message-ID: <20220901222218.ytusdn7xvgiru7qw@Rockosov-MBP>
References: <20220901132336.33234-1-andriy.shevchenko@linux.intel.com>
 <20220901132336.33234-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220901132336.33234-2-andriy.shevchenko@linux.intel.com>
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

On Thu, Sep 01, 2022 at 04:23:35PM +0300, Andy Shevchenko wrote:
> There is no need to have explicit castings to the same type the
> variables are of. Remove the explicit castings.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/base/regmap/trace.h | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/base/regmap/trace.h b/drivers/base/regmap/trace.h
> index e92edc4f4ca5..a0f83e44a9d1 100644
> --- a/drivers/base/regmap/trace.h
> +++ b/drivers/base/regmap/trace.h
> @@ -32,9 +32,7 @@ DECLARE_EVENT_CLASS(regmap_reg,
>  		__entry->val = val;
>  	),
>  
> -	TP_printk("%s reg=%x val=%x", __get_str(name),
> -		  (unsigned int)__entry->reg,
> -		  (unsigned int)__entry->val)
> +	TP_printk("%s reg=%x val=%x", __get_str(name), __entry->reg, __entry->val)
>  );
>  
>  DEFINE_EVENT(regmap_reg, regmap_reg_write,
> @@ -85,8 +83,7 @@ DECLARE_EVENT_CLASS(regmap_bulk,
>  		memcpy(__get_dynamic_array(buf), val, val_len);
>  	),
>  
> -	TP_printk("%s reg=%x val=%s", __get_str(name),
> -		  (unsigned int)__entry->reg,
> +	TP_printk("%s reg=%x val=%s", __get_str(name), __entry->reg,
>  		  __print_hex(__get_dynamic_array(buf), __entry->val_len))
>  );
>  
> @@ -124,9 +121,7 @@ DECLARE_EVENT_CLASS(regmap_block,
>  		__entry->count = count;
>  	),
>  
> -	TP_printk("%s reg=%x count=%d", __get_str(name),
> -		  (unsigned int)__entry->reg,
> -		  (int)__entry->count)
> +	TP_printk("%s reg=%x count=%d", __get_str(name), __entry->reg, __entry->count)
>  );
>  
>  DEFINE_EVENT(regmap_block, regmap_hw_read_start,
> @@ -196,8 +191,7 @@ DECLARE_EVENT_CLASS(regmap_bool,
>  		__entry->flag = flag;
>  	),
>  
> -	TP_printk("%s flag=%d", __get_str(name),
> -		  (int)__entry->flag)
> +	TP_printk("%s flag=%d", __get_str(name), __entry->flag)
>  );
>  
>  DEFINE_EVENT(regmap_bool, regmap_cache_only,
> @@ -283,8 +277,7 @@ TRACE_EVENT(regcache_drop_region,
>  		__entry->to = to;
>  	),
>  
> -	TP_printk("%s %u-%u", __get_str(name), (unsigned int)__entry->from,
> -		  (unsigned int)__entry->to)
> +	TP_printk("%s %u-%u", __get_str(name), __entry->from, __entry->to)
>  );
>  
>  #endif /* _TRACE_REGMAP_H */
> -- 
> 2.35.1
> 

Reviewed-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>

-- 
Thank you,
Dmitry
