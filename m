Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B179C534B3F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 10:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243239AbiEZINe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 04:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237858AbiEZINb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 04:13:31 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C866537BF5;
        Thu, 26 May 2022 01:13:25 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id h5so742128vsq.5;
        Thu, 26 May 2022 01:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zNrA8G7W8xImy1CA/f8Tn4I9dL7mTaFk+uvIb/eV3wY=;
        b=A/U4yg/dwMTa7ikHjmx0yWt56HCq7ojuzUZBjDMA9A9C4zLZnYCYq9G8HtKcvVNWU1
         HpelFYniLokE5zGnN9AC0ye/+jOfHyrHoOXuNkiIMGlIaLV+10eaU/R5NhYsLWvuMhkT
         cM+Mt5MAbL/LAzitybRh9N/81T7AVGwUPBtL5eb7+b9765e1waSMd5c8aXvOo0MMvDTs
         SRt4Tk5ye6URu+wkRjToUv8k55+CYSfTq9ushuvr7mD2iaYpwTNNhaPK1IEIEPHML5sE
         B/gcn5SN2PFgfHv0NUbIOM7hF7eCmcs2Cnl4aO9W8zuSkzKopPE6ZRwBN0QEPYlk6yJh
         BcPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zNrA8G7W8xImy1CA/f8Tn4I9dL7mTaFk+uvIb/eV3wY=;
        b=eddpHFlYHFiTVWGvXUFy0uYtRbDWFcEl8KY3Ha018CacCO4AM3jlj0f5G8MVdKRkZI
         0rT3GMDn5irWmVIgTUKQBXxcsrZ1DjR1vsHk72wnWEMN7o2ZuMry4M3WbPE8u4liS1bN
         cjPD4j+51vwKx2mHZinwV5/9aJHiWmyQmysJbd9+DTdfQkDCV8AVt4N/flJNuvHRgMti
         OfzdpkC9njdVecjKrg3OhU7B3WFU8I2wVmNVzYlSXRbH8O6Jkrccu+a5y0I5CVaqZcQw
         6jUkZbuv1Jy8In3i+6L24NjPAoavBtCx2lluKASsBXjXF7KVb7krjs+0BovWgaD+mssa
         Lwzw==
X-Gm-Message-State: AOAM531qDwcltbyU3GkGFVLXDlUGgqV0whJ0BSv+eV11vxNJW+MFykUz
        AC4Qqb7zFa6ToudxoU7IOgs6VJJPqb6ICKOKK2w=
X-Google-Smtp-Source: ABdhPJy7IZUGyv7zqBT+CrvFboZMNbh3rYZ6gsvuEd2TcV8iBZSTLtKckUJsJz1OFrlMnIfHyYtdH1A+1A3ceRfZddw=
X-Received: by 2002:a67:ef5b:0:b0:335:e3a3:9b33 with SMTP id
 k27-20020a67ef5b000000b00335e3a39b33mr14948741vsr.57.1653552804397; Thu, 26
 May 2022 01:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <1653534995-30794-1-git-send-email-u0084500@gmail.com>
 <1653534995-30794-2-git-send-email-u0084500@gmail.com> <1c7ab94c-a736-c629-bd8c-8a974803e2b9@linaro.org>
In-Reply-To: <1c7ab94c-a736-c629-bd8c-8a974803e2b9@linaro.org>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Thu, 26 May 2022 16:13:13 +0800
Message-ID: <CADiBU39jZ6TdYZoH80m4R-X2_fUXZOvDA4yUd_TQdPzBJLE+JA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: backlight: rt4831: Add the new property
 for ocp level selection
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        jingoohan1@gmail.com, Pavel Machek <pavel@ucw.cz>, deller@gmx.de,
        cy_huang <cy_huang@richtek.com>, lucas_tsai@richtek.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
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

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E6=96=BC 2022=E5=B9=
=B45=E6=9C=8826=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=884:06=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> On 26/05/2022 05:16, cy_huang wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > Add the new property for ocp level selection.
> >
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
> >  .../bindings/leds/backlight/richtek,rt4831-backlight.yaml         | 8 =
++++++++
> >  include/dt-bindings/leds/rt4831-backlight.h                       | 5 =
+++++
> >  2 files changed, 13 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/leds/backlight/richtek,r=
t4831-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/ric=
htek,rt4831-backlight.yaml
> > index e0ac686..c1c59de 100644
> > --- a/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-b=
acklight.yaml
> > +++ b/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-b=
acklight.yaml
> > @@ -47,6 +47,14 @@ properties:
> >      minimum: 0
> >      maximum: 3
> >
> > +  richtek,bled-ocp-sel:
>
> Skip "sel" as it is a shortcut of selection. Name instead:
> "richtek,backlight-ocp"
>
OK, if so, do I need to rename all properties from 'bled' to 'backlight' ?
If  only this property is naming as 'backlight'. it may conflict with
the others like as "richtek,bled-ovp-sel".
>
> > +    description: |
> > +      Backlight OCP level selection, currently support 0.9A/1.2A/1.5A/=
1.8A
>
> Could you explain here what is OCP (unfold the acronym)?
Yes. And the full name is 'over current protection'.
>
>
> Best regards,
> Krzysztof
