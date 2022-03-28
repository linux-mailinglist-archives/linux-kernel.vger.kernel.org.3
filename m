Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530794E9CF0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 18:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243817AbiC1RAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 13:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234838AbiC1RA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 13:00:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F7C60DA8;
        Mon, 28 Mar 2022 09:58:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0FD4FB810D5;
        Mon, 28 Mar 2022 16:58:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5950C004DD;
        Mon, 28 Mar 2022 16:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648486725;
        bh=fc1ZqAVDO0efw8axuiPEWNcZoPrAnCItKAK5ldZG1EY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o2T5CvXfvYNhjsxOwg9KcQkxv9jT4itsTBvvL2bLNQEG2jyZUQxEaJM8QtGWfNwTU
         70PVLeCXiRc2Wv7bPhOqXl8a1zkvmfloiwRROzSk6aag/qVBkjFpYp0jVSbT+RHN6z
         SsFyKCaDdenUG0S1DqPE0T86hjYLL9LN9bfJsgsRz+y08Av4FMih7RQquEY6zsdQai
         +wCceg1AXiiUg3O/TCV01bdFgfA4pBug1QbnpHwSYbKabsXIkpg1uGd9JB2RPS6LmF
         tbJSpL1b+IwWGi0jMuzS+FAvPgYnhbdGt+SBjIZFxeXSUC3SVDKPn6qkLPTOQxSqe4
         zhI1vDn3vUYnQ==
Date:   Mon, 28 Mar 2022 18:06:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Paul Lemmermann <thepaulodoom@thepaulodoom.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IIO: accel: fixed coding style issues
Message-ID: <20220328180623.1380d23e@jic23-huawei>
In-Reply-To: <YkHOpCT2Gad1YaxN@hp-amd-paul>
References: <YkHOpCT2Gad1YaxN@hp-amd-paul>
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

On Mon, 28 Mar 2022 10:05:08 -0500
Paul Lemmermann <thepaulodoom@thepaulodoom.com> wrote:

> Fixed case statement issues and spacing issues.
> 
> Signed-off-by: Paul Lemmermann <thepaulodoom@thepaulodoom.com>
Hi Paul,

Thanks for the patch.

These are drivers written / maintained by different authors, so one
patch per driver preferred.  Particularly handy as people might not
agree with all of them so separate patches would allow me to pick
and choose which ones to pick up.

Comments inline.

Please state how you identified the changes btw.  Script?

Jonathan

> ---
>  drivers/iio/accel/bmc150-accel-core.c | 15 +++++++++++----
>  drivers/iio/accel/dmard09.c           |  2 +-
>  drivers/iio/accel/kxsd9-spi.c         |  4 ++--
>  3 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> index d11f66801..f7dd7ec2c 100644
> --- a/drivers/iio/accel/bmc150-accel-core.c
> +++ b/drivers/iio/accel/bmc150-accel-core.c
> @@ -432,10 +432,17 @@ static bool bmc150_apply_bosc0200_acpi_orientation(struct device *dev,
>  
>  		for (j = 0; j < 3; j++) {
>  			switch (val[j]) {
> -			case -1: str = "-1"; break;
> -			case 0:  str = "0";  break;
> -			case 1:  str = "1";  break;
> -			default: goto unknown_format;
> +			case -1:
> +				str = "-1";
> +				break;
> +			case 0:
> +				str = "0";
> +				break;
> +			case 1:
> +				str = "1";
> +				break;
> +			default:
> +				goto unknown_format;

I'm not seeing any clear advantage to this change.


>  			}
>  			orientation->rotation[i * 3 + j] = str;
>  		}
> diff --git a/drivers/iio/accel/dmard09.c b/drivers/iio/accel/dmard09.c
> index e6e28c964..87bc38d4d 100644
> --- a/drivers/iio/accel/dmard09.c
> +++ b/drivers/iio/accel/dmard09.c
> @@ -24,7 +24,7 @@
>  #define DMARD09_AXIS_Y 1
>  #define DMARD09_AXIS_Z 2
>  #define DMARD09_AXIS_X_OFFSET ((DMARD09_AXIS_X + 1) * 2)
> -#define DMARD09_AXIS_Y_OFFSET ((DMARD09_AXIS_Y + 1 )* 2)
> +#define DMARD09_AXIS_Y_OFFSET ((DMARD09_AXIS_Y + 1) * 2)

This is one is good.

>  #define DMARD09_AXIS_Z_OFFSET ((DMARD09_AXIS_Z + 1) * 2)
>  
>  struct dmard09_data {
> diff --git a/drivers/iio/accel/kxsd9-spi.c b/drivers/iio/accel/kxsd9-spi.c
> index 57c451cfb..989f53fb0 100644
> --- a/drivers/iio/accel/kxsd9-spi.c
> +++ b/drivers/iio/accel/kxsd9-spi.c
> @@ -44,8 +44,8 @@ static const struct spi_device_id kxsd9_spi_id[] = {
>  MODULE_DEVICE_TABLE(spi, kxsd9_spi_id);
>  
>  static const struct of_device_id kxsd9_of_match[] = {
> -        { .compatible = "kionix,kxsd9" },
> -        { },
> +	{ .compatible = "kionix,kxsd9" },

Also good to clean up.

Thanks,

Jonathan


> +	{ },
>  };
>  MODULE_DEVICE_TABLE(of, kxsd9_of_match);
>  

