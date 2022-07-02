Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02BE5642DD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 23:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiGBVWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 17:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiGBVWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 17:22:24 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7159B1E2
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 14:22:23 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id h23so9958667ejj.12
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 14:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T+uKYXdP+hAwjll7pb6aDF1MjtCeY9OgKItERoEDFSg=;
        b=Y571+BtPBWYPZsGiGOdArDW26sF3iP879gIGoq1PYMCSqpTHmyw5OjUyib1auiHcWu
         U9NBEqQ022G4sS/jPvnYqgJyu+QDbSh+QMaPYR4iVKGBTLCuhH/sdrtbYQ49YiPIpGh8
         Q/wl7NJYBsv9c3Ve/RqkERvGtijr7K/vZw2wLDDz785NWaiCluIEpj1Ik7OnL/X9xLK4
         ZTrN3rHXC57cPA9MhRiYDgWn0/V0Bb7dK13quB2gMS2z8HlFt0W3x6gbE7W1zTzkpMO8
         P35A8vISHrxUPmjSGf7Sj+SWS+LSasOO5B7FQ5+1WQa5LlkXdwCwetTz2E1vY7kQ6oO+
         C1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T+uKYXdP+hAwjll7pb6aDF1MjtCeY9OgKItERoEDFSg=;
        b=LRV40vw0YIUeCfrS+kqGT8oGKwvJeAQUfygvynqHJqm/ly545S9fAyQTs2rdnOIzAE
         IaRs2TmhwZxbm1KJkpX90qu3Y0qnaM/gUpuj/YeNrZ4aGEoHECx4vtStEkcSM7ABsQLv
         /f3yKxYQY+GPLV2U8VVsgLBoN1a8jb8yI47fiVyoUwP+hpJHCm/FnTwWrpBjwV3823Xx
         CwiVXEZ1SUlIT6FXeGApWIWF1ZwHEyhncg5MjSFROw0Q7uTGEXVhK3uNlwiiY2y2zdnB
         6ihxaxWQnTTS3ykHT4K37DhmoZQ3r+7cU3jk9JKmCmebwjgOIiLULfeiZ7D08N24dLG8
         zp5g==
X-Gm-Message-State: AJIora8NrC8d8nUONhPpyQDzn3mOElu6ogcf9iszsdSrmLc6PWvCRVn0
        AP+X2SZQ7wysOFNxYu+2pWo=
X-Google-Smtp-Source: AGRyM1sOLUCI5Z9pSbtRpdrO9mrFZa/SyMFDPAV5MKgJCcdQqQI9BJPD2O7q5UNYywnj22S81PZOgg==
X-Received: by 2002:a17:907:6da2:b0:726:3ebd:9c9a with SMTP id sb34-20020a1709076da200b007263ebd9c9amr20960512ejc.628.1656796942425;
        Sat, 02 Jul 2022 14:22:22 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id a4-20020a170906274400b00726b03f83a0sm7937837ejd.33.2022.07.02.14.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 14:22:21 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, wens@csie.org,
        samuel@sholland.org, Zhou jie <zhoujie@nfschina.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, kernel@nfschina.com,
        Zhou jie <zhoujie@nfschina.com>
Subject: Re: [PATCH] drivers: remove unnecessary (void*) conversions.
Date:   Sat, 02 Jul 2022 23:22:20 +0200
Message-ID: <2589523.X9hSmTKtgW@jernej-laptop>
In-Reply-To: <20220629062658.56466-1-zhoujie@nfschina.com>
References: <20220629062658.56466-1-zhoujie@nfschina.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sreda, 29. junij 2022 ob 08:26:58 CEST je Zhou jie napisal(a):
> remove unnecessary void* type casting.
> 
> Signed-off-by: Zhou jie <zhoujie@nfschina.com>

Subject line should have "clocksource/drivers/sun4i:" prefix instead of 
"drivers:"

Best regards,
Jernej

> ---
>  drivers/clocksource/timer-sun4i.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/timer-sun4i.c
> b/drivers/clocksource/timer-sun4i.c index 0ba8155b8287..6fe71f95e2c2 100644
> --- a/drivers/clocksource/timer-sun4i.c
> +++ b/drivers/clocksource/timer-sun4i.c
> @@ -131,7 +131,7 @@ static void sun4i_timer_clear_interrupt(void __iomem
> *base)
> 
>  static irqreturn_t sun4i_timer_interrupt(int irq, void *dev_id)
>  {
> -	struct clock_event_device *evt = (struct clock_event_device 
*)dev_id;
> +	struct clock_event_device *evt = dev_id;
>  	struct timer_of *to = to_timer_of(evt);
> 
>  	sun4i_timer_clear_interrupt(timer_of_base(to));




