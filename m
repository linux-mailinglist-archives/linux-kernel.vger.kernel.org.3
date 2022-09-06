Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE2B5AE1F2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 10:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbiIFIJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 04:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238774AbiIFIIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:08:32 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5BB6D555;
        Tue,  6 Sep 2022 01:08:31 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id gb36so21329023ejc.10;
        Tue, 06 Sep 2022 01:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=ixcTJEmX6ojSJFpffdmxDEeT09//71awlYUYMTCkQ2k=;
        b=ZEw2t8eu/IGDJPWWS2O9AIx5J+sVDehAoSc0jwGGUi62VfOxEv0EBn/OlitZ+YCeRf
         PR7LKeKeVrdvAjyp8thX5wqf3UHxdpDl/5T0XW+lG1qku5rK3Hmmkzjsm47nUXSsg7+J
         8Q8z8iDRqSYxh3qlGRknUNhrP+SLOPhXZYUqTDAd5ceCxMn3My+V9VqLUS81gaE+cIXs
         9GfSR3XtxUG6oomZZeXFRlN68cuesq9Zl6Ovhe3SK7WEcHMxmTFlxs4Xjq5ADtAWyUOX
         oVY5p05K7+V5XUbz+R/MJUb0BWZLhdSpttHWjB9fbbrIPyoqqov5dyuatCRJqfNPHBKQ
         mU6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ixcTJEmX6ojSJFpffdmxDEeT09//71awlYUYMTCkQ2k=;
        b=q1Oc9B2rNSeUbfBTuh7vdkbKep0iTlYrepaAyezIjs4vdgfUdfaGvkSvheVeDUqi5X
         nwmsPaAQqFi1J/PLPERVCnNBPUeJ6j8njYXT0OQ3NMzLugCRSqXFRB+VjU9xFy7NAPWN
         xd6rYioE+HBGu7sE+2Kre+XXWTlTGyjdDSSm+fItLt616VUjhSFwJ2YxNPuEUmorVrfn
         vE1PA89x4qoXeIQ/eXEcOt7PJV8qtID3sXtUFomulnrnj2Y6mXxLtcINz68NTQJoHpK4
         Vfr88WXA5PUbSt5GA1MC8SASBNGsxN8Da7qk03gJsAc1cNzuCGHwoO/VYJxZoaOOZw7b
         LwSg==
X-Gm-Message-State: ACgBeo2yIU+pMEox/bVAowz1l+nZuJJIPfxvSaOnXDm3xfChmX1bb5PS
        mjuLHqTI8+Oz/eGadwfx0iob1FpHTLQQv2WUCCYrrDBsSAs=
X-Google-Smtp-Source: AA6agR7l2FBAWvpWs6dGX+cL9sjarYnZLQUBlXz3+1QQvQp7fIsevP7hAeerxFCrUwKA5g5IT5oDby9FydR2xo3Y+I4=
X-Received: by 2002:a17:906:8450:b0:741:5b1b:5c7f with SMTP id
 e16-20020a170906845000b007415b1b5c7fmr30767205ejy.766.1662451709902; Tue, 06
 Sep 2022 01:08:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220905171601.79284-1-peron.clem@gmail.com> <20220905171601.79284-5-peron.clem@gmail.com>
 <OS0PR01MB5922142861E78A1DD81AD1C9867F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAJiuCceGZJr24hVjpP0ptOkG8bMFKr=QLj0LcyDX4fUy7Rr2xA@mail.gmail.com>
 <OS0PR01MB5922EE3F6CDD827919A7763E867E9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAJiuCcd7upgT6vQWHos-X1-89+Z-5xxDe2SMCdC2=_LgZaVMiw@mail.gmail.com> <OS0PR01MB5922240073630A409D67ED03867E9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922240073630A409D67ED03867E9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Tue, 6 Sep 2022 10:08:18 +0200
Message-ID: <CAJiuCcddO9m3L2--rycO9TVtoELy24OMb9NRdpin2mbokm=Hog@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] drm/panfrost: devfreq: set opp to the recommended
 one to configure and enable regulator
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
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

Hi,

On Tue, 6 Sept 2022 at 10:06, Biju Das <biju.das.jz@bp.renesas.com> wrote:
>
> Hi Clement,
>
> > Subject: Re: [PATCH v3 4/5] drm/panfrost: devfreq: set opp to the
> > recommended one to configure and enable regulator
> >
> > Hi Biju,
> >
> > On Tue, 6 Sept 2022 at 08:42, Biju Das <biju.das.jz@bp.renesas.com>
> > wrote:
> > >
> > > Hi Clement,
> > >
> > > >
> > > > Hi,
> > > >
> > > > On Mon, 5 Sept 2022 at 20:17, Biju Das <biju.das.jz@bp.renesas.com>
> > > > wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > Thanks for the patch.
> > > > >
> > > > > > Subject: [PATCH v3 4/5] drm/panfrost: devfreq: set opp to the
> > > > > > recommended one to configure and enable regulator
> > > > > >
> > > > > > devm_pm_opp_set_regulators() doesn't enable regulator, which
> > > > > > make regulator framework switching it off during
> > regulator_late_cleanup().
> > > > >
> > > > > In that case, why not regulator_get()for Dynamic regulator(non
> > > > > fixed regulator)??
> > > >
> > > > Sorry I don't understand, what do you mean?
> > >
> > > Normally we need to turn on regulator and clock only when needed.
> > > I am not sure with your new code, will make it always on and drains
> > > the power unnecessarily and does it set lower opp or higher opp at th=
e
> > > start??
> >
> > The code doesn't make it always on, it makes it how it should be at the
> > recommended OPP which is the "start point".
> >
> > If the recommended OPP says to switch off the regulator then it will.
> >
> > >
> > > Compared to the fixed regulator, you have voltage regulator to contro=
l
> > > that is the difference between my environment and Your environment.
> > >
> > > I am not sure any other SoC is using voltage regulator??
> > > If yes, thenthere should be some bug or some difference in HW which i=
s
> > > giving different behaviour??
> > >
> > > If you are the first one using voltage regulator with mali gpu, Then
> > > Your implementation may be correct, as you have proper HW to check.
> >
> > The issue is that my regulator is not marked as "always-on", if no OPP =
is
> > called before regulator_late_cleanup() then nobody sets the
> > regulator_enable() and the regulator is switched off, which makes my
> > board hang.
>
> Cool, From your testing looks like no one tested this feature with
> mali GPU on mainline??

Or no one without always-on.

Clement

>
> Cheers,
> Biju
>
>
> >
> > Like Viresh recommends I will send an update with more details in the
> > commit log.
> >
> > Regards,
> > Clement
> >
> >
> > >
> > > >
> > > > >
> > > > > >
> > > > > > Call dev_pm_opp_set_opp() with the recommend OPP in
> > > > > > panfrost_devfreq_init() to enable the regulator and avoid any
> > > > > > switch off by regulator_late_cleanup().
> > > > > >
> > > > > > Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > > > > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > > > > > ---
> > > > > >  drivers/gpu/drm/panfrost/panfrost_devfreq.c | 8 ++++++++
> > > > > >  1 file changed, 8 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> > > > > > b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> > > > > > index 5110cd9b2425..67b242407156 100644
> > > > > > --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> > > > > > +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> > > > > > @@ -131,6 +131,14 @@ int panfrost_devfreq_init(struct
> > > > > > panfrost_device
> > > > > > *pfdev)
> > > > > >               return PTR_ERR(opp);
> > > > > >
> > > > > >       panfrost_devfreq_profile.initial_freq =3D cur_freq;
> > > > > > +
> > > > > > +     /* Setup and enable regulator */
> > > > > > +     ret =3D dev_pm_opp_set_opp(dev, opp);
> > > > > > +     if (ret) {
> > > > > > +             DRM_DEV_ERROR(dev, "Couldn't set recommended
> > OPP\n");
> > > > > > +             return ret;
> > > > > > +     }
> > > > >
> > > > >
> > > > > FYI,
> > > > > On RZ/G2L mali gpu, we have fixed regulator and I was able to do
> > > > > GPU OPP transition without any issues previously.
> > > >
> > > > rzg2l-smarc-som.dtsi uses regulator reg_1p1v; which is marked as
> > > > regulator-always-on; that's why
> > > > regulator_late_cleanup() doesn't switch it off.
> > >
> > > Yes that is correct. It is fixed regulator and always on.
> > > We control only frequency.
> > >
> > > Cheers,
> > > Biju
> > >
> > > >
> > > > >
> > > > > root@smarc-rzg2l:~# cat /sys/class/devfreq/11840000.gpu/trans_sta=
t
> > > > >      From  :   To
> > > > >            :  50000000  62500000 100000000 125000000 200000000
> > > > 250000000 400000000 500000000   time(ms)
> > > > > *  50000000:         0         0         0         0         0
> > > > 0         0         1       144
> > > > >    62500000:         0         0         0         0         0
> > > > 0         0         0         0
> > > > >   100000000:         0         0         0         0         0
> > > > 0         0         9       524
> > > > >   125000000:         0         0         9         0         0
> > > > 0         0         3      2544
> > > > >   200000000:         0         0         0        11         0
> > > > 0         0        46      3304
> > > > >   250000000:         1         0         0         0        33
> > > > 0         0         0      7496
> > > > >   400000000:         0         0         0         0        16
> > > > 19         0         0      2024
> > > > >   500000000:         1         0         0         1         8
> > > > 15        35         0      4032
> > > > > Total transition : 208
> > > > >
> > > > > Cheers,
> > > > > Biju
> > > > >
