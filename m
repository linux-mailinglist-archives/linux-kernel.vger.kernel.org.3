Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20AE6536DF3
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 19:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239117AbiE1RZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 13:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbiE1RZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 13:25:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B8111A32;
        Sat, 28 May 2022 10:25:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3998B807ED;
        Sat, 28 May 2022 17:25:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C3BC34100;
        Sat, 28 May 2022 17:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653758711;
        bh=GdCxg+Hoqs4A5uVj70itM0dbHtrrCFfc1B7A5Kv46nA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FB63uImwGdFeA5/Z9TrQifFVx/+xCf8Ko2Rs/y5W1IGoJgSyHuusfcef+E3g5pzy0
         Km4W1kx70qfQf5Pcq85PNL1yqX+IoErx9DlI6pXZhgBS4CUkEm5Pr+ewB7aF7BDcJ6
         oF+VyBFJdXZEu/JQiZguzZt6E3DTAlA5QLOKTo6J1jlB1qzFlNbrvuqFJLUCAJWIZk
         FDN6Pf+SOodovwP2l9MG9/ltlvjKAR21XFLRERbzwHpepBiU94sx2rSdFlbtVe5bOD
         +TvKE9R46jwb9jmG6LvZw7mikGNzOrZjLYwC51QtBSLmAX9n+/tKgjN8Ol0EkwM9d+
         8bmRuMnT0/PqQ==
Date:   Sat, 28 May 2022 18:34:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Joe Simmons-Talbott <joetalbott@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iio: Prefer octal over symbolic permissions.
Message-ID: <20220528183405.22b55033@jic23-huawei>
In-Reply-To: <20220527185651.465204-1-joetalbott@gmail.com>
References: <20220527185651.465204-1-joetalbott@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 May 2022 14:56:52 -0400
Joe Simmons-Talbott <joetalbott@gmail.com> wrote:

> As reported by checkpatch.pl use ocatl permissions rather than symbolic
> permissions.
> 
> Signed-off-by: Joe Simmons-Talbott <joetalbott@gmail.com>

Hi Joe,

Why the resend?  Given change of description, I'm guessing this is v2
because of feedback on a similar patch elsewhere. If so, please
put the version number in the patch log and provide a changelog
below the ---

Hmm. I guess I don't really mind cleaning this up though it is
some churn in core code which is usually something we try to avoid
for fairly trivial style reasons.

One request inline (though I suspect it applies in several places,
I just haven't checked ;)

Thanks,

Jonathan

> ---
>  drivers/iio/industrialio-buffer.c  | 12 ++++++------
>  drivers/iio/industrialio-core.c    | 10 +++++-----
>  drivers/iio/industrialio-trigger.c |  4 ++--
>  3 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index b078eb2f3c9d..c27f74a3c0f3 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -1391,17 +1391,17 @@ static ssize_t direction_show(struct device *dev,
>  	}
>  }
>  
> -static DEVICE_ATTR(length, S_IRUGO | S_IWUSR, iio_buffer_read_length,
> +static DEVICE_ATTR(length, 0644, iio_buffer_read_length,
>  		   iio_buffer_write_length);
>  static struct device_attribute dev_attr_length_ro = __ATTR(length,
> -	S_IRUGO, iio_buffer_read_length, NULL);
> -static DEVICE_ATTR(enable, S_IRUGO | S_IWUSR,
> +	0444, iio_buffer_read_length, NULL);
> +static DEVICE_ATTR(enable, 0644,
>  		   iio_buffer_show_enable, iio_buffer_store_enable);
> -static DEVICE_ATTR(watermark, S_IRUGO | S_IWUSR,
> +static DEVICE_ATTR(watermark, 0644,
>  		   iio_buffer_show_watermark, iio_buffer_store_watermark);
>  static struct device_attribute dev_attr_watermark_ro = __ATTR(watermark,
> -	S_IRUGO, iio_buffer_show_watermark, NULL);
> -static DEVICE_ATTR(data_available, S_IRUGO,
> +	0444, iio_buffer_show_watermark, NULL);
> +static DEVICE_ATTR(data_available, 0444,
>  		iio_dma_show_data_available, NULL);

a side effect of this change a slight shortening of how long the above
two lines will be if combined into one.  It's now sub 80 chars
I think, so please make them a single line.  Also check for similar
cases elsewhere.


>  static DEVICE_ATTR_RO(direction);
>  
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index e1ed44dec2ab..35de348d686e 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1114,12 +1114,12 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
>  	dev_attr->attr.name = name;
>  
>  	if (readfunc) {
> -		dev_attr->attr.mode |= S_IRUGO;
> +		dev_attr->attr.mode |= 0444;
>  		dev_attr->show = readfunc;
>  	}
>  
>  	if (writefunc) {
> -		dev_attr->attr.mode |= S_IWUSR;
> +		dev_attr->attr.mode |= 0200;
>  		dev_attr->store = writefunc;
>  	}
>  
> @@ -1401,7 +1401,7 @@ static ssize_t iio_show_dev_name(struct device *dev,
>  	return sysfs_emit(buf, "%s\n", indio_dev->name);
>  }
>  
> -static DEVICE_ATTR(name, S_IRUGO, iio_show_dev_name, NULL);
> +static DEVICE_ATTR(name, 0444, iio_show_dev_name, NULL);
>  
>  static ssize_t iio_show_dev_label(struct device *dev,
>  				 struct device_attribute *attr,
> @@ -1411,7 +1411,7 @@ static ssize_t iio_show_dev_label(struct device *dev,
>  	return sysfs_emit(buf, "%s\n", indio_dev->label);
>  }
>  
> -static DEVICE_ATTR(label, S_IRUGO, iio_show_dev_label, NULL);
> +static DEVICE_ATTR(label, 0444, iio_show_dev_label, NULL);
>  
>  static ssize_t iio_show_timestamp_clock(struct device *dev,
>  					struct device_attribute *attr,
> @@ -1509,7 +1509,7 @@ int iio_device_register_sysfs_group(struct iio_dev *indio_dev,
>  	return 0;
>  }
>  
> -static DEVICE_ATTR(current_timestamp_clock, S_IRUGO | S_IWUSR,
> +static DEVICE_ATTR(current_timestamp_clock, 0644,
>  		   iio_show_timestamp_clock, iio_store_timestamp_clock);
>  
>  static int iio_device_register_sysfs(struct iio_dev *indio_dev)
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index f504ed351b3e..e22a35634f2c 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -54,7 +54,7 @@ static ssize_t iio_trigger_read_name(struct device *dev,
>  	return sysfs_emit(buf, "%s\n", trig->name);
>  }
>  
> -static DEVICE_ATTR(name, S_IRUGO, iio_trigger_read_name, NULL);
> +static DEVICE_ATTR(name, 0444, iio_trigger_read_name, NULL);
>  
>  static struct attribute *iio_trig_dev_attrs[] = {
>  	&dev_attr_name.attr,
> @@ -494,7 +494,7 @@ static ssize_t iio_trigger_write_current(struct device *dev,
>  	return ret;
>  }
>  
> -static DEVICE_ATTR(current_trigger, S_IRUGO | S_IWUSR,
> +static DEVICE_ATTR(current_trigger, 0644,
>  		   iio_trigger_read_current,
>  		   iio_trigger_write_current);
>  

