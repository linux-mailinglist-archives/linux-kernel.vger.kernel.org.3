Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55CB85A8650
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 21:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbiHaTAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 15:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbiHaTAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 15:00:32 -0400
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F10313CD0;
        Wed, 31 Aug 2022 12:00:31 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id y197so5519115yby.13;
        Wed, 31 Aug 2022 12:00:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=8GRPBJfRUNFNbBxX5ff3oJ5k+8sP9Y+7/xpPrXBmKjo=;
        b=21am6jtuPoOfEPkR8UgSzMZUSGHnHpGX7PvXr2/D1QJlBFtMYPX3uMSqTzAoDIQD22
         njVzw/1d7gpQENCx5H0aWXBf7dPzxd8QeN6ourbzy1P3ZAp7HatWQ8aJDzEVjy5SgBtj
         74ZRh2/0+7MRokPMeSAxct6eEuhx0XlfPufPE478+k7jGVu5LkuqOT2Zu3B/fIcW4dKj
         QhntNQFJqIkArrEFkqDNs+j7usYp/pc3z4SYwxw3gBAhrXsHD7/wzlvf1Vv+OnF6VxVK
         Okd0mnlJNaRYDs6U5bCtIB0Ui+Nph0qEAiChC6ghsQ3ozLhcn25EYRZl3K3i0e/meYyc
         +mbA==
X-Gm-Message-State: ACgBeo19lVJAjZr+rWZkycUJUdcjzf9hPYSdrVIB3HwdeesuyBHl/pfS
        w4bMKtVktXh1ywbj/PL3eMbSfspodJUnY7qepDA=
X-Google-Smtp-Source: AA6agR543/dw33qtXK4P6Kd52hv2N774zJwops7LeT4eJYxn/ObQoyDaOgoIZfIbNoEDiBPqHHxyQUPLkcg2jTVMyAg=
X-Received: by 2002:a25:8d84:0:b0:695:836a:fcaf with SMTP id
 o4-20020a258d84000000b00695836afcafmr16460939ybl.633.1661972430301; Wed, 31
 Aug 2022 12:00:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220812063926.12924-1-zhaoxiao@uniontech.com>
In-Reply-To: <20220812063926.12924-1-zhaoxiao@uniontech.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 31 Aug 2022 21:00:19 +0200
Message-ID: <CAJZ5v0gpBco1OmKiMXm5fatFRuQYpCo5g8Cauh4S+BV+OxWJWw@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/da9062: Remove unnecessary print function dev_err()
To:     zhaoxiao <zhaoxiao@uniontech.com>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
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

On Fri, Aug 12, 2022 at 8:40 AM zhaoxiao <zhaoxiao@uniontech.com> wrote:
>
> The print function dev_err() is redundant because platform_get_irq()
> already prints an error.
>
> Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
> ---
>  drivers/thermal/da9062-thermal.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/da9062-thermal.c b/drivers/thermal/da9062-thermal.c
> index 180edec34e07..7dcfde7a9f2c 100644
> --- a/drivers/thermal/da9062-thermal.c
> +++ b/drivers/thermal/da9062-thermal.c
> @@ -248,10 +248,9 @@ static int da9062_thermal_probe(struct platform_device *pdev)
>                 jiffies_to_msecs(thermal->zone->passive_delay_jiffies));
>
>         ret = platform_get_irq_byname(pdev, "THERMAL");
> -       if (ret < 0) {
> -               dev_err(&pdev->dev, "Failed to get platform IRQ.\n");
> +       if (ret < 0)
>                 goto err_zone;
> -       }
> +
>         thermal->irq = ret;
>
>         ret = request_threaded_irq(thermal->irq, NULL,
> --

Applied as 6.1 material with subject and changelog edits, thanks!
