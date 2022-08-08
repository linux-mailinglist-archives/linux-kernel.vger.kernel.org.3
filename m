Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB4858CAB0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 16:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243177AbiHHOrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 10:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbiHHOrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 10:47:08 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F125BB851
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 07:47:06 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j1so11202579wrw.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 07:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=LZVAaOQcgm//Tca/hldBYEABmqrBI/5UJwrd1QzDx7M=;
        b=s+vdPeXQ4kcWMgnjJcPA0ThaClExPbPbYQTdBSbB6pSt8dn7I74TO48JQM/HbYahxG
         qxkJTGr48OdV2dCy7ZhVxw3bitAVZnipHDFbPLowNNyl0c2GdmYKUjhq7sJkG3tQow/Z
         lIIqLUuUlubs3mF7+AgiJ5ceBldV2JYwsM2EzWBWDJucKiTLLyfMpYal2PDtki+ZCPL+
         vDaLph18dfwxDvTGa3Z5VRWJsyS8pJoWQqnqgdO9P79BuQwTUSqkWSwLzwuu1NXcID1L
         QOme00HxQ+iwrI97Q5Ar12Q94u9GHd3MeUYqZAhKbM7MhifauwWygTm4fAwe5zFfh24o
         iGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=LZVAaOQcgm//Tca/hldBYEABmqrBI/5UJwrd1QzDx7M=;
        b=e5tMcGfKu2QklAxMEK6E74m3jbjLRl4g+yDPn5O41kymtXiB3SOwHxFTi6QdrVBJGO
         78T4KYFgedLZ6fPK5243oCh9i1UczpmUFCRGphop1IPOeHUh3T2WmWtEohq0fLKk3Yxv
         GV8mQIb+5oqAWvZf2qww+ZTw1R5eyG94MO2nrKHOlr6APobTsR7Ws48z/Ds+Dp57m9sq
         zCS3RRei8GSpgz0tciEwMw27S4WPFh9vUu0+ic8Tf34yphq42k8nu7xFtunjdrAROmnF
         eLg8QSynfIcjtTicUZ+yroAA7mDBDdcROlecxE+IaKnIl3Oefpx6fs+ryGYhUWqm+FxN
         7dow==
X-Gm-Message-State: ACgBeo1G3TIdZwQc3r1dd/7JTkV8lny6cinIvaDAT4AN/e80XnjhkfEe
        mZ7hjtB8G6GjKrXQ9uPVeyRilyjNzVOh8Q==
X-Google-Smtp-Source: AA6agR5F3kkZcPrL4wQy82jkM65atD2sIrKuNGzpvnBzphC/qyfm91PM4S+RiaIPb+RPs6cEHXlgaA==
X-Received: by 2002:a5d:5957:0:b0:220:6004:18c2 with SMTP id e23-20020a5d5957000000b00220600418c2mr11688108wri.568.1659970025434;
        Mon, 08 Aug 2022 07:47:05 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id u8-20020a7bc048000000b003a50924f1c0sm13640544wmc.18.2022.08.08.07.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 07:47:04 -0700 (PDT)
Date:   Mon, 8 Aug 2022 15:47:03 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     Paul Cercueil <paul@crapouillou.net>, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH 20/28] mfd: arizona: Remove #ifdef guards for PM related
 functions
Message-ID: <YvEh53o4I3Q6+zho@google.com>
References: <20220807145247.46107-1-paul@crapouillou.net>
 <20220807145247.46107-21-paul@crapouillou.net>
 <94394206-a018-27b0-5a21-97976fc4a3bc@opensource.cirrus.com>
 <T2KAGR.KY35O6CZFRQ83@crapouillou.net>
 <2c5c063b-da58-1f6f-5422-1ada3dabb90a@opensource.cirrus.com>
 <ANMAGR.U803VAFDNZVL@crapouillou.net>
 <a27df713-31e6-a0d5-7004-80f3f7d952e6@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <a27df713-31e6-a0d5-7004-80f3f7d952e6@opensource.cirrus.com>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Aug 2022, Richard Fitzgerald wrote:

> On 08/08/2022 12:01, Paul Cercueil wrote:
> >=20
> >=20
> > Le lun., ao=FBt 8 2022 at 11:43:31 +0100, Richard Fitzgerald
> > <rf@opensource.cirrus.com> a =E9crit :
> > > On 08/08/2022 11:06, Paul Cercueil wrote:
> > > > Hi Richard,
> > > >=20
> > > > Le lun., ao=FBt 8 2022 at 10:53:54 +0100, Richard Fitzgerald
> > > > =7F<rf@opensource.cirrus.com> a =E9crit :
> > > > > On 07/08/2022 15:52, Paul Cercueil wrote:
> > > > > > Only export the arizona_pm_ops if CONFIG_PM is set, but leave t=
he
> > > > > > suspend/resume functions (and related code) outside #ifdef guar=
ds.
> > > > > >=20
> > > > > > If CONFIG_PM is not set, the arizona_pm_ops will be defined as
> > > > > > "static __maybe_unused", and the structure plus all the callbac=
ks will
> > > > > > be automatically dropped by the compiler.
> > > > > >=20
> > > > > > The advantage is then that these functions are now always compi=
led
> > > > > > independently of any Kconfig option, and thanks to that bugs and
> > > > > > regressions are easier to catch.
> > > > > >=20
> > > > > > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > > > > > Cc: patches@opensource.cirrus.com
> > > > > > ---
> > > > > > =A0 drivers/mfd/arizona-core.c | 21 +++++++++++----------
> > > > > > =A0 drivers/mfd/arizona-i2c.c=A0 |=A0 2 +-
> > > > > > =A0 drivers/mfd/arizona-spi.c=A0 |=A0 2 +-
> > > > > > =A0 3 files changed, 13 insertions(+), 12 deletions(-)
> > > > > >=20
> > > > > > diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-c=
ore.c
> > > > > > index cbf1dd90b70d..c1acc9521f83 100644
> > > > > > --- a/drivers/mfd/arizona-core.c
> > > > > > +++ b/drivers/mfd/arizona-core.c
> > > > > > @@ -480,7 +480,6 @@ static int
> > > > > > wm5102_clear_write_sequencer(struct =7F=7F=7Farizona *arizona)
> > > > > > =A0=A0=A0=A0=A0 return 0;
> > > > > > =A0 }
> > > > > > =A0 =7F-#ifdef CONFIG_PM
> > > > > > =A0 static int arizona_isolate_dcvdd(struct arizona *arizona)
> > > > >=20
> > > > > __maybe_unused?
> > > >=20
> > > > No need. The symbols are always referenced.
> > > >=20
> > > > > > =A0 {
> > > > > > =A0=A0=A0=A0=A0 int ret;
> > > > > > @@ -742,9 +741,7 @@ static int
> > > > > > arizona_runtime_suspend(struct device =7F=7F=7F*dev)
> > > > >=20
> > > > > __maybe_unused?
> > > > >=20
> > > > > > =A0 =7F=A0=A0=A0=A0=A0 return 0;
> > > > > > =A0 }
> > > > > > -#endif
> > > > > > =A0 =7F-#ifdef CONFIG_PM_SLEEP
> > > > > > =A0 static int arizona_suspend(struct device *dev)
> > > > >=20
> > > > > __maybe_unused?
> > > > >=20
> > > > > > =A0 {
> > > > > > =A0=A0=A0=A0=A0 struct arizona *arizona =3D dev_get_drvdata(dev=
);
> > > > > > @@ -784,17 +781,21 @@ static int arizona_resume(struct device *=
dev)
> > > > >=20
> > > > > __maybe_unused?
> > > > >=20
> > > > > > =A0 =7F=A0=A0=A0=A0=A0 return 0;
> > > > > > =A0 }
> > > > > > -#endif
> > > > > > =A0 =7F+#ifndef CONFIG_PM
> > > > > > +static __maybe_unused
> > > > > > +#endif
> > > > >=20
> > > > > No need to ifdef a __maybe_unused.
> > > >=20
> > > > Yes, it is needed, because the symbol is conditionally exported. If
> > >=20
> > > Why conditionally export it?
> > >=20
> > > > !CONFIG_PM, we want the compiler to discard the dev_pm_ops
> > > =A0and all the
> > > > callbacks, hence the "static __maybe_unused". That's the same
> > > > trick used > in _EXPORT_DEV_PM_OPS().
> > > >=20
> > > > (note that this patch is broken as it does not change the struct
> > > > name, =7Fin the !PM case, which causes conflicts with the .h. I'll
> > > > fix in v2)
> > > >=20
> > > > > > =A0 const struct dev_pm_ops arizona_pm_ops =3D {
> > > > > > -=A0=A0=A0 SET_RUNTIME_PM_OPS(arizona_runtime_suspend,
> > > > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 arizona_runtime_res=
ume,
> > > > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 NULL)
> > > > > > -=A0=A0=A0 SET_SYSTEM_SLEEP_PM_OPS(arizona_suspend, arizona_res=
ume)
> > > > > > -=A0=A0=A0 SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(arizona_suspend_noirq,
> > > > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 arizona_resume_noirq)
> > > > > > +=A0=A0=A0 RUNTIME_PM_OPS(arizona_runtime_suspend,
> > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 arizona_runtime_res=
ume,
> > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 NULL)
> > > > > > +=A0=A0=A0 SYSTEM_SLEEP_PM_OPS(arizona_suspend, arizona_resume)
> > > > > > +=A0=A0=A0 NOIRQ_SYSTEM_SLEEP_PM_OPS(arizona_suspend_noirq,
> > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 arizona_re=
sume_noirq)
> > > > > > =A0 };
> > > > > > +#ifdef CONFIG_PM
> > > > > > =A0 EXPORT_SYMBOL_GPL(arizona_pm_ops);
> > > > > > +#endif
> > > > >=20
> > > > > This ifdeffing is ugly. Why must the structure only be exported if
> > > > > CONFIG_PM is set?
> > > >=20
> > > > So that all the PM code is garbage-collected by the compiler if
> > > > !CONFIG_PM.
> > >=20
> > > The functions will be dropped if they are not referenced. That doesn't
> > > answer why the struct must not be exported.
> > >=20
> > > What is the aim of omitting the struct export?
> >=20
> > The functions are always referenced by the dev_pm_ops structure.
> > Omitting the struct export means that the struct can now be a "static
> > __maybe_unused" symbol in the !CONFIG_PM case, and everything related to
> > PM will be automatically removed by the compiler.
> >=20
> > Otherwise, the symbol is exported as usual. The symbol being
> > conditionally exported is not a problem - the struct is always
> > referenced (as it should be) using the pm_sleep_ptr() or pm_ptr()
> > macros.
> >=20
> > This is basically what EXPORT_SIMPLE_DEV_PM_OPS() does by the way.
> >=20
> > Cheers,
> > -Paul
> >=20
> Ok,
> Well ultimately it's up to Lee as the maintainer of the MFD subsystem.
>=20
> But the open-coded #ifdef around "static __maybe_unused" is ugly, so if
> this is going to be a common pattern a new macro would be nice.

I like to avoid #ifery in C files wherever possible.

--=20
DEPRECATED: Please use lee@kernel.org
