Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4408D53027D
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 12:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244306AbiEVKqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 06:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244237AbiEVKqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 06:46:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27641205E1;
        Sun, 22 May 2022 03:46:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACE1360F7C;
        Sun, 22 May 2022 10:46:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F41C385AA;
        Sun, 22 May 2022 10:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653216375;
        bh=tUiB0mjT6bn4bMX9OLe5ONRikydVfNZrTIHbogIIqSo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I/gmUEFBAgDBJElgsixnhDMy+meO59XpKdTFZFmomSIoAtmxVamLIjpBab5KXFJgg
         6iQvR5wbXgd34oG52k2ojGl/r3wq3D15E9PNEOPcKWl1Jn/XNY71RKA4Cv8zusDlmT
         sRX3EvBg6NGRa3qbtZwWCphG4QgMaeVWJnPLKXNq/+CHPLWu8LZ9isbHtN1dQB7sCS
         9WFIqbwBEeBLz70UPl8aDcskQWChhC4LgFe8VyK1aoHtu4aJGkBIQT/kQTUe2bpiPN
         JA7jVcdVZD8lxb7+/F5Ly3uBd+vQiHHex71NiLeICdyl7UfMASaNnCAbn0H6samdep
         X9QSaU9Q4F44Q==
Date:   Sun, 22 May 2022 11:55:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Andreas Klinger <ak@it-klinger.de>,
        kernel-janitors@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: ping: fix typo in comment
Message-ID: <20220522115500.63c601b2@jic23-huawei>
In-Reply-To: <20220521111145.81697-54-Julia.Lawall@inria.fr>
References: <20220521111145.81697-54-Julia.Lawall@inria.fr>
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

On Sat, 21 May 2022 13:11:04 +0200
Julia Lawall <Julia.Lawall@inria.fr> wrote:

> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
Applied for 5.20

Thanks,

Jonathan

> 
> ---
>  drivers/iio/proximity/ping.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/proximity/ping.c b/drivers/iio/proximity/ping.c
> index d56e037378de..2ad69b150902 100644
> --- a/drivers/iio/proximity/ping.c
> +++ b/drivers/iio/proximity/ping.c
> @@ -173,7 +173,7 @@ static int ping_read(struct iio_dev *indio_dev)
>  
>  	/*
>  	 * read error code of laser ping sensor and give users chance to
> -	 * figure out error by using dynamic debuggging
> +	 * figure out error by using dynamic debugging
>  	 */
>  	if (data->cfg->laserping_error) {
>  		if ((time_ns > 12500000) && (time_ns <= 13500000)) {
> 

