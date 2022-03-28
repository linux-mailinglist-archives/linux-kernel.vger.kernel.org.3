Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7474E970E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 14:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242700AbiC1Mxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 08:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242702AbiC1Mxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 08:53:47 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37235C669
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 05:51:50 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id b16so16898090ioz.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 05:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Hl62ZZF9xXxGgi6ZZphdBA1i//kHz1iBa2y3695NrsA=;
        b=icASZrSdFNGQbdG/IOShlTLaQfwjDp+8NApwJepYPtkO2VaC8ATzL5GB0O7w1lwJnC
         gQK/lMYDEIt2Uhb+6lmuiTqoPwhBpKt6V+zk0WyvV6JqFZkkq3lcEDuX1leU7siSlnLA
         3KBEzm2uuxPJiizEuJX544AU8uZXfi3+gLQM5j+1wjsTAPiJqc+7miG69zs/cEcN4eli
         yRLAsRf6Kty/Wh5lXqdQATNNQY3BpTJAuEsokXdbyXJTTJ7Fm3sXLqJ4POh4aMKQASxa
         EuinR2GO4dDxqRAJ7/fQj1zOgInecsrGs+2pRx0vv1bAz4R/BzKdXcYv89C6F+C9sHxN
         h2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Hl62ZZF9xXxGgi6ZZphdBA1i//kHz1iBa2y3695NrsA=;
        b=vz7uVinsaOsK9LO2yaNjGil6vcqqiP8KaVBhze7O1/U2/iPfzbrJEifuf2/F7pclfq
         wXSz7CFPYq7lO2yTwhYLPLCSfDRC3TmWn8ZmluIhZHUDYgC/oa3a8BdaxfAzl3XbJp1Q
         FX9qd9zzV12W4R1UvDwR7Rf1rqTPDrc1KaScZzd3khRSHNqW3S1i5eQjYj4VeHeGQNxq
         ROhKO+ChrNM/e3+AiaTLupbOWI+JElLUwD7OQR+SMnQuLswVxjeoHY6spDxia35HK9D1
         heDG5xNbL0Z8BSykXWFJX40QSvJ1fqj9eQO+GCXrsUWwHaDliTG6fs4C5eUQbYFL6Uv9
         c1fg==
X-Gm-Message-State: AOAM532be+jWk+UWbNK5M/ITLjF/ENF+AGELn6WbrH11B/WgHT2hCw0V
        rBVBKV6BNo47ZAVatcMIzfuPYb73IcnoHyJwMsJ93io1+tASaA==
X-Google-Smtp-Source: ABdhPJwjOhlugyhQlt5yYxr+1HihIKi/r9Q2nmaXntqRiDx9IpPxhh1ziluusQ/rSAQ46Z5+SMaNsJ5FYPJaYLRk8b4=
X-Received: by 2002:a05:6602:1683:b0:649:f7d3:f0cf with SMTP id
 s3-20020a056602168300b00649f7d3f0cfmr6162906iow.197.1648471910425; Mon, 28
 Mar 2022 05:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220328021139.8700-1-steve.lee.analog@gmail.com> <PH0PR03MB6786EB43BFAD3B711096F69B991D9@PH0PR03MB6786.namprd03.prod.outlook.com>
In-Reply-To: <PH0PR03MB6786EB43BFAD3B711096F69B991D9@PH0PR03MB6786.namprd03.prod.outlook.com>
From:   Lee Steve <steve.lee.analog@gmail.com>
Date:   Mon, 28 Mar 2022 21:51:39 +0900
Message-ID: <CA+Fz0PaxSFhZG9dOYOWd4MOtHLxwyC3fXmCDZtOTwg4+aQ+jOA@mail.gmail.com>
Subject: Re: [V3 1/2] ASoC: max98390: Add reset gpio control
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "ryans.lee@maximintegrated.com" <ryans.lee@maximintegrated.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "krzk@kernel.org" <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 5:46 PM Sa, Nuno <Nuno.Sa@analog.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Steve Lee <steve.lee.analog@gmail.com>
> > Sent: Monday, March 28, 2022 4:12 AM
> > To: lgirdwood@gmail.com; broonie@kernel.org; perex@perex.cz;
> > tiwai@suse.com; ryans.lee@maximintegrated.com; linux-
> > kernel@vger.kernel.org; alsa-devel@alsa-project.org
> > Cc: krzk@kernel.org; Sa, Nuno <Nuno.Sa@analog.com>; Steve Lee
> > <steve.lee.analog@gmail.com>
> > Subject: [V3 1/2] ASoC: max98390: Add reset gpio control
> >
> > [External]
> >
> >  Add reset gpio control to support RESET PIN connected to gpio.
> >
> > Signed-off-by: Steve Lee <steve.lee.analog@gmail.com>
> > ---
> >  sound/soc/codecs/max98390.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/sound/soc/codecs/max98390.c
> > b/sound/soc/codecs/max98390.c
> > index 40fd6f363f35..05df9b85d9b0 100644
> > --- a/sound/soc/codecs/max98390.c
> > +++ b/sound/soc/codecs/max98390.c
> > @@ -1022,6 +1022,7 @@ static int max98390_i2c_probe(struct
> > i2c_client *i2c,
> >
> >       struct max98390_priv *max98390 =3D NULL;
> >       struct i2c_adapter *adapter =3D i2c->adapter;
> > +     struct gpio_desc *reset_gpio;
> >
> >       ret =3D i2c_check_functionality(adapter,
> >               I2C_FUNC_SMBUS_BYTE
> > @@ -1073,6 +1074,17 @@ static int max98390_i2c_probe(struct
> > i2c_client *i2c,
> >               return ret;
> >       }
> >
> > +     reset_gpio =3D devm_gpiod_get_optional(&i2c->dev,
> > +                                          "reset", GPIOD_OUT_LOW);
>
> Forgot to mention,
>
> As you stated in the bindings the gpio is active low, this should also be
> GPIOD_OUT_HIGH, if we want to have the device in reset after this call.
>
> - Nuno S=C3=A1
>

This also agree with your comment. I will update next version patch if
there is other concern.
