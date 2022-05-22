Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA3653027A
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 12:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242205AbiEVKqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 06:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236524AbiEVKp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 06:45:57 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4ED6A19F;
        Sun, 22 May 2022 03:45:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1C62CCE0AF7;
        Sun, 22 May 2022 10:45:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED660C385AA;
        Sun, 22 May 2022 10:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653216350;
        bh=kwD3mtm4Hvanzvn5hDWN2epjuaFZqIjGopPobIPCHiU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X0y0X3jIBWbYu4AL6d8N1vK//G5SPnCYZMs0Eye/ktWqePA81oqMTixK1CS4N4xFg
         qFW67nhRnrqVBoeMo4gS14V6CUj1E8tvS03GfwU2cQ7nK+x/1Gssu31D9Ir/zJiHcd
         zR1F0VZoMp2PDRdqkpuDuv72oH0eNBwrOeSLqSCygRtM/jI1Dv6J2UOxFjXjzkgIpj
         0F1ZyDVp+8gh23KDxxxN4sMe/PinYX+omBCfmTZh62Qk2mPhFrURcj/mm4y3EQrfUR
         nN1l1BXtVKrRqtA0qAI3VbXUkB02akSYdbaWB6LaNj4h2EdFjLF5ONzwX3XGdx4rC+
         yk+n/ZSqJ8eiA==
Date:   Sun, 22 May 2022 11:54:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     kernel-janitors@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: bme680: fix typo in comment
Message-ID: <20220522115436.267704d6@jic23-huawei>
In-Reply-To: <20220521111145.81697-68-Julia.Lawall@inria.fr>
References: <20220521111145.81697-68-Julia.Lawall@inria.fr>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 May 2022 13:11:18 +0200
Julia Lawall <Julia.Lawall@inria.fr> wrote:

> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
Applied for 5.20.

Thanks,

Jonathan

> 
> ---
>  drivers/iio/chemical/bme680_core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
> index 16ff7a98c9f0..ef5e0e46fd34 100644
> --- a/drivers/iio/chemical/bme680_core.c
> +++ b/drivers/iio/chemical/bme680_core.c
> @@ -638,7 +638,7 @@ static int bme680_read_temp(struct bme680_data *data, int *val)
>  	comp_temp = bme680_compensate_temp(data, adc_temp);
>  	/*
>  	 * val might be NULL if we're called by the read_press/read_humid
> -	 * routine which is callled to get t_fine value used in
> +	 * routine which is called to get t_fine value used in
>  	 * compensate_press/compensate_humid to get compensated
>  	 * pressure/humidity readings.
>  	 */
> 

