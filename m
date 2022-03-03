Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384CB4CB763
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 08:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiCCHFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 02:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiCCHFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 02:05:35 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CF22D1D3;
        Wed,  2 Mar 2022 23:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646291055;
        bh=c8B08IuN0ueJ5P1Qw3m4mZcla5OpJNkiL6GjsRpN5GY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=hZaujvICUT5hjdB6Lp+cImer0Md6B745NTlpYuexL6B27u5X4lYSDPsd0hI8v+bIK
         yPqf87EaL996Qtg2ExqEUipUGTMS+Tw76vJ8zo4oYFxopgkNj2Fln1EDQon3qf1xIg
         6Kn/358VgBKo66uqDsfkNTDjOzxUjMD3NQx0egj0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.154.125] ([217.61.154.125]) by web-mail.gmx.net
 (3c-app-gmx-bs69.server.lan [172.19.170.214]) (via HTTP); Thu, 3 Mar 2022
 08:04:15 +0100
MIME-Version: 1.0
Message-ID: <trinity-1ca1f3fd-1eeb-4c8d-a7e2-65851eb8002b-1646291055736@3c-app-gmx-bs69>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Frank Wunderlich <linux@fw-web.de>, devicetree@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Subject: Aw: Re: [PATCH v4 1/5] dt-bindings: Convert ahci-platform DT
 bindings to yaml
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 3 Mar 2022 08:04:15 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <Yh+0B+iKx1gJXXCk@robh.at.kernel.org>
References: <20220301152421.57281-1-linux@fw-web.de>
 <20220301152421.57281-2-linux@fw-web.de>
 <Yh+0B+iKx1gJXXCk@robh.at.kernel.org>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:/lChWm1rfjWQIQe56yrqiZm3Y/F+aYSHAhSYt2mbFXFdfKYmHyqTFxKsF/VidPyXBtz9B
 7wR4CfTQ9nqIidZ2bWyS+UF9dqeyvvZE2/0x1FomSQe+j0VjqQk3qexBjQPMLHCDlP2tXLZlBsGa
 QBS9Jwxf2do9zTXbnkzKTXiO4L+/ZoCvP4wZU+z6gweuR97SP+Xko7O52mvTGmt5GwABhf5TKX1S
 sn4TZYtnMs1L8cs9uic5xCqL37CC//+7ptb7BN6pk27+YDUeL8IF7+qKvIYDAwwZsuQX1d1WMIeB
 A4=
X-UI-Out-Filterresults: notjunk:1;V03:K0:SKDpZk6cLk0=:qnvAElGXZA38EYbbf7iG9I
 x2MFrBDk9KWc9CGfyaQZsF7A7x2AKK7Ouvkzd3x0QffCTeUq8uDrhHyLX7CX3UsTpwCep0Ygi
 jsmF7gcb26NsqP2x9A8io9eRUKcwCyrbR8AKPy9ZtL0o5pYemEyv69QCA+kWjA9auq5AFqcfB
 dIG8rN1+CAnc9A00+X9xI+3s5dJ9u7BCopnbU4pVk1EwO/IrLrB4ZLbJFhjxtf5Ttu8xCASHu
 S1pOTckExZS0q97mVVkvC9T7A29bdqLoMSJ03LUm5acTAA3CvKw9NPn0GqwL8j0LinvOxR69Q
 3SP9rKd/4SsG3RkItDGFst67vJ/LaDvunXDC9aZC3p8tJlzmXLciVhAn5+xDxSaJafbKYUTQj
 +oUxjVRc/A9aRtLRWpSdr3qeHOkolI4N7oG1tblp/QYIWhsMkY8MCb4lFj73+6O2q7hixksfy
 RdUoDTH3jx9MZSrXZK1J/b1E4mrNBM43EOQ+E/eI5gncyuKCHmYEBU5bqWYllaDetkXfRvtmL
 9o9+OmDNq9XE1kQSk3YQUFLZ/YBEeB23Uw67FbkfFNzme/7EwHAyhi3E7vzPS39mF4lgAuaCl
 XHvGJnosohw1/HakN7NvEkYiUz/rca4KxwjgFGyBU5vBsptZ+uFi7Xwe5bYLlCT2HpfSPk+DL
 F4IBJ05JDDNSEA5P8greI8EiNEkU9fjYRFzrbrn65CkmRDKd+D6iotTQAw/H/+zUXhPR76Q9q
 KIfhkZ8geKPHcoC91j3ORzXkOg6Uq2hJTG+O522WVVtnggvEutvX8thTE6nxBMcppqyN00bcr
 SqvHZmg
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

thanks for review,

have prepared the changes based on yours and krzysztof comments

https://github=2Ecom/frank-w/BPI-R2-4=2E14/commits/5=2E17-next-20220225

(just ignore the top 2 commits) i thought i had a size-cells-error, but di=
d not get them again after reverting this part, seems they are fixed by inc=
lusion of the sata-common binding

> Gesendet: Mittwoch, 02=2E M=C3=A4rz 2022 um 19:14 Uhr
> Von: "Rob Herring" <robh@kernel=2Eorg>
> An: "Frank Wunderlich" <linux@fw-web=2Ede>

> On Tue, Mar 01, 2022 at 04:24:17PM +0100, Frank Wunderlich wrote:
> > From: Frank Wunderlich <frank-w@public-files=2Ede>

> > diff --git a/Documentation/devicetree/bindings/ata/ahci-platform=2Eyam=
l b/Documentation/devicetree/bindings/ata/ahci-platform=2Eyaml
> > new file mode 100644
> > index 000000000000=2E=2Ecf67ddfc6afb
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/ata/ahci-platform=2Eyaml
> > @@ -0,0 +1,162 @@
> > +# SPDX-License-Identifier: GPL-2=2E0
> > +%YAML 1=2E2
> > +---
> > +$id: http://devicetree=2Eorg/schemas/ata/ahci-platform=2Eyaml#
> > +$schema: http://devicetree=2Eorg/meta-schemas/core=2Eyaml#
> > +
> > +title: AHCI SATA Controller
>=20
> blank line=2E

done
=20
> > +description:
> > +  SATA nodes are defined to describe on-chip Serial ATA controllers=
=2E
> > +  Each SATA controller should have its own node=2E
> > +
> > +  It is possible, but not required, to represent each port as a sub-n=
ode=2E
> > +  It allows to enable each port independently when dealing with multi=
ple
> > +  PHYs=2E
>=20
> You need a '|' after 'description' if you want to maintain the=20
> paragraphs=2E

ok added | to all multiline descriptions

> > +
> > +maintainers:
> > +  - Hans de Goede <hdegoede@redhat=2Ecom>
> > +  - Jens Axboe <axboe@kernel=2Edk>
> > +
> > +allOf:
> > +- $ref: "sata-common=2Eyaml#"
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +        - enum:
> > +          - brcm,iproc-ahci
> > +          - marvell,armada-8k-ahci
> > +          - marvell,berlin2q-ahci
> > +        - const: generic-ahci
> > +      - enum:
> > +        - brcm,iproc-ahci
> > +        - cavium,octeon-7130-ahci
> > +        - hisilicon,hisi-ahci
> > +        - ibm,476gtr-ahci
> > +        - marvell,armada-3700-ahci
> > +        - marvell,armada-380-ahci
> > +        - snps,dwc-ahci
> > +        - snps,spear-ahci
>=20
> Install yamllint and run 'make dt_binding_check'=2E It's going to=20
> complain about the indentation=2E

you're right, i had no yamllint installed, so i have not seen these indent=
ion errors

> > +  ahci-supply:
> > +    description:
> > +      regulator for AHCI controller
> > +
> > +  clock-names:
>=20
> Group with 'clocks'

ok, already done in my tree because of krzysztofs comment

> > +  ports-implemented:
> > +    $ref: '/schemas/types=2Eyaml#/definitions/uint32'
> > +    description:
> > +      Mask that indicates which ports that the HBA supports
> > +      are available for software to use=2E Useful if PORTS_IMPL
> > +      is not programmed by the BIOS, which is true with
> > +      some embedded SoCs=2E
> > +    maxItems: 1
>=20
> A uint32 is only ever 1 item=2E Drop=2E
>=20
> IIRC, isn't the max here 0xff? Add constraints=2E

i've found it only set to 0x1 so i have currently set the maximum to 0x1, =
is this ok?
If some higher value is needed binding needs to be touched=2E=2E=2E

> > +
> > +  reg-names:
> > +    maxItems: 1
>=20
> Group with 'reg'=2E

ok

> > +patternProperties:
> > +  "^sata-port@[0-9a-f]+$":
> > +    type: object
>=20
>        additionalProperties: false

ok added to my tree

and needed to add phy-names because some marvell boards using this

arch/arm64/boot/dts/marvell/armada-8040-mcbin-singleshot=2Edt=2Eyaml: sata=
@540000: sata-port@1: 'phy-names' does not match any of the regexes: 'pinct=
rl-[0-9]+'

now i have only the marvell-errors about incomplete sata-port subnode (wit=
hout phy/target-supply) like i mention in the patch=2E=2E=2Ehow to proceed =
with this?

regards Frank


