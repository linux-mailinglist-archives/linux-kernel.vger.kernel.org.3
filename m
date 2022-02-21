Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3F14BEBDA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 21:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbiBUU3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 15:29:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiBUU25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 15:28:57 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0C122BFF;
        Mon, 21 Feb 2022 12:28:33 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id p9so36136619ejd.6;
        Mon, 21 Feb 2022 12:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q6Ei0SlXMY3U/GoKunxXGFN3d3mmMhFrtGn6z+uSaC0=;
        b=NoakwNhd8fsNBSn2f119ciSVyPnsAJM1JwLA9Zrmt+mf+4bNHRgomzv0sQHHVrEI8f
         HIZfzeu9yPeL7oZCHeYC0sO74zDMqqOur1h2QUvye1XwcSq0yKT8rlJytPqBNS9I6ZyX
         Jdu4tnIdkSezU/azVi6oiGgtjyjklFStzDW6GUi9DNRNuxrn6dCitFd1KByOaKo/v5Qv
         XTK3D2Fp3plPwPXmPieVsq1fhH3bFbCQjrxv+JaM6Fi8DxgWxioklPkRRg8BT6lhbsVB
         fd42r3Mlui5vEaMwRrk/6ZLkIbSSjX4lfvx3zbVBjE6hol134NMAzHwECg1x5+4I857a
         LDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q6Ei0SlXMY3U/GoKunxXGFN3d3mmMhFrtGn6z+uSaC0=;
        b=T6mCe2gvZrPO18eG8jAYkl6q3FnB0a5kl1vVO3thRgtYPT7+u+Rl1/M+Fwb2MZVm1G
         yfXdabM36JBtH7CqgZ7X84dhMkU3cDy11vlJz4qJ5AL7X/dqh38xmVVQMNtimUlRES4v
         U/WVluIFxzR2LjJ1EStBnyFfO1CxB2OpUWh2k+Kb0uySyrBL1SA7UMxN+x0MFbOVRy2n
         g8saCYhtUMAb4nNHbjSRx7DV/f93c/V4oIA4N3LNTvAXjfAPN8ZO+uxqBXr7YPMf0o/3
         lXv4Mx4p1Z4VDkJ8kru3ZIhqU+1CHa9ZaYxHib0cpTOStU+PlcHtF1YkI1ROyogXr/Yu
         9S1g==
X-Gm-Message-State: AOAM531eqnDjzUGTSoy4w+mC9y0DPPsIbC5uxl0DndTTLFHsNY1vJg2h
        PmaRl3DgGqvTGAq8g39uHr1Cp1K8/ucRiCNrCKWXMzKX+v60PA==
X-Google-Smtp-Source: ABdhPJxMRStBkzPxpbZgk30MqjUMTHWbg9bwebVH/catXsHjZZf8XkEvU9uyAXyAas8QN0uqZONLpwWNZyXhrIAoZZs=
X-Received: by 2002:a17:906:cc12:b0:6b5:ec8f:fdf2 with SMTP id
 ml18-20020a170906cc1200b006b5ec8ffdf2mr16711397ejb.579.1645475311926; Mon, 21
 Feb 2022 12:28:31 -0800 (PST)
MIME-Version: 1.0
References: <20220217162710.33615-1-andrea.merello@gmail.com> <20220217162710.33615-12-andrea.merello@gmail.com>
In-Reply-To: <20220217162710.33615-12-andrea.merello@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 21 Feb 2022 21:27:55 +0100
Message-ID: <CAHp75VcbkZV0ek6C-YKb3iuZKyQGp7U48j-hQ+UqXFuGEYgZ4Q@mail.gmail.com>
Subject: Re: [v3 11/13] iio: imu: add BNO055 serdev driver
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@iit.it>
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

On Thu, Feb 17, 2022 at 5:27 PM Andrea Merello <andrea.merello@gmail.com> wrote:
>
> This path adds a serdev driver for communicating to a BNO055 IMU via
> serial bus, and it enables the BNO055 core driver to work in this
> scenario.

>  drivers/iio/imu/bno055/bno055_sl.c | 557 +++++++++++++++++++++++++++++

Can we use the suffix _ser instead of _sl?

...

> +config BOSCH_BNO055_SERIAL
> +       tristate "Bosch BNO055 attached via serial bus"

Serial is too broad, it can cover a lot of buses, can we be more specific?

...

> +       help
> +         Enable this to support Bosch BNO055 IMUs attached via serial bus.

Ditto.

...

> +struct bno055_sl_priv {
> +       struct serdev_device *serdev;
> +       struct completion cmd_complete;
> +       enum {
> +               CMD_NONE,
> +               CMD_READ,
> +               CMD_WRITE,
> +       } expect_response;
> +       int expected_data_len;
> +       u8 *response_buf;
> +
> +       /**
> +        * enum cmd_status - represent the status of a command sent to the HW.
> +        * @STATUS_OK:   The command executed successfully.
> +        * @STATUS_FAIL: The command failed: HW responded with an error.
> +        * @STATUS_CRIT: The command failed: the serial communication failed.
> +        */
> +       enum {
> +               STATUS_OK = 0,
> +               STATUS_FAIL = 1,
> +               STATUS_CRIT = -1

+ Comma and sort them by value?
For the second part is an additional question, why negative?

> +       } cmd_status;
> +       struct mutex lock;
> +
> +       /* Only accessed in RX callback context. No lock needed. */
> +       struct {
> +               enum {
> +                       RX_IDLE,
> +                       RX_START,
> +                       RX_DATA

+ Comma.

> +               } state;
> +               int databuf_count;
> +               int expected_len;
> +               int type;
> +       } rx;
> +
> +       /* Never accessed in behalf of RX callback context. No lock needed */
> +       bool cmd_stale;
> +};

...

> +       dev_dbg(&priv->serdev->dev, "send (len: %d): %*ph", len, len, data);

Not a fan of this and similar. Can't you introduce a trace events for
this driver?

...

> +       ret = serdev_device_write(priv->serdev, data, len,
> +                                 msecs_to_jiffies(25));

One line?

...

> +       int i = 0;

> +       while (1) {
> +               ret = bno055_sl_send_chunk(priv, hdr + i * 2, 2);
> +               if (ret)
> +                       goto fail;
> +
> +               if (i++ == 1)
> +                       break;
> +               usleep_range(2000, 3000);
> +       }

The infinite loops are hard to read and understand.
Can you convert it to the regular while or for one?

Also, this looks like a repetition of something (however it seems that
it's two sequencial packets to send).

...

> +       const int retry_max = 5;
> +       int retry = retry_max;

> +       while (retry--) {

Instead simply use

unsigned int retries = 5;

do {
  ...
} while (--retries);

which is much better to understand.

...

> +               if (retry != (retry_max - 1))
> +                       dev_dbg(&priv->serdev->dev, "cmd retry: %d",
> +                               retry_max - retry);

This is an invariant to the loop.

> +               ret = bno055_sl_do_send_cmd(priv, read, addr, len, data);
> +               if (ret)
> +                       continue;

...

> +               if (ret == -ERESTARTSYS) {
> +                       priv->cmd_stale = true;
> +                       return -ERESTARTSYS;

> +               } else if (!ret) {

Redundant 'else'

> +                       return -ETIMEDOUT;
> +               }

Also {} can be dropped.

...

> +               if (priv->cmd_status == STATUS_OK)
> +                       return 0;

> +               else if (priv->cmd_status == STATUS_CRIT)

Redundant 'else'

> +                       return -EIO;

...

> +static int bno055_sl_write_reg(void *context, const void *_data, size_t count)
> +{
> +       u8 *data = (u8 *)_data;

Why casting?

...

> +       if (val_size > 128) {
> +               dev_err(&priv->serdev->dev, "Invalid read valsize %d",
> +                       val_size);

One line?

> +               return -EINVAL;
> +       }

...

> +       reg_addr = ((u8 *)reg)[0];

This looks ugly.
Can't you supply the data struct pointer instead of void pointer?

...

> +       if (serdev_device_set_baudrate(serdev, 115200) != 115200) {

Is it limitation / requirement by the hardware? Otherwise it should
come from DT / ACPI.

...

> +       ret = serdev_device_set_parity(serdev, SERDEV_PARITY_NONE);

Ditto.

...

> +       regmap = devm_regmap_init(&serdev->dev, &bno055_sl_regmap_bus,
> +                                 priv, &bno055_regmap_config);

> +       if (IS_ERR(regmap)) {
> +               dev_err(&serdev->dev, "Unable to init register map");
> +               return PTR_ERR(regmap);
> +       }

return dev_err_probe();

-- 
With Best Regards,
Andy Shevchenko
