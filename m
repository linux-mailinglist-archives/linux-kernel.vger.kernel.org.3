Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582F44E5E8E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 07:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346437AbiCXGSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 02:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343775AbiCXGSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 02:18:21 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E16E7B132;
        Wed, 23 Mar 2022 23:16:50 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-de2cb87f6aso4020698fac.10;
        Wed, 23 Mar 2022 23:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fSsW23yNgDx6r+FS0u68Qg029/AB4e8b1y+xPbDhULo=;
        b=WaI+XZdlauZC3xyLkQQLnmRijx39Be+Lk2FTR8a5lvp09vlh86qvN+gP1ATCWQ3OCu
         PyNSrbZ2Y9l99v3neukWshZ2+HdQDUKKSRAgjNqQ45lIgu4UL+pZteJvEF11nekudRcu
         WZzyX4kIrtzPdJD3PBiItywg3PwS80gohi37HVajPfOJBAmBWXfnKmJ/frdY4YgyWW3b
         d6Xt0x2BhNIBWqzKlMbju8bCkpck5QcL9NCJGRoKd05PffCBWFL6PVrnRumgs4HAmrwv
         M0nbbsu+kabq0Le2ruXvPU9BZoE1McvHKZNtPTvfxYz/UHvBmyjEefwuq7J08frY1b18
         //Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fSsW23yNgDx6r+FS0u68Qg029/AB4e8b1y+xPbDhULo=;
        b=DM3fi2OvvPsOA6Lxqe0Bd1CH6c3DuXQ3m8eqmqUkhcIOBnwmyhvIvXcb26IWS1Qj5g
         KAOMF4AuGj4JZlrsmndzR8Ml67uWle9FfupDjKbpNq1qUn0tD/S/6Ch4a9C91bgJvVd2
         nDUnOAzPKMAFh0CGTmp2gfeQc2oAV2HCfRKNVL9uuyIWx+gnG59zwG0rixZAqRju4wGY
         iIqUZ9iMLebX47MxjFPnHY4bdJfzWKvRqIdAsruJfT+GP0GP1MgLtIUCMIbJKKoB95GC
         8vajhuqgtD4K6Q71gSwh6LWR/N5IuFZMcS6fjIhIvC40135xNxtQ1y/B7HHO/+XG0Xvl
         CMlg==
X-Gm-Message-State: AOAM533iUyV6UyrdbT179urJVW48ln7RUvXjSwxVnDTHopqnxDMtKITw
        2zMumEWVfQmiJTXCi5MdPcNcJ1Uo4+T8yUUwnFY=
X-Google-Smtp-Source: ABdhPJzCYmS20Q8SZvgn1kQn7PsXTmLexuJqlQvadFLu8VnVU87uYlBjU4l/30QR2hR/lFfMwi2Itp9Rmc/BTUHtCq0=
X-Received: by 2002:a05:6870:a188:b0:da:cecb:8c2f with SMTP id
 a8-20020a056870a18800b000dacecb8c2fmr6048603oaf.247.1648102609845; Wed, 23
 Mar 2022 23:16:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220311164628.378849-1-gengcixi@gmail.com> <20220311164628.378849-2-gengcixi@gmail.com>
 <20220320133014.7f5cb5b9@jic23-huawei>
In-Reply-To: <20220320133014.7f5cb5b9@jic23-huawei>
From:   Cixi Geng <gengcixi@gmail.com>
Date:   Thu, 24 Mar 2022 14:16:13 +0800
Message-ID: <CAF12kFssN46oo_w5NcJDYAG59866VqaTDVtoC5kgThk2s9MNOw@mail.gmail.com>
Subject: Re: [PATCH V2 1/7] dt-bindings:iio:adc: add sprd,ump9620-adc dtbindings
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        "baolin.wang7@gmail.com" <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, lgirdwood@gmail.com,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?B?5pyx546J5piOIChZdW1pbmcgWmh1LzExNDU3KQ==?= 
        <yuming.zhu1@unisoc.com>, linux-iio@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Cameron <jic23@kernel.org> =E4=BA=8E2022=E5=B9=B43=E6=9C=8820=E6=
=97=A5=E5=91=A8=E6=97=A5 21:22=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, 12 Mar 2022 00:46:22 +0800
> Cixi Geng <gengcixi@gmail.com> wrote:
>
> > From: Cixi Geng <cixi.geng1@unisoc.com>
>
> In title, use dt-binding instead of dtbindings at the end.
>
> >
> > sprd,ump9620-adc is one variant of sc27xx series, add ump9620 in
> > dtbindings.
>
> dt-bindings.
>
> >
> > Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
> > Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
>
> If the patch was authored by Chunyan Zhang, it should be From: Chunyan Zh=
ang,
> if it is more complex than you simply passing the patch on then we should
> see a co-developed to indicate that.
Thanks your advise, I will fix the comment and add correct Signed message
>
> Patch looks good to me
>
> Jonathan
>
> > ---
> >  .../bindings/iio/adc/sprd,sc2720-adc.yaml     | 30 +++++++++++++++++--
> >  1 file changed, 27 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.=
yaml b/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml
> > index caa3ee0b4b8c..331b08fb1761 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml
> > @@ -20,6 +20,7 @@ properties:
> >        - sprd,sc2723-adc
> >        - sprd,sc2730-adc
> >        - sprd,sc2731-adc
> > +      - sprd,ump9620-adc
> >
> >    reg:
> >      maxItems: 1
> > @@ -37,9 +38,32 @@ properties:
> >      maxItems: 2
> >
> >    nvmem-cell-names:
> > -    items:
> > -      - const: big_scale_calib
> > -      - const: small_scale_calib
> > +    description: Names for each nvmem-cells specified.
> > +
> > +if:
> > +  not:
> > +    properties:
> > +      compatible:
> > +        contains:
> > +          enum:
> > +            - sprd,ump9620-adc
> > +then:
> > +  properties:
> > +    nvmem-cell-names:
> > +      items:
> > +        - const: big_scale_calib
> > +        - const: small_scale_calib
> > +
> > +else:
> > +  properties:
> > +    nvmem-cell-names:
> > +      items:
> > +        - const: big_scale_calib1
> > +        - const: big_scale_calib2
> > +        - const: small_scale_calib1
> > +        - const: small_scale_calib2
> > +        - const: vbat_det_cal1
> > +        - const: vbat_det_cal2
> >
> >  required:
> >    - compatible
>
