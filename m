Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3ABB5AC074
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 19:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbiICR5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 13:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiICR5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 13:57:04 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A6C53023;
        Sat,  3 Sep 2022 10:57:03 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-334dc616f86so41016307b3.8;
        Sat, 03 Sep 2022 10:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=6Z8GKPwv0VpZ/qZskdH19bolEfM25JaWF8WrYodGaEA=;
        b=xfvitAcCgC/r/bW0pcjdTbBSukBZvKgRwpA/wUObv0TPKF2iW74bpp7m9X6Oca1Glo
         w+ClXo9GAjlhrq0OWX1PIYFgt3QgcCaNdJ+Gg02CGM1PNFexHxi8luxUgRqxr+xuk0NK
         HyMm7Xfs3z9m7kOh1kj0FuYa5y2nFdhe81+FTdHhfYMqQhv5EVN2vDHVuxF9/RID7oqE
         XQtRQMJvKcNA34N1DKInGZjx6ffIUTRJ3vXW1R+eQy9w4d2L8hfPTl5MsV+tMlzvlOjG
         jDVdPkTlXbXiJFReBKmmhJ3LyvPhTZ84/QpzuRwQ39g82PiBW1WV5vOEcCysQFYP2Gqo
         n4Yg==
X-Gm-Message-State: ACgBeo2TvUy9GPgFXBilFWv1CmwFDOWg/2qijO0ZEZRiTCBiNeND0kD9
        TnSRZDPXxlco5sDFr+xys+rgo4jUlK+lzYKC1YM=
X-Google-Smtp-Source: AA6agR7JLebP8UxAPve8tgfo84lBxzbx6wgRHlv9HUdLlk3fI/fr3SLoR4I3bxBuuOiTGg/lOxi+zcGvtfX0R1TjtOY=
X-Received: by 2002:a0d:e701:0:b0:336:90d7:c67a with SMTP id
 q1-20020a0de701000000b0033690d7c67amr31474683ywe.7.1662227822857; Sat, 03 Sep
 2022 10:57:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220822123239.28400-1-yuanjilin@cdjrlc.com>
In-Reply-To: <20220822123239.28400-1-yuanjilin@cdjrlc.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 3 Sep 2022 19:56:51 +0200
Message-ID: <CAJZ5v0idwPoK_VoHXTNr+eGzq8+d2=Y0v1sxS7NmwX-PkvNSBA@mail.gmail.com>
Subject: Re: [PATCH] drivers/thermal: fix repeated words in comments
To:     Jilin Yuan <yuanjilin@cdjrlc.com>
Cc:     Amit Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 2:32 PM Jilin Yuan <yuanjilin@cdjrlc.com> wrote:
>
>  Delete the redundant word 'device'.
>  Delete the redundant word 'which'.
>
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
> ---
>  drivers/thermal/cpufreq_cooling.c | 2 +-
>  drivers/thermal/thermal_of.c      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
> index b8151d95a806..13551b386e72 100644
> --- a/drivers/thermal/cpufreq_cooling.c
> +++ b/drivers/thermal/cpufreq_cooling.c
> @@ -495,7 +495,7 @@ static struct thermal_cooling_device_ops cpufreq_cooling_ops = {
>
>  /**
>   * __cpufreq_cooling_register - helper function to create cpufreq cooling device
> - * @np: a valid struct device_node to the cooling device device tree node
> + * @np: a valid struct device_node to the cooling device tree node
>   * @policy: cpufreq policy
>   * Normally this should be same as cpufreq policy->related_cpus.
>   * @em: Energy Model of the cpufreq policy
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index b65d435cb92f..91bbed308305 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -651,7 +651,7 @@ EXPORT_SYMBOL_GPL(devm_thermal_zone_of_sensor_register);
>  /**
>   * devm_thermal_zone_of_sensor_unregister - Resource managed version of
>   *                             thermal_zone_of_sensor_unregister().
> - * @dev: Device for which which resource was allocated.
> + * @dev: Device for which resource was allocated.
>   * @tzd: a pointer to struct thermal_zone_device where the sensor is registered.
>   *
>   * This function removes the sensor callbacks and private data from the
> --

Applied (as 6.1 material) under edited subject and with rewritten changelog.

Thanks!
