Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4ACE550A51
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 13:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235723AbiFSLoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 07:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiFSLoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 07:44:38 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F32E11A37;
        Sun, 19 Jun 2022 04:44:37 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id o7so16277213eja.1;
        Sun, 19 Jun 2022 04:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FQbBjcBfD7V1TcniNo3XYd/5J9V350QbGnDoj858ycY=;
        b=Xb2iTmdVGW+PvMqYxyub4QxQHV0TQ3b1izCzfoW+XluTzOwzcJfFWuSbZRoAA8lbzD
         v8FNJy0aJolsQjoY545X+w1K24MJJ5xZ1YJcMRSE57UH+wPFznA2G+6mpi7DS/3FlPRd
         FFalUTcBi633WGar9Efv/B9+GqSU1Y7hiwCWUOppYIlzQ0q+41xmysIiOxkknSiCpHUS
         TcZ86uKkqZAwlnnwnxfOIm9jG85icOGl9SiA0lwCsTpyP/KlLoaHvhupschG9uoJflWM
         f2DM8vuegImSXr+iCVartWQDiucYQCQDLz9opYJK4TWDIvyu7T9lB9/C+vOtLHmw2NT0
         PWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FQbBjcBfD7V1TcniNo3XYd/5J9V350QbGnDoj858ycY=;
        b=KRa96/jvB68+sNWm9CIHygqGsBKsFOdnKlEhprZfnq+tHbCx05q2QWKa/lEJ5yBrIN
         rQ/qxbyDxDURpjdfp4ekqg/UrWZXi+9/mqgBr/BqjOUux8DA3Oy78qsTRVpI0lX6AblA
         Kw5lo/Am+1wI1awIrm76FvmbdFPQQnUTvrZgaX2yz61QufWTw+iBBDLRwSCJ5zBdpq1M
         3bo1Yq7dLy6vs2tBnKzGh23ZCKs/seL/X2eTR2lR4e7wK9vpWTHbcX0uLelpHdYNJa4s
         QNFAuF7BVGAq57/IUtoVYXMiCGgFmY6U48L6/cNvNPM03iK7aHfODMlBDVEf0V1R7Z5l
         OKCQ==
X-Gm-Message-State: AJIora/T2Yhsa8Lg9Kn6AlwSU4hsbUsJ4UCLLFNsZ92Bt6gMG2L9LuGp
        mSvXLa9utP+YlWt3A3WJYVtIiGzYQ1l3H1O8fR+PNAhvkQU=
X-Google-Smtp-Source: AGRyM1tlqH8/GM63li+9dtAK0sP+225UJsR/jtnTMd09exzoSTHeAoncSqMSOd4NfnVRj4GYFD3MYUvNG3rNbv4f1SY=
X-Received: by 2002:a17:906:d550:b0:704:7ba6:9854 with SMTP id
 cr16-20020a170906d55000b007047ba69854mr16758726ejc.579.1655639075680; Sun, 19
 Jun 2022 04:44:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220618165747.55709-1-samuel@sholland.org> <20220618165747.55709-3-samuel@sholland.org>
In-Reply-To: <20220618165747.55709-3-samuel@sholland.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 19 Jun 2022 13:43:59 +0200
Message-ID: <CAHp75VcXNTxusT5N_8JvYWMhUyY_sAUzTcT3h0hz2bAawv6ThQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] Input: pinephone-keyboard - Add PinePhone keyboard driver
To:     Samuel Holland <samuel@sholland.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input <linux-input@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Ondrej Jirman <x@xff.cz>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Colin Ian King <colin.king@intel.com>,
        David Gow <davidgow@google.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        "fengping.yu" <fengping.yu@mediatek.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev
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

On Sat, Jun 18, 2022 at 7:10 PM Samuel Holland <samuel@sholland.org> wrote:
>
> The official Pine64 PinePhone keyboard case contains a matrix keypad and
> a MCU which runs a libre firmware. Add support for its I2C interface.

...

> +#include <linux/crc8.h>
> +#include <linux/i2c.h>
> +#include <linux/input/matrix_keypad.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/regulator/consumer.h>

Missed
types.h

...

> +#define PPKB_ROWS                      6
> +#define PPKB_COLS                      12

...

> +       for (col = 0; col < PPKB_COLS; ++col) {
> +               u8 old = old_buf[1 + col];
> +               u8 new = new_buf[1 + col];
> +               u8 changed = old ^ new;
> +
> +               if (!changed)
> +                       continue;
> +
> +               for (row = 0; row < PPKB_ROWS; ++row) {
> +                       u8 mask = BIT(row);
> +                       u8 value = new & mask;
> +                       unsigned short code;
> +                       bool fn_state;
> +
> +                       if (!(changed & mask))
> +                               continue;
> +
> +                       /*
> +                        * Save off the FN key state when the key was pressed,
> +                        * and use that to determine the code during a release.
> +                        */
> +                       fn_state = value ? ppkb->fn_pressed : ppkb->fn_state[col] & mask;
> +                       if (fn_state)
> +                               ppkb->fn_state[col] ^= mask;

Can't it be converted to use bitmap APIs?

> +               }
> +       }

...

> +static int ppkb_set_scan(struct i2c_client *client, bool enable)
> +{
> +       struct device *dev = &client->dev;
> +       int ret, val;
> +
> +       ret = i2c_smbus_read_byte_data(client, PPKB_SYS_CONFIG);
> +       if (ret < 0) {
> +               dev_err(dev, "Failed to read config: %d\n", ret);
> +               return ret;
> +       }
> +
> +       if (enable)
> +               val = ret & ~PPKB_SYS_CONFIG_DISABLE_SCAN;
> +       else
> +               val = ret | PPKB_SYS_CONFIG_DISABLE_SCAN;
> +       ret = i2c_smbus_write_byte_data(client, PPKB_SYS_CONFIG, val);
> +       if (ret) {
> +               dev_err(dev, "Failed to write config: %d\n", ret);

> +               return ret;
> +       }
> +
> +       return 0;

return ret;

> +}

...

> +static int ppkb_open(struct input_dev *input)
> +{
> +       struct i2c_client *client = input_get_drvdata(input);

> +       int ret;
> +
> +       ret = ppkb_set_scan(client, true);
> +       if (ret)
> +               return ret;
> +
> +       return 0;

  return ppkb_set_scan(...);

> +}

-- 
With Best Regards,
Andy Shevchenko
