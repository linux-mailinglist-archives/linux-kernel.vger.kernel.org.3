Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8947517CBF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 07:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbiECE5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 00:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiECE5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 00:57:30 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647F43EB82;
        Mon,  2 May 2022 21:53:58 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id c1so12858540qkf.13;
        Mon, 02 May 2022 21:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2AL/JKHLZMiDrdtYYPFneIU29x/Fvo6xQuo1PE3Elwk=;
        b=mAsS7cKNG2PcNpkIxfZGdFnsrTzZ1+XVZ5/f1toViYts+E+bjdP4sEBqlsxmF1TWOk
         O3YrZ/gM18x/N07rTZ9oT06xFXzhPpPF/o1E216+MTax+Poncw8+a2BIym8xhmdM8l/6
         MdpeGFauQi3zUvv93bedj18NbkrGjFSCrsZ1QmCYCmpVKDebQFdUXyNnR4Q5vkJZZCe9
         3TId3IazbL/n9U9wPkrxOJ3fVc3U8ehSzIz071HGJ+qGWAwoUqBT7V8NDRuPRYDC9HI8
         T00uArG6Nl94iE/Vi0hKBERItx4k7G/0nST+3nEuj/MtjOLrAax2H0GPSoVmQz5k+XBN
         SGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2AL/JKHLZMiDrdtYYPFneIU29x/Fvo6xQuo1PE3Elwk=;
        b=ER9t6yWD2H6h90N/CxaoduYu0p/0WBzkM1Di9IP9Gmgz60PphSBro7FQNRxtWT8iMD
         jTTe85/u5YYDlgOvehFXGdrApbQBR7xoo+mQKDP5rCjK98Pa8ijUU93O0Ks3aAo9nGDZ
         xheJwfzWU3BN4e76dD1k+R6fQrdP7kpk+i7mtVG8gja04FmrT6fdP1TbmvlZ/eKHawpl
         XOCmAheVXJFlLRGlJBiqXzQaAX0iSeCW7uqmHVGArYLk8JKCtMsJUaYue23triiVQ5Kv
         /xePc7KZSoDMLUwQYIUuUNxfpL6ASIAIqcViV+KTfpMEFRyAEwAX2eGJ8+tQkGKrX+rS
         5hOQ==
X-Gm-Message-State: AOAM530E/VQ+C5eTO/FH0f3QdEMnwu5Ib/inDsbCKo68nTWoG6DsYvA9
        Wp7ERTMbHeG+b8vgy1O5g8m0Sxw6Ui9cgKYsrCitdfJeuog=
X-Google-Smtp-Source: ABdhPJxh/EMgybZ61mkZgKwbyOrk5nhF7HHNj5cj5Uh/FQaAgfMFW9AIxqS8YCnNLqNtXnjQqCFP0CvEnSb6ZyV5YpE=
X-Received: by 2002:a37:b886:0:b0:69f:c337:7bb with SMTP id
 i128-20020a37b886000000b0069fc33707bbmr9823558qkf.74.1651553637547; Mon, 02
 May 2022 21:53:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220428125610.66647-1-gengcixi@gmail.com>
In-Reply-To: <20220428125610.66647-1-gengcixi@gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Tue, 3 May 2022 12:54:31 +0800
Message-ID: <CADBw62r8eGRNcXH1cAZvYQdKCgBjxUVnxhLsa=Oyzs-uwavRTA@mail.gmail.com>
Subject: Re: [PATCH v2] power: supply: Add enable the primary charger interface
To:     Cixi Geng <gengcixi@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, chenyongzhi811@gmail.com,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 8:56 PM Cixi Geng <gengcixi@gmail.com> wrote:
>
> From: Chen Yongzhi <Yongzhi.Chen@unisoc.com>
>
> In the case of charging multiple charging ICs,the primary
> charging IC often needs to be turned off in the fast
> charging stage, and only using the charger pump to charge,
> need to add a new power_supply_property attribute.

I'm still confused why introducing a new
POWER_SUPPLY_PROP_CHARGE_ENABLED property to control the charging, but
you already controlled the charging by POWER_SUPPLY_PROP_STATUS?

>
> Signed-off-by: Chen Yongzhi <Yongzhi.Chen@unisoc.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/all/202204230206.9TgyhSb1-lkp@intel.com
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> ---
>  drivers/power/supply/sc2731_charger.c | 52 +++++++++++++++++++++++++--
>  include/linux/power_supply.h          |  1 +
>  2 files changed, 50 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/power/supply/sc2731_charger.c b/drivers/power/supply/sc2731_charger.c
> index 9ac17cf7a126..c15f9b75e6a8 100644
> --- a/drivers/power/supply/sc2731_charger.c
> +++ b/drivers/power/supply/sc2731_charger.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> -// Copyright (C) 2018 Spreadtrum Communications Inc.
> +// Copyright (C) 2022 Spreadtrum Communications Inc.

Do not add unrelated changes.

>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> @@ -146,6 +146,24 @@ static int sc2731_charger_get_status(struct sc2731_charger_info *info)
>         return POWER_SUPPLY_STATUS_CHARGING;
>  }
>
> +static int sc2731_charger_set_status(struct sc2731_charger_info *info, int val)
> +{
> +       int ret = 0;
> +
> +       if (!val && info->charging) {
> +               sc2731_charger_stop_charge(info);
> +               info->charging = false;
> +       } else if (val && !info->charging) {
> +               ret = sc2731_charger_start_charge(info);
> +               if (ret)
> +                       dev_err(info->dev, "start charge failed\n");

Duplicate error information, since you already print errors in
sc2731_charger_usb_set_property()

> +               else
> +                       info->charging = true;
> +       }
> +
> +       return ret;
> +}
> +
>  static int sc2731_charger_get_current(struct sc2731_charger_info *info,
>                                       u32 *cur)
>  {
> @@ -204,7 +222,7 @@ sc2731_charger_usb_set_property(struct power_supply *psy,
>                                 const union power_supply_propval *val)
>  {
>         struct sc2731_charger_info *info = power_supply_get_drvdata(psy);
> -       int ret;
> +       int ret = 0;
>
>         mutex_lock(&info->lock);
>
> @@ -214,6 +232,12 @@ sc2731_charger_usb_set_property(struct power_supply *psy,
>         }
>
>         switch (psp) {
> +       case POWER_SUPPLY_PROP_STATUS:
> +               ret = sc2731_charger_set_status(info, val->intval);
> +               if (ret < 0)
> +                       dev_err(info->dev, "set charge status failed\n");
> +               break;
> +
>         case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
>                 ret = sc2731_charger_set_current(info, val->intval / 1000);
>                 if (ret < 0)
> @@ -227,6 +251,15 @@ sc2731_charger_usb_set_property(struct power_supply *psy,
>                         dev_err(info->dev, "set input current limit failed\n");
>                 break;
>
> +       case POWER_SUPPLY_PROP_CHARGE_ENABLED:
> +               if (val->intval == true) {
> +                       ret = sc2731_charger_start_charge(info);
> +                       if (ret)
> +                               dev_err(info->dev, "start charge failed\n");
> +               } else if (val->intval == false) {
> +                       sc2731_charger_stop_charge(info);
> +               }
> +               break;
>         default:
>                 ret = -EINVAL;
>         }
> @@ -241,7 +274,7 @@ static int sc2731_charger_usb_get_property(struct power_supply *psy,
>  {
>         struct sc2731_charger_info *info = power_supply_get_drvdata(psy);
>         int ret = 0;
> -       u32 cur;
> +       u32 cur, enabled;
>
>         mutex_lock(&info->lock);
>
> @@ -277,6 +310,16 @@ static int sc2731_charger_usb_get_property(struct power_supply *psy,
>                 }
>                 break;
>
> +       case POWER_SUPPLY_PROP_CHARGE_ENABLED:
> +               ret = regmap_read(info->regmap, info->base + SC2731_CHG_CFG0, &enabled);
> +               if (ret) {
> +                       dev_err(info->dev, "get sc2731 charge enabled failed\n");
> +                       goto out;
> +               }
> +
> +               val->intval = enabled & SC2731_CHARGER_PD;
> +
> +               break;
>         default:
>                 ret = -EINVAL;
>         }
> @@ -292,8 +335,10 @@ static int sc2731_charger_property_is_writeable(struct power_supply *psy,
>         int ret;
>
>         switch (psp) {
> +       case POWER_SUPPLY_PROP_STATUS:
>         case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
>         case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +       case POWER_SUPPLY_PROP_CHARGE_ENABLED:
>                 ret = 1;
>                 break;
>
> @@ -308,6 +353,7 @@ static enum power_supply_property sc2731_usb_props[] = {
>         POWER_SUPPLY_PROP_STATUS,
>         POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
>         POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
> +       POWER_SUPPLY_PROP_CHARGE_ENABLED,
>  };
>
>  static const struct power_supply_desc sc2731_charger_desc = {
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index cb380c1d9459..1dfe194d8a5e 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -167,6 +167,7 @@ enum power_supply_property {
>         POWER_SUPPLY_PROP_PRECHARGE_CURRENT,
>         POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
>         POWER_SUPPLY_PROP_CALIBRATE,
> +       POWER_SUPPLY_PROP_CHARGE_ENABLED,
>         POWER_SUPPLY_PROP_MANUFACTURE_YEAR,
>         POWER_SUPPLY_PROP_MANUFACTURE_MONTH,
>         POWER_SUPPLY_PROP_MANUFACTURE_DAY,
> --
> 2.25.1
>


-- 
Baolin Wang
