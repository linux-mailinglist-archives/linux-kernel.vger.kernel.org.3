Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5639504C9F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 08:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236778AbiDRG3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 02:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbiDRG3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 02:29:45 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1417E1834E;
        Sun, 17 Apr 2022 23:27:07 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id i20so17473060wrb.13;
        Sun, 17 Apr 2022 23:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s+1LbEHTZ4xb/p3MS2k3Xy2C6GVhDnJWDT9sJsoDOPA=;
        b=aEtrZrDwD81IkQf7qqZzqWCOqcb7Q211AlcRLiYcoOuDujHbxfhOoluP2i1Kf+XV1e
         TDqGfFdAYNsm4QK6bkR9NAq5Z07hYM15Fw8wpouvXX8J9wWqrVvRwDEFtC3YBUgaKyff
         Bp0kzyniNrHLJvQi10iJf2ysjkWRr4lV2tPznLo6k84x+Q/miW+GahtshZtos33LYK3A
         /nZ8QJjnPfvKhQWUo6Qjct8ZIlWufFokK1nRyFqDR4hD/67/yP3yMCemUt49QlTK8aMr
         bCp2NlXbve0BRZn9f3tcZUfw9LNIEFsaxTU++OioT1ItfbYHxSU4CFnOERhlOwa+HVws
         5q8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s+1LbEHTZ4xb/p3MS2k3Xy2C6GVhDnJWDT9sJsoDOPA=;
        b=ksz6akFeedbeQ9a12lqObzOuT19KX95QlSf9HHzHh/UYGl7pk2/cLGihPAx7O18bnX
         94AirdLHpt0bTeTFNp7lhwuVs2uSwbm6ro3HGttJdOR6mQtkb3CN76FA6K0wOvXkc95w
         4LodYaXJ4xVzzrzIdE1Xel3dqA79UK2aMrdzP+B1K1GYq84q9Mx3dw7hbOE8RiNpxFBp
         PEDZ5kmrGddI5gTVkB19Dmm/k78DzqYJNzrCuvyu/vkZHvvYaNGYo1Z+6x944OhE8dDl
         zfsqLKyHT9WiEfAQ++q48K12PdFDSNI/ufx9Ykthnr50mhSwbPqd1mxDEIxS/bUt/lEf
         Alyg==
X-Gm-Message-State: AOAM532xeEwgZKX7eGE9kqDhYbOnLcF6YuI0MB/mHOuaPGEMfuaTuvIs
        BFc+OI/acHlahv+4peuvJpqwBaBfMPhYEGtNnwU=
X-Google-Smtp-Source: ABdhPJzW2eAw+FwQCJpaDWa8O+sHyNYdtqXYOVCPpNDBj5c1YcLjVlfa6Qaw/+hh0JEa0XA4a6Yk/a7GrBprm47ed6g=
X-Received: by 2002:a5d:6e85:0:b0:207:a435:d9a7 with SMTP id
 k5-20020a5d6e85000000b00207a435d9a7mr7165580wrz.217.1650263225527; Sun, 17
 Apr 2022 23:27:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220407082148.571442-1-gengcixi@gmail.com> <20220407082148.571442-2-gengcixi@gmail.com>
 <YlcgtLmXwc2s2+oJ@robh.at.kernel.org>
In-Reply-To: <YlcgtLmXwc2s2+oJ@robh.at.kernel.org>
From:   Cixi Geng <gengcixi@gmail.com>
Date:   Mon, 18 Apr 2022 14:26:29 +0800
Message-ID: <CAF12kFuY_t4i2SpAaBvTAOagKVJOf3Awuds1O0J7xvKFgSEQQg@mail.gmail.com>
Subject: Re: [PATCH V3 1/7] dt-bindings:iio:adc: add sprd,ump9620-adc dt-binding
To:     Rob Herring <robh@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Orson Zhai <orsonzhai@gmail.com>,
        "baolin.wang7@gmail.com" <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
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

Rob Herring <robh@kernel.org> =E4=BA=8E2022=E5=B9=B44=E6=9C=8814=E6=97=A5=
=E5=91=A8=E5=9B=9B 03:12=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Apr 07, 2022 at 04:21:42PM +0800, Cixi Geng wrote:
> > From: Cixi Geng <cixi.geng1@unisoc.com>
> >
> > sprd,ump9620-adc is one variant of sc27xx series, add ump9620
> > description and sample in dt-bindings.
> >
> > Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> > ---
> >  .../bindings/iio/adc/sprd,sc2720-adc.yaml     | 57 +++++++++++++++++--
> >  1 file changed, 53 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.=
yaml b/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml
> > index caa3ee0b4b8c..0d0f317b75c5 100644
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
> > @@ -34,12 +35,39 @@ properties:
> >      maxItems: 1
> >
> >    nvmem-cells:
> > -    maxItems: 2
> > +    description: nvmem-cells.
> >
> >    nvmem-cell-names:
> > -    items:
> > -      - const: big_scale_calib
> > -      - const: small_scale_calib
> > +    description: Names for each nvmem-cells specified.
>
> These descriptions of common properties are redundant. Just use 'true'
> for the property values.
>
> > +
> > +if:
> > +  not:
> > +    properties:
> > +      compatible:
> > +        contains:
> > +          enum:
> > +            - sprd,ump9620-adc
>
> Use 'const'

Hi Rob Herring=EF=BC=9A
did you mean I should use "- const: sprd,ump9620-adc"? or change the
enum to const?
but the above two modification methods have failed for me to test
dt-bindings-check.
>
> > +then:
> > +  properties:
> > +    nvmem-cells:
> > +      maxItems: 2
> > +    nvmem-cell-names:
> > +      items:
> > +        - const: big_scale_calib
> > +        - const: small_scale_calib
> > +
> > +else:
> > +  properties:
> > +    nvmem-cells:
> > +      maxItems: 6
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
> > @@ -69,4 +97,25 @@ examples:
> >              nvmem-cell-names =3D "big_scale_calib", "small_scale_calib=
";
> >          };
> >      };
> > +
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    pmic {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +        adc@504 {
> > +            compatible =3D "sprd,ump9620-adc";
> > +            reg =3D <0x504>;
> > +            interrupt-parent =3D <&ump9620_pmic>;
> > +            interrupts =3D <0 IRQ_TYPE_LEVEL_HIGH>;
> > +            #io-channel-cells =3D <1>;
> > +            hwlocks =3D <&hwlock 4>;
> > +            nvmem-cells =3D <&adc_bcal1>, <&adc_bcal2>,
> > +                          <&adc_scal1>, <&adc_scal2>,
> > +                          <&vbat_det_cal1>, <&vbat_det_cal2>;
> > +            nvmem-cell-names =3D "big_scale_calib1", "big_scale_calib2=
",
> > +                               "small_scale_calib1", "small_scale_cali=
b2",
> > +                               "vbat_det_cal1", "vbat_det_cal2";
> > +        };
> > +    };
> >  ...
> > --
> > 2.25.1
> >
> >
