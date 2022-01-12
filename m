Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1739F48C72B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 16:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343582AbiALPZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 10:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239638AbiALPZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 10:25:19 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E77C06173F;
        Wed, 12 Jan 2022 07:25:18 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id u21so11389076edd.5;
        Wed, 12 Jan 2022 07:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jb0Aws15sUqqPPF1snX5idhvSSKTtYFJ6la0GoyCYmQ=;
        b=GSOmQ2fuM/KZtX/L7+KQQQNTzAEr4YHKm7VoHV/pBd/JE9+kVc9ii6Z0sWSZqYeWj3
         V0bvtZKsbt0Q4DGXohdJ1HDi8squ6Gprx8MzIG8/8WfSzG+hkJLVXqNdr5bTpSoUBC5q
         0Zd0kRRBCPgDzYuYry7vaRMBQiN3ZSr/FNO0w4fJ9k9g9nqw8v8PdEfaaZuM8RCucS5Z
         EVmbVhrQeH06zobwpmtSL0ykVUtCAyM5jbfH++8wL8pVrJa3Xy+b/TPu8V0XBHobTzTw
         L9gnOInzJj0y1Nc1QD8EE1Y8GZnh5jxWsZ5B5iEEXAQ5gHh9/yTDPuQe6dVgwrkxLPNq
         ezNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jb0Aws15sUqqPPF1snX5idhvSSKTtYFJ6la0GoyCYmQ=;
        b=P6+zITU5r5rxmEfW+UPiVYWSLTG9wdaz1YRT7FskcMyLt5RKsg9eBiOCm0Y+q7iTpt
         jMUtq9f5j3jjwxZmIgrHXFxXDFmzIrKSqXOCye/0lqrwrkw8my7Z/76Z3uYNIWR+irpp
         N+K3Hk/vobbeN3jwcLVGSd8zZ/jTEyc8TbL+9Kz2TArYLZ4WdaMSEA0gydzeoRb70X8P
         ULGO6Mruudv0lDXi10rcO8icfIH86C6DLCTw/2spzUTpSUU0yGrAxs6ZFMY7Hob5KHJ1
         cNLnFQhHWKqncTTbXAsBl2uHtgO567Xrt5557M1ETFf5ubVtXmoaQORdTFq5hgJ7we9D
         cqjw==
X-Gm-Message-State: AOAM532a1qI1UoPD7F8Y0Rm6XeniclAS54eb7ugOhev/PE9H79Yu8GZ2
        kkOH8MUBQQdnUw3pHn6cwsBlcKTe5sM0IFKbFu4=
X-Google-Smtp-Source: ABdhPJzwJY6j8De4Ww6BiJIZ9VQo11crPFItxOnoxWjRZsAMMvg1dIOXI5gplqXeHXXi9N2T2WOqBqu+HVqgLIfVOu0=
X-Received: by 2002:a17:907:6e0b:: with SMTP id sd11mr226344ejc.132.1642001117349;
 Wed, 12 Jan 2022 07:25:17 -0800 (PST)
MIME-Version: 1.0
References: <20220111115919.14645-1-cristian.pop@analog.com> <20220111115919.14645-2-cristian.pop@analog.com>
In-Reply-To: <20220111115919.14645-2-cristian.pop@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 12 Jan 2022 17:23:31 +0200
Message-ID: <CAHp75VcE=Ac=DAJc2t2dp5G7CM_qRDKWencNiWmb_ijhHh4NBg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] one-bit-adc-dac: Add initial version of one bit ADC-DAC
To:     Cristian Pop <cristian.pop@analog.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 11:50 AM Cristian Pop <cristian.pop@analog.com> wrote:
>
> This allows remote reading and writing of the GPIOs. This is useful in
> application that run on another PC, at system level, where multiple iio
> devices and GPIO devices are integrated together.

Should it be called GPIO-IIO proxy or something like that?

...

> +/*

> + * one-bit-adc-dac
> + *

These two lines make no sense.

> + * Copyright 2022 Analog Devices Inc.
> + */

...

> +enum ch_direction {
> +       CH_IN,
> +       CH_OUT,
> +};

How is it different from the corresponding GPIO flag?

...

> +static int one_bit_adc_dac_write_raw(struct iio_dev *indio_dev,
> +                           struct iio_chan_spec const *chan,
> +                           int val,
> +                           int val2,
> +                           long info)

Can be compressed to a fewer LOCs.

...

> +       return sprintf(label, "%s\n", st->labels[ch]);

In a few releases the sysfs_emit() is present and must be used.

...

> +       fwnode = dev_fwnode(device);

No need. See below.

...

> +       child_num = device_get_child_node_count(device);

Error checks?

...

> +       st->labels = devm_kzalloc(device, sizeof(*st->labels) * child_num, GFP_KERNEL);

You should use devm_kcalloc() instead, it does slightly more than
simple multiplication.

> +       if (!st->labels)
> +               return -ENOMEM;

...

> +       fwnode_for_each_child_node(fwnode, child) {

device_for_each_...

> +               if (fwnode_property_read_u32(child, "reg", &crt_ch))
> +                       continue;
> +
> +               if (crt_ch >= num_channels)
> +                       continue;
> +
> +               if (fwnode_property_read_string(child, "label", &label))
> +                       continue;
> +
> +               chan = &channels[crt_ch];
> +               st->labels[--i] = label;
> +       }

...

> +MODULE_LICENSE("Dual BSD/GPL");
> \ No newline at end of file

Aiaiai.

-- 
With Best Regards,
Andy Shevchenko
