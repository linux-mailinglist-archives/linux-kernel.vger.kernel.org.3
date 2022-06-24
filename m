Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254645596C0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 11:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbiFXJev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 05:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiFXJet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 05:34:49 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9638B699BF;
        Fri, 24 Jun 2022 02:34:48 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id p69so2092342iod.10;
        Fri, 24 Jun 2022 02:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MP9RQT0mw2gx9xecm41XDjO0xQp/A9AAK0cYbd+v7PM=;
        b=XOSjJie8EVvJ68P8cDkEuXXdIP7YNykFHD5ucaFHa23sPTgdW5s+vEyYglwP5ITADf
         de6ih0EGdaikqxaCCoMYFOazeMTR+HJ2Od3FO0aVrMGZ9Ao0YQc3IGKpdK1KsldTwlvh
         mNgixo6yDK8vv6W4zP9rFZEgeSROQH0wRlhznnuez0r+LK3zlRzbpSDq8zkiXpRGsUdD
         wlBFXBP+v/yudkNVKvRuUvTnfyVEt9q4H+CcHi3K0tEYuY/us9b2jbsRIceZSdwT323h
         bCW6ZtoKL/DDgyl9mBYWdF/TeTYV9OJiSRhfvnTTdEl5HuLFgATDlbAUJ79bLaqNIqyo
         pjrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MP9RQT0mw2gx9xecm41XDjO0xQp/A9AAK0cYbd+v7PM=;
        b=hTAwqwnpuD0bg8/et7uTMOZKNM6Jv3GlxUPHmRqiY5BPoi+LOY0oBU6SMxoD9ZITW7
         bSuFV3mfndskomSI+cNkjpWG9DLQCS+O1zx6GROfdejgo0+U0Int8kVR0hHISku+Kb1p
         /2rLNceaWpnkvE4oNF7oSvrCyNG5fq6bb405EaUJfDHIjiLp6Q/VTwys6lfNd0XYF6Po
         kbvIqC5LCFWflKy6lo3HM6jVbc63MOOoPHy++FhBM0YxYEEng+lk3la3kJ8PgH2XGVof
         04eUcvPzwZ+FUUi4X0bxOEnIzQyhRe/WOBb2HRDE7XinMHgKS743ZgfGki+AYIbOxnK7
         VSkg==
X-Gm-Message-State: AJIora+kPWz4/GuYVOPISnffJ+3zolxj/ChUizbAmgtKayi0/soZjcBz
        nMNvrZUHp3/mb2kSsjujN1lv0a9JqL16dkIFp+E=
X-Google-Smtp-Source: AGRyM1uasjCkCSVNNk3dqGVMtMHhWuLiOU+3vPo8KNEsy3IZCmdFQUJiWYJTC/E8bQMesuaOX1oy1FkolQJLbHcM1Io=
X-Received: by 2002:a05:6638:348d:b0:331:d8f0:fd9d with SMTP id
 t13-20020a056638348d00b00331d8f0fd9dmr7928714jal.165.1656063287244; Fri, 24
 Jun 2022 02:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220623115631.22209-1-peterwu.pub@gmail.com> <20220623115631.22209-6-peterwu.pub@gmail.com>
 <YrRny9TPqMUW7Yr/@spruce>
In-Reply-To: <YrRny9TPqMUW7Yr/@spruce>
From:   ChiaEn Wu <peterwu.pub@gmail.com>
Date:   Fri, 24 Jun 2022 17:34:36 +0800
Message-ID: <CABtFH5JdPHfvGi+tG+EKh_-XH0YxWHR3o=LsPAdW38e8fFoBeg@mail.gmail.com>
Subject: Re: [PATCH v3 05/14] dt-bindings: backlight: Add Mediatek MT6370 backlight
To:     Joe Simmons-Talbott <joetalbott@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        jingoohan1@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, Jonathan Cameron <jic23@kernel.org>,
        lars@metafoo.de, lgirdwood@gmail.com, broonie@kernel.org,
        linux@roeck-us.net, heikki.krogerus@linux.intel.com, deller@gmx.de,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Alice Chen <alice_chen@richtek.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com
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

Hi Joe,

Joe Simmons-Talbott <joetalbott@gmail.com> =E6=96=BC 2022=E5=B9=B46=E6=9C=
=8823=E6=97=A5 =E9=80=B1=E5=9B=9B =E6=99=9A=E4=B8=8A9:17=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> On Thu, Jun 23, 2022 at 07:56:22PM +0800, ChiaEn Wu wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > Add mt6370 backlight binding documentation.
> >
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
> >
> > v3
> > - Rename "mediatek,bled-pwm-hys-input-threshold-steps" to
> >   "mediatek,bled-pwm-hys-input-th-steps"
> > - Refine "bled-pwm-hys-input-th-steps", "bled-ovp-microvolt",
> >   "bled-ocp-microamp" enum values
> > ---
> >  .../leds/backlight/mediatek,mt6370-backlight.yaml  | 92 ++++++++++++++=
++++++++
> >  1 file changed, 92 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/leds/backlight/me=
diatek,mt6370-backlight.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/leds/backlight/mediatek,=
mt6370-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/me=
diatek,mt6370-backlight.yaml
> > new file mode 100644
> > index 0000000..26563ae
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/leds/backlight/mediatek,mt6370-=
backlight.yaml
> > @@ -0,0 +1,92 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/leds/backlight/mediatek,mt6370-back=
light.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Mediatek MT6370 Backlight
> > +
> > +maintainers:
> > +  - ChiaEn Wu <chiaen_wu@richtek.com>
> > +
> > +description: |
> > +  This module is part of the MT6370 MFD device.
> > +  The MT6370 Backlight WLED driver supports up to a 29V output voltage=
 for
> > +  4 channels of 8 series WLEDs. Each channel supports up to 30mA of cu=
rrent
> > +  capability with 2048 current steps (11 bits) in exponential or linea=
r
> > +  mapping curves.
> > +
> > +allOf:
> > +  - $ref: common.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: mediatek,mt6370-backlight
> > +
> > +  default-brightness:
> > +    minimum: 0
> > +    maximum: 2048
> > +
> > +  max-brightness:
> > +    minimum: 0
> > +    maximum: 2048
> > +
> > +  enable-gpios:
> > +    description: External backlight 'enable' pin
> > +    maxItems: 1
> > +
> > +  mediatek,bled-pwm-enable:
> > +    description: |
> > +      Enable external PWM input for backlight dimming
> > +    type: boolean
> > +
> > +  mediatek,bled-pwm-hys-enable:
> > +    description: |
> > +      Enable the backlight input-hysteresis for PWM mode
> > +    type: boolean
> > +
> > +  mediatek,bled-pwm-hys-input-th-steps:
> > +    $ref: /schemas/types.yaml#/definitions/uint8
> > +    enum: [1, 4, 16, 64]
> > +    description: |
> > +      The selection of the upper and lower bounds threshold of backlig=
ht
> > +      PWM resolution. If we choose selection 64, the variation of PWM
> > +      resolution needs over than 64 steps.
>
> more than?
>
> Thanks,
> Joe
>

Thanks for your helpful comments!
I will revise this in the next patch. Thanks!

> > +
> > +  mediatek,bled-ovp-shutdown:
> > +    description: |
> > +      Enable the backlight shutdown when OVP level triggered
> > +    type: boolean
> > +
> > +  mediatek,bled-ovp-microvolt:
> > +    enum: [17000000, 21000000, 25000000, 29000000]
> > +    description: |
> > +      Backlight OVP level selection.
> > +
> > +  mediatek,bled-ocp-shutdown:
> > +    description: |
> > +      Enable the backlight shutdown when OCP level triggerred.
> > +    type: boolean
> > +
> > +  mediatek,bled-ocp-microamp:
> > +    enum: [900000, 1200000, 1500000, 1800000]
> > +    description: |
> > +      Backlight OC level selection.
> > +
> > +  mediatek,bled-channel-use:
> > +    $ref: /schemas/types.yaml#/definitions/uint8
> > +    description: |
> > +      Backlight LED channel to be used.
> > +      Each bit mapping to:
> > +        - 0: CH4
> > +        - 1: CH3
> > +        - 2: CH2
> > +        - 3: CH1
> > +    minimum: 1
> > +    maximum: 15
> > +
> > +required:
> > +  - compatible
> > +  - mediatek,bled-channel-use
> > +
> > +additionalProperties: false
> > --
> > 2.7.4
> >

Best regards,
ChiaEn Wu
