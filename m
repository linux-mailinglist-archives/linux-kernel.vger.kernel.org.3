Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1ADF586E8E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 18:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbiHAQa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 12:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbiHAQaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 12:30:55 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2808A19297;
        Mon,  1 Aug 2022 09:30:54 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id tl27so3499939ejc.1;
        Mon, 01 Aug 2022 09:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=pCF8pZfhJZgUAo3G4AwwHQOTwlc2Y3ZcF/WhS1H9H3E=;
        b=BuhlNN3/eM69jEo4xsOlIMyuFyLgI5epqWF832Y69q6TnSS0Qwce6dkFr/WKtuCAR9
         ooKxm+s0jebokSpSIizQq2Reum48dm9tu84Ir7qpa+8hZ1F4ZxgQtuRgy9B58R4FYHbf
         YmTeOvD+l9CxILjjMAmszbz4ikwm6rUKO9JllJFbIX57bXaOudSmudol60KeNiLY4HBj
         BNPoB2fmhl+CENvpW0gL8C3sruQYFQSq817nSwOgoI8UhX2TcfEv83fe6JsXbBtlKjiO
         MyqgXFzy10lPHI0Iq26PcYwsPHY9c5/Qb0J2pNSlc/Vzbt+4xZrfimmB/8i2Ur661MlZ
         9wig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=pCF8pZfhJZgUAo3G4AwwHQOTwlc2Y3ZcF/WhS1H9H3E=;
        b=8IZBaXPbqc3HvMuP/eE5lSrtk8zjwGE0wUP8zO+ZX8EPEfcmSVqynZvMr/yaKXnQBl
         DEDAzuzEO+Vh4B/5YKukOML5/Y+lDZ9L7jRrA8TZMAOy7SGm/2sb2bIB0HgUS9pngWhe
         JpIPlA15aOQv70L7ChEClKLvePNZ/Yg1JeSku7c1y4On3xrnAKdAvE+0Xb/KTSD6VTrU
         KLDWa/6qWeMcpSUPvtatDVb4HsjAl7C5WvYcPBSYKCYhIQunl7rC37T1OWfjZfpc2qcN
         k6RBSKxNzhsOfTg1UpovM83zJSmdXpnJzouT4Nxb5YBVlFCn0RrQj9L2Hq1rUgze3Ryv
         kC5A==
X-Gm-Message-State: AJIora/i/eksl2rTbz72pYHUulnfxtmgRwO6FbA59QrDyfRoZz681pr+
        aq/zNhtgZEh9DIaEAbXctR2nmuDxHlOAu16bjf8=
X-Google-Smtp-Source: AGRyM1uTUuY1reAj2HR/7630oTEyyDlsnOyudLaV+9Ht+3hMoQCiZXhWFXByMGkbtmanwtHcIX5z6yfg0eRZVC5vwxg=
X-Received: by 2002:a17:907:2dab:b0:72f:f7:bdd6 with SMTP id
 gt43-20020a1709072dab00b0072f00f7bdd6mr13731128ejc.330.1659371452623; Mon, 01
 Aug 2022 09:30:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220728125435.3336618-1-potin.lai.pt@gmail.com>
 <20220728125435.3336618-3-potin.lai.pt@gmail.com> <20220731130959.50826fc4@jic23-huawei>
 <4ea235d1-46c1-87de-760f-dc4775007ae0@gmail.com> <CAHp75VcZqTpmvVV=u4t=fdx=ffzksoWVDFZmq6Lfr6DrFrB2aA@mail.gmail.com>
 <Yuf7UAVrIJCnO40X@heinlein.stwcx.org.github.beta.tailscale.net> <CAHp75Vfe33oJAf1j27B-pTd84kX5JNPd+e16ygLYgZjCs=ZJfQ@mail.gmail.com>
In-Reply-To: <CAHp75Vfe33oJAf1j27B-pTd84kX5JNPd+e16ygLYgZjCs=ZJfQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 1 Aug 2022 18:30:16 +0200
Message-ID: <CAHp75VfOPgDbTdt1EXJ5+exGXCZeT9VdtcOUDt_g4fn20S2Qwg@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] iio: humidity: hdc100x: add manufacturer and
 device ID check
To:     Patrick Williams <patrick@stwcx.xyz>
Cc:     Potin Lai <potin.lai.pt@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
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

On Mon, Aug 1, 2022 at 6:26 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Aug 1, 2022 at 6:12 PM Patrick Williams <patrick@stwcx.xyz> wrote:
> > On Mon, Aug 01, 2022 at 10:22:16AM +0200, Andy Shevchenko wrote:
> > > On Mon, Aug 1, 2022 at 3:52 AM Potin Lai <potin.lai.pt@gmail.com> wrote:
> > > > On 7/31/22 20:09, Jonathan Cameron wrote:
> > > > In our hardware board, we have "ti,hdc1080" as main source, and "silabs,si7020"
> > > > for 2nd source. This two chip are locate at same bus and same slave address,
> > > > and we want to use multiple compatibles to support both chips with single device
> > > > node in device tree.
> > > >
> > > > Ex:
> > > > compatible = "ti,hdc1099", "silabs,si7020";
> > >
> > > This is simply broken DT, you must not put incompatible hardware on
> > > the same compatible string. DT is by definition the description of a
> > > certain platform. What you showed is a combination of incompatible
> > > chips in a single DT.
> >
> > We were mistaken that this is the appropriate way to specify this
> > behavior, partially because it works as long as the probe functions
> > return an error the next matching driver from the compatible will probe.
> > It does seem that specifying two different compatibles like this would
> > violate the intention of the DT spec:
> >
> >     The property value consists of a concatenated list of null terminated
> >     strings, from most specific to most general. They allow a device to
> >     express its compatibility with a family of similar devices, potentially
> >     allowing a single device driver to match against several devices.
> >
> > >
> > > > In order to support this, I need to add ID checking mechanism into the current
> > > > hdc100x driver, so the si7020 chip will fail to probe with hdc100x driver
> > > > (because the ID checking is not failed), then success probe with si7020.
> > > >
> > > > Base on you explanation, it looks multiple compatibles is not suitable in this
> > > > case? Would you mind advise us what would be the better approach for our case?
> > >
> > > If I may advise... fix your DT by dropping the wrong compatible item.
> >
> > This doesn't really give any helpful advice.
>
> Sorry to hear this, but it's the best and correct solution to your
> problem. Believe me, many Linux people will tell you the same.
>
> > The reality is that these two chips are pin compatible and function
> > compatible but not driver compatible.  Boards have been manufactured
> > which are identical except for this chip replaced, due various to chip
> > shortages.
> >
> > Making probe fail so that the next 'compatible' is chosen sounds like it
> > isn't desired.  I'm pretty sure you can't have two DT entries for the
> > same i2c address, but with different 'compatible" properties, and even
> > if we did you'd still need probe to fail on one of them.
> >
> > Are there any other suggestions for being able to inform the kernel that
> > one of two chips might be present?

Btw, how would it be solved in ACPI is the playing status bits by
firmware, depending on the run-time detected environment (straps,
other means). So, you may fix it on bootloader / firmware level by
patching DTB with status okay / disabled. I believe in DTB is the
number, which can be easily binary patched.

> I guess there is a gap in understanding what DT is. DT is the
> description of the *platform*. Changing any discrete component on the
> platform is changing the platform.


-- 
With Best Regards,
Andy Shevchenko
