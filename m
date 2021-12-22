Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D56647CADA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 02:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbhLVBlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 20:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbhLVBlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 20:41:20 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BBDC061574;
        Tue, 21 Dec 2021 17:41:20 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id k4so631088pgb.8;
        Tue, 21 Dec 2021 17:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6K7N4UjpnuaxK3Sh6mPVLELDuxKa+PLKP+BFEP685jY=;
        b=SMRAJ1xqXIoyhnMoLmIxQWVa/YpTEx71QOMPEebv+xBLCjgoDFHJAVpy6eMOzkWzox
         6WQ7BplXFgfVGNUJHyyMEIY+OREEbXI/dbTIxkQBaXWDaZ+Aa0BsyhEEsCI/C6rR8DcY
         N5Fcz1DKiWid+tJSSVdpQWri1J05CvDrbUY4E1W5m90vEfu8g6gb40rkykh/WVaLlAtM
         Ki+7JHxby0+dKGMTgJptKz7D7oxDC4q27O6h/uA8bmf37GGFlMGUziq3sTQzF41x48ZG
         XWR2KfIgzY1ZBwLSJi7Qv9qpVqhmJZvGJsTsd/CrXfz4HU8g0yHsd4u6AV6jCGT6KLkr
         iC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6K7N4UjpnuaxK3Sh6mPVLELDuxKa+PLKP+BFEP685jY=;
        b=xeVI1sxSVMjV7HaDEn8OjJERbRvY/+ixp+oEJjLJ367Ahl2RKZIbW7XFIJGoLE81eN
         xGYgBPoU7XFuTe5sB/uKOKKsOQmRQx2CqxzcPo33/TBt16uzwBywUS+SpIOKkLu6g2HA
         nYRMnUb622OMcVyO+4VlL9McH8at5f2ZxLXOJB1tYN6J6nuVX6LcipwqsAPXscaoo348
         KGXpts0HtecSzuxIaPRF/MNTMYM67+MQoxOW+rS6ajzHeboxTlwwbSwtlsYG84VIMDoW
         PIDUuO8dt9SEpOMM69RcCwFFEfVo8kbKoTpFjJ44zT/MxoXT4aP2YjN5+gO6Vt1VjkeB
         8STA==
X-Gm-Message-State: AOAM531DeLUqCE3G5OeDeQPa20zp7XVBI/ffIrd6+MOR/m3ArlbCZBz7
        1N5OG1I/DG3JTqHEdQ0QNSwMJvZlXFpZsLFyA6Q=
X-Google-Smtp-Source: ABdhPJzfCo98u7x/jwskvJDCvCk1PyC9iP6mze1CLwuBv6w/DaWloS5g93zen5uYK6IYg+LxohLuHf7U1T7kw7PGlJ8=
X-Received: by 2002:a63:5725:: with SMTP id l37mr914873pgb.476.1640137279698;
 Tue, 21 Dec 2021 17:41:19 -0800 (PST)
MIME-Version: 1.0
References: <1639741568-5846-1-git-send-email-hammer.hsieh@sunplus.com>
 <1639741568-5846-2-git-send-email-hammer.hsieh@sunplus.com> <YcIZiFvyo+N4ai7r@robh.at.kernel.org>
In-Reply-To: <YcIZiFvyo+N4ai7r@robh.at.kernel.org>
From:   hammer hsieh <hammerh0314@gmail.com>
Date:   Wed, 22 Dec 2021 09:41:25 +0800
Message-ID: <CAOX-t55PpckabHXHU+f9_Js16qiFk2rcmG7-TjOwVkq6OspTZA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings:pwm:Add bindings doc for Sunplus SoC
 PWM Driver
To:     Rob Herring <robh@kernel.org>
Cc:     thierry.reding@gmail.com,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, lee.jones@linaro.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wells.lu@sunplus.com,
        Hammer Hsieh <hammer.hsieh@sunplus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Rob Herring:

I will fix it in next submit patch.

Regards,
Hammer Hsieh


Rob Herring <robh@kernel.org> =E6=96=BC 2021=E5=B9=B412=E6=9C=8822=E6=97=A5=
 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=882:14=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Fri, Dec 17, 2021 at 07:46:07PM +0800, Hammer Hsieh wrote:
> > Add bindings doc for Sunplus SoC PWM Driver
> >
> > Signed-off-by: Hammer Hsieh <hammer.hsieh@sunplus.com>
>
> The author email and S-o-b must match.
>
> > ---
> >  .../devicetree/bindings/pwm/pwm-sunplus.yaml       | 45 ++++++++++++++=
++++++++
> >  MAINTAINERS                                        |  5 +++
> >  2 files changed, 50 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sunplus.y=
aml
> >
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-sunplus.yaml b/D=
ocumentation/devicetree/bindings/pwm/pwm-sunplus.yaml
> > new file mode 100644
> > index 0000000..9af19df
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/pwm-sunplus.yaml
> > @@ -0,0 +1,45 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright (C) Sunplus Co., Ltd. 2021
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pwm/pwm-sunplus.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Sunplus SoC PWM Controller
> > +
> > +maintainers:
> > +  - Hammer Hsieh <hammer.hsieh@sunplus.com>
> > +
> > +properties:
> > +  '#pwm-cells':
> > +    const: 2
> > +
> > +  compatible:
> > +    items:
> > +      - const: sunplus,sp7021-pwm
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  resets:
> > +    maxItems: 1
> > +
> > +required:
> > +  - '#pwm-cells'
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    pwm: pwm@9c007a00 {
> > +      #pwm-cells =3D <2>;
> > +      compatible =3D "sunplus,sp7021-pwm";
> > +      reg =3D <0x9c007a00 0x80>;
> > +      clocks =3D <&clkc 0xa2>;
> > +    };
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 13f9a84..721ed79 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -18242,6 +18242,11 @@ L:   netdev@vger.kernel.org
> >  S:   Maintained
> >  F:   drivers/net/ethernet/dlink/sundance.c
> >
> > +SUNPLUS PWM DRIVER
> > +M:   Hammer Hsieh <hammer.hsieh@sunplus.com>
> > +S:   Maintained
> > +F:   Documentation/devicetree/bindings/pwm/pwm-sunplus.yaml
> > +
> >  SUPERH
> >  M:   Yoshinori Sato <ysato@users.sourceforge.jp>
> >  M:   Rich Felker <dalias@libc.org>
> > --
> > 2.7.4
> >
> >
