Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06ACF57FC87
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 11:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbiGYJf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 05:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbiGYJfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 05:35:22 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C951B7C9;
        Mon, 25 Jul 2022 02:35:21 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id mf4so19538848ejc.3;
        Mon, 25 Jul 2022 02:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bgUgJBvxAhuHvSfctuL9q0uW5q/+DZQMYz/lA7RIUCA=;
        b=MFyztQ19BRe9zdCrYubOitgMCBp8GI0b4DvplwRVcqISIBwwNIPlXI/4eAiwShhUa/
         Pc4Ef4jempOLnPMXNwqkt0yah1WsDY81i6smP2bMtBPGVm0qm3SqTAtCLtJk6T1qJzT8
         xVOZFWRMLFUWB1INy+EdHANpTgcip5GTaFvymbb/aW6vd0i5gfxL9cW34K9aLG+ddZI4
         0quxQtGcj9NKeOIUcNxj1SdX9v7wMuhtLboasEUHa0AMZAxoRsJE3AyX5a8SKdGGtZxU
         b0UXuCX3zVWPzNUj0fTapDUhEk9UKuHDcInxakio2QDQcZ6TXzLeusQCnN04T21KyE0a
         cJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bgUgJBvxAhuHvSfctuL9q0uW5q/+DZQMYz/lA7RIUCA=;
        b=gusB5ZoWyW44x06c1sxSXtaQ9foOA6S0UqHJpnSaeUgxxtXMG2ft5KXBkRw+My0xxr
         6YjCe1nP5MsFuL3rrt8EhXhfto+/w1ZAbFiTOS/UbTTndcvywaSary7jC+T665wz8F3+
         0R3KBedKLL6Qfhx4pqP+cKhvgjnYjs1K6QlAPPcNCbf+YuQJswDRzs5+1dGZh6Qg8ij0
         YZ3bmjKPXz/ijoXQ+l0hwyxcW7PR0MDhhxaY3vgBtq2n+yf9xZvlvCVJPYBNDK4JoQ95
         jpwIrok2ttRq9x4Tw5oWcaCLDXlT6s5GvopNIFWFXgDdlXctAt601/gqUq4LHgUQiHmZ
         Wc8Q==
X-Gm-Message-State: AJIora90RcgvvlSK8yhvzgH/5hyidlYqQ3zy7rItdCKqtwguZORISITG
        kIOvj8cL2DAw1nNWl9gwITd2OzhPVIXuBjqnqEU=
X-Google-Smtp-Source: AGRyM1s8oA6sKIkWyCiMyRbR3ezVUaZ7h8X3gbjvwcpJP15f9TOmATgpNLYn5PAsWa/S1imm/2A2S4Z0Rpoh9i95JGA=
X-Received: by 2002:a17:907:1c8d:b0:6f2:eb2:1cd6 with SMTP id
 nb13-20020a1709071c8d00b006f20eb21cd6mr9223153ejc.568.1658741719378; Mon, 25
 Jul 2022 02:35:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220721093422.2173982-1-marcus.folkesson@gmail.com> <CAHp75VddBhc9peHXfNfTyTNni246kC8CyLqCrMFadn67LGDarQ@mail.gmail.com>
In-Reply-To: <CAHp75VddBhc9peHXfNfTyTNni246kC8CyLqCrMFadn67LGDarQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 25 Jul 2022 11:34:43 +0200
Message-ID: <CAHp75VeaDMChQ9dALUBrXKY5tT7G5yYPLvUpqczaNV+3GP40+w@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: gpio-74x164: add support for CDx4HC4094
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
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

On Mon, Jul 25, 2022 at 11:32 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Jul 21, 2022 at 11:32 AM Marcus Folkesson
> <marcus.folkesson@gmail.com> wrote:
> >
> > 74hc4094 and 75hc4094 works similar to 74x164 but has an additional
> > storage latch associated with each stage for strobing data from the
> > serial input to parallell buffer tri-state output.
>
> parallel
>
> > Add support for an optional strobe pin.
>
> Sorry for my absence of understanding, but why?
> SPI has MOSI, CLK, CS, where the last one is exactly for that. No?

I have a 595 register which also has a latch. What I expect to see in
this series is just a compatible string addition (but again, why even
that is needed?).


-- 
With Best Regards,
Andy Shevchenko
