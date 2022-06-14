Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1491B54BE28
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 01:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238864AbiFNXKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 19:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiFNXKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 19:10:00 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC5350B2D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 16:09:59 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id m20so19889996ejj.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 16:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qhv7YLyAi4BrmQXx3nUWE7hhcFNv7AcKBHmsYhP5KPM=;
        b=cNgezFl+M+gTPGuMJRJWa0Mbg58VEK5mM4OGpXpx84sJr9RbU7N3RzHHAz5E3evMnJ
         rdhwzHZop0iS2+06lJCH6gvL10x0FjATjKPL1jDdUaRI+r0hD35NWOiTjMsPkwU7w16x
         HpF4p5puSupgKso7I4kYDUcO29taypkE36PGf4uG1N9WWE+drNyHEdTDMABxZEz+mXPn
         kvM/vBVyXIIETZg5j5Sgyz2fo8gfX/m5viI1gNz3DKVlq7vesP8jKgL0//9bpJ1e0u4v
         vwpXJ6maxn+hfgqnFWiFrNSMdGrnGCwx1YzLuuPWYX/EuK2PP/IW5D5eV/WsQXk5isWa
         wkKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qhv7YLyAi4BrmQXx3nUWE7hhcFNv7AcKBHmsYhP5KPM=;
        b=JqzRz7r5hpNSBXnIzamowndm2SRsIgDKYIKHifgDssALeroWWvmOL5usNCmN8UXUcm
         Z69sgVoOf9X4gE/0tJeCQ3SlMMaxGQC5GNA2rdh3NrcDUeEg7QYCYvQi/WpmPQ/YUJVu
         vbIW8LhqFmnzka0OpRg9N6vZaERg1rRt301kYlkE8iGBxwQI/H5AdiwmHns4czurDnyT
         yMszFH1NQBxJJnsdYKHlpxshcsyckHyRpcmOBWfZISOg/u10nSGhUdmAlpNrtIWM4R0j
         p//BIEHjAB7JX6G9Yuca2SSyJyfO19sQ6pHCpn7VQj7tYRT1kpr6TjqlxEfqDURMU0Wm
         hb2g==
X-Gm-Message-State: AJIora+keyPZITVZUOp9F87DzHQ0nX5hj2zl881pszBdt+VxttVy5svx
        hxYtsMMwzsFKR7mjar+Hki5xb27zgXrGOsYQdxJ16g==
X-Google-Smtp-Source: AGRyM1tdS4T7dOBzwuIh4syn5mV1pdfjDpNBZAVBPhL1m3tv8qL3cQrVJclclkViVM4AOjSU8cenih372VNztuAKfZI=
X-Received: by 2002:a17:906:79ca:b0:705:111f:12dc with SMTP id
 m10-20020a17090679ca00b00705111f12dcmr6462486ejo.602.1655248198216; Tue, 14
 Jun 2022 16:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220608130406.46005-1-wangxiang@cdjrlc.com>
In-Reply-To: <20220608130406.46005-1-wangxiang@cdjrlc.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 14 Jun 2022 17:09:46 -0600
Message-ID: <CANLsYkxLi1G1T57AVwNu+Mg7YbqE3Lox3Auh3YAT9mZsMH0r3w@mail.gmail.com>
Subject: Re: [PATCH] remoteproc: omap_remoteproc: Fix typo in comment
To:     Xiang wangx <wangxiang@cdjrlc.com>
Cc:     bjorn.andersson@linaro.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jun 2022 at 07:04, Xiang wangx <wangxiang@cdjrlc.com> wrote:
>
> Delete the redundant word 'The'.
> Delete the redundant word 'to'.
>
> Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
> ---
>  drivers/remoteproc/omap_remoteproc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>

I have applied this patch.

Thanks,
Mathieu

> diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
> index 32a588fefbdc..430fab0266ed 100644
> --- a/drivers/remoteproc/omap_remoteproc.c
> +++ b/drivers/remoteproc/omap_remoteproc.c
> @@ -243,7 +243,7 @@ static inline int omap_rproc_get_timer_irq(struct omap_rproc_timer *timer)
>   * omap_rproc_ack_timer_irq() - acknowledge a timer irq
>   * @timer: handle to a OMAP rproc timer
>   *
> - * This function is used to clear the irq associated with a watchdog timer. The
> + * This function is used to clear the irq associated with a watchdog timer.
>   * The function is called by the OMAP remoteproc upon a watchdog event on the
>   * remote processor to clear the interrupt status of the watchdog timer.
>   */
> @@ -303,7 +303,7 @@ static irqreturn_t omap_rproc_watchdog_isr(int irq, void *data)
>   * @configure: boolean flag used to acquire and configure the timer handle
>   *
>   * This function is used primarily to enable the timers associated with
> - * a remoteproc. The configure flag is provided to allow the driver to
> + * a remoteproc. The configure flag is provided to allow the driver
>   * to either acquire and start a timer (during device initialization) or
>   * to just start a timer (during a resume operation).
>   *
> @@ -443,7 +443,7 @@ static int omap_rproc_enable_timers(struct rproc *rproc, bool configure)
>   * @configure: boolean flag used to release the timer handle
>   *
>   * This function is used primarily to disable the timers associated with
> - * a remoteproc. The configure flag is provided to allow the driver to
> + * a remoteproc. The configure flag is provided to allow the driver
>   * to either stop and release a timer (during device shutdown) or to just
>   * stop a timer (during a suspend operation).
>   *
> --
> 2.36.1
>
