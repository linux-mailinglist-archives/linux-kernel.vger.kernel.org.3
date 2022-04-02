Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264624F04D4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 18:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357972AbiDBQXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 12:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358127AbiDBQXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 12:23:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35545CBE6C;
        Sat,  2 Apr 2022 09:21:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2681B80A6C;
        Sat,  2 Apr 2022 16:21:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A68C340F3;
        Sat,  2 Apr 2022 16:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648916506;
        bh=R4xX0nZUJB2h/jpS68lCERpoTucJ4KN+l6ypGuDvodE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DH3ob2v4SNXbHTxI1nUAp/0E22Xi++fkd0M69I04Qv8LUl5gUcrE/L/C1zS+OeOZm
         dyB2amV8L8ylkcui9Nyr5M57L7PkT2O3pIqLCaADs2lHWXhES1iM0SNiMaQu9SNIV2
         El/7D068OM5FLpqCOFsrez1clQZzvpZgWf/5Mq1PJYKiwIwiAyao70wxJN5yi7NgZN
         I2soWoQqDivz5S1oBd1zAMi7JIDf3wC6ygg4f5lU0g21xBBS8VQVrbk18QvuKEMt19
         WVmrm9KE5ey86Qf4nQi6Mcd3BZExTcVgwHhm6YCimyLPvvsZeTPi6mttiicVa+RZXk
         lxrDJP3u/Hlfw==
Date:   Sat, 2 Apr 2022 17:29:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Paul Lemmermann <thepaulodoom@thepaulodoom.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IIO: accel: kxsd9-spi: changed leading spaces to tabs
Message-ID: <20220402172929.05be6a63@jic23-huawei>
In-Reply-To: <YkInN6SL7pP2f5Sf@hp-amd-paul>
References: <YkInN6SL7pP2f5Sf@hp-amd-paul>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Mar 2022 16:23:03 -0500
Paul Lemmermann <thepaulodoom@thepaulodoom.com> wrote:

> Changed the leading spaces to tabs, in accordance with kernel coding
> conventions, and removed trailing comma.
> 
> Signed-off-by: Paul Lemmermann <thepaulodoom@thepaulodoom.com>
Applied to the togreg branch of iio.git and pushed out as testing to let
0-day take a look at it and see what it thinks.  Note I'll also be
rebasing that tree after rc1 is out.

Thanks,

Jonathan
> ---
>  drivers/iio/accel/kxsd9-spi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/kxsd9-spi.c b/drivers/iio/accel/kxsd9-spi.c
> index ec17e35e5..b7b5af454 100644
> --- a/drivers/iio/accel/kxsd9-spi.c
> +++ b/drivers/iio/accel/kxsd9-spi.c
> @@ -44,8 +44,8 @@ static const struct spi_device_id kxsd9_spi_id[] = {
>  MODULE_DEVICE_TABLE(spi, kxsd9_spi_id);
>  
>  static const struct of_device_id kxsd9_of_match[] = {
> -        { .compatible = "kionix,kxsd9" },
> -        { },
> +	{ .compatible = "kionix,kxsd9" },
> +	{ }
>  };
>  MODULE_DEVICE_TABLE(of, kxsd9_of_match);
>  

