Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127504E5EA4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 07:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348086AbiCXGY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 02:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242262AbiCXGYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 02:24:25 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B497C96818;
        Wed, 23 Mar 2022 23:22:50 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id j83so3965861oih.6;
        Wed, 23 Mar 2022 23:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rdzl6Jf6niYa4MMeejzQkrqz2P7au8ACLXhQDsT0pBI=;
        b=EO8K1z8BS/6PReRIIFoQ+Sduaw9R2peQUYTyIFAutGKVo+RcXyF/uo+vSXXVndxwBN
         l+ih26tIUR214XE/aObvcvzckQtXCHvy3kjpY6Qb5B3LAF8bSME3g2j+2uUhIe+qht3X
         gIW8pi6/DghC0Quq2jjcaFOUqvSad4Mexv0hPKo01oMQvF2sn5HtYKRbwPa6fLN8SCJd
         9NxRVMDNAYIS5vBlWCD/1xLIVanxtLEiHvzfFK9k2o+XhLZlb1w4yKX7F5y5iSinwI+p
         1DLYpjyBFzSVINqcz4iSsshrwU7P8Y367+KPQ9k8LePCBumRIP1VpKPm96ybfsF3oFAW
         DqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rdzl6Jf6niYa4MMeejzQkrqz2P7au8ACLXhQDsT0pBI=;
        b=kEZBK4HDhdJUPYYLlbgblfpCFW+arMkYdhPaR0Hen/T4704gAm4W+nxXx0Si60anbu
         SkcHorRB4OrN8ClQxifxJ70JSBE5c6SDWWBMzVIrgAKOzU43Fr3jngou4ujOr69e4loa
         ljUxw2veMW3yld8blLWCgbzixSt+V0QlrxW7jxFAaSTCwLzR3BqjTdY84Zf/EKOe238e
         Q5q2Cp5RSZb4ZMTXZsRpeR3SzEkVP1Ew2yzMNBfwcMCXJcLBqMDCJvMEkAertUQEj73l
         iOpi5k0A7JNDroYNWVyavz5N9awvEo0LwRaZaIftN9+Ca67MffWQRNTx1WiBAVYohW0h
         S5Dg==
X-Gm-Message-State: AOAM532cVZVMsMBH1hV3W7xy1PNzEGFQGaGVKPJfdkkpDuYUJ3fzVn7r
        iIgKCfcOxGJdT1TIjtc/hdPUvBaMiJrIMnloVL4BdyPfOgI0bSZy
X-Google-Smtp-Source: ABdhPJwkl1nlYBOxuy2+4DJvoCItRF5uKq2+SVGIlCrOWlibkxJsklVyDYmabbg/+sNw0PITKUiGcz44TvUP2jJeS3k=
X-Received: by 2002:aca:61c1:0:b0:2ec:d091:ff53 with SMTP id
 v184-20020aca61c1000000b002ecd091ff53mr6584829oib.235.1648102969953; Wed, 23
 Mar 2022 23:22:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220311164628.378849-1-gengcixi@gmail.com> <20220311164628.378849-2-gengcixi@gmail.com>
 <6e4f64dc-bb3d-0e05-0380-7e6f3b1a823c@kernel.org>
In-Reply-To: <6e4f64dc-bb3d-0e05-0380-7e6f3b1a823c@kernel.org>
From:   Cixi Geng <gengcixi@gmail.com>
Date:   Thu, 24 Mar 2022 14:22:13 +0800
Message-ID: <CAF12kFuKnm2qenvpmKhCVD4T+d=0SyruzdpJ5FX1RS8gvqbyNA@mail.gmail.com>
Subject: Re: [PATCH V2 1/7] dt-bindings:iio:adc: add sprd,ump9620-adc dtbindings
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     jic23@kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Kozlowski <krzk@kernel.org> =E4=BA=8E2022=E5=B9=B43=E6=9C=8820=E6=
=97=A5=E5=91=A8=E6=97=A5 22:50=E5=86=99=E9=81=93=EF=BC=9A
>
> On 11/03/2022 17:46, Cixi Geng wrote:
> > From: Cixi Geng <cixi.geng1@unisoc.com>
> >
> > sprd,ump9620-adc is one variant of sc27xx series, add ump9620 in
> > dtbindings.
> >
> > Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
> > Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
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
>
> Please test your changes with dt_binding_check and dtbs_check. Your
> change looks not complete - you have still nvmem-cells =3D 2.
>
Hi Krzysztof
I test all is PASS on my local.  could you tell how did you test?
my_logs:
cixi.geng1@tj10039pcu:~/upsteatming/linux$ make DT_CHECKER_FLAGS=3D-m
dt_binding_check &>dt_check.log
cixi.geng1@tj10039pcu:~/upsteatming/linux$ cat dt_check.log |grep sprd,sc27=
20
  DTEX    Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.example=
.dts
  DTC     Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.example=
.dt.yaml
  CHECK   Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.example=
.dt.yaml
cixi.geng1@tj10039pcu:~/upsteatming/linux$ tuxmake -C ${kernel_src} -b
${topdir}/obj/gcc -o ${topdir}/dist/gcc -a $ARCH -t gcc  -K
CONFIG_ARCH_${PLAT}=3Dy -K CONFIG_MFD_SC27XX_PMIC=3Dy -K
CONFIG_SC27XX_ADC=3Dy

I: config: PASS in 0:00:00.000549
I: default: PASS in 0:10:20.931602
I: kernel: PASS in 0:01:10.643458
I: xipkernel: SKIP in 0:00:00.003244
I: modules: PASS in 0:00:35.658938
I: dtbs: PASS in 0:00:18.696416
I: dtbs-legacy: SKIP in 0:00:00.005625
I: debugkernel: PASS in 0:00:11.541855
I: headers: PASS in 0:00:11.778253
I: build output in /home/cixi.geng1/upsteatming/dist/gcc


>
> Best regards,
> Krzysztof
