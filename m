Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40633583B6E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 11:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235296AbiG1JlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 05:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235617AbiG1JlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 05:41:10 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB16E21E37;
        Thu, 28 Jul 2022 02:41:09 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id o15so2364737yba.10;
        Thu, 28 Jul 2022 02:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UG+9vtgWnJhp082ZzldcRuAAtoKhL/O1VbY14YM11t4=;
        b=cq3FItztKYYb8ycxcVrruwq8/F/HSKRUYcTwAkyFy56HZT1hDe+0dDR3L5R1Bw/Les
         IJ2jCIZxPfugq7TLwa0uTSXFJ31RNLT4MzRIsnWf49wu6DcJ1zN2V858oyerN0hH1UAJ
         voIF39GTgD7wNgtjhAvg3fPuHSRCvMc3jGuhJ9ylz4mMFzkmh7D+daLhHqG7Wpul/Jvi
         XzvZSaEjV53ytowjJkxwcDtk/ZCb6DUSt5vWdUH7PvBdwTrPJLgSy/eKc9Pj4+j2hOx/
         twd13v9y9bnsrw7YSzK+KMrmevX0aCzf+biXajiPJqzteq0VnHgIDv+a6gsw3qVg0k/H
         0qkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UG+9vtgWnJhp082ZzldcRuAAtoKhL/O1VbY14YM11t4=;
        b=lRVhIPUbG6X7b1zn6gyeoZh8fK3zjZlwc5Qkc+luS+3aqzkClcf8+fO1xBExYzhNVd
         IWDwon+33IeCk6w7/steaF7i1e6WvDWDn61R20cgT2ML/53cz3nnqMWcpReVqiBAWLp2
         PgIWhlZgygzY+38g+FLzRdIhqmEv/NfuXQZBLRJWlxvCOFSacP5qCaTbQKW+qMD4pRDr
         QeRYNAMQzlbhgeBEuBz8jVmP31CX2ReWTdFtnfr0gdNcpYY1TmwJbbY16v5dNqBfs8x+
         fX6GEEx/RJaB9OmGOWFv4xz3LfruWGUVXTNOqKYTBptMX6Ri4mijRKStnX96R2U9xfL+
         qp0g==
X-Gm-Message-State: AJIora+pJ/1EC0k4fR7dYXyTX2ayP1wS7wu7Kz2MQri/3cQ8aiNUpu9I
        aHilH+9ae+W7e4/cu4lQqnU4dnmX0xJ6BeNskHQ=
X-Google-Smtp-Source: AGRyM1t9Ez2dflKZy3BCCWSd+3wth+XMrDuf/Aa1io7G9hyoxwDLmlPmMz3BOPSswTMx/lj4uEQyXMJjlNx9jWVKO/Y=
X-Received: by 2002:a25:22d5:0:b0:669:dd4:c67e with SMTP id
 i204-20020a2522d5000000b006690dd4c67emr20467132ybi.129.1659001269135; Thu, 28
 Jul 2022 02:41:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220728091043.1896158-1-zengjx95@gmail.com>
In-Reply-To: <20220728091043.1896158-1-zengjx95@gmail.com>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Thu, 28 Jul 2022 15:10:58 +0530
Message-ID: <CAOh2x=kfFtT9LzqZzkkb_J7oLGmBOt0PP_YfcjqD98TEcGGJhA@mail.gmail.com>
Subject: Re: [PATCH] rtc: rtc-spear: set range max
To:     Zeng Jingxiang <zengjx95@gmail.com>
Cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeng Jingxiang <linuszeng@tencent.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 2:49 PM Zeng Jingxiang <zengjx95@gmail.com> wrote:
>
> From: Zeng Jingxiang <linuszeng@tencent.com>
>
> In the commit f395e1d3b28d7c2c67b73bd467c4fb79523e1c65

Please add this as fixes tag.

> ("rtc: spear: set range"), the value of
> RTC_TIMESTAMP_END_9999 was incorrectly set to range_min.
> 390     config->rtc->range_min = RTC_TIMESTAMP_BEGIN_0000;
> 391     config->rtc->range_max = RTC_TIMESTAMP_END_9999;
>
> Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
> ---
>  drivers/rtc/rtc-spear.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/rtc/rtc-spear.c b/drivers/rtc/rtc-spear.c
> index d4777b01ab22..736fe535cd45 100644
> --- a/drivers/rtc/rtc-spear.c
> +++ b/drivers/rtc/rtc-spear.c
> @@ -388,7 +388,7 @@ static int spear_rtc_probe(struct platform_device *pdev)
>
>         config->rtc->ops = &spear_rtc_ops;
>         config->rtc->range_min = RTC_TIMESTAMP_BEGIN_0000;
> -       config->rtc->range_min = RTC_TIMESTAMP_END_9999;
> +       config->rtc->range_max = RTC_TIMESTAMP_END_9999;
>
>         status = devm_rtc_register_device(config->rtc);
>         if (status)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
