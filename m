Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEAD75ADA63
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 22:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbiIEUqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 16:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiIEUqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 16:46:16 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A194F6AA;
        Mon,  5 Sep 2022 13:46:14 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 29so7565615edv.2;
        Mon, 05 Sep 2022 13:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=WFLvyYn+rf0DWQUBosQOMvrDyyhko4+gjrrIITVLAsc=;
        b=I6iH1/v4LoaIiCU1U/gwBWJUBNKI9fGFy6oyWuI1XpFemSWXXJaukVORy6X3T5ZTA2
         J/ZQoYVo3d87S4QPIODNT36+yUqhPmC4qJJck37x68XFMtqneCq6z+d83+u2g1XJtK5L
         y3+vNzEz796iG0XlWxJegm/6OxVW43Pa+Awfja9+ZOXNooHLJcrNLSJSaB3KPLRHjVre
         UxWrGrdd49/eWrSEMYOq5/a07P2QmHCxWlkwcAHB/aY//1SyoqL5XutMfIn5IdAfUmE4
         L9pHc9HOaldkoZc9FZD/qH3Bk1eIxLJIxCtrJMPX2QySVMLseWxKJSp4ruM4nOR9cnJS
         8XxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=WFLvyYn+rf0DWQUBosQOMvrDyyhko4+gjrrIITVLAsc=;
        b=c8bhELVAJ9WJBl+oJBdyckUEMaEB8AaEnifcOHhUJFNlJo+pvGOJX7U80oa5gAKrHd
         k8nwILrl8e2R1jwvJI2AYLCO2gi88jSi2C3r5/UP2Z2h9ZtnB8XF185fm//VzBn5EWb3
         EG5zsP0KRYUUOi7ViGyKced/W+PLlxjC4V2PIUfcymF7VR05wtke6h9OudUDkQwDS1Mc
         jU+pN5bRt8PMzIZDeqgssjK1jpgPpDTZFV8PJrYKP2yUwtKh2Ge0IEb1XG83cvrf74i4
         pFA43t9CWxmUJud6SwR6b/YJyJHMEhfmqZEdCrcJm1S7IVQOzbGEcOeBuy8aYp4Y1m93
         k0hA==
X-Gm-Message-State: ACgBeo2dYNLRMm0H5GQDgN6LWfzEcF/hIRap7k4cC6Zmy+k/BOWhf5jS
        id7f0/29dH/lAQHqQ6LSroj3cEIq9ms702BEH1M=
X-Google-Smtp-Source: AA6agR7oxhL2vEF/WmlU2hxC//3Fn04/jOIk16kXGFjt5hjArbBY8Mo898XQ0ppR+tjdRIK3RHebegiuH7snlR+NLk0=
X-Received: by 2002:a05:6402:518b:b0:448:f30:38b0 with SMTP id
 q11-20020a056402518b00b004480f3038b0mr38038451edd.164.1662410772949; Mon, 05
 Sep 2022 13:46:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220830142136.299373-1-cui.jinpeng2@zte.com.cn>
In-Reply-To: <20220830142136.299373-1-cui.jinpeng2@zte.com.cn>
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
Date:   Mon, 5 Sep 2022 22:46:01 +0200
Message-ID: <CAGfqbt5qtcxjfEjxumffBBDRKPvJz-W=J9eTXiNkJ-PgBUH8RA@mail.gmail.com>
Subject: Re: [PATCH linux-next] ARM: omap1: remove redundant variables err
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>, cgel.zte@gmail.com
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jinpeng Cui <cui.jinpeng2@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 30 August 2022 16:21:36 CEST cgel.zte@gmail.com wrote:
> From: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
>
> Rturn value directly from platform_device_register()
> instead of getting value from redundant variable err.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Jinpeng Cui <cui.jinpeng2@zte.com.cn>

Acked-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Note: The same change, form a different author @zte.com.cn, with a different
wording in commit message and description, was submitted a few hours before
this one.  However, I decided to respond with my Ack to this one because
the other one was not sent to linux-omap@vger.kernel.org, then it didn't
reach OMAP patchwork.  If my decision is not in line with some
recommendations and I should rather prefer the submission sent earlier then
please let me know and I'll respond with my Ack to it as well.

Thanks,
Janusz


> ---
>  arch/arm/mach-omap1/board-ams-delta.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
> index 651c28d81132..e5531ef0fbde 100644
> --- a/arch/arm/mach-omap1/board-ams-delta.c
> +++ b/arch/arm/mach-omap1/board-ams-delta.c
> @@ -822,8 +822,6 @@ static int __init modem_nreset_init(void)
>   */
>  static int __init ams_delta_modem_init(void)
>  {
> -     int err;
> -
>       if (!machine_is_ams_delta())
>               return -ENODEV;
>
> @@ -832,9 +830,7 @@ static int __init ams_delta_modem_init(void)
>       /* Initialize the modem_nreset regulator consumer before use */
>       modem_priv.regulator = ERR_PTR(-ENODEV);
>
> -     err = platform_device_register(&ams_delta_modem_device);
> -
> -     return err;
> +     return platform_device_register(&ams_delta_modem_device);
>  }
>  arch_initcall_sync(ams_delta_modem_init);
>
>
