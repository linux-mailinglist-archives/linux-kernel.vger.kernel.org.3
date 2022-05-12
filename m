Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0FD4524CC7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 14:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353705AbiELM0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 08:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353972AbiELM03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:26:29 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1667D5401A
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:26:24 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id h11so3410462ila.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MwYIAF3cq8G3u9Ili7Yhf5dC/zi9S7Kv9orW3ndyyMo=;
        b=xTNWxvaZpM3RIRF+c17vz2buBi9TO3q0Z8ZgBNj48ZR9clc2FfK/UCy0G7zvhxlaeJ
         Aj1uMDAg0bhohTIXxFfKVwSJCKPvgmLY0xLLOdPoX9WY+8GPpLLIVGMT/Nxqi8luuVg5
         6g9enenQBEath3GvnAy2JD9vjbNdf+q/Sd8OpuoJe/Toalwtap2L+g8jUxiIlQvx2lP4
         EokHmG0APOOnQZw4EWwASwkkBst1Y0DQ/JVK0JNzO0L4LgvhoH/cXUNcHAM6HtBmF8vG
         XO2ZVL6BDkZNpGdXKY6o5mBaz/nf9qU+hdKma0/bc8wPMZXLQF9XsNbGsAxZaj7lTRo0
         Gscg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MwYIAF3cq8G3u9Ili7Yhf5dC/zi9S7Kv9orW3ndyyMo=;
        b=c0Q6iiEBwnZcwzwaeHNzER+KIUyVQjn0+r9GDocoVPWhtNTGTAnfa2sSkfX935ZfxT
         lGFIiDjA/kMjDT2cycap7zN3JJHto+/Nlg3rnGVDJzETMx8JVA4xHOIAQSTcDTLRuIHH
         vIqxmmiWJeed1bf9neL/aKK9H2ZFkkzWmFiU5RRYP2/nic4KpMQA14Rivt1+t2NSmO6X
         TGhEFb27ixcfDS8s752DX56/AC0jNUEYeCL4eNG46iX4zwtb4mBEu9x6NezL4YoS/ftw
         TZam5enQ4WLil4DmtwPgE/Jh1s/gqaT3h61UbelWlcE6/nxsL1LuWKn0+QuREl6icu8u
         LMPg==
X-Gm-Message-State: AOAM5305MwDXuIVlXd5lXMItEMtqFJMVaKVKd2JQtTbW2fT3DdtRSc5s
        Tg8HgrBUSrUrIEx3IUb2HPhgxYZbzU/CdH5BaCXXlw==
X-Google-Smtp-Source: ABdhPJw1Mn/rYopWnBcxdUmVQgBRtHp0rWD0yynzcXfeeIA6XHLAfB7cjfGXcYrldDJTX7JH/wSLwSWlfM+XAHtdMug=
X-Received: by 2002:a05:6e02:154b:b0:2cf:7701:47e3 with SMTP id
 j11-20020a056e02154b00b002cf770147e3mr14459824ilu.40.1652358383440; Thu, 12
 May 2022 05:26:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220510124929.91000-1-robert.marko@sartura.hr>
 <20220510124929.91000-2-robert.marko@sartura.hr> <0815f581-ca5b-6fb6-a59e-f5d0a3686caa@linaro.org>
In-Reply-To: <0815f581-ca5b-6fb6-a59e-f5d0a3686caa@linaro.org>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Thu, 12 May 2022 14:26:12 +0200
Message-ID: <CA+HBbNFnXoEghSdhTYoC-VvCMkiEuuee9p8SuNGubYCeLWoYfA@mail.gmail.com>
Subject: Re: [PATCH v2 02/11] dt-bindings: marvell: convert Armada 37xx
 compatibles to YAML
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, Andrew Lunn <andrew@lunn.ch>,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        kostap@marvell.com, devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 6:52 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 10/05/2022 14:49, Robert Marko wrote:
>
> Thank you for your patch. There is something to discuss/improve.
>
> > -
> > - - compatible: must contain "cznic,turris-mox"
> > diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.yaml b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.yaml
> > new file mode 100644
> > index 000000000000..3f41ef2c6f3e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.yaml
> > @@ -0,0 +1,50 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/arm/marvell/armada-37xx.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Marvell Armada 37xx Platforms Device Tree Bindings
> > +
> > +maintainers:
> > +  - Robert Marko <robert.marko@sartura.hr>
> > +
> > +properties:
> > +  $nodename:
> > +    const: '/'
> > +  compatible:
> > +    oneOf:
> > +      - description: Armada 3710 SoC
> > +        items:
> > +          - const: marvell,armada3710
>
> This does not look correct. The SoC usually cannot be used by itself,
> it's always a part of some product, SoM, board.

Hi Krzysztof,
Currently, there are no Armada 3710 boards present in Linux, so I just
put the SoC compatible.
If that is not appropriate, I can drop it.

>
> > +
> > +      - description: Armada 3720 SoC
> > +        items:
> > +          - enum:
> > +              - marvell,armada-3720-db
> > +              - globalscale,espressobin
> > +              - cznic,turris-mox
> > +              - methode,udpu
>
> Order by name.
Will fixup in v3.

>
> > +          - const: marvell,armada3720
> > +          - const: marvell,armada3710
> > +
> > +      - description: Globalscale Espressobin boards
> > +        items:
> > +          - enum:
> > +              - globalscale,espressobin-emmc
> > +              - globalscale,espressobin-ultra
> > +              - globalscale,espressobin-v7
> > +          - const: globalscale,espressobin
> > +          - const: marvell,armada3720
> > +          - const: marvell,armada3710
Do these const compatibles also need to be in alphabetical ordering,
cause I ported them as they are meant to be used with the board and
then 3720 compatibles being in front of 3710 one as required by the current
text bindings.

Regards,
Robert
> > +
> > +      - description: Globalscale Espressobin V7 boards
> > +        items:
> > +          - enum:
> > +              - globalscale,espressobin-v7-emmc
> > +          - const: globalscale,espressobin-v7
> > +          - const: globalscale,espressobin
> > +          - const: marvell,armada3720
> > +          - const: marvell,armada3710
> > +
> > +additionalProperties: true
>
>
> Best regards,
> Krzysztof



-- 
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
