Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C5258124B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 13:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238797AbiGZLqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 07:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbiGZLqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 07:46:38 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F413C24BDC;
        Tue, 26 Jul 2022 04:46:36 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id u12so10232318qtk.0;
        Tue, 26 Jul 2022 04:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wL1b72wWwttocLxQ4i2N7IFKv69W21HPhWs4hRLf0o0=;
        b=AZ8qDLn4Znu85xCahXNOnmojv9wcePPk3Lf2KSJODsdYIL/u4rdAI0Lnw8MiXeeTQl
         0fNcl+cJw4vrGMs/9mjAcX99bHsbOpeBwt1ay2R33YRq1VsVjC++YG2fmlp7hix1YwsO
         IKZ3zoTB97u6iKZxmk+c33+dSbGXuJXJDQz+RRlu+LRdNCgrsyBWNRh2nYIBbuWUos51
         BrJUcA7G/8NE1M8r1t7zyLNEvXtcGsNdIwqfkXwOFPRNUwWDTrUivYLlX/lxHIIPKvWG
         uXmZtHYk57ezocXOjrXXXwhnGpuE94ql5T95iceJZSiu4iSTtJVip83p/q4s/P1JT7m/
         PgVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wL1b72wWwttocLxQ4i2N7IFKv69W21HPhWs4hRLf0o0=;
        b=wvpnYcrqPqDabB8SW5KSFMUYX0aK44p9eQIe9nlxcfis3Mdmi5cDaHQVkXupczyKOc
         GUXeWGFIfKOtsPn9HMGR1vVzNcd9Suh6fMHxm/2EpODI081YjQiCr07vZ7rdvwqoVXdU
         l+UhkoLymdbCOTE92gQAoUnKY/3Ln6dxdUQJz6DdDZP5m3GZOw3v0AGO8xx2pU3uQgNS
         El/qLbHDgfQSvvnVtETCjHvad0rx/1z2YdYdtcGMRyiShArQSuojf8xKIabwCgw/vYAu
         0wSJR2ApvrkKBhrnrxD66zFVuRj2v8HJ0yrhBvON8eutSbfvNcN8Vj2m+Td1uIrxj28K
         jQBQ==
X-Gm-Message-State: AJIora+A+mosHoqzSrnva77+s7B6I/5oJ7n4l9HJJlWqtX8if5/BxLJY
        m4MK65D3+ln3/uSARZx+S+8g1u8tH5TnJ8erMvE=
X-Google-Smtp-Source: AGRyM1sOWaWg8F0hJmRbLUJyv570Fqyt5WL0lP9RdfcVPQQLkd4tLFbTSnSOHuBdwqMxVIGbB1G4Kxurui/itRlhhGY=
X-Received: by 2002:ac8:5a8b:0:b0:31f:27b8:2260 with SMTP id
 c11-20020ac85a8b000000b0031f27b82260mr13732022qtc.198.1658835995667; Tue, 26
 Jul 2022 04:46:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220722102407.2205-1-peterwu.pub@gmail.com> <20220722102407.2205-12-peterwu.pub@gmail.com>
 <CAHp75VewxvEDGoPdRBvLSLQOQ6OZzVft1ce3DkF7MK_O1VXZkQ@mail.gmail.com>
In-Reply-To: <CAHp75VewxvEDGoPdRBvLSLQOQ6OZzVft1ce3DkF7MK_O1VXZkQ@mail.gmail.com>
From:   ChiaEn Wu <peterwu.pub@gmail.com>
Date:   Tue, 26 Jul 2022 19:45:59 +0800
Message-ID: <CABtFH5+im7=vyKLUqztYeAX81e7ETFc+9o7y0seg2pxH0PEnUQ@mail.gmail.com>
Subject: Re: [PATCH v6 11/13] leds: rgb: mt6370: Add MediaTek MT6370 current
 sink type LED Indicator support
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Helge Deller <deller@gmx.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Alice Chen <alice_chen@richtek.com>,
        cy_huang <cy_huang@richtek.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        szuni chen <szunichen@gmail.com>
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

On Mon, Jul 25, 2022 at 4:41 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
...
> > From: ChiYuan Huang <cy_huang@richtek.com>
>
> ^^^^ (Note this and read below)

...

> In conjunction with above what SoB of Alice means?
>
> You really need to take your time and (re-)read
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html.

Hi Andy,

Thanks for your reply.
We are very sorry for this mistake. We will revise it in the next patch.

>
> ...
>
> > + * Author: Alice Chen <alice_chen@richtek.com>
> > + * Author: ChiYuan Huang <cy_huang@richtek.com>
>
> Would
>  * Authors:
>  *    Name_of_Author 1
>  *    Name_of_Author 2
>
> work for you?

It looks good, thanks! We will apply this in the next patch.

 ...

> > +struct mt6370_led {
> > +       union {
> > +               struct led_classdev isink;
> > +               struct led_classdev_mc mc;
> > +       };
>
> Where is the field that makes union work?

Just for saving memory space.
Because these led_classdevs do not be used at the same time.
Or do you think it would be better to rewrite it as follows?
-------------------------------------------------------------------------------------
struct mt6370_led {
       struct led_classdev isink;
       struct led_classdev_mc mc;
       struct mt6370_priv *priv;
       u32 default_state;
       u32 index;
};
-------------------------------------------------------------------------------------

...

> > +static int mt6370_gen_breath_pattern(struct mt6370_priv *priv,
> > +                                    struct led_pattern *pattern, u32 len,
> > +                                    u8 *pattern_val, u32 val_len)
> > +{
> > +       enum mt6370_led_ranges sel_range;
> > +       struct led_pattern *curr;
> > +       unsigned int sel;
> > +       u8 val[P_MAX_PATTERNS / 2] = {};
> > +       int i;
> > +
> > +       if (len < P_MAX_PATTERNS && val_len < P_MAX_PATTERNS / 2)
> > +               return -EINVAL;
> > +
> > +       /*
> > +        * Pattern list
> > +        * tr1: byte 0, b'[7: 4]
> > +        * tr2: byte 0, b'[3: 0]
> > +        * tf1: byte 1, b'[7: 4]
> > +        * tf2: byte 1, b'[3: 0]
> > +        * ton: byte 2, b'[7: 4]
> > +        * toff: byte 2, b'[3: 0]
> > +        */
> > +       for (i = 0; i < P_MAX_PATTERNS; i++) {
> > +               curr = pattern + i;
> > +
> > +               sel_range = i == P_LED_TOFF ? R_LED_TOFF : R_LED_TRFON;
> > +
> > +               linear_range_get_selector_within(priv->ranges + sel_range,
> > +                                                curr->delta_t, &sel);
> > +
> > +               val[i / 2] |= sel << (4 * ((i + 1) % 2));
> > +       }
> > +
> > +       memcpy(pattern_val, val, 3);
>
> Isn't it something like put_unaligned_be24()/put_unaligned_le24()?

OK, we will try to apply this method in the next patch.
Thank you so much for reviewing our patches so many times and
providing so many great suggestions!

-- 
Best Regards,
ChiaEn Wu
