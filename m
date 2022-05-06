Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C5151DF2A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 20:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345942AbiEFSiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 14:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiEFSiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 14:38:04 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63006D845;
        Fri,  6 May 2022 11:34:20 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id y2so14311753ybi.7;
        Fri, 06 May 2022 11:34:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nC6W8a6qKsChzlkK2pVqEzNOxfTALLGgiZco+DC/LTQ=;
        b=PfWR4Uz9loLMGXh/LDsr/xU92RagjqklW9Sp2GW/0j5jmqHSY7UaJgg86vxPlbYq2M
         aoumjplGyHco2TFchSY0n70O++9Ci4EuMsdagkeO0GYs7aWyjhBDOrq7uQfOwa0kTLK5
         TBQVny7fOYmE0zRDubeRVeLHIfNPO+7+Cw4w0mEu/fvTfbSr5BAwNk3+wJByk1hrIrfo
         kr7YrXLWwFRJ8EQX/YwutVwnDloZJIneuliFskBnoR6a09OMmg3ItWDnOY3iBYHq2Lgh
         IMEiHrTTAR9jIimfED5uUuyjWJkM5dYr/fn8kRfrotFTeT+uG2tdyRJjRxh96XLXPkAG
         pyYQ==
X-Gm-Message-State: AOAM530tb5Lsp3J+HVuaU4VKaQimp2J+jmfZWuMDx1HwpFjfi7AiokWN
        zlinZAvccH4vNrj05xjE/xEnsR/a/4DuHXqF4D7Sj+hc
X-Google-Smtp-Source: ABdhPJzqHNjf6f+rGOKdsFqTdsMPlLXnR/Fgsi9gO3TRsaCEyyHQjNRtH6iZoSKX2iJDJ2UJrDZvvjlOhBbzwTr0qSQ=
X-Received: by 2002:a05:6902:352:b0:63e:94c:883c with SMTP id
 e18-20020a056902035200b0063e094c883cmr3307517ybs.365.1651862060042; Fri, 06
 May 2022 11:34:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220425021407.486916-1-ian@linux.cowan.aero>
In-Reply-To: <20220425021407.486916-1-ian@linux.cowan.aero>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 6 May 2022 20:34:09 +0200
Message-ID: <CAJZ5v0hb9Goj9N+VCfAB9Fy+HA7EqG=Z+XJo1t53KcmF62-PbA@mail.gmail.com>
Subject: Re: [PATCH] drivers: acpi: clean up spaces to be consistent
To:     Ian Cowan <ian@linux.cowan.aero>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 4:14 AM Ian Cowan <ian@linux.cowan.aero> wrote:
>
> This cleans up a few line spaces so that it is consistent with the rest
> of the file. There are a few places where a space was added before a
> return and two spots where a double line space was made into one line
> space.
>
> Signed-off-by: Ian Cowan <ian@linux.cowan.aero>
> ---
>  drivers/acpi/ac.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
> index db487ff9dd1b..f8ec48cd7659 100644
> --- a/drivers/acpi/ac.c
> +++ b/drivers/acpi/ac.c
> @@ -32,7 +32,6 @@ MODULE_AUTHOR("Paul Diefenbaugh");
>  MODULE_DESCRIPTION("ACPI AC Adapter Driver");
>  MODULE_LICENSE("GPL");
>
> -
>  static int acpi_ac_add(struct acpi_device *device);
>  static int acpi_ac_remove(struct acpi_device *device);
>  static void acpi_ac_notify(struct acpi_device *device, u32 event);
> @@ -125,6 +124,7 @@ static int get_ac_property(struct power_supply *psy,
>         default:
>                 return -EINVAL;
>         }
> +
>         return 0;
>  }
>
> @@ -190,12 +190,14 @@ static int acpi_ac_battery_notify(struct notifier_block *nb,
>  static int __init thinkpad_e530_quirk(const struct dmi_system_id *d)
>  {
>         ac_sleep_before_get_state_ms = 1000;
> +
>         return 0;
>  }
>
>  static int __init ac_only_quirk(const struct dmi_system_id *d)
>  {
>         ac_only = 1;
> +
>         return 0;
>  }

I don't really think that it is useful to add empty lines in the two
cases above.

The rest of the patch is fine with me.

>
> @@ -286,6 +288,7 @@ static int acpi_ac_resume(struct device *dev)
>                 return 0;
>         if (old_state != ac->state)
>                 kobject_uevent(&ac->charger->dev.kobj, KOBJ_CHANGE);
> +
>         return 0;
>  }
>  #else
> @@ -296,7 +299,6 @@ static int acpi_ac_remove(struct acpi_device *device)
>  {
>         struct acpi_ac *ac = NULL;
>
> -
>         if (!device || !acpi_driver_data(device))
>                 return -EINVAL;
>
> --
> 2.35.1
>
