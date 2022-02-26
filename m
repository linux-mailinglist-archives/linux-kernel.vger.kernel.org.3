Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590234C577C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 19:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbiBZS3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 13:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbiBZS3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 13:29:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B21414EF7A;
        Sat, 26 Feb 2022 10:28:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF04760EEC;
        Sat, 26 Feb 2022 18:28:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973FFC340E8;
        Sat, 26 Feb 2022 18:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645900111;
        bh=A5x+J24q++41RYB+T+gJgAyODlZbkpVmhA1bsmhBEx0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SbC9C3ykaWYW3JnhSA0C7SKAvUTBlcD5SC+M7F6pBxzYcVPvaD6i7tN9h8WQPee3E
         BQnWhYKUmzL1kcmVOvf+1UwJ06NfOkOr0HHEPiyvaqIPNbrW7uV54PM9PTNH0IpXr4
         m2W5DA7ajyrc70iqpGttmEzzo/sO/c5TZl5X9VC5CVgVO41Qp4eDLjMlWhV+S3xhC6
         MofQmzx7XFrLUPDvPnjIcCI+W1JjZ56BtR6XjhG61U6c5TCMu0flfA2DOoRC8z94Fm
         6LQgiKRaBpF4oio7+NY3tkx1C/GsfWC8ceJQ7HvlBl+WcqmaXzsiD/G+EpM7xTWDm/
         zsxEIeR2VryIw==
Date:   Sat, 26 Feb 2022 18:35:31 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     lars@metafoo.de, andy.shevchenko@gmail.com, sst@poczta.fm,
        robh+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/7] iio: potentiometer: Alignment to match the open
 parenthesis
Message-ID: <20220226183531.05f5f0be@jic23-huawei>
In-Reply-To: <20220223163525.13399-2-jagathjog1996@gmail.com>
References: <20220223163525.13399-1-jagathjog1996@gmail.com>
        <20220223163525.13399-2-jagathjog1996@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
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

On Wed, 23 Feb 2022 22:05:19 +0530
Jagath Jog J <jagathjog1996@gmail.com> wrote:

> Fix following checkpatch.pl check by removing blank space.
> CHECK: Alignment should match open parenthesis.
> 
> Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
I didn't noticed before, but for future please put the driver name
in the patch titles!

iio: potentiometer: ds1803: xxxx

I'll fix up.

> ---
>  drivers/iio/potentiometer/ds1803.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/potentiometer/ds1803.c b/drivers/iio/potentiometer/ds1803.c
> index 20b45407eaac..3c542a50ece6 100644
> --- a/drivers/iio/potentiometer/ds1803.c
> +++ b/drivers/iio/potentiometer/ds1803.c
> @@ -55,8 +55,8 @@ static const struct iio_chan_spec ds1803_channels[] = {
>  };
>  
>  static int ds1803_read_raw(struct iio_dev *indio_dev,
> -			    struct iio_chan_spec const *chan,
> -			    int *val, int *val2, long mask)
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long mask)
>  {
>  	struct ds1803_data *data = iio_priv(indio_dev);
>  	int pot = chan->channel;
> @@ -66,7 +66,7 @@ static int ds1803_read_raw(struct iio_dev *indio_dev,
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
>  		ret = i2c_master_recv(data->client, result,
> -				indio_dev->num_channels);
> +				      indio_dev->num_channels);
>  		if (ret < 0)
>  			return ret;
>  
> @@ -83,8 +83,8 @@ static int ds1803_read_raw(struct iio_dev *indio_dev,
>  }
>  
>  static int ds1803_write_raw(struct iio_dev *indio_dev,
> -			     struct iio_chan_spec const *chan,
> -			     int val, int val2, long mask)
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long mask)
>  {
>  	struct ds1803_data *data = iio_priv(indio_dev);
>  	int pot = chan->channel;
> @@ -109,8 +109,7 @@ static const struct iio_info ds1803_info = {
>  	.write_raw = ds1803_write_raw,
>  };
>  
> -static int ds1803_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> +static int ds1803_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  {
>  	struct device *dev = &client->dev;
>  	struct ds1803_data *data;

