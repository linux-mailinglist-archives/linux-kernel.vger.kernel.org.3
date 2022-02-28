Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017334C7216
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 18:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238086AbiB1RDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 12:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238048AbiB1RDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 12:03:11 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375EA765F;
        Mon, 28 Feb 2022 09:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646067719;
        bh=k0F6SvpCnls0O/0DV0EzovTEbGLpabyeCkX8dCik5jo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Fc/tFMfnhnLQjv5kZ7pSXE/dQgPU6KhkZPWtyb2CPNrs8kEcT1pogOrMaJ1lYmnvV
         VdV1pBsK9814RNDWLpRKOBHND+OQRGoU22oQE0wCOe25FywrkoNiZluWk8uZIFiZ7L
         W0fjGQWyv+b8+xkqPBVGsfLlqVJO6oH7BDvJKgWU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [80.245.79.12] ([80.245.79.12]) by web-mail.gmx.net
 (3c-app-gmx-bs53.server.lan [172.19.170.137]) (via HTTP); Mon, 28 Feb 2022
 18:01:58 +0100
MIME-Version: 1.0
Message-ID: <trinity-bfe6b2d5-52cd-458d-92b2-66216620a4b3-1646067718759@3c-app-gmx-bs53>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        Rob Herring <robh+dt@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Aw: Re:  Re: Re: [PATCH v3 1/3] dt-bindings: Convert ahci-platform
 DT bindings to yaml
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 28 Feb 2022 18:01:58 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <ddd09f4f-782f-67e9-ec2f-dd5818ae26c5@canonical.com>
References: <20220227182800.275572-1-linux@fw-web.de>
 <20220227182800.275572-2-linux@fw-web.de>
 <4c3303f5-7af5-9974-7bea-b7f0d6c7ef53@canonical.com>
 <trinity-ac45bde6-392d-4810-8aad-9a06d2bcd85a-1646050780475@3c-app-gmx-bs53>
 <8fbbce9e-4fd9-d420-43ef-953e846d29f1@canonical.com>
 <trinity-f1b6ce3a-6f22-4cf8-bf51-a5e7f007dda7-1646057347735@3c-app-gmx-bs53>
 <ddd09f4f-782f-67e9-ec2f-dd5818ae26c5@canonical.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:1sAIoTtR42be1SxcghXxsWmzRmXeoAOJamY6t168/WaUJiXHT+4izW5decLTrn8wEXQT7
 7sJw/WzpVBqu1akl+pvbxgb7zMRcnKCaNX2ZZXJLAtQnb8WiWCUYkRC04sbpZpqbeNpX0z79jpCX
 G3/uTEddAB5iIVsCTcrtnlXazbRlxitcDF/MnxLdbpFh2esg0pU34lIOxb41swWoI/R/0MgU5DB3
 TBqyHo3GR1IqdDRcSehSA/t0vhnl7IfYkTuyV+aMZR/xYB3vODSCW2qrkUIMhRJRhG8LdqL8B4ZP
 AY=
X-UI-Out-Filterresults: notjunk:1;V03:K0:VmkEUVxE6/s=:AgE2Y0u0Dd1vG2/ZILjYR/
 fhoyEv+mJ/Y7cEKejpo16PPfmCiYpK7Zjq2rVzM93b9cyHx5LAeoEDAyRw6aFUvK15hBK2Ekx
 cY7nE3icg0HTddlthKYBkgeIEqb6/NvAO8wt2qDgTPJU/GQLyoOh2G3EP3Xhz6fyPFsU3pfGk
 ASDrN4geUk0/c0DJMf62yew1n/gG84cHzoYSL+n0C4S50s+MVFvwZeHTxw1sTdcRz36WWSlg7
 xCURwi0olci2GPJmE3Da9A0pcsTNMr+gORV/u1Q4kHRUbnEdlblHaEpZA3DkNxpKzYJcfjRPI
 QUKG4xzKdYV0dKaWeEGravMhEuwCQgLFLogJKHPYaHUKEVnIIuYM97u+Bt8+kA7yq4vjHmjKj
 HQCOc9g9NqkJyBxJyMrKJlhNP6awcxTKjfQtJ+AgmtqluLl9ilQxwDf6zXJAY5fJ3xGiBDqCr
 XENhmE/GUNnnB5Sl2O3LNAvzd/itkVSIceRLpj/3G3sLd37bmL12q0K7lyc7MzHNp7lmw5+me
 kcQaCeiBtLruBhTUsg7heVQKT8hhgAFd+BKU92KQx2ZiDNZZztspKqvpJwQMPNY1If/Zflauj
 NxvKrf/D2TzRXrYr0+pchFUOXo5zRJqWlOEjmJg6pEC6KiVY42kZ1o60fqZAGkwRLVumHB9KD
 EuspsrjujA6Rgu8/+ohzGV4ihDgbzq0mjefJwdAIj7soWW9IGuMC/5GYk0QPikRpnGCFLy5vK
 Zh3wxy7fuC5sJz+VPcARyM2zg4cRpUIgT1Mx118fiMZHruUPbXarkCddzI9lhdE2yrnl7OTFu
 ZN6NPDv
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> Gesendet: Montag, 28. Februar 2022 um 15:35 Uhr
> Von: "Krzysztof Kozlowski" <krzysztof.kozlowski@canonical.com>
> >> Gesendet: Montag, 28. Februar 2022 um 13:38 Uhr
> >> Von: "Krzysztof Kozlowski" <krzysztof.kozlowski@canonical.com>

> >> No, this has to be oneOf. See for example
> >> Documentation/devicetree/bindings/gpio/gpio-vf610.yaml or many other =
files.

> > compatible:
> >   oneOf:
> >     - enum:
> >       - brcm,iproc-ahci
> >       - cavium,octeon-7130-ahci
> >       - hisilicon,hisi-ahci
> >       - ibm,476gtr-ahci
> >       - marvell,armada-3700-ahci
> >       - marvell,armada-380-ahci
> >       - snps,dwc-ahci
> >       - snps,spear-ahci
> >     - items:
> >       - const: generic-ahci
> >       - enum:
> >         - brcm,iproc-ahci
> >         - cavium,octeon-7130-ahci
> >         - hisilicon,hisi-ahci
> >         - ibm,476gtr-ahci
> >         - marvell,armada-3700-ahci
> >         - marvell,armada-380-ahci
> >         - snps,dwc-ahci
> >         - snps,spear-ahci
>
> That could be one way, but instead I propose to have only second part
> (so enum + generic-ahci) for all compatibles mentioned in
> ahci_platform.c, which do not customize the driver behavior for these
> compatibles..

tried many ways of defining it, but none passes with the examples. either =
to short (first example) or too long (second)

as far as i understand the logic it should be similar to this:

properties:
  compatible:
    oneOf:
      - items:
        - enum:
          - marvell,berlin2q-achi
        - const: generic-ahci
      - items:
        - enum:
          - brcm,iproc-ahci
          - cavium,octeon-7130-ahci
          - hisilicon,hisi-ahci
          - ibm,476gtr-ahci
          - marvell,armada-3700-ahci
          - marvell,armada-380-ahci
          - snps,dwc-ahci
          - snps,spear-ahci

this passes the dt-binding_check (examples) for me, but i guess there are =
many more compatibles defined with the generic.

dtbs_check found some more like

'brcm,iproc-ahci'
'marvell,armada-8k-ahci'
and many more

it looks like these are also checked in the enum, so the yaml itself look =
correct, but needs some kind of wildcard instead of the "marvell,berlin2q-=
achi" as second for the generic-ahci compatible

regards Frank
