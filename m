Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9912580617
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 23:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbiGYVCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 17:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiGYVCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 17:02:35 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41532237CB;
        Mon, 25 Jul 2022 14:02:34 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id z22so15531079edd.6;
        Mon, 25 Jul 2022 14:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1zhas+8j3Wav2jMIlQmpqUM9YHQ6PqTqpsAq4Djjqwg=;
        b=M/gXcYWmpK6NPe5p+2Pq4EMKc3X45ZXAOFG2H1e/evwrSyEU+YnnNtpJpAgyIb0nPG
         2iRgZNe0RN68r7cAdZ7eNBbRKbXboinWjbGGFgYvuemsP+2zq3Ekp5KPvdS1QFsU0gWg
         lcVkNtwt9uk3Sar7RHWr39BCkyI0nD0HvVdCF9PJJP7oEdg5FC6Z/UqVtSL5VV7F0Crn
         An4siyp+A/7DXsmczgc5ZX+ejf06aeaFUtIIT8p8OAwMSHIlb70UDeybuZCG8tojKfKY
         t6OiJsU4ae93uEXDV8q9J4WJEEUNCqw07kMY5wbdXCaPBefTlrVAwNLcflsyFF47SKJp
         ZUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1zhas+8j3Wav2jMIlQmpqUM9YHQ6PqTqpsAq4Djjqwg=;
        b=qT7LHtQWxkr/5wYn353cJSoyUNIVpqVt2RroBo0G2gMEXC0lvqO6j4XyJvn3NJVxuF
         OPL0a1CbnLOHXFfid1Ugb3rK4DFeNuyJducPJo+alBJnK4Ada1lX7/ctfjsMob7txz/v
         Qj37+uX1nRB1BcS9cQcTJ5sOCQwMZNf0Ib+O3MgF7SvHxBhYSfg7T+msLmvUtCc+/dEX
         /8F6w7V4238kNVWai8Re/PeapT8tViG/I5Yw28mE6CU8u+TGi01LYqGBzSZYiYG7HXkP
         cngXdPcluLRH1n/EDYqcr5AMNUG3N83SscV3F3nZVTmZ+GWb57nRv2BWgJtcKXg7fE+f
         m0ww==
X-Gm-Message-State: AJIora8aaycO4lzfye+kMJSxbx7aFQSsP1bZccb+695fhsrRyDLLoncX
        RSOdx4NUESAOmkAGuVIAlAkLKsR0iyFVFJdFUGceMNjV77Q=
X-Google-Smtp-Source: AGRyM1toS9e2QkPPe35y3WOoD+NQiUZrM17KRlMPBBqXq/DFCH4IquvDKzOfQAYT58z4+gR2SWNOQ9NSDettfjc+DFc=
X-Received: by 2002:a05:6402:d53:b0:43b:a0cf:d970 with SMTP id
 ec19-20020a0564020d5300b0043ba0cfd970mr14726259edb.277.1658782952432; Mon, 25
 Jul 2022 14:02:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220722172035.44977-1-potin.lai.pt@gmail.com>
In-Reply-To: <20220722172035.44977-1-potin.lai.pt@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 25 Jul 2022 23:01:56 +0200
Message-ID: <CAHp75VdH4UXsG7GP5A3ocy0-J2XDr=9akwX+dwczt6ejA8kO7A@mail.gmail.com>
Subject: Re: [PATCH 1/1] iio: humidity: hdc100x: add manufacturer and device
 id cehck
To:     Potin Lai <potin.lai.pt@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 7:25 PM Potin Lai <potin.lai.pt@gmail.com> wrote:
>
> Add manufacturer and device id checking during probe, and Skip the

ID
skip

> checking if chip model not supported.
>
> Supported:
> - HDC1000
> - HDC1010
> - HDC1050
> - HDC1080
>
> Not supported:
> - HDC1008

...

> +enum {
> +       HDC100X,
> +       HDC1000,
> +       HDC1008,
> +       HDC1010,
> +       HDC1050,
> +       HDC1080

+ Comma here.

> +};

...

> +static const struct of_device_id hdc100x_dt_ids[];

No, drop it.

...

> +       match = i2c_of_match_device(hdc100x_dt_ids, client);
> +
> +       if (match) {
> +               of_data = (struct hdc100x_of_data *)match->data;
> +               if (!of_data->support_mfr_check)
> +                       return true;

Besides the redundant blank line this call to i2c_of_match_device() is not good.

of_data is a misleading name. What about ACPI?

What you are looking for is:

  data = device_get_match_data(&client->dev);

> +       } else if (id->driver_data == HDC1008)

Don't use I2C id field, switch to i2c ->probe_new() if it's not done yet.

> +               return true;
> +
> +       mfr_id = hdc100x_read_mfr_id(client);
> +       dev_id = hdc100x_read_dev_id(client);
> +       if (mfr_id == HDC100X_MFR_ID &&
> +          (dev_id == 0x1000 || dev_id == 0x1050))
> +               return true;
> +
> +       return false;
> +}

...

>  static const struct i2c_device_id hdc100x_id[] = {
> -       { "hdc100x", 0 },
> -       { "hdc1000", 0 },
> -       { "hdc1008", 0 },
> -       { "hdc1010", 0 },
> -       { "hdc1050", 0 },
> -       { "hdc1080", 0 },
> +       { "hdc100X", HDC100X },
> +       { "hdc1000", HDC1000 },
> +       { "hdc1008", HDC1008 },
> +       { "hdc1010", HDC1010 },
> +       { "hdc1050", HDC1050 },
> +       { "hdc1080", HDC1080 },

Please, use pointers as in of_device_id table.

>         { }
>  };

-- 
With Best Regards,
Andy Shevchenko
