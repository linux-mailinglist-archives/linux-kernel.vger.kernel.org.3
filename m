Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8980B52FDC8
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 17:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355380AbiEUPXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 11:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239672AbiEUPXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 11:23:02 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84FA5DD31;
        Sat, 21 May 2022 08:23:00 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id w4so14990253wrg.12;
        Sat, 21 May 2022 08:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JvR8EfMneLH17KDR7mkxGH6ytw5t2KWJ1oGbwHLRP+I=;
        b=BE7C1sg9dwzS9wigMsHqlYA7qZQXESfP/NvFZo+4WS6FP3c/O0C/8Ysg6l3Xl5JHlb
         H0n9t9ts/9kvykGHTILqJFh8Y5wMUns6Jx0LKO3ccTQitCPAFC7jrpHOc53TrCdEvrEl
         1Qdf4B3/wr6rCHn6hF7TA4OiD9UJZfsshwT1JMXrNpM/MfIe72xSyPCtIfuRlU/uPqHJ
         GMEsIFoPEVfqsZ0nXmdk/5frWRkyUKOLMzfl+8b+y8z18S27vVxMg/uXEbNdT7cwHuw8
         XWzYUW8/Uszu/HSs+t2SpLO8RiYRpE3CgjNwrXjvSTQVkKKGFK09W5Dg6qcVBF/wO0Qr
         cVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JvR8EfMneLH17KDR7mkxGH6ytw5t2KWJ1oGbwHLRP+I=;
        b=I2jWe9hMww56LVTzntATmAV6u99OnGpt9wkYdzHNAvt2ex6xB8oWtdwMA7eUqQJa1I
         lojdYVU19bXYD5doVdVXBlE1vz90cXv8qbews9LMHOze+vjn80wvsAFWOEA5ILXl1Sm+
         8V9hD8OqAORDWfj/PM2VzuszRQU+QUKIy4a6G3lWdBOu2o+Jl/RqaUO5wxLNHZH0pPDJ
         rA/4IjnRAVcLGr5D+N1tQXl7dM3h/fSDJxJczwJreg/kyxWbQpsMgYQWMzshAuHDpgLL
         fGAQpeRtXFnCh14BzAAkIvVU8W83r++GJbM3yu31zFrfwOqLyk27x7cJgvSm3q6n1VR1
         83Fg==
X-Gm-Message-State: AOAM531jrt2GQEPq0dyiE0PkWGCYH1Tdm1ku/5/z3jOcO8ZV3REhBCMm
        PLaDjVjos8EqCYRCy0Cz9eaQf8oWKJTmD1NH8NM=
X-Google-Smtp-Source: ABdhPJy2otIU6LY2zRIkW7mIAELe35y0IXHfO2ziBmZjskvQSLFDXG9FhwC+MgwvPK6BWB/YN5t8Bs47fz7TL91u8xg=
X-Received: by 2002:a5d:4892:0:b0:20c:d4eb:1886 with SMTP id
 g18-20020a5d4892000000b0020cd4eb1886mr13053812wrq.96.1653146579366; Sat, 21
 May 2022 08:22:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220521111145.81697-36-Julia.Lawall@inria.fr>
In-Reply-To: <20220521111145.81697-36-Julia.Lawall@inria.fr>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Sat, 21 May 2022 08:22:32 -0700
Message-ID: <CA+E=qVc-_NbBhybRs8aAU324_GMYAokmZT3mQZN796x6u090oQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: sun8i: fix typo in comment
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     kernel-janitors@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 4:11 AM Julia Lawall <Julia.Lawall@inria.fr> wrote:
>
> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Acked-by: Vasily Khoruzhick <anarsoul@gmail.com>

> ---
>  drivers/thermal/sun8i_thermal.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
> index d9cd23cbb671..212c87e63a66 100644
> --- a/drivers/thermal/sun8i_thermal.c
> +++ b/drivers/thermal/sun8i_thermal.c
> @@ -237,7 +237,7 @@ static int sun50i_h6_ths_calibrate(struct ths_device *tmdev,
>          * The calibration data on the H6 is the ambient temperature and
>          * sensor values that are filled during the factory test stage.
>          *
> -        * The unit of stored FT temperature is 0.1 degreee celusis.
> +        * The unit of stored FT temperature is 0.1 degree celsius.
>          *
>          * We need to calculate a delta between measured and caluclated
>          * register values and this will become a calibration offset.
>
