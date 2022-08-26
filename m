Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6665A27F8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 14:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344016AbiHZMrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 08:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbiHZMrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 08:47:45 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E6BC12D9;
        Fri, 26 Aug 2022 05:47:44 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 12so1329384pga.1;
        Fri, 26 Aug 2022 05:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=Arj98nNDlCzWgvh9P+5/WdVw6hDCg8VNnpc0NYq4W8E=;
        b=JMDrol2qorwhloDEn2HEfpk6Pw63aCLB/6hCVf92+BlPcykLQcdbBZyx6so7h8cn/z
         fGVbxBJP0QzfQZThRrkW/M0+xO9J7H3RgxkfCJ+eFehg6SjIbBXI/KYgqSMZU57MZ2f+
         o/Nkk2PhGtfR2mBFxKrHp4YYMDeIykY/Q6I9L0OX1HQ6MAbFYOCKqO/M6abJQ2re21Ol
         jL7QA7Exx1RCm5VVXfBUSAsDqLAbeKK+v6UmVzG3YGQLk/2+7araJwn3qPefo3JTK/g3
         khdB1Rst1q5bcrxfv+lNq6lkN0/JxOc6pAusOkl2H6F0p/on6LTQTVv8XYatxq6+GHXv
         WyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=Arj98nNDlCzWgvh9P+5/WdVw6hDCg8VNnpc0NYq4W8E=;
        b=TjyUz1wL4wY3SoYf+J88wGPqXh2Kh8ft7/u/7/Ofg2JLUGGqGS6wjJC2rA+BkWJKoe
         6V7kEUPMcANXR+hm3m6zBg7RJOnDrA83UJ1II0GZiFixKuSrWCkv4Aw97+CiNQ+idVVd
         TdvGjpWdL+W5Tg36a1JtSTDdX62gacX9+d2Hn0ft8YcM2HM9xXI90pH3NmY0AOvsKGm7
         BDtvRsGywcOVKLO5sbu3z4SUQDOMaWyOTcOzBMbVkkg1U44Ti32VjYTVJqEjm7u7Is96
         TlDYgD31ArJ/BiqqYZItaKTKgM5gVlTqsqk/xVzI9Mb9Lxkx1fq38MbLb2N8ZYSWxNz5
         2d8A==
X-Gm-Message-State: ACgBeo1L2fIRe4v/tK2C+bbh8jsQg77sB1dAeussL0GI0xGmRzOlC7DX
        MXrjTBgestXSE3r8R6INf2c=
X-Google-Smtp-Source: AA6agR6Q0m8cd8uqSrL6HawKTpplkIo7VUVjWG1k/hit8Fh9ioJf5Otk+ZDwcXXsgganX2iMArBGuQ==
X-Received: by 2002:a05:6a00:2789:b0:531:c43:6290 with SMTP id bd9-20020a056a00278900b005310c436290mr3721119pfb.21.1661518063938;
        Fri, 26 Aug 2022 05:47:43 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o22-20020a63fb16000000b0040cb1f55391sm1373704pgh.2.2022.08.26.05.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 05:47:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 26 Aug 2022 05:47:42 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] hwmon: Add include stubs
Message-ID: <20220826124742.GD2897306@roeck-us.net>
References: <20220825214341.2743-1-W_Armin@gmx.de>
 <20220825214341.2743-2-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825214341.2743-2-W_Armin@gmx.de>
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

On Thu, Aug 25, 2022 at 11:43:40PM +0200, Armin Wolf wrote:
> If CONFIG_HWMON/CONFIG_HWMON_VID was disabled during compile
> time, driver using the hwmon subsystem might fail to compile.

That would be a bug in driver dependencies and is not a problem
to be solved in the hwmon subsystem. Dummies are not provided on
purpose so far because we _want_ driver developers to think about
usage and for them to understand what happens if HWMON is not enabled.

The benefit is that it would reduce the need for conditional code
in drivers registering with hwmon from outside the hwmon subsystem. 

> Provide stubs for such cases.
> 

HWMON_VID is not user selectable, it is only needed by hwmon drivers,
it is mandatory for the drivers needing it, those drivers _must_ select
it, and there must be no dummies.

I am not really sure about the benefits of dummies for HWMON either,
but I am open to discussion. Either case that must be accompanied
by matching driver patches to show its usage, to make sure that there
is no negative impact, to show the benefits, and to get a wider audience.

> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  include/linux/hwmon-vid.h | 18 ++++++++++
>  include/linux/hwmon.h     | 76 ++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 93 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/hwmon-vid.h b/include/linux/hwmon-vid.h
> index 9409e1d207ef..329151416c47 100644
> --- a/include/linux/hwmon-vid.h
> +++ b/include/linux/hwmon-vid.h
> @@ -11,9 +11,27 @@
>  #ifndef _LINUX_HWMON_VID_H
>  #define _LINUX_HWMON_VID_H
> 
> +#include <linux/kconfig.h>
> +
> +#if IS_ENABLED(CONFIG_HWMON_VID)
> +
>  int vid_from_reg(int val, u8 vrm);
>  u8 vid_which_vrm(void);
> 
> +#else
> +
> +static inline int vid_from_reg(int val, u8 vrm)
> +{
> +	return 0;
> +}
> +
> +static inline u8 vid_which_vrm(void)
> +{
> +	return 0;
> +}
> +
> +#endif /* CONFIG_HWMON_VID */
> +
>  /* vrm is the VRM/VRD document version multiplied by 10.
>     val is in mV to avoid floating point in the kernel.
>     Returned value is the 4-, 5- or 6-bit VID code.
> diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
> index 14325f93c6b2..281387ee03bc 100644
> --- a/include/linux/hwmon.h
> +++ b/include/linux/hwmon.h
> @@ -13,6 +13,9 @@
>  #define _HWMON_H_
> 
>  #include <linux/bitops.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/kconfig.h>
> 
>  struct device;
>  struct attribute_group;
> @@ -433,6 +436,8 @@ struct hwmon_chip_info {
>  	const struct hwmon_channel_info **info;
>  };
> 
> +#if IS_ENABLED(CONFIG_HWMON)

This should be IS_REACHABLE(). It doesn't help if HWMON is built as
module and called from an in-kernel driver. Otherwise drivers using it
would still need "depends on HWMON || HWMON=n" and it would still require
conditional code to catch "HWMON enabled but not reachable".

> +
>  /* hwmon_device_register() is deprecated */
>  struct device *hwmon_device_register(struct device *dev);
> 
> @@ -467,6 +472,75 @@ int hwmon_notify_event(struct device *dev, enum hwmon_sensor_types type,
>  char *hwmon_sanitize_name(const char *name);
>  char *devm_hwmon_sanitize_name(struct device *dev, const char *name);
> 
> +#else
> +
> +static inline struct device *hwmon_device_register(struct device *dev)
> +{
> +	return ERR_PTR(-ENODEV);

-ENOTSUPP would probably be a more suitable error code.

> +}
> +
> +static inline struct device
> +*hwmon_device_register_with_groups(struct device *dev, const char *name, void *drvdata,
> +				   const struct attribute_group **groups)
> +{
> +	return ERR_PTR(-ENODEV);
> +}
> +
> +static inline struct device
> +*devm_hwmon_device_register_with_groups(struct device *dev, const char *name, void *drvdata,
> +					const struct attribute_group **groups)
> +{
> +	return ERR_PTR(-ENODEV);
> +}
> +
> +static inline struct device
> +*hwmon_device_register_with_info(struct device *dev, const char *name, void *drvdata,
> +				 const struct hwmon_chip_info *info,
> +				 const struct attribute_group **extra_groups)
> +{
> +	return ERR_PTR(-ENODEV);
> +}
> +
> +static inline struct device *hwmon_device_register_for_thermal(struct device *dev, const char *name,
> +							       void *drvdata)
> +{
> +	return ERR_PTR(-ENODEV);
> +}
> +
> +static inline struct device
> +*devm_hwmon_device_register_with_info(struct device *dev, const char *name, void *drvdata,
> +				      const struct hwmon_chip_info *info,
> +				      const struct attribute_group **extra_groups)
> +{
> +	return ERR_PTR(-ENODEV);
> +}
> +
> +static inline void hwmon_device_unregister(struct device *dev)
> +{
> +}
> +
> +static inline void devm_hwmon_device_unregister(struct device *dev)
> +{
> +}
> +
> +static inline int hwmon_notify_event(struct device *dev, enum hwmon_sensor_types type, u32 attr,
> +				     int channel)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline char *hwmon_sanitize_name(const char *name)
> +{
> +	return ERR_PTR(-ENODEV);
> +}
> +
> +static inline char *devm_hwmon_sanitize_name(struct device *dev, const char *name)
> +{
> +	return ERR_PTR(-ENODEV);
> +}
> +
> +#endif /* CONFIG_HWMON */
> +
>  /**
>   * hwmon_is_bad_char - Is the char invalid in a hwmon name
>   * @ch: the char to be considered
> @@ -490,4 +564,4 @@ static inline bool hwmon_is_bad_char(const char ch)
>  	}
>  }
> 
> -#endif
> +#endif /* _HWMON_H_ */
> --
> 2.30.2
> 
