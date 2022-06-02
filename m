Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98FC53BF7F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 22:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238688AbiFBUQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 16:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237676AbiFBUQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 16:16:07 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A112BC2E;
        Thu,  2 Jun 2022 13:16:03 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b135so5613066pfb.12;
        Thu, 02 Jun 2022 13:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Kb/EgUnEl+66ubR0OBdnZBhP1OFKsT5B/tkrmGF5yWM=;
        b=NkE0Ee2nKeVG01X4TGf7Tds/HpDebAAGIAaGwKYQebrpvg7ak4oaNFBWIPs3Xdbx/6
         /ueM/g2UgL33WPhvSE1L6JXOWT5chkMdkpBYr1/zYN99/wpvyMYpmPhA1oytFSuRvYuV
         PNVqn/U5agKa+qIWBAIGEorsNvVDKBWugZg900PvAoG9Qmtwztu7xfeAcVkvqkOl0WYL
         cOZn4F9+0NeUducPaMA2Z6OZ8Mng1gwTUzPg03BP8mG4yWhRQRsi/9O5/gtaqrHqD4Bg
         4OA13xXtBNtUEnlW2r45PUnCTtuMdwsf1kr3gPJWnFj4wDmdBPTRZoNV0p1ETDx5FzvG
         2rSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Kb/EgUnEl+66ubR0OBdnZBhP1OFKsT5B/tkrmGF5yWM=;
        b=IA3B5ANyWQw+rp206KCxp2mt1dg61aeWI7z7dxUsnrqwcrGNiinwbJtlIZ30OU2dFc
         s83uxfkU8P9iOtzxMhd/TqbA81mVZACImSX7PhJQHjL1RT4BdVmmR1gXcgaYcU/zZ/6R
         loc74AviYG2FhoM0bNGD9nzb1437FVAqbEVWZ17xIaYZBMIvK5VkVsewxDfWWkZHEGq6
         Aozq1NKz2BlcOpQmzP1khm/ojNKTnrNwcSE9SgOdOGkLdpRdXxCVpZpJHRrIOP3jJvTo
         RgXHTiinSYp0EnIkcToU6O4d7BvTWwvGRgPvnNK0rZdzlHg+PL0J3JNbxIZsyDaD5qs6
         bXew==
X-Gm-Message-State: AOAM533H9oh3TID4oc2GaTs5tFVkwi+HS+vtN9aaWvDRTlw6RtUAlxWH
        jm4Q0cE8UrCs/5mWSaRA8XEOPgZnh8NdvKxYfPvyDQxWGiU=
X-Google-Smtp-Source: ABdhPJys4WOb9urNyLdt4aeuOqGuCZdLw80FNC5PvFsBXte5r8ULYu9Wjjuq4Wzf+sPQ6VLvykCW8T4PAgm77gNu2zY=
X-Received: by 2002:a05:6e02:4a1:b0:2d3:a778:f0f1 with SMTP id
 e1-20020a056e0204a100b002d3a778f0f1mr3986818ils.212.1654194896902; Thu, 02
 Jun 2022 11:34:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220531104211.17106-1-peterwu.pub@gmail.com> <20220531104211.17106-2-peterwu.pub@gmail.com>
 <33a797d7-ca60-5153-2ba1-3a909fcc5965@linaro.org>
In-Reply-To: <33a797d7-ca60-5153-2ba1-3a909fcc5965@linaro.org>
From:   ChiaEn Wu <peterwu.pub@gmail.com>
Date:   Fri, 3 Jun 2022 02:34:45 +0800
Message-ID: <CABtFH5+nNRn4azfniKCNc=S2Z2Y0jji_beA_16_UYzAvkak-VA@mail.gmail.com>
Subject: Re: [PATCH 10/14] dt-bindings: power: supply: Add Mediatek MT6370
 Charger binding documentation
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, broonie@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, deller@gmx.de,
        ChiYuan Huang <cy_huang@richtek.com>, alice_chen@richtek.com,
        chiaen_wu@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
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

Hi Krzysztof,

Thank you for the valuable suggestion.
Sorry for sending the same email again. I forgot to reply to everyone
in my last email..

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E6=96=BC 2022=E5=B9=
=B46=E6=9C=881=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=884:15=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> On 31/05/2022 12:42, ChiaEn Wu wrote:
> > From: ChiaEn Wu <chiaen_wu@richtek.com>
> >
>
> Subject - remove "binding documentation". It's already implied by prefix.
>
> > Add Mediatek MT6370 Charger binding documentation.
> >
> > Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
> > ---
> >  .../power/supply/mediatek,mt6370-charger.yaml | 60 +++++++++++++++++++
> >  1 file changed, 60 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/supply/medi=
atek,mt6370-charger.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/power/supply/mediatek,mt=
6370-charger.yaml b/Documentation/devicetree/bindings/power/supply/mediatek=
,mt6370-charger.yaml
> > new file mode 100644
> > index 000000000000..9d5c4487ca9c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/supply/mediatek,mt6370-ch=
arger.yaml
> > @@ -0,0 +1,60 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/power/supply/mediatek,mt6370-charge=
r.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Mediatek MT6370 Battery Charger
> > +
> > +maintainers:
> > +  - ChiaEn Wu <chiaen_wu@richtek.com>
> > +
> > +description: |
> > +  This module is part of the MT6370 MFD device.
> > +  Provides Battery Charger, Boost for OTG devices and BC1.2 detection.
> > +
> > +properties:
> > +  compatible:
> > +    const: mediatek,mt6370-charger
> > +
> > +  interrupts:
> > +    description: |
> > +      Specify what irqs are needed to be handled by MT6370 Charger dri=
ver. IRQ
> > +      "MT6370_IRQ_CHG_MIVR", "MT6370_IRQ_ATTACH" and "MT6370_IRQ_OVPCT=
RL_UVP_D"
> > +      are required.
> > +    items:
> > +      - description: BC1.2 done irq for mt6370 charger
> > +      - description: usb plug in irq for mt6370 charger
> > +      - description: mivr irq for mt6370 charger
>
> s/for mt6370 charger//
> in each item

I got it, this will be refined in the next version. Thanks!

>
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: attach_i
> > +      - const: uvp_d_evt
> > +      - const: mivr
> > +
> > +  io-channels:
> > +    description: |
> > +      Use ADC channel to read vbus, ibus, ibat, etc., info. Ibus ADC c=
hannel
> > +      is required.
>
> Constraints (e.g. maxItems) are needed.

OK, I will add them in the new version!

>
> > +
> > +  usb-otg-vbus:
>
> Let's keep the same name as in MT6360:
>
> usb-otg-vbus-regulator

I'll change the name to correspond with MT6360 in the next patch, thanks!

> > +    type: object
> > +    description: OTG boost regulator.
> > +    $ref: /schemas/regulator/regulator.yaml#
> > +
> > +    properties:
> > +      enable-gpio:
> > +        maxItems: 1
> > +        description: |
> > +          Specify a valid 'enable' gpio for the regulator and it's opt=
ional
>
> This description is pointless - does not bring any more information. You
> repeat the schema. Please, avoid such descriptions.

I got it, I will remove them in the next patch.

>
> > +
> > +required:
> > +  - compatible
> > +  - interrupts
> > +  - interrupt-names
> > +  - io-channels
> > +
> > +additionalProperties: false
>
>
> How about example? Or is it going to be in MFD schema?

All of MT6370 binding documentation examples are in the MFD schema! Thanks.

>
>
> Best regards,
> Krzysztof

Best regards,
ChiaEn Wu
