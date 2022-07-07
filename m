Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606E0569E9F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 11:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbiGGJgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 05:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiGGJgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 05:36:41 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DE933E3D;
        Thu,  7 Jul 2022 02:36:40 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id f39so30140942lfv.3;
        Thu, 07 Jul 2022 02:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uk6eRcniuhN5P9bQg4gHK3VjMm5IPigYNw1THcOSKvQ=;
        b=FyW9C9qfEZR7mIZPF8S5ycmEPLrPFTBUXsb+qNIX6ciPJNlJ5nK62YzBOuRXszQ5qS
         ly6Kg2bk4jh0p4SYd83cpL8Xi7/FgvBXqHjjCwMdawTMnRoHjXIZOtkcLU6vcnW8IKex
         TyttroUtcTPW6/lNBnrgkX44TNj4pc0mOud8iCQEDrcKAVaAVikMuym8H4OZ9L02bXxf
         lSF/zq4wUUjdloN5t7rje790Ofi7sIHes0cLDnYZ0avFnmwUBkjMP7vY8hdmuvyJN752
         DzHCyWeGBxXRNNRH/sAhIBDfV8iRhR7hG0QwMSSP/RWspZsu3IpF/f07KyCfN8/mgrN9
         gDWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uk6eRcniuhN5P9bQg4gHK3VjMm5IPigYNw1THcOSKvQ=;
        b=WtDiXkJX0mW9fdrZPMpI7HEnpdU6fKSNfPp/5L49XRmErcv8Zp9QWZgyCSk9VOv9cQ
         SWgMnzoADv6bAsYYBDnIt+qZW0U3FwLzSbpHBv28gO3qcylJJdGnUHfot4CK3FrWuHRM
         ltQIPh5NGNlBdYOoDB4CLIPYgELwjVnm1PZUqorJDBq2ZhaLYfvzlPecVRCykiQ3m4sD
         J7kf18H7qeFSUVAh39L43wGJ+dLVb9BIrKd04RxBxA2MPNIu1xvGfNAbdcQcCbPdKfc8
         Rl/YCRdnG+gqNPltMZUWgJoNjOWk/F2vj77vaL51JM7MQBe0cehvS4sOEsUx6rRFXEPt
         kRGg==
X-Gm-Message-State: AJIora9A3Xy14oLlI62bRb6QvhlNlNkjeoXIIQu/UraO12te7llobJXx
        AUuBJ3EyLNxj68pDzHQ1E6Vq3o02KB1vC5EiMpw=
X-Google-Smtp-Source: AGRyM1s/3fGanv457EEA0rSnHymLVsgKvtRdCMQ/zbb9LZ8KzRNHq3RmIRwPJjpEQWKBjKorkI/YCRyBMceDO+VGtDE=
X-Received: by 2002:a05:6512:31d5:b0:47f:718a:3459 with SMTP id
 j21-20020a05651231d500b0047f718a3459mr30234854lfe.480.1657186598284; Thu, 07
 Jul 2022 02:36:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220527084647.30835-1-ctcchien@nuvoton.com> <20220527084647.30835-4-ctcchien@nuvoton.com>
 <YrYd+FkiFPz84twJ@mail.local> <CAHpyw9cdmCSZEE4ZbpnehpyvFhpPWA+_E5zXzJerNX9xqYet5Q@mail.gmail.com>
 <CAL3ZnpzSm7f1L2MMuDr9_vg3TQuk3PSr46fwmJTMz4sA2sdCJg@mail.gmail.com> <YsaQrksj8jBhJYGP@mail.local>
In-Reply-To: <YsaQrksj8jBhJYGP@mail.local>
From:   Mining Lin <mimi05633@gmail.com>
Date:   Thu, 7 Jul 2022 17:36:26 +0800
Message-ID: <CAL3ZnpxwEhH4bu8pmCCCkVG=bUHGvoTKSa1NgVJaEeEtcbGCBQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] RTC: nuvoton: Add NCT3018Y real time clock driver
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Benjamin Fair <benjaminfair@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Patrick Venture <venture@google.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, a.zummo@towertech.it,
        KWLIU@nuvoton.com, YSCHU@nuvoton.com, JJLIU0@nuvoton.com,
        KFTING <KFTING@nuvoton.com>, ctcchien@nuvoton.com,
        Medad Young <medadyoung@gmail.com>,
        CS20 MYLin1 <mylin1@nuvoton.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Alexandre,

Thank you for your comment and response.
I will refine again and reply below.

Thanks.
Best Regards,
Mia

Alexandre Belloni <alexandre.belloni@bootlin.com> =E6=96=BC 2022=E5=B9=B47=
=E6=9C=887=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=883:52=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> On 07/07/2022 15:17:28+0800, Mining Lin wrote:
> > Dear Alexandre,
> >
> > Thank you for your comments.
> > I will refine and reply below.
> >
> > Thanks.
> > Best Regards,
> > Mia
> >
> > Medad Young <medadyoung@gmail.com> =E6=96=BC 2022=E5=B9=B47=E6=9C=887=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=881:31=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > >
> > > Hello Alexandre,
> > >
> > > Thanks for your comments.
> > > I add Mining Lin <mimi05633@gmail.com> into this mail thread,
> > > and she is going to follow up this RTC driver.
> > > She will be in charge of maintaining this driver.
> > >
> > > Alexandre Belloni <alexandre.belloni@bootlin.com> =E6=96=BC 2022=E5=
=B9=B46=E6=9C=8825=E6=97=A5 =E9=80=B1=E5=85=AD =E5=87=8C=E6=99=A84:26=E5=AF=
=AB=E9=81=93=EF=BC=9A
> > > >
> > > > Hello,
> > > >
> > > > Please run ./scripts/checkpatch.pl --strict on your patch, there ar=
e a
> > > > bunch of issues.
> > > >
> > [Mia] I will run ./scripts/checkpatch.pl --strict on my patch to fix is=
sues.
> >
> > > > On 27/05/2022 16:46:47+0800, medadyoung@gmail.com wrote:
> > > > > +static int nct3018y_set_alarm_mode(struct i2c_client *client, bo=
ol on)
> > > > > +{
> > > > > +     int err, flags;
> > > > > +
> > > > > +     dev_dbg(&client->dev, "%s:on:%d\n", __func__, on);
> > > > > +
> > > > > +     flags =3D  i2c_smbus_read_byte_data(client, NCT3018Y_REG_CT=
RL);
> > > > > +     if (flags < 0) {
> > > > > +             dev_err(&client->dev,
> > > > > +                     "Failed to read NCT3018Y_REG_CTRL\n");
> > > >
> > > > You should cut down on the number of error messages, they are usual=
ly
> > > > not useful as the user doesn't have any specific action after getti=
ng
> > > > one of them apart from trying the action once again. Also, this wil=
l
> > > > make your code shorter. dev_dbg is fine.
> > > >
> > [Mia] I will modify dev_err to dev_dbg if there is an error and nothing=
 to do.
> >
> > > > > +/*
> > > > > + * In the routines that deal directly with the nct3018y hardware=
, we use
> > > > > + * rtc_time -- month 0-11, hour 0-23, yr =3D calendar year-epoch=
.
> > > > > + */
> > > > > +static int nct3018y_rtc_read_time(struct device *dev, struct rtc=
_time *tm)
> > > > > +{
> > > > > +     struct i2c_client *client =3D to_i2c_client(dev);
> > > > > +     unsigned char buf[10];
> > > > > +     int err;
> > > > > +
> > > >
> > > > You should still return an error if the time is invalid there but w=
ithout
> > > > an error message.
> > > >
> > [Mia] I will verify the time by rtc_valid_tm(tm).
> >
>
> No, I meant checking NCT3018Y_REG_ST as was done in the previous
> revisions of the series
>
[Mia] I will check NCT3018Y_REG_ST as was done in the previous revisions.

> > > > > +static struct clk *nct3018y_clkout_register_clk(struct nct3018y =
*nct3018y)
> > > > > +{
> > > > > +     struct i2c_client *client =3D nct3018y->client;
> > > > > +     struct device_node *node =3D client->dev.of_node;
> > > > > +     struct clk *clk;
> > > > > +     struct clk_init_data init;
> > > > > +     int flags, err;
> > > > > +
> > > > > +     /* disable the clkout output */
> > > > > +     flags =3D 0;
> > > > > +     err =3D i2c_smbus_write_byte_data(client, NCT3018Y_REG_CLKO=
, flags);
> > > >
> > > > BTW, this introduces a glitch in the clock output if the clock is
> > > > actually used. Maybe you could just rely on the CCF core to disable=
 this
> > > > clock when there are no users.
> > > >
> > [Mia] Do you mean there is no need to disable the clock output here?
> >
>
> The CCF will disable the clock at boot time if there are no users
>
[Mia] I will remove disable clock output. Thank you so much for your reply.

> --
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
