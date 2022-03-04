Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A564CE109
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 00:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiCDXiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 18:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiCDXiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 18:38:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFF611B;
        Fri,  4 Mar 2022 15:37:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C2CB61F1E;
        Fri,  4 Mar 2022 23:37:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84BCBC340F6;
        Fri,  4 Mar 2022 23:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646437046;
        bh=vYW2Inc1gofPuL2v43VLkLxzmzCwQMyJPz0gOoV+3UI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uCBwUfqYPO14kQFStyCPuYAY65dVziFIDvjAEG7SAjtkLay1Cnlwpgmrnoy3IBmj9
         2VwFzs5h0xty6dEF9K0mtUbloSRgzfr0uKTzZ3HcTzkHBcpYURHts2OndxLUe8mmXT
         3UzA9s97Whx5U4PnMclmZTKrkPvZLErB7ZnH47JgEc7ntpN63XRSqYk26Q8YUc32ZK
         VQ0ggKVqquIPRkPi3MsKr0juutUzr/3Jh5813ep8emmgUDXk/Rwwl/+mj0H/5Xadvc
         H8tRzXdD5aDw8xvhBaYm45hmnJicWs7ZKfs0jlG+neTFi6LgyaaZWBgBYda6d+mVrC
         xKl7rlaHRF52g==
Received: by mail-ej1-f42.google.com with SMTP id qx21so20436743ejb.13;
        Fri, 04 Mar 2022 15:37:26 -0800 (PST)
X-Gm-Message-State: AOAM532Y/WILcgUykrZLhkuC5GJeLHDOUiyXvqiTx8O+YS1CocTwJ8hO
        svfY1CfBO2fQAhGMhTVI4qDEq+2coRQZxFC37A==
X-Google-Smtp-Source: ABdhPJysjUsy0FGiLn6wFPmbk1rqw0yxwzXpgWZTQIFFHB18ic8Jox7eKR/BaHXTH8v9rCjwtz80d697E9wdwnZEpWo=
X-Received: by 2002:a17:906:9913:b0:6d6:dc48:5d49 with SMTP id
 zl19-20020a170906991300b006d6dc485d49mr895534ejb.325.1646437044625; Fri, 04
 Mar 2022 15:37:24 -0800 (PST)
MIME-Version: 1.0
References: <20220301152421.57281-1-linux@fw-web.de> <20220301152421.57281-2-linux@fw-web.de>
 <Yh+0B+iKx1gJXXCk@robh.at.kernel.org> <trinity-1ca1f3fd-1eeb-4c8d-a7e2-65851eb8002b-1646291055736@3c-app-gmx-bs69>
In-Reply-To: <trinity-1ca1f3fd-1eeb-4c8d-a7e2-65851eb8002b-1646291055736@3c-app-gmx-bs69>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 4 Mar 2022 17:37:11 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJMZ1mZ91SYZR03rMkK-ZqFd-tCwV6zOrNu5NmP6V+duA@mail.gmail.com>
Message-ID: <CAL_JsqJMZ1mZ91SYZR03rMkK-ZqFd-tCwV6zOrNu5NmP6V+duA@mail.gmail.com>
Subject: Re: Re: [PATCH v4 1/5] dt-bindings: Convert ahci-platform DT bindings
 to yaml
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Frank Wunderlich <linux@fw-web.de>, devicetree@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 3, 2022 at 1:04 AM Frank Wunderlich <frank-w@public-files.de> w=
rote:
>
> Hi Rob,
>
> thanks for review,
>
> have prepared the changes based on yours and krzysztof comments
>
> https://github.com/frank-w/BPI-R2-4.14/commits/5.17-next-20220225
>
> (just ignore the top 2 commits) i thought i had a size-cells-error, but d=
id not get them again after reverting this part, seems they are fixed by in=
clusion of the sata-common binding
>
> > Gesendet: Mittwoch, 02. M=C3=A4rz 2022 um 19:14 Uhr
> > Von: "Rob Herring" <robh@kernel.org>
> > An: "Frank Wunderlich" <linux@fw-web.de>
>
> > On Tue, Mar 01, 2022 at 04:24:17PM +0100, Frank Wunderlich wrote:
> > > From: Frank Wunderlich <frank-w@public-files.de>
>
> > > diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.yaml=
 b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> > > new file mode 100644
> > > index 000000000000..cf67ddfc6afb
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> > > @@ -0,0 +1,162 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/ata/ahci-platform.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: AHCI SATA Controller
> >
> > blank line.
>
> done
>
> > > +description:
> > > +  SATA nodes are defined to describe on-chip Serial ATA controllers.
> > > +  Each SATA controller should have its own node.
> > > +
> > > +  It is possible, but not required, to represent each port as a sub-=
node.
> > > +  It allows to enable each port independently when dealing with mult=
iple
> > > +  PHYs.
> >
> > You need a '|' after 'description' if you want to maintain the
> > paragraphs.
>
> ok added | to all multiline descriptions
>
> > > +
> > > +maintainers:
> > > +  - Hans de Goede <hdegoede@redhat.com>
> > > +  - Jens Axboe <axboe@kernel.dk>
> > > +
> > > +allOf:
> > > +- $ref: "sata-common.yaml#"
> > > +
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > > +      - items:
> > > +        - enum:
> > > +          - brcm,iproc-ahci
> > > +          - marvell,armada-8k-ahci
> > > +          - marvell,berlin2q-ahci
> > > +        - const: generic-ahci
> > > +      - enum:
> > > +        - brcm,iproc-ahci
> > > +        - cavium,octeon-7130-ahci
> > > +        - hisilicon,hisi-ahci
> > > +        - ibm,476gtr-ahci
> > > +        - marvell,armada-3700-ahci
> > > +        - marvell,armada-380-ahci
> > > +        - snps,dwc-ahci
> > > +        - snps,spear-ahci
> >
> > Install yamllint and run 'make dt_binding_check'. It's going to
> > complain about the indentation.
>
> you're right, i had no yamllint installed, so i have not seen these inden=
tion errors
>
> > > +  ahci-supply:
> > > +    description:
> > > +      regulator for AHCI controller
> > > +
> > > +  clock-names:
> >
> > Group with 'clocks'
>
> ok, already done in my tree because of krzysztofs comment
>
> > > +  ports-implemented:
> > > +    $ref: '/schemas/types.yaml#/definitions/uint32'
> > > +    description:
> > > +      Mask that indicates which ports that the HBA supports
> > > +      are available for software to use. Useful if PORTS_IMPL
> > > +      is not programmed by the BIOS, which is true with
> > > +      some embedded SoCs.
> > > +    maxItems: 1
> >
> > A uint32 is only ever 1 item. Drop.
> >
> > IIRC, isn't the max here 0xff? Add constraints.
>
> i've found it only set to 0x1 so i have currently set the maximum to 0x1,=
 is this ok?
> If some higher value is needed binding needs to be touched...

There's a spec for it, so no need to look at what's used. Calxeda AHCI
had 5 ports IIRC.


> > > +  reg-names:
> > > +    maxItems: 1
> >
> > Group with 'reg'.
>
> ok
>
> > > +patternProperties:
> > > +  "^sata-port@[0-9a-f]+$":
> > > +    type: object
> >
> >        additionalProperties: false
>
> ok added to my tree
>
> and needed to add phy-names because some marvell boards using this
>
> arch/arm64/boot/dts/marvell/armada-8040-mcbin-singleshot.dt.yaml: sata@54=
0000: sata-port@1: 'phy-names' does not match any of the regexes: 'pinctrl-=
[0-9]+'
>
> now i have only the marvell-errors about incomplete sata-port subnode (wi=
thout phy/target-supply) like i mention in the patch...how to proceed with =
this?

So the child nodes are incomplete? They should be disabled then
(status =3D "disabled") and that turns off required properties checks.

Rob
