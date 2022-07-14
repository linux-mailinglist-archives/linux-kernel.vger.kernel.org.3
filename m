Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7ED5749A6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 11:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237752AbiGNJvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 05:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234301AbiGNJuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:50:19 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FAC12D26;
        Thu, 14 Jul 2022 02:50:07 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id l11so2244959ybu.13;
        Thu, 14 Jul 2022 02:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UBLXrSfINFn+OkykEbtev0CVHfJNR4Ha91FDbpJe6vw=;
        b=jco1TUUJamGLBjUMKQJxmHydRs46RlrJYGVBVuXrdgoujFg+bNA+FRuqu9xySWKxm+
         iJ1MtPVhlh7NDYej/YkFvBQH1rWl4haWJzS8oJMmpCSCAzDBnx5brocoXUfXiB/uAfdM
         OFCWFOj+Wa/coQ+L/p2yRun8h9nxwhqAUhtPNkhFXDvtJQmjTfMKd8aLu5aGAQ9r4rKt
         pG3Pip2NDEZSbCM/gpswT2iVdDW8lMLvPHmzuu6unQZJ9SrI3aON/fekc5ofeaTFY0gc
         5sGqoeNtKloDBRE9yF69b0PWXyQ8T9A1xzHCn4bZ9woFCXpR/laDfNHFMvp3+dX42tLc
         fMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UBLXrSfINFn+OkykEbtev0CVHfJNR4Ha91FDbpJe6vw=;
        b=E7GOkMxKQvvxTeKx1WSSygnh68cvDjSYCp+lefeV/QDM912R3H2C6Y/dSo+9W+tsi+
         yz21Ew4YxkhiNaZyOKtOH+y/cmbooM8xuG1XIbmcXFRPbBtn9YtlS+3UGEOG3Pq+HHJj
         xpaWEaOyA1pRCaMMXLmCy6qfuDesdeEbS8YbAwYfQ9ur3VkI4vDMGI4gvN08Elp7eiNe
         VYVVsSb0VfaIvkL5wZRnJZo3qwEP3eHG91p+0MmSoYeKhQsHhH778BrL/c2iuw4cThKW
         U56TAyCOM1wjAKqHgmdhs/MO4wujVlAfoPAVuJDoZJnqSYp8CWjlFY4otQokoLt0RN4X
         keoQ==
X-Gm-Message-State: AJIora/NIu+kSPoBMxcmQNc7R1Ed2Ovi5gqPSTpMSOaNsixBR++rk7Tx
        SEZvltegrip4HzPXO2DDsK6UrSxIqUIBdKNG+Hg=
X-Google-Smtp-Source: AGRyM1uVizFvY1JstQJgDopDPPcpsJilLyYnoZh/AYBxHpJVN7WLVW/f3jKrRS5Q3mGaEk9B3sqdSTOJVu/pQIHekz4=
X-Received: by 2002:a25:df97:0:b0:66f:6e7c:b3c0 with SMTP id
 w145-20020a25df97000000b0066f6e7cb3c0mr7544434ybg.93.1657792207178; Thu, 14
 Jul 2022 02:50:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220704053901.728-1-peterwu.pub@gmail.com> <20220704053901.728-14-peterwu.pub@gmail.com>
 <CAHp75VdwEc9AW1w8ejsxkw+sBTF1dumd99QyzTY9BZaXiViRWQ@mail.gmail.com>
 <CABtFH5K-2+2hbpvpq2nPE5AsznkQxZF2r3MVC64Q39DJhVuUtA@mail.gmail.com>
 <CAHp75VevDwdAKLYEWJgnMDvzuPuFibLuVqH-GKazEOT76wM6_A@mail.gmail.com>
 <CABtFH5LT1Ct_9-B_XRrGwYFmL5kGS6KHR7dNVyUO5z4sTy_6oA@mail.gmail.com>
 <CAHp75VcU_9Ao2CoqiUDZHqhVOjEMZor+hctPp3YYP4HOjYLDUg@mail.gmail.com> <20220714094709.6ekfnfcf5sktiegi@maple.lan>
In-Reply-To: <20220714094709.6ekfnfcf5sktiegi@maple.lan>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 14 Jul 2022 11:49:30 +0200
Message-ID: <CAHp75VdVSvux3HRPOj=xWXZoBdn1e=nSmWi9+BZUX69XAPcZPg@mail.gmail.com>
Subject: Re: [PATCH v4 13/13] video: backlight: mt6370: Add Mediatek MT6370 support
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     ChiaEn Wu <peterwu.pub@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 11:47 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Thu, Jul 14, 2022 at 11:27:07AM +0200, Andy Shevchenko wrote:
> > On Thu, Jul 14, 2022 at 9:13 AM ChiaEn Wu <peterwu.pub@gmail.com> wrote:
> > > I have tried two methods so far, as follows
> > > -------------------------------------------------------------
> > > /*
> > >  * prop_val =  1      -->  1 steps --> b'00
> > >  * prop_val =  2 ~  4 -->  4 steps --> b'01
> > >  * prop_val =  5 ~ 16 --> 16 steps --> b'10
> > >  * prop_val = 17 ~ 64 --> 64 steps --> b'11
> > > */
> >
> > So, for 1 --> 0, for 2 --> 1, for 5 --> 2, and for 17 --> 3.
> > Now, consider x - 1:
> > 0  ( 0 ) --> 0
> > 1  (2^0) --> 1
> > 4  (2^2) --> 2
> > 16 (2^4) --> 3
> > 64 (2^6) --> ? (but let's consider that the range has been checked already)
> >
> > Since we take the lower limit, it means ffs():
> >
> >   y = (ffs(x - 1) + 1) / 2;
> >
> > Does it work for you?
>
> To be honest, for this tiny table, writing code that *doesn't* require intricate
> deciphering together with a huge comment saying what is does would probably be
> better:
>
>                 prop_val = (prop_val <=  1 ? 0 :
>                             prop_val <=  4 ? 1 :
>                             prop_val <= 16 ? 2 :
>                                              3);
>
> This would be "obviously correct" and require no comment.

Agree. It will also limit checking (and whatever needed for that).

-- 
With Best Regards,
Andy Shevchenko
