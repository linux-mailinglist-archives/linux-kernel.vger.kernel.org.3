Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743BE53AF6E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 00:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiFAVN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 17:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbiFAVNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 17:13:23 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5FAB1CE;
        Wed,  1 Jun 2022 14:13:21 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id d26so3937384wrb.13;
        Wed, 01 Jun 2022 14:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YSra+xZypJ0FJ486+Gwr7FAaNCY381qadd9B+4XsECM=;
        b=pEHbXnJrh11adu3sXTrDywHGGLnSoxHR0e1zvfbmPQO/hWn+8dn7xLMO4VcYNG6kZ5
         v2YoKD6hAdW3nNCeza4LbSWmQLCTJb3wvLB6jR3O+t+oL0XvnNc8JoxKvoEwLW79ZF/g
         V+dIOJBkz0CTqnpm4h4dDIV6pfE3g9yr2F6FYIayrISp4tWD9Bw5t52hRNShEBQ4DPTf
         +4hEFXd9gleZe6liMPZHbHQW7endqH1w+yxmLp6NViriwH+ubWQ8vudFXEqtgdfv8x5Z
         nlkSHORsSOweoxXyhI4dMEeEnIsbLWkRiPKba9cdBbXV4VqNOwzFxFmYEuHOUm5jxmNr
         BHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YSra+xZypJ0FJ486+Gwr7FAaNCY381qadd9B+4XsECM=;
        b=4znGjBALbfLZFMs2ePP3lnLwmTh3P8tpvncmJatIplzdDNenV7cgip5LgGbUa9p+HW
         aOj52Azhoew7L3qUkPrG3W0XgZnGHmpfV7cu6weHZZDNNDrdc8b5JRTN8ZmJ1GlcLjRJ
         8YWaxjth0UXJ45xeNjx+0/Udmx98i7VxxtnKtrh7+KfVLB3f/gosekJNcpOcteC6atNo
         UEZBF3DgigNwLOc4MYCsg9Y4yAL6dLzkOuKme0NiLIDyY1xGxetm8EhpZMAmQl2WjS4Z
         PDVfYN7Sjd+dIjMIeEOWYqtuHTSdti3NcnzcV8WVGKCnWoEfYiKTs/Ujz4irs61ahg2b
         OM+Q==
X-Gm-Message-State: AOAM5300Mb1Ot5FANNozwgeodmyMkblrK3DT74J64fhZjjuLRFycdr0c
        Sfy+iDAamM8bXO5AJPqyk26iy0v6KPhR9MkTwg+apCUH4u4T/w==
X-Google-Smtp-Source: ABdhPJy7yAtkjybaQGZrz7aIvrau6Pa2girDmMwJdDiM1/vyphxzNnjRiveq8KmbG9AB/P6tDMjIficAmSFYDUhkS1Q=
X-Received: by 2002:a17:907:2ce3:b0:6ff:1447:d3a4 with SMTP id
 hz3-20020a1709072ce300b006ff1447d3a4mr894025ejc.497.1654110209519; Wed, 01
 Jun 2022 12:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220601185414.251571-1-joetalbott@gmail.com>
In-Reply-To: <20220601185414.251571-1-joetalbott@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 1 Jun 2022 21:02:52 +0200
Message-ID: <CAHp75Vd79=x93KgqcR3coYHUbHiHwyYTagOuKki54omEPx64jA@mail.gmail.com>
Subject: Re: [PATCH v3] iio: Use octal permissions and DEVICE_ATTR_{RO,RW}.
To:     Joe Simmons-Talbott <joetalbott@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 1, 2022 at 8:54 PM Joe Simmons-Talbott <joetalbott@gmail.com> wrote:
>
> As reported by checkpatch.pl.  Where possible use DEVICE_ATTR_RO(),
> DEVICE_ATTR_RW(), and __ATTR_RO().  Change function names to be
> <var>_show() for read and <var>_store() for write.

Thank you for an update!
I have a few nit-picks, but no need to resend, I believe Jonathan may
(or may not :) modify when applying.
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Suggested-by: Joe Perches <joe@perches.com>
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Joe Simmons-Talbott <joetalbott@gmail.com>
> ---
>
> Changes in v3:
>   - Use __ATTR_RO() and add parens to DEVICE_ATTR_{RW,RO} in description
>     as suggested by Andy Shevchenko <andy.shevchenko@gmail.com>
>
> Changes in v2:
>   - Use DEVICE_ATTR_RO() and DEVICE_ATTR_RW() rather than octal permissions
>         where applicable.  Rename functions to <var>-show() and
>         <var>-store().  Based on review by Joe Perches <joe@perches.com>
>
>  drivers/iio/industrialio-buffer.c  | 64 ++++++++++++++----------------
>  drivers/iio/industrialio-core.c    | 35 ++++++++--------
>  drivers/iio/industrialio-trigger.c | 32 +++++++--------
>  3 files changed, 61 insertions(+), 70 deletions(-)
>
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index b078eb2f3c9d..80121b1ac554 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -630,18 +630,18 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
>         return ret;
>  }
>
> -static ssize_t iio_buffer_read_length(struct device *dev,
> -                                     struct device_attribute *attr,
> -                                     char *buf)
> +static ssize_t length_show(struct device *dev,
> +                          struct device_attribute *attr,

I think we have enough space to move the attr parameter to the previous line.

> +                          char *buf)
>  {
>         struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
>
>         return sysfs_emit(buf, "%d\n", buffer->length);
>  }
>
> -static ssize_t iio_buffer_write_length(struct device *dev,
> -                                      struct device_attribute *attr,
> -                                      const char *buf, size_t len)
> +static ssize_t length_store(struct device *dev,
> +                           struct device_attribute *attr,

Ditto.

> +                           const char *buf, size_t len)
>  {
>         struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>         struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
> @@ -672,9 +672,9 @@ static ssize_t iio_buffer_write_length(struct device *dev,
>         return ret ? ret : len;
>  }
>
> -static ssize_t iio_buffer_show_enable(struct device *dev,
> -                                     struct device_attribute *attr,
> -                                     char *buf)
> +static ssize_t enable_show(struct device *dev,
> +                          struct device_attribute *attr,

Ditto.

> +                          char *buf)
>  {
>         struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
>
> @@ -1289,10 +1289,10 @@ void iio_disable_all_buffers(struct iio_dev *indio_dev)
>         iio_buffer_deactivate_all(indio_dev);
>  }
>
> -static ssize_t iio_buffer_store_enable(struct device *dev,
> -                                      struct device_attribute *attr,
> -                                      const char *buf,
> -                                      size_t len)
> +static ssize_t enable_store(struct device *dev,
> +                           struct device_attribute *attr,

Ditto.

> +                           const char *buf,
> +                           size_t len)

And these two may be on one line.

>  {
>         int ret;
>         bool requested_state;
> @@ -1322,19 +1322,19 @@ static ssize_t iio_buffer_store_enable(struct device *dev,
>         return (ret < 0) ? ret : len;
>  }
>
> -static ssize_t iio_buffer_show_watermark(struct device *dev,
> -                                        struct device_attribute *attr,
> -                                        char *buf)
> +static ssize_t watermark_show(struct device *dev,
> +                             struct device_attribute *attr,

Ditto.

> +                             char *buf)
>  {
>         struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
>
>         return sysfs_emit(buf, "%u\n", buffer->watermark);
>  }
>
> -static ssize_t iio_buffer_store_watermark(struct device *dev,
> -                                         struct device_attribute *attr,
> -                                         const char *buf,
> -                                         size_t len)
> +static ssize_t watermark_store(struct device *dev,
> +                              struct device_attribute *attr,

Ditto.

> +                              const char *buf,
> +                              size_t len)

Ditto.

>  {
>         struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>         struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
> @@ -1366,9 +1366,9 @@ static ssize_t iio_buffer_store_watermark(struct device *dev,
>         return ret ? ret : len;
>  }
>
> -static ssize_t iio_dma_show_data_available(struct device *dev,
> -                                               struct device_attribute *attr,
> -                                               char *buf)
> +static ssize_t data_available_show(struct device *dev,
> +                                  struct device_attribute *attr,

Ditto.

> +                                  char *buf)
>  {
>         struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
>
> @@ -1391,18 +1391,12 @@ static ssize_t direction_show(struct device *dev,
>         }
>  }
>
> -static DEVICE_ATTR(length, S_IRUGO | S_IWUSR, iio_buffer_read_length,
> -                  iio_buffer_write_length);
> -static struct device_attribute dev_attr_length_ro = __ATTR(length,
> -       S_IRUGO, iio_buffer_read_length, NULL);
> -static DEVICE_ATTR(enable, S_IRUGO | S_IWUSR,
> -                  iio_buffer_show_enable, iio_buffer_store_enable);
> -static DEVICE_ATTR(watermark, S_IRUGO | S_IWUSR,
> -                  iio_buffer_show_watermark, iio_buffer_store_watermark);
> -static struct device_attribute dev_attr_watermark_ro = __ATTR(watermark,
> -       S_IRUGO, iio_buffer_show_watermark, NULL);
> -static DEVICE_ATTR(data_available, S_IRUGO,
> -               iio_dma_show_data_available, NULL);
> +static DEVICE_ATTR_RW(length);
> +static struct device_attribute dev_attr_length_ro = __ATTR_RO(length);
> +static DEVICE_ATTR_RW(enable);
> +static DEVICE_ATTR_RW(watermark);
> +static struct device_attribute dev_attr_watermark_ro = __ATTR_RO(watermark);
> +static DEVICE_ATTR_RO(data_available);
>  static DEVICE_ATTR_RO(direction);
>
>  /*
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index e1ed44dec2ab..bb1dd00b99ac 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1114,12 +1114,12 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
>         dev_attr->attr.name = name;
>
>         if (readfunc) {
> -               dev_attr->attr.mode |= S_IRUGO;
> +               dev_attr->attr.mode |= 0444;
>                 dev_attr->show = readfunc;
>         }
>
>         if (writefunc) {
> -               dev_attr->attr.mode |= S_IWUSR;
> +               dev_attr->attr.mode |= 0200;
>                 dev_attr->store = writefunc;
>         }
>
> @@ -1393,29 +1393,29 @@ void iio_free_chan_devattr_list(struct list_head *attr_list)
>         }
>  }
>
> -static ssize_t iio_show_dev_name(struct device *dev,
> -                                struct device_attribute *attr,
> -                                char *buf)
> +static ssize_t name_show(struct device *dev,
> +                        struct device_attribute *attr,

Ditto.

> +                        char *buf)
>  {
>         struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>         return sysfs_emit(buf, "%s\n", indio_dev->name);
>  }
>
> -static DEVICE_ATTR(name, S_IRUGO, iio_show_dev_name, NULL);
> +static DEVICE_ATTR_RO(name);
>
> -static ssize_t iio_show_dev_label(struct device *dev,
> -                                struct device_attribute *attr,
> -                                char *buf)
> +static ssize_t label_show(struct device *dev,
> +                         struct device_attribute *attr,

Ditto.

> +                         char *buf)
>  {
>         struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>         return sysfs_emit(buf, "%s\n", indio_dev->label);
>  }
>
> -static DEVICE_ATTR(label, S_IRUGO, iio_show_dev_label, NULL);
> +static DEVICE_ATTR_RO(label);
>
> -static ssize_t iio_show_timestamp_clock(struct device *dev,
> -                                       struct device_attribute *attr,
> -                                       char *buf)
> +static ssize_t current_timestamp_clock_show(struct device *dev,
> +                                           struct device_attribute *attr,
> +                                           char *buf)
>  {
>         const struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>         const clockid_t clk = iio_device_get_clock(indio_dev);
> @@ -1459,9 +1459,9 @@ static ssize_t iio_show_timestamp_clock(struct device *dev,
>         return sz;
>  }
>
> -static ssize_t iio_store_timestamp_clock(struct device *dev,
> -                                        struct device_attribute *attr,
> -                                        const char *buf, size_t len)
> +static ssize_t current_timestamp_clock_store(struct device *dev,
> +                                            struct device_attribute *attr,
> +                                            const char *buf, size_t len)
>  {
>         clockid_t clk;
>         int ret;
> @@ -1509,8 +1509,7 @@ int iio_device_register_sysfs_group(struct iio_dev *indio_dev,
>         return 0;
>  }
>
> -static DEVICE_ATTR(current_timestamp_clock, S_IRUGO | S_IWUSR,
> -                  iio_show_timestamp_clock, iio_store_timestamp_clock);
> +static DEVICE_ATTR_RW(current_timestamp_clock);
>
>  static int iio_device_register_sysfs(struct iio_dev *indio_dev)
>  {
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index f504ed351b3e..21f113c0ee96 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -37,7 +37,7 @@ static LIST_HEAD(iio_trigger_list);
>  static DEFINE_MUTEX(iio_trigger_list_lock);
>
>  /**
> - * iio_trigger_read_name() - retrieve useful identifying name
> + * name_show() - retrieve useful identifying name
>   * @dev:       device associated with the iio_trigger
>   * @attr:      pointer to the device_attribute structure that is
>   *             being processed
> @@ -46,15 +46,15 @@ static DEFINE_MUTEX(iio_trigger_list_lock);
>   * Return: a negative number on failure or the number of written
>   *        characters on success.
>   */
> -static ssize_t iio_trigger_read_name(struct device *dev,
> -                                    struct device_attribute *attr,
> -                                    char *buf)
> +static ssize_t name_show(struct device *dev,
> +                        struct device_attribute *attr,

Ditto.

> +                        char *buf)
>  {
>         struct iio_trigger *trig = to_iio_trigger(dev);
>         return sysfs_emit(buf, "%s\n", trig->name);
>  }
>
> -static DEVICE_ATTR(name, S_IRUGO, iio_trigger_read_name, NULL);
> +static DEVICE_ATTR_RO(name);
>
>  static struct attribute *iio_trig_dev_attrs[] = {
>         &dev_attr_name.attr,
> @@ -395,7 +395,7 @@ void iio_dealloc_pollfunc(struct iio_poll_func *pf)
>  EXPORT_SYMBOL_GPL(iio_dealloc_pollfunc);
>
>  /**
> - * iio_trigger_read_current() - trigger consumer sysfs query current trigger
> + * current_trigger_show() - trigger consumer sysfs query current trigger
>   * @dev:       device associated with an industrial I/O device
>   * @attr:      pointer to the device_attribute structure that
>   *             is being processed
> @@ -407,9 +407,9 @@ EXPORT_SYMBOL_GPL(iio_dealloc_pollfunc);
>   * Return: a negative number on failure, the number of characters written
>   *        on success or 0 if no trigger is available
>   */
> -static ssize_t iio_trigger_read_current(struct device *dev,
> -                                       struct device_attribute *attr,
> -                                       char *buf)
> +static ssize_t current_trigger_show(struct device *dev,
> +                                   struct device_attribute *attr,

Ditto.

> +                                   char *buf)
>  {
>         struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>
> @@ -419,7 +419,7 @@ static ssize_t iio_trigger_read_current(struct device *dev,
>  }
>
>  /**
> - * iio_trigger_write_current() - trigger consumer sysfs set current trigger
> + * current_trigger_store() - trigger consumer sysfs set current trigger
>   * @dev:       device associated with an industrial I/O device
>   * @attr:      device attribute that is being processed
>   * @buf:       string buffer that holds the name of the trigger
> @@ -432,10 +432,10 @@ static ssize_t iio_trigger_read_current(struct device *dev,
>   * Return: negative error code on failure or length of the buffer
>   *        on success
>   */
> -static ssize_t iio_trigger_write_current(struct device *dev,
> -                                        struct device_attribute *attr,
> -                                        const char *buf,
> -                                        size_t len)
> +static ssize_t current_trigger_store(struct device *dev,
> +                                    struct device_attribute *attr,

Ditto.

> +                                    const char *buf,
> +                                    size_t len)

Ditto.

>  {
>         struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>         struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> @@ -494,9 +494,7 @@ static ssize_t iio_trigger_write_current(struct device *dev,
>         return ret;
>  }
>
> -static DEVICE_ATTR(current_trigger, S_IRUGO | S_IWUSR,
> -                  iio_trigger_read_current,
> -                  iio_trigger_write_current);
> +static DEVICE_ATTR_RW(current_trigger);
>
>  static struct attribute *iio_trigger_consumer_attrs[] = {
>         &dev_attr_current_trigger.attr,
> --
> 2.35.3
>


-- 
With Best Regards,
Andy Shevchenko
