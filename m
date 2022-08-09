Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4372658D805
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 13:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238096AbiHIL2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 07:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbiHIL2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 07:28:40 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E80219292;
        Tue,  9 Aug 2022 04:28:40 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d16so11040956pll.11;
        Tue, 09 Aug 2022 04:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=VIiZZVAptd5oSBmx9Azfpj0vKhX9kuKTVoBaO2I82Tw=;
        b=LgAxdbOWyuUIuL3YTJih5ytfqHTawzMlOfNpy9MIPTRVVVtIuhnPwmz10U7GTmxwoa
         A7CU08LoPnc3dFyKheKIND6+C3FMOcv+Zec+PVO48Ig5UDN0+TpprbqmgdjW0FusXqjo
         6JuU5KeMz/j2QDwmNX4l9I2K2xIKpvZc8ktQjHEQ/d3FJ7ntXXTOO7Z5yM/kxgWetyJw
         g81gwpIbPYEpD7xHwGkiJJWpMyNLXWPqDDvX9UvXhQixmyYZGzkWuBk+sCZHkmawJvpR
         eWh3sLR4E3WoaRrr1WAZ7ok4nX7tz64WlKXF7nc0e5hI3s3Jh45H6hWsMFyUNho9Dxxw
         kPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=VIiZZVAptd5oSBmx9Azfpj0vKhX9kuKTVoBaO2I82Tw=;
        b=pgSdgLHOITuulg0Vppj+g8fIpunPPJEfA7XyjLXn4T6YsQavYHJ1Hj4cP3ezSir4ML
         KmNpNst2oT+svEba4pBelzeoWK2sBOuxTchtYGrVVSImMgdWnqiEwiZYRteCBk9JjtNL
         oWGXPe57OfztxrQKU9Lpz2VV+GkD+hO4tfFvcTprJBNTHxYe7UVS8M7a7hzk3ZsawlAE
         g0NhbEH5I2Yd7dbneXdrqoKjrR7/9S/nbu0hkrKhwSflja6bhJdbm6Qt9Zl8T4FUmgp+
         tnV3sc7ZxQznZXjUhtteMH2+DSBHEs3Eq2Elnw5L1ledAHCh186QxhmweuUsjucY9Miq
         SVsg==
X-Gm-Message-State: ACgBeo1KSDkICOaMUkSUou6WvaspPndgYXIEx9RafEhs2kMzpmh33THf
        uu3ED6qijs/vyxr+zTNMiXqMRbNLPPybebcXBsA=
X-Google-Smtp-Source: AA6agR45VCQGXf/7Di9MAsVfM1ob5MNVs/XZtyhXe84XqAGlWYokWouUAXa/mdqnKk+nv6X7bGSqAGb+8u6s77Mnnb4=
X-Received: by 2002:a17:902:e5c8:b0:16f:1511:7575 with SMTP id
 u8-20020a170902e5c800b0016f15117575mr23196630plf.83.1660044519576; Tue, 09
 Aug 2022 04:28:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220525115554.430971-1-alistair@alistair23.me>
 <20220525115554.430971-2-alistair@alistair23.me> <Yo5vjlsc0J1S70zN@sirena.org.uk>
 <Yo86jpMrKR0Dj/HB@google.com>
In-Reply-To: <Yo86jpMrKR0Dj/HB@google.com>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Tue, 9 Aug 2022 21:28:13 +1000
Message-ID: <CAKmqyKOrtHHGOB81UvHQX=bMke_1e5Y7GPcSrqFcMtEvL6EtJw@mail.gmail.com>
Subject: Re: [PATCH v21 1/4] mfd: silergy,sy7636a: Add config option
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Alistair Francis <alistair@alistair23.me>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        Amit Kucheria <amitk@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-hwmon@vger.kernel.org, dl-linux-imx <linux-imx@nxp.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Zhang Rui <rui.zhang@intel.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
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

On Thu, May 26, 2022 at 6:30 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Wed, 25 May 2022, Mark Brown wrote:
>
> > On Wed, May 25, 2022 at 09:55:51PM +1000, Alistair Francis wrote:
> > > Add a specific MFD_SY7636A config option.
> > >
> > > As part of this change we can use MFD_SY7636A as a dependency for all
> > > SY7636a components and also remove the name from MFD_SIMPLE_MFD_I2C a=
s
> > > it no longer needs to be selectable.
> >
> > Acked-by: Mark Brown <broonie@kernel.org>
>
> Full disclosure; I've already made my cut for v5.19.
>
> This is due for v5.20.

I just wanted to double check that this is still going in for 5.20

Alistair

>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Principal Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
