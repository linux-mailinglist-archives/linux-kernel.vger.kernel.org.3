Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFD55505C5
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 17:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235658AbiFRPbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 11:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234228AbiFRPbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 11:31:09 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58B410FE8;
        Sat, 18 Jun 2022 08:31:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 41B72CE02BE;
        Sat, 18 Jun 2022 15:31:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36268C3411A;
        Sat, 18 Jun 2022 15:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655566265;
        bh=1/JqD0jrLT+kJuKDhRHBaxwfNIV3cVZwTcjFBPk6sRI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DRq5DP/dXx2lZQB31tll4Avibx0zKqv+18F1YRmohciCwpMSmDstNj2rGgr9lMIpq
         5I67qkw05iQlp4a3C2eANCMYfKAUqCVNKRrSFNwTdRUTolPAmpSJvBRXnlhXPvxmRj
         2zh2q7lPoUpn1LUZLSNPDY3Yr9f6cOBxTRsWDm1NbtQ+gwOjYLpf+qUciUAj8gbjX+
         al4dQTuBNOiGZtnonm2uQu9mtuHwBbCwRIyOIjVRCinc6kscmPf0kbbSTYzxHdkSQp
         RYXT9EtqwMpi1yFK2Cisf5UPiWS81Dc/lEcxTjrNdoVsHujBbUF1bYqXyAg8QLT9uN
         85xg3ealaIvyw==
Date:   Sat, 18 Jun 2022 16:40:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Xiang wangx <wangxiang@cdjrlc.com>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: Fix typo in comment
Message-ID: <20220618164023.51b3080f@jic23-huawei>
In-Reply-To: <20220616141522.2238-1-wangxiang@cdjrlc.com>
References: <20220616141522.2238-1-wangxiang@cdjrlc.com>
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

On Thu, 16 Jun 2022 22:15:22 +0800
Xiang wangx <wangxiang@cdjrlc.com> wrote:

> Delete the redundant word 'in'.
> 
> Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
Applied, but with patch title changed to reflect the driver in question.

iio: gyro: bmg160: ...

> ---
>  drivers/iio/gyro/bmg160_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
> index 81a6d09788bd..cedd9f02ea21 100644
> --- a/drivers/iio/gyro/bmg160_core.c
> +++ b/drivers/iio/gyro/bmg160_core.c
> @@ -766,7 +766,7 @@ static int bmg160_write_event_config(struct iio_dev *indio_dev,
>  		return 0;
>  	}
>  	/*
> -	 * We will expect the enable and disable to do operation in
> +	 * We will expect the enable and disable to do operation
>  	 * in reverse order. This will happen here anyway as our
>  	 * resume operation uses sync mode runtime pm calls, the
>  	 * suspend operation will be delayed by autosuspend delay

