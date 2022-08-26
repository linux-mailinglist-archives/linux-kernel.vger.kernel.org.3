Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5C75A27BB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 14:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240209AbiHZMXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 08:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343946AbiHZMXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 08:23:38 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B403FC38;
        Fri, 26 Aug 2022 05:23:31 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id z187so1375413pfb.12;
        Fri, 26 Aug 2022 05:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=ABA6MOjoBqLgAQYvm4GjUj7yyml/Z4V8cSOkonOq26M=;
        b=pwh2HRetkTW7Ka8kEqlRhKBD2Qm08Iccfe/AjJYbPiDUbLnzx+PzxJDgHVXT2wV+u7
         fhw+jsFZ+doPe1aFfTLCbsP/YjoCHywMEkLr3t8CyFYAYuZH4A/FfBIo1apvpjo3u6kP
         3xN5fTTV0RJfn2JJV8zu1Lw6ht0RjKlyX76z8Bk7EeIipt1nSVGes0D6YTNqLeR+/GU7
         qB7jTjSc+SIDkiOQ5R0bDltLWSdUNFB2hBNnxU8T24dykYOfezy80yHV8n/jnAQTFUpA
         Y89JYmxldPs92iu1+6G43EnxGHfu88Trp7LGiIqBxb3VIUx3VpOOWHrmXG2tqtBkSQoW
         g32A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=ABA6MOjoBqLgAQYvm4GjUj7yyml/Z4V8cSOkonOq26M=;
        b=XKhTPv7MgOovBGNvSarPvITDeuPh/4JXr7zKyhRovva59VD0FDThvPp9e9jguIINM7
         9VWueebGwZMw6L9LbyyZiMJn7xUbXtz+h/DcDFCar+47JrFCt/tGiDL9G8/QlLImB4Xy
         2WiumvvLkbq784AbLGLslIy9GZi3rssBRi1ahC3VH+txiCd/xYawCNAtiWxfP/vUP76R
         uZhAxScpEnz4KJJ836SbQ1DFm1K3qp6XUrjjlGchXAPWOcUaAxfADGFthnmp8SC047mU
         HSjqUfGGGX/lKUUdNdTYVQSQO2E0HxnuBmUEt2fj7bSzjYg+HckAksp3egUcC0A+o4rT
         MoMw==
X-Gm-Message-State: ACgBeo0xhV5SqS1ZUTChPCMSJfKqgDeFmG/y2oHi6JXUTiaK57MNcibW
        P5bYkGi3WWEhvy8RTUODbCY=
X-Google-Smtp-Source: AA6agR4v2t1q9dOQFzla8ew9Ttz+DdPisQLBIJIs46X0K18TYDtE9IJytbcOQctkb1PrcrmEQmqOtA==
X-Received: by 2002:a63:b24e:0:b0:42a:b42b:3826 with SMTP id t14-20020a63b24e000000b0042ab42b3826mr3014232pgo.605.1661516611212;
        Fri, 26 Aug 2022 05:23:31 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h7-20020aa796c7000000b005364c8786b7sm1583474pfq.215.2022.08.26.05.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 05:23:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 26 Aug 2022 05:23:29 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: Use struct definitions from header files
Message-ID: <20220826122329.GC2897306@roeck-us.net>
References: <20220825214341.2743-1-W_Armin@gmx.de>
 <20220825214341.2743-3-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825214341.2743-3-W_Armin@gmx.de>
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

On Thu, Aug 25, 2022 at 11:43:41PM +0200, Armin Wolf wrote:
> The structs attribute_group and device are provided
> by linux/sysfs.h and linux/device.h.
> Use those definitions.
> 

No. The limited definitions are on purpose, meaning the details
are not needed in this header file and that drivers using the
structures must include the necessary files directly. That is what
struct declarations without details are to be used for in C, and
there is neither a desire nor need to change that code.

Guenter

> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  include/linux/hwmon.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
> index 281387ee03bc..e8acc35af12d 100644
> --- a/include/linux/hwmon.h
> +++ b/include/linux/hwmon.h
> @@ -13,12 +13,11 @@
>  #define _HWMON_H_
> 
>  #include <linux/bitops.h>
> +#include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/errno.h>
>  #include <linux/kconfig.h>
> -
> -struct device;
> -struct attribute_group;
> +#include <linux/sysfs.h>
> 
>  enum hwmon_sensor_types {
>  	hwmon_chip,
> --
> 2.30.2
> 
