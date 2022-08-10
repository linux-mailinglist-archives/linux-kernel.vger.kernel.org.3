Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7CFF58EB9A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 13:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbiHJL6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 07:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiHJL63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 07:58:29 -0400
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFD082FB0;
        Wed, 10 Aug 2022 04:58:28 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id n8so22910179yba.2;
        Wed, 10 Aug 2022 04:58:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=9JfEXzMfTVhBDtMwX1BN6FvfajX+PQlhsv3StGgPVb8=;
        b=jJB4IWtjqPXUxg9OSUQwxC311sMqioUSXU1pPhSzV9LoW+WPq767YdKr6tfu2tabm4
         Cz9wCEy05J4/fXagJngDkuZ0p3tJS78cmRgfIngu18TLZ0eYTePR6yc2yAa/M5UUP5TH
         FG+KQ9EXD7tIDil9rZKP9Nek0heKZiyXrv6JdoiCY4Nv5luBoyWP+iCfm0YcRd4lhnC1
         DUHt6Xi52oq4yeYp43y6/V7ojQ74R3ccQqnNLTzBVKKrorcPLLWniyOqWo+X+WFW3g2O
         3gd8Jg/7irXdRmLSI4V2S9JzYXsvJ1il4MkJkTBpD6+b1PP/GyNpGZ3mXBZFF5WGYEUl
         H6iA==
X-Gm-Message-State: ACgBeo0nzIFBFmVdbPHWOOJsXkf7iDMLakJ1/HD4iZdr5ekXi9f0zzuY
        aTSyTf6W3rUbzX3B0njles4YKzqJSLVzBsNmnR0=
X-Google-Smtp-Source: AA6agR51DXRic5c2iVTQUsTfKSb8eitFjRfO/qijCuvkAKyoV4mVlvBjWayvltMVuTJJPkSWi/YA7mjcqIMl5wS0OwM=
X-Received: by 2002:a25:24ca:0:b0:67c:439f:1d59 with SMTP id
 k193-20020a2524ca000000b0067c439f1d59mr2477278ybk.81.1660132707603; Wed, 10
 Aug 2022 04:58:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220810100731.749317-1-daniel.lezcano@linaro.org>
In-Reply-To: <20220810100731.749317-1-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 10 Aug 2022 13:58:15 +0200
Message-ID: <CAJZ5v0iv4oMsZyUg7-YY6cD2jsYyLdi7sDeE0GEm814kCEAvmQ@mail.gmail.com>
Subject: Re: [PATCH] thermal/core: Add missing EXPORT_SYMBOL_GPL
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
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

On Wed, Aug 10, 2022 at 12:07 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The function thermal_zone_device_register_with_trips() is not exported
> for modules.
>
> Add the missing EXPORT_SYMBOL_GPL().
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

A Fixes tag missing?

> ---
>  drivers/thermal/thermal_core.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index b4c68410c158..10c979dce512 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1329,6 +1329,7 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
>         kfree(tz);
>         return ERR_PTR(result);
>  }
> +EXPORT_SYMBOL_GPL(thermal_zone_device_register_with_trips);
>
>  struct thermal_zone_device *thermal_zone_device_register(const char *type, int ntrips, int mask,
>                                                          void *devdata, struct thermal_zone_device_ops *ops,
> --
> 2.34.1
>
